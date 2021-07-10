# CB-FLTS Document Repository

This is the CB-FLTS (Computer-Based Flexible Land Tenure System) document repository configuration that is leveraged in managing scheme supporting documents. The configuration is mostly dependent on [Alfresco Community Edition](https://www.alfresco.com/products/community). The files have been customized to work and integrate with CB-FLTS Database and Desktop Client.

## Dependencies and Components

This repository has been configured to work with the following components:

|                 Component               | Version      |         Status       |
| :---------------------------------------| :----------: |:--------------------:|
|  1. Alfresco Content Services Community | 7.0.0        | Configured           |
|  2. Alfresco Repository                 | 8.423        | Installed separately |
|  3. Alfresco Share                      | 7.0.0        | Installed separately |
|  4. Apache ActiveMQ                     | 5.16.2       | Configured           |
|  5. Apache Tomcat                       | 9.0.0        | Configured           |
|  6. PostgreSQL                          | 11           | Installed separately |


## Steps
This highlights some configuration steps taken to ensure the repository runs as expected. Screenshots have been provided where necessary.

1. Clone the repository using the clone command. It is recommended to perform this action in Windows disk containing the system i.e. Local Disk C. </br> ```git clone```
2. Download the Alfresco Content Services (Community Edition) from [Alfresco Download page](https://www.alfresco.com/products/community/download). 
3. Copy the WAR files into the tomcat webapps folder.
4. Edit the alfresco configuration properties file.
5. Start the services.
6. Open the Alfresco home URL.
7. Stop the services.
