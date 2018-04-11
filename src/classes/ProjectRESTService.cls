@RestResource(urlMapping='/project/*')
global class ProjectRESTService {
    //Implement service logic here
    @HttpPost
    global static String  postProjectData(String ProjectRef,String ProjectName,String OpportunityId,Date StartDate, Date EndDate,Double Amount, String Status){
        Boolean isRecordExist=false;
        List<Project__c> projects = [SELECT Billable_Amount__c,End_Date__c,Id,Name,Opportunity__c,ProjectRef__c,Start_Date__c,Status__c FROM Project__c WHERE ProjectRef__c = :ProjectRef];
        Project__c project = new Project__c();
        if(projects.size() > 0){
            project = projects.get(0);
            isRecordExist=true;
        }
            
        
        String successORFailureString='OK';
        Savepoint sp = Database.setSavepoint();
        try{
            project.ProjectRef__c=ProjectRef;
            project.Name=ProjectName;
            project.Start_Date__c=StartDate;
            project.End_Date__c=EndDate;
            project.Billable_Amount__c=Amount;
            project.Status__c=Status;
            if(isRecordExist){
             upsert project;
            }else{
             project.Opportunity__c=OpportunityId;
             insert project;
            }
            
            Opportunity opportunity = [SELECT Id, DeliveryInstallationStatus__c FROM Opportunity WHERE Id = :OpportunityId];       
            opportunity.Id=OpportunityId;
            opportunity.DeliveryInstallationStatus__c='In Progress';
            update opportunity;
        }catch(Exception e){
            successORFailureString=e.getMessage();
            Database.rollback(sp);
        }
        
        return successORFailureString;
        
        
    }
}