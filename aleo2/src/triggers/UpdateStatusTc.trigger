trigger UpdateStatusTc on Test_Case__c (after insert, after update,after Delete)
 
{ //You want it on update too, right?
  Map<ID, Requirement__c> parentReq = new Map<ID, Requirement__c>(); //Making it a map instead of list for easier lookup
  List<Id> listIds = new List<Id>();

  for (Test_Case__c childObj : Trigger.new )
  {
    listIds.add(childObj.Requirement__c);
    
    }
    
  parentReq = new Map<Id, Requirement__c>([SELECT id, TestingCompletedCheckbox__c,(SELECT ID, Status__c FROM Test_Cases__r) FROM Requirement__c WHERE ID IN :listIds]);

  for (Test_Case__c tc: Trigger.new)
  {
     
     Requirement__c myParentReq = parentReq.get(tc.Requirement__c);
     boolean checkFlg = myParentReq.TestingCompletedCheckbox__c;
     if(checkFlg)
     {
     myParentReq.Status__c = 'Testing Completed';
     System.debug('Hello');
     }
     
   
  }
  
  
  
          update parentReq.values();
          
  
 
}