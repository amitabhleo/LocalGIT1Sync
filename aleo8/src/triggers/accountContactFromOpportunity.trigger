/*
	@author Amitabh Date June 18, 2018
	Creating a contact with the Opportunity name every time the Opportunity is modified
	and the condition is met will be using an after trigger as a new contact has to be created
*/
trigger accountContactFromOpportunity on Opportunity (after insert, after update) {
	//Step1 Passing the values of Account Ids in a set
	Set <ID> acctId = new Set<ID>();
    for(Opportunity oppty:Trigger.new){
        acctId.add(oppty.AccountId);
    }
	//Step2 quering all the opportunities for the Opportunity name under the account	
    Map<Id,Opportunity> opptMap = New Map<Id,Opportunity>(
        [Select Id,AccountId,Name from Opportunity where AccountId IN: acctId]);
    // Going Round and Round will fix once the code works this is redundent
       	//Set<Id> optyId = new Set<Id>(opptMap.keyset());
    //List<Opportunity> oppts = new List<Opportunity>(
    //[Select Id,AccountId,Name from Opportunity where Id IN: optyId]);
	//Step3 calling the trigger.new and adding the contacts in a list
	List <Contact> conts = new List<Contact>();
    for (Opportunity oppty2 : opptMap.values()){
        Contact cont = new Contact(LastName = oppty2.Name,AccountId = oppty2.AccountId);
        conts.add(cont);
    }
    
	//Step4 updating the contact 
	upsert conts;
}