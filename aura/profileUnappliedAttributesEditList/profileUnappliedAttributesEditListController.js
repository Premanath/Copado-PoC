({

	handleUnappliedAttributeClicked : function(component, event) {
        var i;
        if (component.hasPendingUpdate === true) {
            return;
        }

        var attributeToBeAppliedName = event.target.innerText; // don't use innerHTML as it contains html encoded entities
        var unappliedAttributesForDisplay = component.get("v.unappliedAttributesForDisplay");
        var attributeToBeAppliedSegmentCode;
        for (i=0; i<unappliedAttributesForDisplay.length; i+=1) {
            if (unappliedAttributesForDisplay[i] && attributeToBeAppliedName === unappliedAttributesForDisplay[i].Name) {
                attributeToBeAppliedSegmentCode = unappliedAttributesForDisplay[i].SegmentCode;
                break;
            }
        }

        // only apply attribute if it is legit
        if (attributeToBeAppliedSegmentCode) {
            var applyAttributeEvent = component.getEvent("applyAttribute");
            applyAttributeEvent.setParams({
                "attributeName" : attributeToBeAppliedName,
                "segmentCode" : attributeToBeAppliedSegmentCode
            });
            applyAttributeEvent.fire();
            var loadingSpinner = component.find("loading-spinner");
            $A.util.removeClass(loadingSpinner.getElement(), "slds-hidden");
            component.hasPendingUpdate = true;
        }
	},

    handleFilteredEvent : function(component, event) {
        var undoFilteringFlag = event.getParam("undoFilteringFlag");

        if (undoFilteringFlag) {
            var unappliedAttributesOriginalList = component.get("v.unappliedAttributesOriginalList");
            // clone unappliedAttributesOriginalList
            var unappliedAttributesOriginalListCloned = JSON.parse( JSON.stringify( unappliedAttributesOriginalList ) );
            component.set("v.unappliedAttributesForDisplay", unappliedAttributesOriginalListCloned);

        } else {
            var filteredList = event.getParam("filteredList");
            component.set("v.unappliedAttributesForDisplay", filteredList);

        }
    },

    handleApplyAttributeSucceededEvent : function(component) {
        var unappliedAttributesOriginalList = component.get("v.unappliedAttributesOriginalList");
        // clone unappliedAttributesOriginalList
        var unappliedAttributesOriginalListCloned = JSON.parse( JSON.stringify( unappliedAttributesOriginalList ) );
        component.set("v.unappliedAttributesForDisplay", unappliedAttributesOriginalListCloned);

        var loadingSpinner = component.find("loading-spinner");
        $A.util.addClass(loadingSpinner.getElement(), "slds-hidden");
        component.hasPendingUpdate = false;
    },

    profileApplyAttributeFailedEvent: function(component) {
        var loadingSpinner = component.find("loading-spinner");
        $A.util.addClass(loadingSpinner.getElement(), "slds-hidden");
        component.hasPendingUpdate = false;
    }

})