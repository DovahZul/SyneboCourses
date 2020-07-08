trigger AccountTrigger on Account (before insert, after insert, before update, before delete) {

    System.debug('Hello World from VS! ');

    if (Trigger.isBefore && Trigger.isInsert){

        AccountTriggerHandler.handleBeforeInsert(Trigger.new);

    }

    

    if (Trigger.isAfter && Trigger.isInsert){

        AccountTriggerHandler.handleAfterInsert(Trigger.new);

    }

    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert) ){
        AccountTriggerHandler.handleExternalId(Trigger.new);
    }

    

    /**

    if (Trigger.isBefore && Trigger.isInsert) {

        System.debug('Before insert');

        

        for (Account account_i : Trigger.new) {

            account_i.Description = 'New description';

        }

    }*/

    /*

    if (Trigger.isAfter && Trigger.isInsert) {

        System.debug('After insert');

        

        List<Task> taskToInsertList = new List<Task>();

        for (Id accountId_i : Trigger.newMap.keySet()) {

            taskToInsertList.add(

                new Task(

                    Subject = 'Test task ' + Trigger.newMap.get(accountId_i).Name,

                    WhatId = accountId_i

                )

            );

        }

        if (!taskToInsertList.isEmpty()) {

            insert taskToInsertList;

        }

    }*/
    if (Trigger.isBefore && Trigger.isUpdate) {
        for (Account account_i : Trigger.new) {
            if (account_i.Phone != Trigger.oldMap.get(account_i.Id).Phone) {
                account_i.Description = 'Phone = ';
                account_i.Description += String.isNotBlank(account_i.Phone) 
                                       ? account_i.Phone 
                                       : '';
            }    
        }
    }
    
    if (Trigger.isBefore && Trigger.isDelete) {
        // Prevent the deletion of accounts if they have related opportunities.
        for (Account account_i : [
            SELECT Id FROM Account
            WHERE Id IN (SELECT AccountId FROM Opportunity) 
              AND Id IN :Trigger.old
        ]) {
            Trigger.oldMap.get(account_i.Id).addError(
                'Cannot delete account with related opportunities.');
        }
    }
}