public with sharing class WarehouseCalloutService{
	private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
	@future(callout=true)
    public static void runWarehouseEquipmentSync(){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(WAREHOUSE_URL);
		request.setMethod('GET');
		HttpResponse response = http.send(request);
            List<Product2> listOfProduct2ToUpser=new List<Product2>();
		// If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
             List<Object> productList= (List<Object>)JSON.deserializeUntyped(response.getBody());           
             for (Object products: productList) {
                 Map<String, Object> mapobj = (Map<String, Object>)products;
                 Product2 product=new Product2();
                 Integer maintenanceperiod = (Integer)mapobj.get('maintenanceperiod');               
                 Integer Lifespan = (Integer)mapobj.get('lifespan');
                 Integer Cost = (Integer)mapobj.get('cost');
                 Boolean replacement = (Boolean)mapobj.get('replacement');
                 Integer quantity = ((Integer)mapobj.get('qIntegerntity'));
                 product.Name  = (String)mapobj.get('name'); 
                 product.Maintenance_Cycle__c = Integer.valueof(maintenanceperiod);
                 product.Cost__c = Cost;
                 product.Current_Inventory__c = quantity;
                 product.Lifespan_Months__c = Lifespan; 
                 product.Replacement_Part__c = replacement;
                 product.Warehouse_SKU__c = (String) mapobj.get('sku');
                 product.ProductCode = (String)mapobj.get('_id');       
                 listOfProduct2ToUpser.add(product);                 
            }
        }
        if(listOfProduct2ToUpser.size() > 0){
            System.debug(listOfProduct2ToUpser);
            upsert listOfProduct2ToUpser Product2.Fields.Warehouse_SKU__c;
        }
    }

}