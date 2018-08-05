public class SurveyQuestions {
//will run from the Case objects
    public List <SurveyQuestions__c> sur {get;set;}
    public case cs {get;set;}
        
        
    //defining the constructor
    public surveyQuestions(){
        
        sur = [SELECT Id, Name, Question_Name__c,response__c,Survey__r.Cases__c FROM SurveyQuestions__c where
              Survey__r.Cases__c =: ApexPages.currentPage().getparameters().get('id')];
        cs = [SELECT Description, Id, CaseNumber, AccountId, Type, Status, Subject, IsClosed FROM Case
             where Id =: ApexPages.currentPage().getparameters().get('id')];
        
        }
    public PageReference save1(){
        update cs;
        return null;
    }
    
}