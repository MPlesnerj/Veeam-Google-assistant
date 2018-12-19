# Veeam Powershell & Google Assistant
I looked at a lot of options on how to execute PowerShell on my Windows platform from a Google Assistant but found that the solution Rob Latour made with Push2Run was by far the easiest to set up.

### Disclaimer
* This project is a private one and not supported by Veeam
* I don’t have any programming skills. Everything was put together using copy & paste and trial and error.
* This is just a demo, the PowerShell scripts I made only works with VMware VM’s but with small changes, it can work with Hyper-V, Veeam Agents and Nutanix I am sure.


### Purpose
I am currently working at Veeam Software as Enterprise Pre-sales where we are doing a lot of automation projects for customers, at home, I was playing with IFTTT.com and my google assistant. **Why not combine the two?**

Let's control Veeam Backup & Replication with Google Assistant!

Of course, I will never recommend using Google Assistant to manage the Veeam Software in a production environment.

This was also a great way for me to start plying a bit with PowerShell.
### Demo
[Video on Youtube![Doemo on how to use Google Assistant to control Veeam Backup & Replication](https://user-images.githubusercontent.com/45893067/50055487-f4a4dc80-014f-11e9-895c-27449422d144.png)
](https://youtu.be/WAAgP2WiwF0)

## Overview

This is the flow of data :
 ![enter image description here](https://user-images.githubusercontent.com/45893067/50211647-69a72a80-0379-11e9-962c-dc4f269945de.png)

-The Google Assistance push the spoken message to IFTTT.

-IFTTT uses the message contents to trigger a push message to PushBullet.com platform.

-The local installed Push2Run.exe is hooked into the Pushbullet.com API platform and receive the message.

-Based on message contents Push2Run then executes PowerShell scripts that trigger functions in Veeam Backup & Replication Software

## Setup
This is what you need:
 Google Assistant on your phone or Google Home like me
 Push2Run Installation with IFTTT.com and Pushbullet.com accounts
 Powershell scripts, download here
 Veeam Backup & Replication 9.5 or newer with VMware Backup jobs
Tested with:

Veeam Backup & Replication v9.5 Update 3a
Push2Run v2.0.5

* [ ] Google Assistant on you phone or [Google Home](https://www.google.com/search?q=google%20home) like me
* [ ] [Push2Run](https://www.push2run.com/) Installation with IFTTT.com and Pushbullet.com accounts
* [ ] Powershell scripts, download  [here](https://github.com/MPlesnerj/Veeam-Google-assistant)
* [ ] [Veeam Backup & Replication 9.5](https://www.veeam.com/downloads/) or newer with VMware VM's 


Tested with:
 * Veeam Backup & Replication v9.5 [Update 3a](https://www.veeam.com/kb2646)
*  Push2Run v2.0.5
---
 ### 1. Veeam Backup & Replication - Powershell
Make sure you have a fully functional Veeam Backup & replications installation running with Powershell Snapin installed.
(Starting with Veeam Backup & Replication 9.x the PowerShell Snapin is automatically installed by default)
 ![enter image description here](https://user-images.githubusercontent.com/45893067/50068048-4be49480-01c4-11e9-90e9-3d017e8efdf4.png)
 
Make sure you got a least one backup job with VMware VM running.

---
 ### 2. Sample PowerShell scripts
PowerShell scripts can be downloaded from Github here: https://github.com/MPlesnerj/Veeam-Google-assistant
 
Download the PowerShell scripts from Github and place them on your Veeam Backup & Replication server. I used the c:\script\ folder.
 ![enter image description here](https://user-images.githubusercontent.com/45893067/50066864-76cbea00-01be-11e9-8a6c-cb5b73a29e8e.png)


##### Modify the scripts to fit your environment
Open the Powershell scripts with you favorite Powershell editor.
(I just use the build in PowerShell ISE in windows).

Locate the ``Connect-VBRServer -Server "localhost" -User "Username" -Password "password"`` an replace the **localhost**, **Username** and **Password** to fit your Veeam Software installation.

Sometimes you might see names of backup jobs and replication jobs or VM names in the scripts, changes them to fit your installation.

![enter image description here](https://user-images.githubusercontent.com/45893067/50069028-818b7c80-01c8-11e9-86b9-d9efbe9608cc.png)


To be able to execute the PowerShell script I needed to modify my Powershell Execution Policy. Run ```Set-ExecutionPolicy Unrestricted``` in PowerShell

Test the scripts to make sure they work ;-)

---
 ### 3. Push2Run Install and configurationen
 Download Push2Run.com and Install the software on your Veeam Backup & Replication server. 

Follow this nice detailed [Installation guide](https://www.push2run.com/setup.html) and make sure that the  "**OK Google tell my computer to open the calculator**" test is sucessful.

Now we can add some scripts to the Push2Run application
![enter image description here](https://user-images.githubusercontent.com/45893067/50212070-6a8c8c00-037a-11e9-9a30-4d320f23822f.png)

Listen for: 
do a quick backup of the web server 
do a quick backup of the webserver
do a quick backup of web server
do a quick backup of webserver
make a backup of the web server
make a quick backup of web server
quick backup of the web server
quick backup of the webserver
quick backup the web server
quick backup the webserver

Open: C:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe

Start directory: C:\Windows\sysnative\WindowsPowerShell\v1.0\

Parameters: & 'C:\Script\RunQuickBackup.ps1'

I found it very useful to add a lot of different 'Listen for' options, because you dont always remember the exact command need to do a quick backup of the web server. I also found that Google Assistanse sometimes hear web server as one word therefor i added "web server" and "webserver" to the mix.
I also found out that my on installation only PowerShell 32bit version was working with Veeam PowerShell Snapin, therefor i force using that version with the "C:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe". 
![enter image description here](https://user-images.githubusercontent.com/45893067/50210579-cbb26080-0376-11e9-9c15-4ebe5599f53c.png)

That is it! 

### Debug Tips
**PowerShell**


When editing in PowerShell ISE use the F8 key to run only the selected text. 
If you want to find out what in a variable, just type the variable name in the Console windows below. Like this example where i want to see what is in $vms
![enter image description here](https://user-images.githubusercontent.com/45893067/50076781-e522a380-01e2-11e9-920f-692e95e88014.png)

In the Parameter in Push2Run you can add ``-onexit`` to see possible error messages. You can also force the PowerShell window to minimize or hide right away by using the ``-WindowStyle`` parameter
![enter image description here](https://user-images.githubusercontent.com/45893067/50211276-7c6d2f80-0378-11e9-8e67-5a8f22fab16e.png)

**Push2Run**
Puch2Run got a nice Session Log function that help me debugging and adding what to listen to. 



### Credit
* Thomas Sandner, for insperation to do the project and this Readme file. https://github.com/tsandner/veeam-alexa-skill

* Rob Latour, Push2Run https://www.push2run.com/ for a easy solution to get from Google Assistance to execute local PowerShell on a Windows PC. [Go Donate](https://www.push2run.com/donate.html)

### Useful links
* Veeam official PowerShell Help: https://helpcenter.veeam.com/docs/backup/powershell/getting_started.html?ver=95
* VeeamHub on Github: https://github.com/VeeamHub for Powershell examples
* Push2Run Help: https://www.push2run.com/help_v2.0.0.0.html
* PowerShell.exe syntax: 
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_powershell_exe


