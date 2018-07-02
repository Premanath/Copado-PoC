({
	getBaseURL : function(cmp) {
        if (/livepreview/.test(window.location.host)) {
            cmp.set('v.hostURL', window.location.protocol + '//' + window.location.host + '/sfsites/c');
        } else {
            cmp.set('v.hostURL', window.location.protocol + '//' + window.location.host + window.location.pathname.split("/s/")[0]);
        }
	},

    getUrlForAction: function(cmp, actionId, contextId, objType) {
        var me = this;
        var getUrlForAction = cmp.get('c.getUrlForAction');
        getUrlForAction.setParams({
            actionId: actionId,
            contextId: contextId,
            objType: objType
        });
        getUrlForAction.setCallback(this, function(result) {
            var r = result.getReturnValue();
            if (r) {
                me.handleURL(cmp, r);
            } else {
                cmp.set('v.isOmniScriptValid', false);
            }
        });
        $A.enqueueAction(getUrlForAction);
    }, 

    handleURL: function(cmp, url) {
        if (url.indexOf('/apex/') > -1) {
            var indexOfQueryString = url.indexOf('?');
            if (indexOfQueryString > -1) {
                url = url.substring(0, indexOfQueryString + 1) + "omniCancelAction=back&omniIframeEmbedded=true&" + url.substring(indexOfQueryString + 1);
            } else {
                url += "?omniCancelAction=back&omniIframeEmbedded=true";
            }
            cmp.set('v.src', url);
        } else if (/^\/[a-zA-Z0-9]+(\?.*)*$/.test(url)) {
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
            var hrefHelper = document.createElement('a');
            hrefHelper.href = url;
            if (hrefHelper.hostname !== window.location.host || hrefHelper.protocol !== window.location.protocol) {
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": url
                });
                urlEvent.fire();
                window.history.back();
            } else {
                cmp.set('v.src', url);
            }
        }
        cmp.set('v.isOmniScriptValid', true);
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