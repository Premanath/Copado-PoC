({
    handleNavigationEvent : function(component, event, helper) {
        var attributeCategoryCode = event.getParam("attributeCategoryCode");
        component.set("v.attributeCategoryCode", attributeCategoryCode);

        var attributeCategoryName = event.getParam("attributeCategoryName");
        component.set("v.attributeCategoryName", attributeCategoryName);

        var appliedAttributes = event.getParam("appliedAttributes");
        component.set("v.appliedAttributes", appliedAttributes);

        var entityId = event.getParam("entityId");
        component.set("v.entityId", entityId);

        var nsPrefix = event.getParam("nsPrefix");
        nsPrefix = nsPrefix?nsPrefix:"";
        component.set("v.nsPrefix", nsPrefix);

        helper.getUnappliedAttributes(component, entityId, attributeCategoryCode);
    },

    applyAttribute : function(component, event, helper) {
        var attributeNameToBeApplied = event.getParam("attributeName");
        var segmentCode = event.getParam("segmentCode");
        var entityId = component.get("v.entityId");
        helper.applyAttribute(component, entityId, segmentCode, attributeNameToBeApplied);
    },

    unapplyAttribute : function(component, event, helper) {
        var attributeNameToBeUnapplied = event.getParam("attributeName");
        var entityId = component.get("v.entityId");
        helper.unapplyAttribute(component, entityId, attributeNameToBeUnapplied);
    },

    addAttribute : function(component, event, helper) {
        var attributeNameToBeAdded = event.getParam("attributeName");
        var entityId = component.get("v.entityId");
        var attributeCategoryCode = component.get("v.attributeCategoryCode");
        helper.addAttribute(component, entityId, attributeNameToBeAdded, attributeCategoryCode);
    },

    handleBackButtonClicked : function() {
        var navigationEvent = $A.get("e.vlocity_cmt:profileNavigationEvent");
        navigationEvent.setParams({
            "navigateFrom" : "slide-to-profiler-edit",
            "navigateTo" : "slide-to-profiler-view"
        });
        navigationEvent.fire();
    }
})