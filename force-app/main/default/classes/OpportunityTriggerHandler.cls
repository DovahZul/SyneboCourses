public with sharing class OpportunityTriggerHandler {
    
    public OpportunityTriggerHandler() {

        System.debug('[OpportunityTriggerHandler] constructor init');

    }

    public static void handleBeforeInsert(List<Opportunity> opportunities){
        bindTask(opportunities);
    }

    public static void handleBeforeUpdate(List<Opportunity> opportunities){
        bindTask(opportunities);
    }

    private static void bindTask(List<Opportunity> opportunities){

        List<Task> toInsert = new List<Task>();
        for(Opportunity op : opportunities){
            if(op.IsWon == true){
                toInsert.add(new Task(Subject = 'Follow up Closed Won', WhatId = op.Id));
            }
        }

        if(!toInsert.isEmpty()){
            insert toInsert;
        }
    }
}
