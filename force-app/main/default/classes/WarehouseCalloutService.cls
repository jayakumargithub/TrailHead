public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        System.debug('runWarehouseEquipmentSync');
        //ToDo: complete this method to make the callout (using @future) to the
        //      REST endpoint and update equipment on hand.
        //      
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Product2> products = new List<Product2>();
        if(response.getStatusCode() == 200){
            List<Object> equipments = (List<Object>)JSON.deserializeUntyped(response.getBody());
            
            for(Object o : equipments){
                Map<String, Object> mapProduct = (Map<String, Object>)o;
                Product2 p = new Product2();
                p.Name = (string)mapProduct.get('name');
                p.Replacement_Part__c = (boolean)mapProduct.get('replacement');
                p.Lifespan_Months__c = (integer)mapProduct.get('lifespan');
                p.Cost__c = (integer)mapProduct.get('cost');
                p.Warehouse_SKU__c = (string)mapProduct.get('sku');
                p.Current_Inventory__c = (integer)mapProduct.get('quantity');
                p.Maintenance_Cycle__c = (integer)mapProduct.get('maintenanceperiod');
                p.ProductCode = (string)mapProduct.get('_id');
                 System.debug('p:' + p);
                products.add(p);
                System.debug('products size ' + products.size());
            }
       }
        
        if(products.size() > 0){
            system.debug('products :' + products.size());
            insert products;
        }
                
    }
}