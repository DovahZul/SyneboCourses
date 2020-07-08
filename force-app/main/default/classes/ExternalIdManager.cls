public with sharing class ExternalIdManager {

    @future(callout=true)
    public static void futurePopulateExternalId(Id accountId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.uuidgenerator.net/api/version1');
        request.setMethod('GET');
        HttpResponse response = http.send(request); // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            String reference = (String)JSON.deserializeUntyped(response.getBody());
            List<Account> targetAccounts = [SELECT Id from Account WHERE Id =:accountId];
            if(!targetAccounts.isEmpty()){
                targetAccounts[0].GUID_ID__c = reference; //??
                upsert(targetAccounts[0]); //
            }
           System.debug('got target contact id: ' + accountId + ':' + reference);
        } else {
            // Log error
            // Log error
        }
    }
}
