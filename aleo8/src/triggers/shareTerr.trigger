// Share an Account with every member of its Territory
trigger ShareTerr on Account (after insert, before update) {

  // Step 1: Create a set of all Zip Codes to evaluate
  Set<String> zips = new Set<String>();
  if (Trigger.isInsert) {
    // For inserted Accounts, all Zip Codes are needed
    for (Account a : Trigger.new) {
      zips.add(a.BillingPostalCode);
    }
  } else if (Trigger.IsUpdate) {
    // For updated Accounts, only evaluate changed Zip Codes
    Set<Id> changedAccs = new Set<Id>();
    for (Account a : Trigger.new) {
      String oldZip = Trigger.oldMap.get(a.Id).BillingPostalCode;
      String newZip = a.BillingPostalCode;
      if (newZip != oldZip) {
        zips.add(newZip);
        changedAccs.add(a.Id);
<<<<<<< HEAD
      }
    }

=======
      }      
    }
    
>>>>>>> 51935292a62aa55d0a91fd2c3cfb00d392832ee7
    // Step 1a: Delete sharing records from old Territories
    List<AccountShare> shares = [SELECT Id FROM AccountShare
                                  WHERE AccountId IN :changedAccs
                                    AND RowCause = 'Manual'];
    delete shares;
  }
<<<<<<< HEAD

  // Step 2: Find the matching Territories and Map them
  Map<String, Territory__c> terrMap =
=======
  
  // Step 2: Find the matching Territories and Map them
  Map<String, Territory__c> terrMap = 
>>>>>>> 51935292a62aa55d0a91fd2c3cfb00d392832ee7
    new Map<String, Territory__c>();
  List<Territory__c> terrs = [SELECT Id, Zip_Code__c,
                   (SELECT Id, User__c FROM Territory_Members__r)
                                FROM Territory__c
                                WHERE Zip_Code__c IN :zips];
  for (Territory__c terr : terrs) {
    terrMap.put(terr.Zip_Code__c, terr);
  }
<<<<<<< HEAD

=======
  
>>>>>>> 51935292a62aa55d0a91fd2c3cfb00d392832ee7
  // Step 3: Create AccountShares for all Territory Members
  List<AccountShare> shares = new List<AccountShare>();
  for (Account a : Trigger.new) {
    Territory__c terr = terrMap.get(a.BillingPostalCode);
    if (terr != null) {
      for (Territory_Member__c tm : terr.Territory_Members__r) {
        // We won't create one if they're already the owner
<<<<<<< HEAD
        //thanks for discussion with Amit Sharma on 11 july 2018
        //consider using a Map for territory members
=======
>>>>>>> 51935292a62aa55d0a91fd2c3cfb00d392832ee7
        if (tm.User__c != a.OwnerId) {
          AccountShare aShare           = new AccountShare();
          aShare.AccountId              = a.Id;
          aShare.UserOrGroupId          = tm.User__c;
          aShare.AccountAccessLevel     = 'Edit';
          aShare.OpportunityAccessLevel = 'Edit';
          shares.add(aShare);
        }
      }
    }
  }
  insert shares;
}
