public with sharing class OpportunityTriggerHandler {
    
    public OpportunityTriggerHandler() {

        System.debug('[OpportunityTriggerHandler] constructor init');

    }

    public static void handleAfterInsert(List<Opportunity> opportunities){
        
        List<Task> toInsert = new List<Task>();
        for(Opportunity op : opportunities){
            if(op.IsWon == true ){
                toInsert.add(new Task(Subject = 'Follow up Closed Won', WhatId = op.Id));
            }
        }

        if(!toInsert.isEmpty()){
            insert toInsert;
        }
    }
    
    public static void handleAfterUpdate(Map<Id,Opportunity> oldMap, List<Opportunity> opportunities){
            
        List<Task> toInsert = new List<Task>();
            for(Opportunity op : opportunities){
                if(oldMap.get(op.Id).StageName != op.StageName && op.IsWon == true ){
                    toInsert.add(new Task(Subject = 'Follow up Closed Won', WhatId = op.Id));
                }
            }

            if(!toInsert.isEmpty()){
                insert toInsert;
            }
    }
    
}