@isTest
public class WarehouseCalloutServiceTest {
   @isTest
    public static void testWarehouseCallOutServerice(){
        WarehouseCalloutServiceMock warehouseCalloutServiceMock=new WarehouseCalloutServiceMock();
         Test.startTest();
        Test.setMock(HttpCalloutMock.class, warehouseCalloutServiceMock);
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
        System.assertEquals(1, [Select count() from Product2]); 
    }
}