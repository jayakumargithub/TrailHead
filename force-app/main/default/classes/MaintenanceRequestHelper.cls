public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(Map<Id,Case> maintainanceRequest ) {
        // TODO: Complete the method to update workorders
         Map<Id, Integer> mapProduct = new Map<Id, Integer>();
        List<Case> newCaseList = new List<Case>();
         
        
        List<Product2> listProduct = [Select Id, Maintenance_Cycle__c from Product2];
        for(Product2 p : listProduct){
            if(p.Maintenance_Cycle__c != null){
                mapProduct.put(p.Id, Integer.valueOf(p.Maintenance_Cycle__c));
            }
        }
        
        for(Case oCase : maintainanceRequest.values()){
            Case newCase = new Case();
            newCase.Vehicle__c = oCase.Vehicle__c;
            newCase.Equipment__c = oCase.Equipment__c;
            newCase.Type = 'Routine Maintenance';
            newCase.Subject = String.isBlank(oCase.Subject) ? 'Routine Maintenance Request' : oCase.Subject;
            newCase.Date_Reported__c = Date.today();
            newCase.Status = 'New';
            newCase.Product__c = oCase.Product__c;
            newCase.AccountId = oCase.AccountId;
            newCase.ContactId = oCase.ContactId;
            newCase.AssetId = oCase.AssetId;
            newCase.Origin = oCase.Origin;
            newCase.Reason = oCase.Reason;
            newCase.Date_Due__c =  (mapProduct.get(oCase.Id) != null) ? (Date.today().addDays(Integer.valueOf(mapProduct.get(oCase.Id)))) : (Date.today());
            newCaseList.add(newCase);
        }
        if(newCaseList.size() > 0){
            insert newCaseList;
        }
        }
    }