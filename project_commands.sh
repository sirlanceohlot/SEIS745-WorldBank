############################################
# INITIALIZE PROJECT PARAMETERS AND VARIABLES  #
############################################
CLIENT_IP="10.0.0.1" # Change this to your IP
PROJ_ENV_NAME="PROJ-emr-cluster"
PROJ_STACK_NAME="${PROJ_ENV_NAME}-stack"
PROJ_KEY_NAME="${PROJ_ENV_NAME}-keypair"
PROJ_KEY_FILE="${PROJ_KEY_NAME}.pem"
CLOUD9_PRIVATE_IP=`hostname -i`
BUCKET_NAME="s3-dle-`uuidgen`"

############################################
# CREATE PROJECT INFRASTRUCTURE USING AWS CLI  #
############################################
aws configure set region us-east-1
export AWS_SHARED_CREDENTIALS_FILE=/home/ec2-user/.aws/credentials

CIDR_SUFFIX=
if [ "${CLIENT_IP}" = "0.0.0.0" ]; then 
    CIDR_SUFFIX="/0"
else
    CIDR_SUFFIX="/32"
fi

aws ec2 create-key-pair \
    --key-name "${PROJ_KEY_NAME}" \
    --query 'KeyMaterial' \
    --output text > "${PROJ_KEY_FILE}"

chmod 400 "${PROJ_KEY_FILE}" #change permissions

aws cloudformation deploy \
  --template-file ./template.json \
  --stack-name "PROJ-emr-cluster-stack" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    Name="${PROJ_ENV_NAME}" \
    BucketName="${BUCKET_NAME}" \
    InstanceType=m4.large \
    ClientIP="${CLIENT_IP}${CIDR_SUFFIX}" \
    Cloud9IP="${CLOUD9_PRIVATE_IP}/32" \
    BucketName="${BUCKET_NAME}" \
    InstanceCount=2 \
    KeyPairName="${PROJ_KEY_NAME}" \
    ReleaseLabel="emr-5.32.0" \
    EbsRootVolumeSize=32

############################################
# COPY FILES, CONNECT TO EMR MASTER NODE   #
############################################
PROJ_CLUSTER_ID=`aws emr list-clusters --query "Clusters[?Name=='${PROJ_ENV_NAME}'].Id | [0]" --output text`
aws emr wait cluster-running --cluster-id ${PROJ_CLUSTER_ID}
PROJ_EMR_MASTER_PUBLIC_HOST=`aws emr describe-cluster --cluster-id ${PROJ_CLUSTER_ID} --query Cluster.MasterPublicDnsName --output text`

# Copy PROJ files to Hadoop master node
scp -i "${PROJ_KEY_FILE}" retail_db.sql "hadoop@${PROJ_EMR_MASTER_PUBLIC_HOST}:/home/hadoop"

ssh -i "${PROJ_KEY_FILE}" "hadoop@${PROJ_EMR_MASTER_PUBLIC_HOST}"

############################################
# PULL FILES FROM WORLD BANK INTO EMR ENV  #
############################################

# Downloading IBRD Dataset from World Bank
curl -OJL https://finances.worldbank.org/resource/zucq-nrc3.csv

# Downloading IDA Dataset from World Bank
curl -OJL https://finances.worldbank.org/resource/tdwh-3krx.csv

#############################################
# STORE WORLD BANK FILE COPIES IN S3 BUCKET #
#############################################

# Storing IBRD Dataset from World Bank in S3
aws s3 cp zucq-nrc3.csv s3://${BUCKET_NAME}/

# Storing IDA Dataset from World Bank in S3
aws s3 cp ztdwh-3krx.csv s3://${BUCKET_NAME}/


