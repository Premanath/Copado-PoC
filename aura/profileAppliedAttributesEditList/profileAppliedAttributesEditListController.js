({
	handleAppliedAttributeClicked : function(component, event) {
        var clickedAppliedAttributeName = event.target.innerText.trim(); // don't use innerHTML as it contains html encoded entities
        var unapplyAttributeEvent = component.getEvent("unapplyAttribute");
        unapplyAttributeEvent.setParams({
            "attributeName" : clickedAppliedAttributeName
        });
        unapplyAttributeEvent.fire();
	},

    filterUnappliedAttributes : function(component, event) {
        var i, j, k;
        var src = event.getSource();
        var searchPattern = src.get("v.value");

        var unappliedAttributesFilteredEvent = $A.get("e.vlocity_cmt:profileUnappliedAttributesFilteredEvent");

        if (searchPattern === null || searchPattern === "") {

            unappliedAttributesFilteredEvent.setParams({
                "undoFilteringFlag" : true,
                "filteredList" : [],
                "searchPattern" : searchPattern,
                "searchPatternExistAsAttributeFlag" : false
            });
            unappliedAttributesFilteredEvent.fire();

        } else {

            var unappliedAttributesToBeSearched = component.get("v.unappliedAttributesToBeSearched");
            var searchRegExp = new RegExp(searchPattern, "i"); // search case insensitive
            var unappliedAttributesFilteredList = [];
            //alert("searching unappliedAttributesToBeSearched....");
            for (i=0; i<unappliedAttributesToBeSearched.length; i+=1) {
            	//alert("unappliedAttributesToBeSearched[" + i + "].Name: " + unappliedAttributesToBeSearched[i].Name);
                var n = unappliedAttributesToBeSearched[i].Name.search(searchRegExp);
                if (n >= 0) {
                    unappliedAttributesFilteredList.push(unappliedAttributesToBeSearched[i]);
                }
            }

            // determine if searchPattern exist as an attribute before
            var searchPatternExistAsAttributeFlag = false;

            // determine if searchPattern exist as an applied attribute
            var appliedAttributes = component.get("v.appliedAttributes");
            for (j=0; j<appliedAttributes.length; j+=1) {
                if (searchPattern.toUpperCase() === appliedAttributes[j].Name.toUpperCase()) {
                    searchPatternExistAsAttributeFlag = true;
                    break;
                }
            }

            // determine if searchPattern exist as an unapplied attribute
            if (!searchPatternExistAsAttributeFlag) {
                for (k=0; k<unappliedAttributesToBeSearched.length; k+=1) {
                    if (searchPattern.toUpperCase() === unappliedAttributesToBeSearched[k].Name.toUpperCase()) {
                        searchPatternExistAsAttributeFlag = true;
                        break;
                    }
                }
            }

            unappliedAttributesFilteredEvent.setParams({
                "undoFilteringFlag" : false,
                "filteredList" : unappliedAttributesFilteredList,
                "searchPattern" : searchPattern,
                "searchPatternExistAsAttributeFlag" : searchPatternExistAsAttributeFlag
            });
            unappliedAttributesFilteredEvent.fire();
        }
    },

    handleApplyAttributeSucceededEvent : function(component) {
        //alert("appliedAttributesList handleApplyAttributeSucceededEvent!");

        var typeAheadInputCmp = component.find("type-ahead-input");
        // reset input text to blank and unappliedAttributesToBeSearched to empty array when attribute has been successfully applied
        typeAheadInputCmp.set("v.value", "");
    }

})