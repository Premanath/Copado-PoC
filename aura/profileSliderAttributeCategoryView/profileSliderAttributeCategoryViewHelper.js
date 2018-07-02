({
    getAppliedAttributes: function(component, clientId, attributeCategoryCode) {
        var action = component.get("c.getAppliedAttributes");
        action.setParams({"clientId" : clientId,
                          "categoryCode" : attributeCategoryCode});
        action.setCallback(this, function(response) {

            var state = response.getState();

            if (component.isValid() && state === "SUCCESS") {

                var returnObjects = this.parseResultSet2JSON(response.getReturnValue());
                component.set("v.appliedAttributes", returnObjects);

            } else if (component.isValid() && state === "ERROR") {

                var errors = response.getError();
                if (errors) {
                    console.error("profileSliderAttributeCategoryViewHelper: getAppliedAttributes encountered error:");
                    console.error(errors);
                    if (errors[0] && errors[0].message) {
                        console.error("profileSliderAttributeCategoryViewHelper: getAppliedAttributes: Error message: " +
                                 errors[0].message);
                    }
                } else {
                    console.error("profileSliderAttributeCategoryViewHelper: getAppliedAttributes: Unknown error");
                }

            }

        });
        $A.enqueueAction(action);
	},

    updateAppliedAttribute: function(component, clientId, attributeCategoryCode, attributeName, appliedAttributeCode, changedValue) {
        var action = component.get("c.upsertAttribute");
        // for update, must follow the following pattern: ONLY clientIdApplied, segmentCode, segmentValue are REQUIRED
        action.setParams({"clientIdApplied" : clientId,
                          "categoryCode" : "",
                          "segmentName" : "",
                          "segmentCode" : appliedAttributeCode,
                          "segmentValue" : changedValue,
                          "segmentData" : "",
                          "storyId" : ""});
        action.setCallback(this, function(response) {

            var state = response.getState();

            if (component.isValid() && state === "SUCCESS") {

                var profileAttributeValueUpdatedEvent = $A.get("e.vlocity_cmt:profileAttributeValueUpdatedEvent");
                profileAttributeValueUpdatedEvent.setParams({
                    "attributeCategoryCode" : appliedAttributeCode
                });
                profileAttributeValueUpdatedEvent.fire();

                // fire application wide event
                $A.get("e.vlocity_cmt:profileUpdatedEvent").fire();

            } else if (component.isValid() && state === "ERROR") {

                var errors = response.getError();
                if (errors) {
                    console.error("profileSliderAttributeCategoryViewHelper: updateAppliedAttribute encountered error:");
                    console.error(errors);
                    if (errors[0] && errors[0].message) {
                        console.error("profileSliderAttributeCategoryViewHelper: updateAppliedAttribute: Error message: " +
                                 errors[0].message);
                    }
                } else {
                    console.error("profileSliderAttributeCategoryViewHelper: updateAppliedAttribute: Unknown error");
                }

            }

        });
        $A.enqueueAction(action);
    },

    parseResultSet2JSON: function(resultSetString) {
        if (typeof resultSetString === 'undefined' || !resultSetString) {
            console.error("profileSliderAttributeCategoryViewHelper: resultSetString null or empty.  resultSetString skipped!");
            return null;
        }

        try {
            var obj = JSON.parse(resultSetString);
            if (obj && typeof obj === "object" && obj !== null) {
                return obj;
            } else {
                return null;
            }
        } catch (e) {
            console.error("profileSliderAttributeCategoryViewHelper: resultSetString has INVALID json format and is skipped: " + resultSetString);
            console.error(e);
            return null;
        }
    }
})