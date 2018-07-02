({
	getBaseURL : function(cmp) {
        if (/livepreview/.test(window.location.host)) {
            cmp.set('v.hostURL', window.location.protocol + '//' + window.location.host + '/sfsites/c');
        } else {
            cmp.set('v.hostURL', window.location.protocol + '//' + window.location.host + window.location.pathname.split("/s/")[0]);
        }
        var getNameSpacePrefix = cmp.get('c.getNameSpacePrefix');
        getNameSpacePrefix.setCallback(this, function(result) {
            var ns = result.getReturnValue() || '';
            var sampleEl = document.createElement("a");
            sampleEl.href = cmp.get('v.hostURL') + '/apex/' + ns + 'UniversalCardPage?layout=' + cmp.get('v.layout') + '&id=' + cmp.get('v.recordId') + '&useCache=' + (!cmp.get('v.disableCache')) + cmp.get('v.baseURL');
            cmp.set("v.url", sampleEl.href);
        });
        $A.enqueueAction(getNameSpacePrefix);
        
	},

    handleUrl: function(cmp, url, action, contextId, sObjectType) {
        if (/^\/[a-zA-Z0-9]+(\?.*)*$/.test(url)) {
            // special case for view object
            var urlEvent = $A.get("e.force:navigateToSObject");
            urlEvent.setParams({
                "recordId": url.substring(1)
            });
            urlEvent.fire();
        } else if (/^\/([a-zA-Z0-9]+)\/e(\?.*)*$/.test(url)) {
            // special case for edit object 
            var result = /^\/([a-zA-Z0-9]+)\/e(\?.*)*$/.exec(url);
            var urlEvent = $A.get("e.force:editRecord");
            urlEvent.setParams({
                "recordId": result[1]
            });
            urlEvent.fire(); 
            cmp.set('v.hostURL', 'about:');
            cmp.set('v.src', 'blank');
        } else {
            this.handleRegularAction(cmp, action, contextId, sObjectType)
        }
    },

    handleRegularAction: function(cmp, action, contextId, sObjectType) {
        var urlHelper = document.createElement('a');
        var actionFramePage = cmp.get('v.openInActionsIn');
        if (actionFramePage) {
            if(action.isCustomAction) {
                var oldStyleOmniRegex = new RegExp("/OmniScriptType/[^/]*/OmniScriptSubType/[^/]*/OmniScriptLang/[^/]*/");
                urlHelper.href = action.url;
                if (action.type === 'OmniScript') {
                    // need to parse url for vfpage, type, subtype, lang
                    var queryString = "actionUrl=" + encodeURIComponent(action.url);
                    urlHelper.href = actionFramePage + '?' + queryString;
                } else if (oldStyleOmniRegex.test(urlHelper.hash) ||
                    (/OmniScriptType=/.test(urlHelper.search) &&
                        /OmniScriptSubType=/.test(urlHelper.search) &&
                        /OmniScriptLang=/.test(urlHelper.search))) {
                    var queryString = "actionUrl=" + encodeURIComponent(action.url);
                    urlHelper.href = actionFramePage + '?' + queryString;
                }
            } else {
                var urlHelper = document.createElement('a');
                urlHelper.href = action.URL__c || action.Url__c;
                if (urlHelper.hostname !== window.location.host || urlHelper.protocol !== window.location.protocol) {
                    var getUrlForAction = cmp.get('c.getUrlForAction');
                    getUrlForAction.setParams({
                        actionId: action.Id,
                        contextId: contextId,
                        objType: sObjectType
                    });
                    getUrlForAction.setCallback(this, function(result) {
                        var urlEvent = $A.get("e.force:navigateToURL");
                        urlEvent.setParams({
                            "url": result.getReturnValue()
                        });
                        urlEvent.fire();
                    });
                    $A.enqueueAction(getUrlForAction);
                    return;
                } else {
                    urlHelper.href = actionFramePage;
                    var queryString = 'actionId=' + encodeURIComponent(action.Id) + "&contextId=" + encodeURIComponent(contextId) + '&objType=' + sObjectType;
                    if (urlHelper.search == "") {
                        urlHelper.href = actionFramePage + '?' + queryString;
                    } else {
                        urlHelper.search += '&' + queryString;
                    }
                }
            }
        } else {
            urlHelper.href = action.URL__c || action.Url__c;
        }
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": urlHelper.pathname + urlHelper.search + urlHelper.hash
        });
        urlEvent.fire();
    }
})