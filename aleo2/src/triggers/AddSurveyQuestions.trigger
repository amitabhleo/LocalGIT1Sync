/*
@amitabh Oct 15,2014
Adding Questions to the SurveyQuestion Junction on Creation of a Survey
*/
trigger AddSurveyQuestions on Survey__c (after insert) {
    Set<ID> surId = new Set<Id>();
    for(Survey__c Sur: Trigger.new){
        surId.add(Sur.Id);
    }
    //Creating a new SurveyQuestions for all the Questions on every Survey creation
    List<SurveyQuestions__c> surQuesList = new List<SurveyQuestions__c>();
    For(Survey__c sur1:[Select name,Id from Survey__c where Id IN:surId]){
        For(Questions__c ques :[Select Id, Name,Type__c from Questions__c]){
            SurveyQuestions__c surQues = new SurveyQuestions__c();
            surQues.Survey__c = sur1.Id;
            surQues.Questions__c = ques.id;
            surQues.QuestionType__c = ques.Type__c;
            
            System.debug('SurveyQuestions: '+surQues.Survey__c +'--'+surQues.Survey__c);
            surQuesList.add(surQues);
            
        }
        
        upsert surQuesList;
    }
}