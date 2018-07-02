({
    doInit : function(component, event, helper) {
        helper.getNameSpacePrefix(component);
        helper.isLanguageRTL(component);
    },

    waiting : function(component) {
        var dataRetrieved = (component.get("v.attributeCategoriesInfo").length>0)?true:false;
        // the following will ensure that the spinner will only be used when the UI is launched the first time
        if (!dataRetrieved) {
            var loadingSpinner = component.find("loading-spinner");
            $A.util.removeClass(loadingSpinner.getElement(), "slds-hidden");
        }
    },

    doneWaiting : function(component) {
        var loadingSpinner = component.find("loading-spinner");
        $A.util.addClass(loadingSpinner.getElement(), "slds-hidden");
    }

})