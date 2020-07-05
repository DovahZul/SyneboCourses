@IsTest
public with sharing class RemindUserBirthdayTest {

    public static String CRON_EXP = '0 0 9 1/1 * ? *'; // '0 0 9 ? * * *' '0 0 0 15 3 ? 2022'


    @TestSetup
    static void makeData(){

      // add some test contacts
      List<Contact> testContacts = new List<Contact>();
      for(Integer i = 0; i < 5; i++){
        testContacts.add(new Contact(LastName = 'lname birthday', Birthdate = System.today()));
      }
      insert(testContacts);
    }


    @IsTest
    public static void testBirthdaySpam(){

        Test.startTest();

        // Schedule the test job
        RemindUserBirthday reminder = new RemindUserBirthday();
        String jobId = System.schedule('RemindMailContactBirthday', CRON_EXP, reminder);         
        // Verify the scheduled job has not run yet.
        List<Task> lt = [SELECT Id 
          FROM Task 
          WHERE Id = :jobId];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run');

        Test.stopTest();

        lt = [SELECT Id 
        FROM Task];
        //System.assertEquals(, lt.size(), 'JobId is invalid' + jobId);
        System.assertEquals(false, lt.isEmpty(), 'Tasks were not created'+ jobId);


    }
}