# Environment Set Up Documentation

# Purpose

This document will serve as a guide alongside the Project_Commands.Sh file in this repository for you to be able to reproduce the results demonstrated in this project in your own environment. 

# Pre-Requisites

1.	This project requires you have an Amazon AWS Account provisioned either by yourself or accessible through your work/educational organization.
a.	Amazon does offer a free tier for Amazon AWS which you can review at this URL: https://go.aws/3Rmd3vB
2.	Next, this project requires you set up a Cloud9 IDE environment within Amazon AWS to run the Project_Commands.sh file.
a.	Amazon has an excellent walkthrough you can utilize to set up your Cloud9 environment at this URL: https://bit.ly/3N5scQh

# Environment Set Up

With the Cloud9 IDE opened, in the left-hand pane, at the top of the canvas click file and select local file 
upload to upload your project files (project_commands.sh & template.json)

![image](https://github.com/sirlanceohlot/SEIS745-WorldBank/assets/62031972/f40362d3-9a48-4d9e-8c93-dbb0d3b0c9e1)

Next, you will double-click the project_commands.sh and it will open a new tab in your Cloud9 IDE.

![image](https://github.com/sirlanceohlot/SEIS745-WorldBank/assets/62031972/4008961b-9055-4ac1-8351-fc4d2aa5119f)

To open a new terminal, select the green circle with the + sign in the middle and select the option ‘New Terminal’

You will now copy each section of the project_commands.sh and past it in a new terminal window where you will run the code.

It is important you run each section of code in order or else the project will not work.

It will take 15-20 minutes for the CloudFormation process to complete before you move on to the Data Preparation section.

Data Preparation 

After you have successfully executed all the sections of code from the project_commands.sh file, you will open a new tab in your web browser and navigate to, http://<YOUR-EMR-Master-Public-DNS>:8888, you will replace the text with your EMR Master Public DNS, this is located in your EC2 instance section for the EMR Cluster you have just started in Cloud9, you can see the circled section in the image below where you can find your Public DNS you’ll copy into the URL provided. 

![image](https://github.com/sirlanceohlot/SEIS745-WorldBank/assets/62031972/058c998e-9151-496d-b699-a864f7790b8d)

Once you have navigated to the http://<YOUR-EMR-Master-Public-DNS>:8888, you will be required to enter a username & password for your HUE, guided user interface (GUI).

![image](https://github.com/sirlanceohlot/SEIS745-WorldBank/assets/62031972/9ecd22bf-76be-46b2-838c-a7dde2abfa60)

Now, it is time to start exploring the datasets we’ve created in our Amazon EMR Cluster.

