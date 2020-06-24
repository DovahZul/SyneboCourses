@IsTest
private class AccountTriggerHandlerTest {  
    
    @isTest
    static void specifyDescriptionTest() {
    	Account testAccount = new Account(
            Name = 'Test'
        );
        insert testAccount;
        testAccount = [SELECT Id, Description FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(AccountTriggerHandler.DEFAULT_DESCROPTION, testAccount.Description);
    }
    
        private static void createNewTask(List<Account> newList) {

        List<Task> taskToInsertList = new List<Task>();

        for (Account account_i : newList) {

            taskToInsertList.add(
                new Task(
                    Subject = 'Test task ' + account_i.Name,
                    WhatId = account_i.Id
                )
            );
        }

        if (!taskToInsertList.isEmpty()) {

            insert taskToInsertList;
        }
    }
}