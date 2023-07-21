# Automate power on and off of Azure resources with Azure Automation (Runbooks)
 Before starting this tutorial, you should be aware that Azure Automation has a cost that you can check here: https://azure.microsoft.com/en-us/pricing/details/automation/

-----------------------

Create the necessary resources:
 To automate the shutdown of Azure resources, you first create an Azure automation resource. A runbook is then created:
  * Runbook Type: Powershell
  * Runtime Version: 7.2 (It is the one used in the code that I share with you)

-----------------------

Grant the necessary permissions to the role that will run the runbook.
* In your Automation resources, go to the Identity tab then User assigned and add an identity that has permission to access the resource you want to turn on or off.

![AutomationAccess](https://github.com/L3C74M0/AzureAutomation/assets/47828446/eb44f873-fd00-47da-adba-4a4e2615efaa)

![UserAssigned](https://github.com/L3C74M0/AzureAutomation/assets/47828446/5b7aa8c5-09bd-436a-80e0-1c976b9ba625)


-----------------------

Copy the code that I share and replace the variables under the `#replace` comment with the data from your Azure account.

* Test that the code works using the Test pane function.
> If it doesn't work, check your account permissions, this is usually the biggest problem. The code that I share works correctly with the necessary permissions.

* To find out if your resource has stopped or started, open the resource you want to stop or start in another tab of your browser and run the test, it will ask you for a parameter, enter stop or start as the case may be and the resource will not take long to execute the action.

-----------------------

To automate the execution of the runbooks, within the Azure Automation resource, go to the Schedules tab and create a new schedule.

* Set the start time (Time the runbook script will be executed) and the recurrence.

> In my case I want a resource to start every day at 8am and shutdown at 6pm. (You must create a schedule to start and a schedule to stop)

Then go to the runbook you created and select link to schedule, select the schedule you just created and in parameters and run settings write: stop or start as appropriate.

-----------------------

And voila, you already have automated turning on and off of resources in Azure through Azure Automation using Schedules.
 
