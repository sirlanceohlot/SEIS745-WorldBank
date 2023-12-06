# World Bank API Endpoints for project

For this project, the API Endpoints provided by the World Bank will be utilized to gather the necessary data in CSV format to be processed in Amazon AWS. 

The Socrata API Endpoint utilized by the World Bank has a default limit when pulling records of 1,000; however, the API is updated to 2.1 which allows for unlimited record pulls with the $limit function.

To review documentation on the API Endpoint use this link - https://dev.socrata.com/docs/paging.html

If you wish to proceed using the predetermined limit of 2,000,000 records which is above the current total of the dataset, you can utilize the below API Endpoint links.

International Bank for Reconstruction and Development (IBRD) Loans - https://finances.worldbank.org/resource/zucq-nrc3.csv?$limit=2000000

International Development Association (IDA) Credits/Grants - https://finances.worldbank.org/resource/tdwh-3krx.csv?$limit=2000000
