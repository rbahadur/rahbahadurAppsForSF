({
    doInit : function(component, event, helper) {
        var sObj = component.get("v.sObjectName");
        var recId = component.get("v.recordId");
        if(sObj){
            helper.getLabelForRecord(component, sObj);
            helper.getBadgesForRecord(component, recId, sObj);
        }
    },
    //future code here
})