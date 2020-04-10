public with sharing class DailyLeadProcessor implements Schedulable { 

        global void execute(SchedulableContext ctx) {

            List<Lead> leads = new List<Lead>();
            if (Schema.sObjectType.Contact.fields.Name.isUpdatable()) {
                leads = [SELECT Id, LeadSource from Lead where LeadSource = '']; 
            }
                   
            for(Lead l: leads){
                l.LeadSource = 'Dreamforce';
            }
            if(leads.size() > 0)
                update leads;
            } 
        }
         
    }