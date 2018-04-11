public with sharing	class ProjectServiceHandler {
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public ProjectServiceHandler(boolean m_isExecuting,integer BatchSize){
        this.m_isExecuting=m_isExecuting;
        this.BatchSize=BatchSize;
    }
    
    public void OnBeforeInsert(Project__c [] projects){
        
    }
    
    public void OnAfterInsert(Project__c [] projects){
        
    }
    @future
    public static void OnAfterInsertAsync(Set<ID> newprojectsIDs){
        
    }
    
    public  void OnBeforeUpdate(Project__c[] oldProjects, Project__c [] updatedProjects, Map<ID, Project__c> projectMap){
        
    }
    
    public  void OnAfterUpdate(Project__c[] oldProjects, Project__c [] updatedProjects, Map<ID, Project__c> projectMap){
        
    }
    @future
    public static void OnAfterUpdateAsync(Set<ID> updatedProjectIDs){
        
    }
    
    public  void OnBeforeDelete(Project__c[] deletedProjects, Map<ID, Project__c> projectMap){
        
    }
    
    public  void OnAfterDelete(Project__c[] deletedProjects, Map<ID, Project__c> projectMap){
        
    }
    
    @future
    public static void OnAfterDeleteAsync(Set<ID> deletedProjectIDs){
        
    }
    
    public  void OnUndelete(Project__c [] projects){
        
    }
    
    public boolean IsTriggerContext{
        get{ return m_isExecuting;}
    }
    
    public boolean IsVisualforcePageContext{
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsWebServiceContext{
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsExecuteAnonymousContext{
        get{ return !IsTriggerContext;}
    }
}