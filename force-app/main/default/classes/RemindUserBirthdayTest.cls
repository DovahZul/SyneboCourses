@IsTest
public with sharing class RemindUserBirthdayTest {

    public static String CRON_EXP = '0 0 9 1/1 * ? *'; // '0 0 9 ? * * *' '0 0 0 15 3 ? 2022'

    public RemindUserBirthdayTest() {

    }


    @IsTest
    public static void testBirthdaySpam(){

        Test.startTest();

        // Schedule the test job
        RemindUserBirthday reminder = new RemindUserBirthday();
        String sch = '20 30 8 10 2 ?';
        String jobId = System.schedule('RemindMailContactBirthday', sch, reminder);         
        // Verify the scheduled job has not run yet.
        List<Task> lt = [SELECT Id 
          FROM Task 
          WHERE Id = :jobId];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run');

        Test.stopTest();

        lt = [SELECT Id 
        FROM Task];
        System.assertEquals(false, lt.isEmpty(), 'Tasks were not created');


    }
}
