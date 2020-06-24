trigger OpportunityTrigger on Opportunity (before insert, before update) {

    if(Trigger.isBefore && Trigger.isUpdate){

        System.debug('[DOVAHZUL][HANDLE][OpportunityTrigger] before update');
        OpportunityTriggerHandler.handleBeforeUpdate(Trigger.new);

        

    }

    if(Trigger.isBefore && Trigger.isInsert){

        System.debug('[DOVAHZUL][HANDLE][OpportunityTrigger] before insert');
        OpportunityTriggerHandler.handleBeforeInsert(Trigger.new);

    }
    


}