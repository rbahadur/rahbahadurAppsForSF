trigger ProjectTrigger on Project__c (after delete, after insert, after undelete,after update, before delete, before insert, before update) {
    
    if(Trigger.isUpdate && Trigger.isAfter){
        for(Project__c project:Trigger.New){
            if(project.Status__c=='Billable'){
             BillingCalloutService.callBillingService(project.ProjectRef__c,project.Billable_Amount__c);
            }
        }
    }
    
   // ProjectServiceHandler projectServiceHandler=new ProjectServiceHandler(Trigger.isExecuting,Trigger.size);
   // if(Trigger.isInsert && Trigger.isBefore){
    //    projectServiceHandler.OnBeforeInsert(Trigger.new);
    //}else if(Trigger.isInsert && Trigger.isAfter){
  //      projectServiceHandler.OnAfterInsert(Trigger.new);
  //      ProjectServiceHandler.OnAfterInsertAsync(Trigger.newMap.keySet());
  //  }else if(Trigger.isUpdate && Trigger.isBefore){
  //      projectServiceHandler.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap);
  //  }else if(Trigger.isUpdate && Trigger.isAfter){
  //      projectServiceHandler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap);
  //      ProjectServiceHandler.OnAfterUpdateAsync(Trigger.newMap.keySet());
  //  }else if(Trigger.isDelete && Trigger.isBefore){
   //     projectServiceHandler.OnBeforeDelete(Trigger.old, Trigger.oldMap);
   // }else if(Trigger.isDelete && Trigger.isAfter){
  //      projectServiceHandler.OnAfterDelete(Trigger.old, Trigger.oldMap);
//        ProjectServiceHandler.OnAfterDeleteAsync(Trigger.oldMap.keySet());
   // }else if(Trigger.isUnDelete){
   //      projectServiceHandler.OnUndelete(Trigger.new);   
   // }
}