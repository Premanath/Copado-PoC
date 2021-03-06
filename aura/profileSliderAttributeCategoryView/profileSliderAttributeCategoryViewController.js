({
	doInit : function(component, event, helper) {
        var entityId = component.get('v.entityId');
        var attributeCategoryCode = component.get('v.attributeCategoryCode');
        helper.getAppliedAttributes(component, entityId, attributeCategoryCode);
    },

    handleAttributeCategoryUpdatedEvent : function(component, event, helper) {
        var attributeCategoryCode = event.getParam("attributeCategoryCode");
        if (attributeCategoryCode === component.get('v.attributeCategoryCode')) {
            var entityId = component.get('v.entityId');
            helper.getAppliedAttributes(component, entityId, attributeCategoryCode);
        }
    },

	handleProfileAttributeValueChangedEvent : function(component, event, helper) {
        var entityId = component.get("v.entityId");
        var attributeCategoryCode = component.get("v.attributeCategoryCode");
        var attributeName = event.getParam("attributeName");
        var appliedAttributeCode = event.getParam("appliedAttributeCode");
        var changedValue = event.getParam("changedValue");
        helper.updateAppliedAttribute(component, entityId, attributeCategoryCode, attributeName, appliedAttributeCode, changedValue);
    },

    editAttributes : function(component) {
        var attributeCategoryCode = component.get("v.attributeCategoryCode");
        var attributeCategoryName = component.get("v.attributeCategoryName");
        var appliedAttributes = component.get("v.appliedAttributes");
        var entityId = component.get("v.entityId");
        var nsPrefix = component.get("v.nsPrefix");
        var navigationEvent = $A.get("e.vlocity_cmt:profileNavigationEvent");
        navigationEvent.setParams({
            "navigateFrom" : "slide-to-profiler-view",
            "navigateTo" : "slide-to-profiler-edit",
            "attributeCategoryCode" : attributeCategoryCode,
            "attributeCategoryName" : attributeCategoryName,
            "appliedAttributes" : appliedAttributes,
            "entityId" : entityId,
            "nsPrefix" : nsPrefix
        });
        navigationEvent.fire();
	}
})