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

Copy the code that I share and replace the variables under the `#replace` comments with the data from your Azure account.

> Currently I only have the powershell code to turn the following resources on and off:
> * Azure Database For My SQL Single Server
> * Azure Container Instances
> * Azure Function App

* ![replace](https://github.com/L3C74M0/AzureAutomation/assets/47828446/9fd35f25-1f20-4262-8c00-b90a707102ac)

Test that the code works using the Test pane function.

* ![testPane](https://github.com/L3C74M0/AzureAutomation/assets/47828446/05126bf9-eb2d-4c55-ab70-1ae179119438)

> If it doesn't work, check your account permissions, this is usually the biggest problem. The code that I share works correctly with the necessary permissions.

> To find out if your resource has stopped or started, open the resource you want to stop or start in another tab of your browser and run the test, it will ask you for a parameter, enter stop or start as the case may be and the resource will not take long to execute the action.

-----------------------

To automate the execution of the runbooks, within the Azure Automation resource, go to the Schedules tab and create a new schedule.

* ![createSchedule](https://github.com/L3C74M0/AzureAutomation/assets/47828446/06d22722-1834-4fb4-9e2c-66fc86d3c397)

Set the start time (Time the runbook script will be executed) and the recurrence. 

* ![newSchedule](https://github.com/L3C74M0/AzureAutomation/assets/47828446/ef90e814-018f-4c2f-8c0e-09af460d8419)

> In my case I want the resources to start at 6AM and shutdown at 8PM from Monday to Friday

Then go to the runbook you created and select Link to schedule

* ![linkToSchedule](https://github.com/L3C74M0/AzureAutomation/assets/47828446/4d926166-78b3-4f5f-8a30-7c3f6de8520b)

Now select the schedule you just created and in parameters and run settings write: stop or start as appropriate.

* ![FinishedSchedule](https://github.com/L3C74M0/AzureAutomation/assets/47828446/4a6f654d-7be0-4529-91be-e27c96443b13) ![parameter](https://github.com/L3C74M0/AzureAutomation/assets/47828446/8bc98476-0be6-452c-8a5d-ff15ef71395f)


Finally verify that the schedules are assigned to your runbook.

* ![AddeSchedules](https://github.com/L3C74M0/AzureAutomation/assets/47828446/d7980176-b16f-4312-b177-8e09bb11f53f)

-----------------------

And voila, you already have automated turning on and off of resources in Azure through Azure Automation using Schedules.

> You can verify that runbooks are running at the times you set in the runbook overview tab.

![overview](https://github.com/L3C74M0/AzureAutomation/assets/47828446/ee06aef5-6a3b-4e27-84d5-d9378f7b7ad6)

