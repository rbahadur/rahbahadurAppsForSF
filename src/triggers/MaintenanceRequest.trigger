trigger MaintenanceRequest on Case (before update, after update) {
    List<Case> relatedCases = [SELECT Id,Equipment__c,Status,Subject,AccountId,Type,ContactId,Origin,Vehicle__c,SLAViolation__c,PotentialLiability__c,Reason,Product__c FROM Case WHERE Id IN :Trigger.New];
    MaintenanceRequestHelper.updateWorkOrders(relatedCases);    
}