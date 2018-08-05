trigger CodeMigrationTask on Code_Migration_Task__c (before insert) {

      set<Id> componentIds = new set<Id>{};
  
  Id currentUserId = UserInfo.getUserId();

  for (Code_Migration_Task__c cc : trigger.new)
  {
    componentIds.add(cc.Build_Item__c);
  }
  
  map<Id,Build_Item__c> components = new map<Id,Build_Item__c>([SELECT Id, 
                                  (SELECT Checked_Out_by__c
                                    FROM Code_Migration_Task__r 
                                    WHERE Checked_In_on__c = null)
                                  FROM Build_Item__c
                                  WHERE Id IN :componentIds]);
                                  
  for (Code_Migration_Task__c cc : trigger.new)
  {
    for (Code_Migration_Task__c ecc : components.get(cc.Build_Item__c).Code_Migration_Task__r )
    {
      if (ecc.Checked_Out_by__c <> currentUserId)
      {
        cc.addError('The selected Component is already checked out by another User');
      }
    }
  }

}