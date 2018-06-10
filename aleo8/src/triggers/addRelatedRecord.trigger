/*
@author Amitabh date July 10, 2018
adding an opportunity record after checking if no Opportunty record exits
Checking if an existing opportunity exits will check the recursion
*/
trigger addRelatedRecord on Account (before insert, before update) {
    //Step1 checking getting all the opportunity records for the account
    //getting the related opportunity of the account in a map
    	Map<Id,Account> accsWithOpps = new Map<Id,Account>(
        [Select Id,(select Id from opportunities)from account where Id IN:Trigger.new]);
    //Step2 will check if the size is 0
    //iterating thru all the accounts
    for(Account a:Trigger.new){
        System.debug('acctswithOppt'+accsWithOpps.get(a.Id).opportunities.size());
    }
    //Step2 insert a new opportunity to that Account.

}