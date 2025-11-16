# Website Uptime Monitor 🖥️ 

🛜 The website uptime monitor will allow lambda functions with a node.js runtime environment to check every 5 mins if a business website is up and running to prevent downtime, notifications will be sent to business owners via SNS notification with an AWS EventBridge backend for scheduled website checks. Website downtime can ultimately impact sales, customer frustration and damage business reputation. 

# 🏗️ Infrastructure Work-Stack

1. Deploy a VPC with a Auto Scaling Group (ASG) and Application Load Balancer (ALB)

2. Configure a lambda function with a node.js runtime environment with a EventBridge backend for scheduled automation. 

3. Configure a DynamoDB table backend to store all URL timestamps and website data. 

4. Have SNS notifications sent via text message about website uptime status  to sales department 📲

![image alt](https://github.com/DMayrant/Website-Uptime-Monitor/blob/main/Screenshot%202568-11-15%20at%2022.31.15.png?raw=true)

### npm init -y
### npm start 


