@isTest
public class Test_UpdateStatusonBI{
    
    static testMethod void Test_UpdateStatusonBI() {
    
        User u1 = [SELECT Id,Name FROM User WHERE UserName='sunil_jayaram@gmail.com'];/*project manager*/
        User u2 = [SELECT Id,Name FROM User WHERE UserName='techm@pmo.com']; /*Functional owner BA*/
        User u3 = [SELECT Id,Name FROM User WHERE UserName='pmo@sfdc.com']; /* Team Lead*/
      
       Datetime dt = DateTime.newInstance(2012,12,28,10,0,0);
       
        Project__c Proj = new Project__c(Name = 'Test_TestClass',
                                         Project_Manager__c =u1.id, //u[0].Name , /*user*/ 
                                         Project_Start_Date__c = Date.parse('25/2/2013'),
                                         Status__c = 'Open',
                                         Project_Type__c = 'Development',
                                         Project_End_Date__c = Date.parse('25/2/2014') );
        insert Proj;
          
        Release__c Rel = new Release__c(Name='Test_Relese',
                                        Project_Name__c = Proj.Id,
                                        Start_Date__c =  Date.parse('05/3/2013'),
                                        End_Date__c =  Date.parse('06/3/2013'),
                                        Status__c = 'Planning',
                                        Type__c='Hotfix',
                                        Summary__c='test Summary');
        insert Rel;
        
        Requirement__c Req = new Requirement__c(Name= 'Test_Requirement',
                                                Release__c = Rel.Id,
                                                Type__c = 'Functional',
                                                Status__c = 'New',
                                                Priority__c = 'High',
                                                TrackList__c = 'Sales',
                                                Functional_Owner__c = u2.id,
                                                Dev_Lead__c = u3.id,
                                                Tech_Architect__c = u3.id,
                                                Detailed_Requirement__c = 'Test requirement');
        insert Req;
               
        Build_Item__c BI = new Build_Item__c(Name = 'Test_component',
                                             Requirement__c = Req.Id,
                                             Release_Name__c = Rel.Id,
                                             Build_Start_Date__c = DateTime.parse('4/4/2013 7:00 PM'),
                                             Build_EndDate__c = DateTime.parse('10/4/2013 5:45 PM') ); 
        
        
        insert BI;
        
        Code_Migration_Task__c Cmt = new Code_Migration_Task__c(Code_Migration_Task_Name__c='Test_CMT1',
                                                               Task_Type__c='Addition',
                                                               Requirement__c = Req.Id,
                                                               Release__c = Rel.Id,
                                                               Status__c='Deployed To Dev',
                                                               Build_Item__c = BI.Id,
                                                               Checked_Out_Method__c='New Sandbox',
                                                               Checked_Out_on__c= DateTime.parse('25/2/2014 5:28 PM'),
                                                               Checked_Out_by__c='00590000001Cr5x')/*user id*/;

       System.debug('before New insertion' + Cmt.Code_Migration_Task__c);
       
       insert Cmt; // Insert Code Migration Task

    }
    

}