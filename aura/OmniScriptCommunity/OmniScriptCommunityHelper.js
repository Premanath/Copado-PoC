({
    getBaseURL : function(cmp, contextId, type, subtype, language) {
        if (/livepreview/.test(window.location.host)) {
            cmp.set('v.hostURL', window.location.protocol + '//' + window.location.host + '/sfsites/c');
        } else {
            cmp.set('v.hostURL', window.location.protocol + '//' + window.location.host + window.location.pathname.split("/s/")[0]);
        }
        this.getUrlForOmni(cmp, contextId, type, subtype, language);
    },
    getUrlForOmni: function(cmp, contextId, type, subtype, language) {
         var types = {
            "/native/bridge.app": "hybrid",
            "/one/one.app": "web"
        };
        var queryStringObj = {
            id: contextId,
            ContextId: contextId,
            OmniScriptType: type, 
            OmniScriptSubType: subtype,
            OmniScriptLang: language,
            scriptMode: 'vertical',
            layout: 'lightning',
            omniIframeEmbedded: true,
            tour: "",
            isdtp: "p1",
            sfdcIFrameOrigin: this.getOrigin(),
            sfdcIFrameHost: "sfNativeBridge"in window ? "hybrid" : types[window.location.pathname.toLowerCase()] || "web"
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
    getOrigin: function() {
        return "origin" in window.location ? window.location.origin : [window.location.protocol, "//", window.location.hostname, window.location.port ? ":" + window.location.port : ""].join("")
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