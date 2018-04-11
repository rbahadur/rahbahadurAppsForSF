@isTest
public class WarehouseSyncScheduleTest {
    public static String CRON_EXP = '0 0 1 15 3 ? 2017';
    @isTest public static void warehouseSyncTest(){
        WarehouseCalloutServiceMock warehouseCalloutServiceMock=new WarehouseCalloutServiceMock();
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, warehouseCalloutServiceMock);
        String jobId = System.schedule('ScheduledApexTest',CRON_EXP,new WarehouseSyncSchedule());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        Test.stopTest();
        System.assertEquals(CRON_EXP,ct.CronExpression);


    }
}