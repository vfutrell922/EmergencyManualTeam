Author: Vincent Futrell
Date Last Modified: 11/27/2021

Introduction:
This ASP.NET Core application is designed to be deployed on a machine running Windows Server 2019. 
While the following instructions should work for any machine running this OS, I am deploying it on 
an Amazon EC2 running Windows Server 2019 and some instructions will be specific to EC2 instances.

1. Install the Software on your server 

Once you have your machine running Windows Server 2019, you will need to download the following 
software, I highly recommend installing a better web browser for this task as Windows Server will 
only have IE by default.
	-Install IIS Web Server
		-Enter the following command into powershell: Install-WindowsFeature –name Web-Server –IncludeManagementTools
	-Install Microsoft SQL Server 2019
		-This can be downloaded from the microsoft website
	-Install SQL Server Management Studio
		-This can be downloaded from the Microsoft website
	-Install ASP.NET Core Libraries
		-This can be downloaded from the Microsoft web site as "Download .NET runtime"
		-When asked to pick a version, select "Hosting Bundle" for Windows

	-After finishing the above installs, open IIS, navigate to your EC2 instance and restart the webserver

	-Install WebDeploy
		-Install the Web Platform Installer for IIS from the Microsoft website
		-Open IIS and select your server
		-There should now be a "Web Platform Installer" in the Management section
		-Open Web Platform Installer
		-Select the products link and search "IIS Management Service"
		-Once IIS Management Service is installed, go back to your server in IIS and click the "Stop" button
		-Open IIS Management Service and select "Enable Remote Connections"
		-Start your server back up
		-Go to "Turn Windows Features on or off" in the Windows control panel, the easiest way to find it is by searching
			in the start menu.
		-Click "next" until you reach the "Select Destination Server" page.
		-Select your EC2 instance and click "next".
		-Search "Windows Deployment service", check the box next to it and click "add features"
		-Click "next" until you reach the final page, then click "install"
		-Search the Start menu for "Services" program and execute.
		-Put "Web Management Service" in automatic mode
		-Download the latest version of Web Deploy from the Microsoft website iis.net
		-When installing Web Deploy, make sure the entire "IIS Deployment Handler" is chosen
		-Restart the webserver.

	Now Once you have finished this step you are ready to publish the application to the web server!

2. Publish the application to the server

In order to publish the application on your server, you will need to setup the publishing profile in Visual Studio.
	-Click the "Build" tab and select "publish" from the dropdown menu.
	-Select "Web Server (IIS)" as the target
	-Select "Web Deploy" as the specific target
	-Enter the credentials for your server
	-Click validate connection
		-If this fails, make sure Web Deploy is working on the server
		-Also check security settings are allowing TCP connections to the server from your machine on the port Web Deploy
			is listening (Port 8172 by default)
	-Click publish.

3. Connect the application to the database on the server
	-Open SQL Server Management Studio
	-Select your server
	-Right click the "Security" folder New -> Login...
	-Create a login name and password
	--In the Databases folder create two databases:
		1. EMTManualContext - This database will hold the handbook information
		2. EMTWebPortal - This database will hold the user identities
		-Select your login you created in the previous step for the "Owner" field
	-Update the connection strings in appsetting.production.json, in Visual Studio with your new login credentials.
	-Restart the server
