trigger ContactTrigger on Contact (before delete) {

    if(Trigger.isBefore && Trigger.isDelete){

        System.debug('[DOVAHZUL][HANDLE][ContactTrigger] before delete');
        ContactTriggerHandler.handleDeletion(Trigger.old);

    }

}