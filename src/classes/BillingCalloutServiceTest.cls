@isTest
private class BillingCalloutServiceTest {
    @testSetup
    public static void prepareDataSet(){
        
        Opportunity opp=new Opportunity();
        opp.Name='Test Rest Opportunity';
        opp.CloseDate=Date.today()+20;
        opp.StageName='Prospecting';
        insert opp;
        
        Project__c project = new Project__c();
        project.ProjectRef__c='Proj-111';
        project.Name='Test Project';
        project.Opportunity__c=opp.Id;
        project.Start_Date__c=Date.today();
        project.End_Date__c=Date.today()+1;
        project.Billable_Amount__c=1000;
        project.Status__c='Running';
        insert project;
        
        
        ServiceCredentials__c serviceCredentials=new ServiceCredentials__c();
        serviceCredentials.Name='BillingServiceCredential';
        serviceCredentials.Username__c='Test';
        serviceCredentials.Password__c='Test';
        insert serviceCredentials;
        
        
    }
    
    @isTest
    public static void testCallOutServiceMock(){
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
        Project__c project=[select Id,Status__c from Project__c where ProjectRef__c=:'Proj-111' LIMIT 1];
       
        Test.startTest();
         if(project!=null){
            project.Status__c='Billable';
         }
         update project;
        Test.stopTest();
        project = [select Id,Status__c from Project__c where ProjectRef__c=:'Proj-111' LIMIT 1];
        System.assertEquals('Billed', project.Status__c);
    }
    
    @isTest
    public static void testCAlloutServiceMockFailure(){
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMockFailure());
        Project__c project=[select Id,Status__c from Project__c where ProjectRef__c=:'Proj-111' LIMIT 1];
        Test.startTest();
         if(project!=null){
            project.Status__c='Billable';
         }
         update project;
        Test.stopTest();
        project = [select Id,Status__c from Project__c where ProjectRef__c=:'Proj-111' LIMIT 1];
        System.assertEquals('Billable', project.Status__c);
    }
}