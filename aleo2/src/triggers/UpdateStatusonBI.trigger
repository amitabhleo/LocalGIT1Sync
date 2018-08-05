trigger UpdateStatusonBI on Code_Migration_Task__c (after insert, after update)
 
{ //You want it on update too, right?
  Map<ID, Build_Item__c> parentBI = new Map<ID, Build_Item__c>(); //Making it a map instead of list for easier lookup
  List<Id> listIds = new List<Id>();

  for (Code_Migration_Task__c childObj : Trigger.new )
  {
    listIds.add(childObj.Build_Item__c);
    
    }
    //Populate the map. Also make sure you select the field you want to update, amount
  //The child relationship is more likely called Quotes__r (not Quote__r) but check
  //You only need to select the child quotes if you are going to do something for example checking whether the quote in the trigger is the latest
  parentBI = new Map<Id, Build_Item__c>([SELECT id, Status__c,(SELECT ID, Status__c FROM Code_Migration_Task__r) FROM Build_Item__c WHERE ID IN :listIds]);

  for (Code_Migration_Task__c cmt: Trigger.new)
  {
     
     Build_Item__c myParentBI = parentBI.get(cmt.Build_Item__c);
     myParentBI.Status__c = cmt.Status__c;
     
     
   
  }
  
  
  
          update parentBI.values();
          
  
 
}