@isTest
public class ProjectCalloutServiceTest {
    
    @testSetup static void prepareDataSetUp(){
        Opportunity successOpportunity=new Opportunity();
        successOpportunity.Name='Success Opportunity';
        successOpportunity.Type = 'New Project';
        successOpportunity.Amount = 1000;
        successOpportunity.CloseDate = Date.today();
        successOpportunity.StageName = 'Submitted Project';
        insert successOpportunity;
        
        Opportunity failureOpportunity=new Opportunity();
        failureOpportunity.Name='Failure Opportunity';
        failureOpportunity.Type = 'New Project';
        failureOpportunity.Amount = 1000;
        failureOpportunity.CloseDate = Date.today();
        failureOpportunity.StageName = 'Resubmit Project';
        insert failureOpportunity;
        
        ServiceTokens__c serviceToken=new ServiceTokens__c();
        serviceToken.Name = 'ProjectServiceToken';
        serviceToken.Token__c = 'shgglskgblsbglbdsflgbldmfbgldb';
        insert serviceToken;
    }
    @isTest
    public static void testPostCalloutSuccess(){
        Opportunity opportunity=[select Id,Name from Opportunity where Name = 'Success Opportunity'];
        List<Id> oppIdList=new List<Id>();
        System.assertEquals('Success Opportunity', opportunity.Name);
        oppIdList.add(opportunity.Id);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock()); 
        ProjectCalloutService.PostOpportunityToPMS(oppIdList);
        Test.stopTest();  
        opportunity=[select Id,Name,StageName from Opportunity where Id =: opportunity.Id];
        System.assertEquals('Submitted Project', opportunity.StageName);
        
    }
    
    @isTest static void testPostCalloutFailure() {
        Opportunity opportunityFailure=[select Id,Name from Opportunity where Name = 'Failure Opportunity'];
        List<Id> oppIdFList=new List<Id>();
        System.assertEquals('Failure Opportunity', opportunityFailure.Name);
        oppIdFList.add(opportunityFailure.Id);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure()); 
        ProjectCalloutService.PostOpportunityToPMS(oppIdFList);
        Test.stopTest();  
        opportunityFailure=[select Id,Name,StageName from Opportunity where Id =: opportunityFailure.Id];
        System.assertEquals('Resubmit Project', opportunityFailure.StageName);
    }
}