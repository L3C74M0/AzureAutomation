# Automate power on and off of Azure resources with Azure Automation (Runbooks)
 Before starting this tutorial, you should be aware that Azure Automation has a cost that you can check here: https://azure.microsoft.com/en-us/pricing/details/automation/

-----------------------

Create the necessary resources:
 To automate the shutdown of Azure resources, you first create an Azure automation resource. A runbook is then created:
  * Runbook Type: Powershell
  * Runtime Version: 7.2 (It is the one used in the code that I share with you)

Now create a Managed Identity resource within the resource group you want to manage

* ![CreateResource](https://github.com/L3C74M0/AzureAutomation/assets/47828446/b85ca02b-e0a2-46a8-bd55-d9b55c8d98a5)

Then, inside the Automation Account - Identity - User Assigned resource add the Managed Identity resource that was created in the previous step

* ![UserAssigned](https://github.com/L3C74M0/AzureAutomation/assets/47828446/5b7aa8c5-09bd-436a-80e0-1c976b9ba625)

Now verify that the automation account is assigned the Managed Identity resource.

* ![AutomationAccess](https://github.com/L3C74M0/AzureAutomation/assets/47828446/eb44f873-fd00-47da-adba-4a4e2615efaa)

Finally, add the Identity to the resource or resources that you want to automate.

* ![DBAccess](https://github.com/L3C74M0/AzureAutomation/assets/47828446/75a42315-7333-4851-a071-b7a3b280aa20)

-----------------------

Copy the code that I share and replace the variables under the `#replace` comment with the data from your Azure account.

* ![replace](https://github.com/L3C74M0/AzureAutomation/assets/47828446/9fd35f25-1f20-4262-8c00-b90a707102ac)

Test that the code works using the Test pane function.

* ![testPane](https://github.com/L3C74M0/AzureAutomation/assets/47828446/05126bf9-eb2d-4c55-ab70-1ae179119438)

> If it doesn't work, check your account permissions, this is usually the biggest problem. The code that I share works correctly with the necessary permissions.

> To find out if your resource has stopped or started, open the resource you want to stop or start in another tab of your browser and run the test, it will ask you for a parameter, enter stop or start as the case may be and the resource will not take long to execute the action.

-----------------------

To automate the execution of the runbooks, within the Azure Automation resource, go to the Schedules tab and create a new schedule.

* Set the start time (Time the runbook script will be executed) and the recurrence.

> In my case I want a resource to start every day at 8am and shutdown at 6pm. (You must create a schedule to start and a schedule to stop)

Then go to the runbook you created and select link to schedule, select the schedule you just created and in parameters and run settings write: stop or start as appropriate.

-----------------------

And voila, you already have automated turning on and off of resources in Azure through Azure Automation using Schedules.
 
