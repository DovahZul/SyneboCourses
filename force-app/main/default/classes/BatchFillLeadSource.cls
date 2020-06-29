global class BatchFillLeadSource implements Database.Batchable<sObject>, Database.Stateful {
    

    private String query;
    private String leadSource;
    global Integer recordsProcessed = 0;

    /*
    Web Other Purchased List


    */
    public BatchFillLeadSource(){
        this.query = 'SELECT LeadSource FROM Lead WHERE CreatedDate = LAST_N_MONTHS:2 or CreatedDate = THIS_MONTH';
        this.leadSource =  'Other';
    }
    public BatchFillLeadSource(String source){
        this.query = 'SELECT LeadSource FROM Lead WHERE CreatedDate = LAST_N_MONTHS:2 or CreatedDate = THIS_MONTH';
        this.leadSource = source != ''? source : 'Other';
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(this.query);
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        List<Lead> leads = new List<Lead>();
        for (Lead lead : scope) {
            lead.LeadSource = leadSource;
            recordsProcessed = recordsProcessed + 1;
        }
        update leads;
    }    

    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
       // Util.sendMessage(job, recordsProcessed);
    }    
}