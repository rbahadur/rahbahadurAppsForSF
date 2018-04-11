public class BillingCalloutService {
    @future(callout=true)
    public static void callBillingService(String projectRef, Decimal billingAmount){
        ServiceCredentials__c serviceCredentials=ServiceCredentials__c.getValues('BillingServiceCredential');
        String userName=serviceCredentials.Username__c;
        String password=serviceCredentials.Password__c;
        BillingServiceProxy.project projectService=new BillingServiceProxy.project(); 
        projectService.username=serviceCredentials.Username__c;
        projectService.password=serviceCredentials.Password__c;
        projectService.billAmount=billingAmount;
        projectService.projectRef=projectRef;
        BillingServiceProxy.InvoicesPortSoap11 invoiceCallRequest = new BillingServiceProxy.InvoicesPortSoap11();
        String invoiceCallResponse = invoiceCallRequest.billProject(projectService);
        if(invoiceCallResponse!=null && invoiceCallResponse.equalsIgnoreCase('OK')){
            Project__c project=[select Id,Status__c from Project__c where ProjectRef__c =:projectRef LIMIT 1];
            if(project!=null)
                project.Status__c='Billed';
            update project;
        }
    }
}