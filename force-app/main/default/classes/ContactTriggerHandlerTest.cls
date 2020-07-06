@IsTest
public with sharing class ContactTriggerHandlerTest {

    @TestSetup
    static void makeData(){

        List<Contact> contacts = new List<Contact>();
        List<Case> cases = new List<Case>();

        Contact relatedContact = new Contact(LastName = 'Bad Bob');
        Contact unrelatedContact = new Contact(LastName = 'Good Bob');
        Case openCase = new Case(ContactId = relatedContact.Id, Comments = 'open case!', Status = 'Escalated');
        Case closedCase = new Case(ContactId = unrelatedContact.Id, Comments = 'closed case!', Status = 'Closed');

        contacts.add(relatedContact);
        contacts.add(unrelatedContact);

        cases.add(openCase);
        cases.add(closedCase);

        upsert(contacts);
        upsert(cases);
        
    }
    @IsTest
    public static void proceedContacts(){

        List<Contact> toDelete = [SELECT Id from Contact WHERE LastName LIKE '%Bob%'];

        delete(toDelete);

        List<Contact> notDeleted = [SELECT ID FROM Contact WHERE LastName LIKE '%Bob%'];
        System.assertEquals(false, notDeleted.isEmpty());//!relatedContact.gotDeleted() && unrelatedContact.gotDeleted());

        

    }
}