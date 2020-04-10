global class LeadProcessor implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
       return Database.getQueryLocator(
           'SELECT ID, LeadSource from Lead'           
       );
   }
   global void execute(Database.BatchableContext bc, List<Lead> scope){
       List<Lead> leadstoUpdate = new List<Lead>();
       System.debug('scope :' + scope.size());
       for(Lead l: scope){
           l.LeadSource = 'Dreamforce'; 
           leadstoUpdate.add(l);
       }
       System.debug('leadstoUpdate ' + leadstoUpdate.size());
       update leadstoUpdate;
   }
   global void finish(Database.BatchableContext bc){
       System.debug('Batch Process Completd.');
   }

}