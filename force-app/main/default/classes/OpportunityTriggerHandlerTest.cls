@IsTest
public with sharing class OpportunityTriggerHandlerTest {

    @TestVisible
    private final String TASK_SUBJECT = 'Follow up Closed Won';

    @TestSetup
    static void createTestOpportunity(){


        
    }


    /*
    public OpportunityTriggerHandlerTest() {

    }
    */

    @IsTest
    public static void checkOpportunityBindings(){

        Opportunity testOpportunity = new Opportunity(Name = 'Test Opportunity', CloseDate = date.newInstance(2001, 3, 21), StageName = 'Closed Won');
        //opportunity.StageName = 'Closed Won';

        insert testOpportunity;

        //List<Task> = new List<Task>()
        //Task targetTask 
        List<Task> targetTasks = [SELECT Subject FROM Task WHERE WhatId = :testOpportunity.Id];
        System.debug('OUTPUT:' + targetTasks);
        System.debug(targetTasks);
        System.assertEquals(false, targetTasks.isEmpty());

    }
}
