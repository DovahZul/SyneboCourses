public with sharing class ExternalIdManager {

    @future
    public static void futurePopulateExternalId(Id contactId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.uuidgenerator.net/api/version1');
        request.setMethod('GET');
        HttpResponse response = http.send(request); // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            String reference = (String)JSON.deserializeUntyped(response.getBody());
            List<Contact> targetContact = [SELECT Id from Contact WHERE Id =:contactId];
           // targetContact.GUID_ID__c = reference; //??
           // upsert(targetContact);
           System.debug('got target contact id: ' + contactId + ':' + reference);
        } else {
            // Log error
        }
    }
}
