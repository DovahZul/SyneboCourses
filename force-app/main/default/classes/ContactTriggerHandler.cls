public with sharing class ContactTriggerHandler {
    public ContactTriggerHandler() {

    }

    public static void handleDeletion(List<Contact> contacts){

        for(Contact contact_i : [SELECT Id 
            FROM Contact 
            WHERE Id IN (SELECT ContactId FROM Case WHERE IsClosed = FALSE)]){
                contact_i.addError('Cannot delete contact with open cases');
        }

    }

    public static void handleExternalId(List<Contact> contacts){
        for(Contact contact_i : contacts){
            ExternalIdManager.populateExternalId(contact_i.Id);
        }
    }
}
