({
    handleFilteredEvent : function(component, event) {
        var undoFilteringFlag = event.getParam("undoFilteringFlag");
        var noResultTextCmp = component.find("no-result-text");
        var addAttributeTextCmp = component.find("add-attribute-text");

        if (undoFilteringFlag) {
            //alert("undoFilteringFlag is true!");

        	$A.util.addClass(noResultTextCmp.getElement(), "hidden");
        	$A.util.addClass(addAttributeTextCmp.getElement(), "hidden");

        } else {
            //alert("undoFilteringFlag is false!");

            var filteredList = event.getParam("filteredList");
            //alert("filteredList: " + filteredList);
            if (filteredList === null || filteredList.length === 0) {
        		$A.util.removeClass(noResultTextCmp.getElement(), "hidden");
            } else {
        		$A.util.addClass(noResultTextCmp.getElement(), "hidden");
            }

            var searchPattern = event.getParam("searchPattern");
            //alert("searchPattern: " + searchPattern);
            component.set("v.searchPattern", searchPattern);

            var searchPatternExistAsAttributeFlag = event.getParam("searchPatternExistAsAttributeFlag");
            //alert("searchPatternExistAsAttributeFlag: " + searchPatternExistAsAttributeFlag);
            if (searchPatternExistAsAttributeFlag) {
                $A.util.addClass(addAttributeTextCmp.getElement(), "hidden");
            } else {
        		$A.util.removeClass(addAttributeTextCmp.getElement(), "hidden");
            }

        }
    },

	handleAddAttribute : function(component, event) {
		//alert("handleAddAttribute");
        var attributeNameToBeAdded = event.target.innerText; // don't use innerHTML as it contains html encoded entities
        //alert("attributeNameToBeAdded: " + attributeNameToBeAdded);

        var addAttributeEvent = component.getEvent("addAttribute");
        addAttributeEvent.setParams({
            "attributeName" : attributeNameToBeAdded
        });
        addAttributeEvent.fire();
	},

    handleApplyAttributeSucceededEvent : function(component) {
        //alert("addAttributesList handleApplyAttributeSucceededEvent");

        var noResultTextCmp = component.find("no-result-text");
        var addAttributeTextCmp = component.find("add-attribute-text");
        $A.util.addClass(noResultTextCmp.getElement(), "hidden");
        $A.util.addClass(addAttributeTextCmp.getElement(), "hidden");
     }

})