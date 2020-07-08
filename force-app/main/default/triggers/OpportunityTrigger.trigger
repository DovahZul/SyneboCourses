trigger OpportunityTrigger on Opportunity (after insert, after update) {

    if(Trigger.isAfter && Trigger.isUpdate){

        System.debug('[OpportunityTrigger] before update');
        OpportunityTriggerHandler.handleAfterUpdate(Trigger.oldMap, Trigger.new);

        

    }

    if(Trigger.isAfter && Trigger.isInsert){

        System.debug('[OpportunityTrigger] before insert');
        OpportunityTriggerHandler.handleAfterInsert(Trigger.new);

    }
    


}