({
    getBaseURL : function(cmp, contextId, type, subtype, language) {
        var baseurl = cmp.get('c.getCommunityBaseURL');
        var me = this;
        baseurl.setCallback(this, function(b) {
            var returnObjects = b.getReturnValue();
            var a = document.createElement('a');
            a.href = returnObjects;
            cmp.set("v.hostURL", a.protocol + '//' + a.hostname + (a.port ? ':' + a.port : '') + '/');             
            cmp.set("v.baseURL", '&baseURL=' + returnObjects);
            me.getUrlForOmni(cmp, contextId, type, subtype, language);
        });
        $A.enqueueAction(baseurl);
    },
    getUrlForOmni: function(cmp, contextId, type, subtype, language) {
        var queryStringObj = {
            id: contextId,
            ContextId: contextId,
            OmniScriptType: type, 
            OmniScriptSubType: subtype,
            OmniScriptLang: language,
            scriptMode: 'vertical',
            layout: 'lightning',
            omniIframeEmbedded: true
        };
        var queryString = Object.keys(queryStringObj).reduce(function(queryString, key) {
            return queryString + (queryString.length > 1 ? '&' : '') + encodeURIComponent(key) + '=' + encodeURIComponent(queryStringObj[key]);
        }, '');
        var getNameSpacePrefix = cmp.get('c.getNameSpacePrefix');
        getNameSpacePrefix.setCallback(this, function(result) {
            var ns = result.getReturnValue() || '';
            cmp.set('v.src', '/apex/' + ns + 'OmniScriptUniversalPage?' + queryString);
        });
        $A.enqueueAction(getNameSpacePrefix);
    },
    handleNavigation: function(cmp, type, destination) {
        if (type === 'URL') {
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": destination
            });
            urlEvent.fire();
        } else if (type == 'SObject') {
            var urlEvent = $A.get("e.force:navigateToSObject");
            urlEvent.setParams({
                "recordId": destination
            });
            urlEvent.fire();
        }
    }
})