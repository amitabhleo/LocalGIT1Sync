trigger AccountTrigger on Account (after insert,after update ) {
/*
*	This is an Account Trigger updating the States and City
*	On selection of a Pin Code, the relationship is Many pin codes to a city
*	and Many cities to a State, we have to traverse to the City and State from the Pin Code
*/
    
    Set<Id> pinId = new Set<Id>();
    //Step 1: Pass all values of the city id in the set
    List <Account> acc = Trigger.new;
    
    //Step 2 : iterating thru the list
    for(Account acc1 : acc){
        //passing the value of cityId in set
       pinId.add(acc1.pin_code__c );
    }
    //Step 3: Will fetch all the values of City and State for each pinCodes
    List <States__c> stList = new List<States__c>();
    List <City__c> ctyList = new List<City__c>();    
    
    for(Pin_Code__c pin : [SELECT Id, Name, City__c,city__r.name FROM Pin_Code__c where Id IN: pinId]){
        System.debug('pin '+pin);
        //passing the values in a new Map
        Map<Id,Id> ctyMap = new Map<Id,Id>();
        ctyMap.put(pin.Id, pin.City__c);
        

        }
    List<Account> accList = new List <Account>();
    for(Account acc2:Trigger.new){
        
    }
    
   
    
}