public with sharing class ContactTriggerHandler {

    public ContactTriggerHandler() {

        System.debug('[ContactTriggerHandler] constructor init');

    }
    // prevent contact deletion when it has open cases
    public static void handleDeletion(List<Contact> contacts){

        for(Contact contact_i : [SELECT Id 
            FROM Contact 
            WHERE Id IN (SELECT ContactId FROM Case WHERE IsClosed = FALSE) AND Id IN :Trigger.old]){
                contact_i.addError('Cannot delete contact with open cases');
        }

    }

}
