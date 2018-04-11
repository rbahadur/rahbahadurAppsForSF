@isTest
public class MaintenanceRequestHelperTest {
    @isTest public static void testMaintenanceRequestHelperTest(){
        //Create 300 Case Records.	
        List<Case> caseList=new List<Case>();
        List<Case> caseUpdateList=new List<Case>();
        for(Integer index=0;index<300;index++){
            Case caseRecords=new Case();
            caseRecords.Subject='This is an Case Records for Testing' + index;
            caseRecords.Status='New';
            caseRecords.Origin='phone';
		    caseRecords.Type='Routine Maintenance';
	        caseList.add(caseRecords);
        }
        insert caseList;
        for(Case caseRecord:caseList){
            System.debug('ID of Created Case' + caseRecord.Id);
            caseRecord.status='Closed';
            caseUpdateList.add(caseRecord);
        }
        update caseUpdateList;
        System.assertEquals(300, [SELECT COUNT() FROM Case where type='Routine Maintenance' and Status!='Closed']);
       // System.assertEquals(300, [Select Id from Case where type='Routine Maintenance' and Status!='Closed']);
       // System.assertEquals(0, [Select Id from Case where type='Repair' and Status!='Closed' and Vehicle__c in :bulkVehicle].size());
        
        
    }
}