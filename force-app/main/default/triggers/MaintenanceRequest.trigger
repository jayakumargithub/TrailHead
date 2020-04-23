trigger MaintenanceRequest on Case (before update, after update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders
    // 
     Map<Id,Case> maintananceRequest = new Map<Id,Case>();
    
    if(Trigger.isUpdate && Trigger.isAfter){
        for(Case oCase : Trigger.new){
            if(oCase.IsClosed && (oCase.Type == 'Repair') ||(oCase.Type == 'Routine Maintenance')){
                maintananceRequest.put(oCase.Id, oCase);
            }
        }
    }
    if(maintananceRequest.size() > 0){
        MaintenanceRequestHelper.updateWorkOrders(maintananceRequest);
    }

}