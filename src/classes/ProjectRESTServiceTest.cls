@isTest
private class ProjectRESTServiceTest {
    @testSetup static void prepareDataSetUp(){
        // Create Opportunity
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
        project.Status__c='Billable';
        insert project;
        
    }
    
    @isTest public static void testRestRequestOKResponse(){
        RestRequest request = new RestRequest();
        
         Opportunity testOpp=new Opportunity();
        testOpp.Name='Test Rest Opportunity';
        testOpp.CloseDate=Date.today()+20;
        testOpp.StageName='Prospecting';
        insert testOpp;
        
        
        request.httpMethod='POST';
        request.requestURI = '/project';
        String ProjectRef='Proj-111';
        String ProjectName='Test Project';
        String OpportunityId=testOpp.Id;
        Date StartDate=Date.today();
        Date EndDate=Date.today()+1;
        Double Amount=1200.00;
        String Status='Billable';
        String requestStatus = ProjectRESTService.postProjectData(ProjectRef, ProjectName, OpportunityId, StartDate, EndDate, Amount, Status);
        System.assertEquals('OK', requestStatus.toUpperCase());
    }
    
    @isTest public static void testRestRequestErrorResponseResponse(){
        RestRequest request = new RestRequest();
        
       
        request.httpMethod='POST';
        request.requestURI = '/project';
        String ProjectRef='';
        String ProjectName='';
        String OpportunityId='1234567';
        Date StartDate=Date.today();
        Date EndDate=Date.today()+1;
        Double Amount=1200.00;
        String Status='Billable';
        String requestStatus = ProjectRESTService.postProjectData(ProjectRef, ProjectName, OpportunityId, StartDate, EndDate, Amount, Status);
        System.assertNotEquals('OK', requestStatus.toUpperCase());
    }
    
}