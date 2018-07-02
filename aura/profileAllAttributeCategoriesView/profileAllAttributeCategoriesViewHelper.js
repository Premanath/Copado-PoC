({
    // Make Profiler self-sufficient in getting nsPrefix, rather than relying on top-level component to pass along nsPrefix.
    // This is necessary because whereas in being embedded inside VF page would have access to the VF controller mechanism to
    // access nsPrefix, the same is NOT true for Profiler to function inside Lightning Experience.  In Lightning Experience,
    // the Profiler has NO immediate container, and has to access nsPrefix by its own means.
    getNameSpacePrefix: function(component) {
        var action = component.get("c.getNameSpacePrefix");

        action.setCallback(this, function(response) {

            var state = response.getState();

            if (component.isValid() && state === "SUCCESS") {

                var nsPrefix = response.getReturnValue();
                component.set("v.nsPrefix", nsPrefix);

                this.getAttributeCategories(component);

            } else if (component.isValid() && state === "ERROR") {

                var errors = response.getError();
                if (errors) {
                    console.error("profileAllAttributeCategoriesViewHelper.js: getNameSpacePrefix encountered error:");
                    console.error(errors);
                    if (errors[0] && errors[0].message) {
                        console.error("profileAllAttributeCategoriesViewHelper.js: getNameSpacePrefix: Error message: " +
                                 errors[0].message);
                    }
                } else {
                    console.error("profileAllAttributeCategoriesViewHelper.js: getNameSpacePrefix: Unknown error");
                }

            }

        });
        $A.enqueueAction(action);
    },

    isLanguageRTL: function(component) {
        var action = component.get("c.isLanguageRTL");

        action.setCallback(this, function(response) {

            var state = response.getState();

            if (component.isValid() && state === "SUCCESS") {

                var isLanguageRTL = response.getReturnValue();
                component.set("v.isLanguageRTL", isLanguageRTL);

            } else if (component.isValid() && state === "ERROR") {

                var errors = response.getError();
                if (errors) {
                    console.error("profileAllAttributeCategoriesViewHelper.js: isLanguageRTL encountered error:");
                    console.error(errors);
                    if (errors[0] && errors[0].message) {
                        console.error("profileAllAttributeCategoriesViewHelper.js: isLanguageRTL: Error message: " +
                                 errors[0].message);
                    }
                } else {
                    console.error("profileAllAttributeCategoriesViewHelper.js: isLanguageRTL: Unknown error");
                }

            }

        });
        $A.enqueueAction(action);
    },

    getAttributeCategories: function(component) {
        var action = component.get("c.getAttributeCategories");
        action.setParams({"entityId" : component.get("v.entityId")});

        action.setCallback(this, function(response) {

            var state = response.getState();

            if (component.isValid() && state === "SUCCESS") {

                // We are using default namespace <vlocity_cmt:mycomponent/> to specify components.  As such, it would be automatically
                // resolved in deployed org such that we do not need to use namespace prefix in component markup files.
                // However, according to Lightning chatter group, there is a bug that in expressions in cmp file, we need to
                // specify namespace in order for it to work.  That is why in the code below, we create object wrapper to contain
                // those essential info that the cmp markup file would require, such as to prevent use of namespace.

                // The expression which had problem was: <aura:if isTrue="{! equals(category.dkoon_card__UIControlType__c,'On-Off')}">
                // in the above expression, there is no way to get type unless we hardcode namespace.  Also bear in mind that
                // in Lightning expression, the property of an object can only be referenced by dot notation, not [] syntx.
                // Otherwise, we could have used category[v.nsPrefix+'UIControlType__c'].  Unfortunately, the [] notation is
                // NOT supported in Lightning expression.

                var nsPrefix = component.get("v.nsPrefix");
                var attributeCategoriesInfo = [];

                //alert("# of attributeCategories: " + a.getReturnValue().length);
                for (var i=0; i<response.getReturnValue().length; i+=1) {
                    var attributeCategoryInfo = {};
                    var attributeCategory = response.getReturnValue()[i];
                    var attributeCategoryType = attributeCategory[nsPrefix + 'UIControlType__c'];
                    var attributeCategoryCode = attributeCategory[nsPrefix + 'Code__c'];
                    var attributeCategoryName = attributeCategory.Name;
                    //alert('attributeCategory type: ' + attributeCategoryType);
                    attributeCategoryInfo.type = attributeCategoryType;
                    attributeCategoryInfo.code = attributeCategoryCode;
                    attributeCategoryInfo.name = attributeCategoryName;
                    attributeCategoriesInfo.push(attributeCategoryInfo);
                }

                component.set("v.attributeCategoriesInfo", attributeCategoriesInfo);

            } else if (component.isValid() && state === "ERROR") {

                var errors = response.getError();
                if (errors) {
                    console.error("profileAllAttributeCategoriesViewHelper.js: getAttributeCategories encountered error:");
                    console.error(errors);
                    if (errors[0] && errors[0].message) {
                        console.error("profileAllAttributeCategoriesViewHelper.js: getAttributeCategories: Error message: " +
                                 errors[0].message);
                    }
                } else {
                    console.error("profileAllAttributeCategoriesViewHelper.js: getAttributeCategories: Unknown error");
                }

            }

        });
        $A.enqueueAction(action);
	}

})