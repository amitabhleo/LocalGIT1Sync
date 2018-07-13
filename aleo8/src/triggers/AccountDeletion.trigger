<<<<<<< HEAD
trigger AccountDeletion on Account (before delete) {


    //Prevent the deletion of accounts if they have related opportunities.
    //this is demostration to Saurabh Kumar 11.july 2018
    for (Account a : [SELECT Id FROM Account
                     WHERE Id IN (SELECT AccountId FROM Opportunity) AND
                     Id IN :Trigger.old]) {
        Trigger.oldMap.get(a.Id).addError(
            'Cannot delete account with related opportunities.');

    }

}
=======
trigger AccountDeletion on Account (before delete) {


    //Prevent the deletion of accounts if they have related opportunities.
    for (Account a : [SELECT Id FROM Account
                     WHERE Id IN (SELECT AccountId FROM Opportunity) AND
                     Id IN :Trigger.old]) {
        Trigger.oldMap.get(a.Id).addError(
            'Cannot delete account with related opportunities.');

    }

}
>>>>>>> 51935292a62aa55d0a91fd2c3cfb00d392832ee7
