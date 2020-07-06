trigger OpportunityTrigger on Opportunity (after insert, after update) {

    if(Trigger.isAfter && Trigger.isUpdate){

        System.debug('[DOVAHZUL][HANDLE][OpportunityTrigger] before update');
        OpportunityTriggerHandler.handleAfterUpdate(Trigger.new);

        

    }

    if(Trigger.isAfter && Trigger.isInsert){

        System.debug('[DOVAHZUL][HANDLE][OpportunityTrigger] before insert');
        OpportunityTriggerHandler.handleAfterInsert(Trigger.new);

    }
    


}