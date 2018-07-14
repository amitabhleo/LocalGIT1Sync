/*
@author Amitabh July 3, 2018
Calculating the Account Sharing based on the Account pincode
The corresponding pincode will be picked from the Territory
The territory members will be shared with the Account
  Please rewrite with the following Steps
  Step1: Trigger on account pass territory ids to a Set
    Step1a: Later handle the trigger.IsUpdate with trigger.old values
    Step1b: Delete Sharing
  Step2: Create a map of string and Territory__c
        pass the territory code with the Territory
        Create a separate map for the territory with territory Territory_Members__r
  Step3: itrate thru the trigger.new account and get the BillingPostalCode
        pass this to a AccountShring object and save in a list
*/

trigger AccountTerritory on Account (before insert,after update) {
    //Step1 find the Account with pincode changed
    Set<Id> accountIds = new Set<Id>();
    for(Account acc:Trigger.new){
        //passing the Ids to the Set
        if (acc.BillingPostalCode != Null)
            accountIds.add(acc.id);
    }
    //iterate thru the account for the Territory
    List<Territory__c> listTerr = new List<Territory__c>();
    for(Account acc1:[SELECT Id, Name, BillingPostalCode FROM Account where Id IN: accountIds]){
        String billPostCode = acc1.BillingPostalCode;
        //checking the billing postal code territory
        Territory__c terr =( [SELECT Id, Name, Zip_Code__c FROM Territory__c where Zip_Code__c = : acc1.BillingPostalCode]);
        listTerr.add(terr);
    }
    System.debug('listTerr '+ listTerr[0].Name);
    //Pickup the territory members
    for(Territory__c ter1 :listTerr){
        List<Territory_Members__c> terrMembrs= ([SELECT Id, Name, User_Name__c, Territory_Name__c FROM Territory_Members__c
                                             WHERE Territory_Name__c =: ter1.Id]);
   		System.debug('terrMemebers '+ terrMembrs );
        //Populate the territory members in the AccountSharing object

    }
    /*for (Account ac1:Trigger.new) {
        AccountShare ac = new AccountShare();
        ac.Id = AccountId;
        ac.AccountAccessLevel = 'edit';
        ac.UserOrGroupId = terrMembrs.User_Name__c;
}
*/


}
