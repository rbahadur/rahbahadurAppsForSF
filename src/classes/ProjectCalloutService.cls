public class ProjectCalloutService {
    public class QueueablePMSCall implements System.Queueable, Database.AllowsCallouts{
        private String serviceToken;
        private String jsonInput;
        private String Id;
        public QueueablePMSCall(String serviceToken, String jsonInput, Id oppoId){
            this.serviceToken = serviceToken;
            this.jsonInput = jsonInput;
            this.Id = oppoId;
        }
        public void execute(QueueableContext context) {
            postToPMS(serviceToken, jsonInput, Id);
        }
    }
    @Future(callout='true')
    public static void postToPMS(String serviceToken,String jsonInput,String oppoId){
        HttpRequest httpRequest= new HttpRequest();
        httpRequest.setEndpoint('callout:ProjectService');
        httpRequest.setHeader('token', serviceToken); 
        httpRequest.setMethod('POST');
        httpRequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
        httpRequest.setBody(jsonInput);
        Http http=new Http();
        HttpResponse httpResponse=http.send(httpRequest);
        Opportunity opp=new Opportunity();
        opp.Id=oppoId;
        if(httpResponse.getStatusCode()==200){
            opp.StageName='Resubmit Project';
            System.debug('Failure: ' + httpResponse.getStatusCode() + ' ' + httpResponse.getStatus());
        }else{
            opp.StageName = 'Submitted Project';                
            System.debug('Success: ' + httpResponse.getStatus());
        }
        update opp;
        
    }
    //Complete the implementation for business and callout logic
    @InvocableMethod
    public static void PostOpportunityToPMS(List<ID> opportunityIds){
        String serviceToken = ServiceTokens__c.getValues('ProjectServiceToken').Token__c;
        Opportunity opportunity = [SELECT Id,Name,Account.Name,CloseDate,Amount FROM Opportunity WHERE Id = :opportunityIds[0]];
        String jsonInput = '{\n' +
            ' "opportunityId" : "'+opportunity.Id+'",\n'+
            ' "opportunityName" : "'+opportunity.Name+'",\n'+
            ' "accountName" : "'+opportunity.Account.Name+'",\n'+
            ' "closeDate" : "'+String.ValueOf(opportunity.CloseDate).mid(0,10)+'",\n'+   
            ' "amoun" : "'+opportunity.Amount+'"\n}';
        System.enqueueJob(new QueueablePMSCall(serviceToken, jsonInput, opportunity.Id));
    }

}