({
	getBaseURL : function(cmp) {
        var baseurl = cmp.get("c.getCommunityBaseURL");
		baseurl.setCallback(this, function(b) {
            var returnObjects = b.getReturnValue();
            var host = returnObjects.split(".com/");
            cmp.set("v.hostURL", host[0] + '.com/');             
            cmp.set("v.baseURL", '&baseURL=' + returnObjects);
            var getNameSpacePrefix = cmp.get('c.getNameSpacePrefix');
            getNameSpacePrefix.setCallback(this, function(result) {
                var ns = result.getReturnValue() || '';
                cmp.set("v.url", cmp.get('v.hostURL') + '/apex/' + ns + 'UniversalCardPage?layout=' + cmp.get('v.layout') + '&id=' + cmp.get('v.recordId') + '&useCache=' + (!cmp.get('v.disableCache')) + cmp.get('v.baseURL'));
            });
            $A.enqueueAction(getNameSpacePrefix);
            
        }); 
        $A.enqueueAction(baseurl);
	},
    getUrlForAction: function(cmp, actionId, contextId, objType) {
        var getUrlForAction = cmp.get('c.getUrlForAction');
        var me  = this;
        getUrlForAction.setParams({
            actionId: actionId,
            contextId: contextId,
            objType: objType
        });
        getUrlForAction.setCallback(this, function(result) {
            var r = result.getReturnValue();
            if (r) {
                me.handleUrl(cmp, r);
            }
        });
        $A.enqueueAction(getUrlForAction);
    },
    handleUrl: function(cmp, url) {
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
            var protocolRegex = new RegExp('://');
            var urlEvent = $A.get("e.force:navigateToURL");
            var hrefHelper = document.createElement("a");
            hrefHelper.href = ((!protocolRegex.test(url) && url.charAt(0) !== '/') ? '/' : '') + url;
            hrefHelper.search += (hrefHelper.search.length == 0 ? '?' : '&') + 'omniCancelAction=back'; 
            urlEvent.setParams({
                "url": hrefHelper.href,
                "isredirect": false
            });
            urlEvent.fire();
        }
    }
})