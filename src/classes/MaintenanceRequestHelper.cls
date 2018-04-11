public class MaintenanceRequestHelper {    
    public static void updateWorkOrders(List<Case> relatedCases){
        List<Case> newListOfCase=new List<Case>();
        for(Case caseRecord:relatedCases){
        if((caseRecord.Type=='Repair' || caseRecord.Type=='Routine Maintenance') && caseRecord.Status=='Closed'){
            Case caseRecords=new Case();
            System.debug('caseRecord.Subject' + caseRecord.Subject);
            caseRecords.Subject=caseRecord.Subject;
            caseRecords.Status='New';
            caseRecords.Type='Routine Maintenance';
            caseRecords.Date_Reported__c=Date.today();
            caseRecords.Product__c = caseRecord.Product__c;
            caseRecords.Date_Due__c=Date.today();
            caseRecords.AccountId=caseRecord.AccountId;
            caseRecords.ContactId=caseRecord.ContactId;
            caseRecords.Origin=caseRecord.Origin;
            caseRecords.Vehicle__c=caseRecord.Vehicle__c;
            caseRecords.Equipment__c=caseRecord.Equipment__c;
            caseRecords.Product__c=caseRecord.Product__c;
            caseRecords.SLAViolation__c=caseRecord.SLAViolation__c;
            caseRecords.PotentialLiability__c=caseRecord.PotentialLiability__c;
            caseRecords.Reason=caseRecord.Reason;
            newListOfCase.add(caseRecords);
        }
    }
        if(newListOfCase.size() > 0){
                System.debug(newListOfCase);
                insert newListOfCase;
        }        
     
    }        
    
}