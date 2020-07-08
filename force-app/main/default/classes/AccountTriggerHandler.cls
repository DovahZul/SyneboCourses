public with sharing class AccountTriggerHandler {

    

    @TestVisible
    private static final String DEFAULT_DESCROPTION = 'New description';

    

    public static void handleBeforeInsert(List<Account> newList){
        specifyDescription(newList);
    }

    public static void handleExternalId(List<Account> accounts){
        for(Account account_i : accounts){
            ExternalIdManager.futurePopulateExternalId(account_i.Id);
        }
    }

    public static void handleAfterInsert(List<Account> newList){

         createNewTask(newList);

    }

    

    private static void specifyDescription(List<Account> newList) {
        for (Account account_i : newList) {
            account_i.Description = DEFAULT_DESCROPTION;
        }
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