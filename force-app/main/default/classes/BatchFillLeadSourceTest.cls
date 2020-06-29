@IsTest
public with sharing class BatchFillLeadSourceTest {
   
    @testSetup 
    public static void setup() {
        
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 10; i++) {
            leads.add(new Lead(
                Company = 'Web company', 
                Description = 'we\'re not building rockets',
                LastName = 'your advertisement could be here',
                LeadSource = 'Web'
                ));
        }
        for (Integer i = 0; i < 10; i++) {
            leads.add(new Lead(
                Company = 'ダンジョン道具屋', 
                Description = '魔王城の公式売り場へようこそ！今週中だけのは必殺罠の売出し！',
                LastName = 'サインのところ',
                LeadSource = 'Purchased List'
                ));
        }

        insert leads;

    }

    @IsTest
    public static void proceedLeads(){

        String testSource = 'Partner Refferal';
        Test.startTest();
        BatchFillLeadSource fls = new BatchFillLeadSource(testSource);
        Id batchId = Database.executeBatch(fls);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(20, [SELECT count() FROM Lead WHERE LeadSource = :testSource]);

    }
}
