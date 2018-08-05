public class addSurvey {
    
/*
*       @amitabh May 6, 2017 
*       This class is the controller for the CallSuvey
*/
    //Defining the Survey apex properties
    
    public Survey__c mySurvey;
    
    public addSurvey(){
    
    mySurvey = [SELECT Id, Name, Cases__c FROM Survey__c where
                cases__c = : '5009000001CgXpT' limit 1];
              // Cases__c = : ApexPages.currentPage().getParamerters().get('id')];
                }
                public Survey__c getSurvey(){
                    return mySurvey;
                }
}