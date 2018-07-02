({
    doInit : function(cmp, event, helper) {
        var url = window.location.host;
        var isPreview = false;
        if (/livepreview/.test(url)) {
            cmp.set('v.isPreview', true);
            isPreview = true;
        }
        if (!isPreview) {
            helper.getBaseURL(cmp);
            var match = /[?&]{1}actionUrl=([^&#]*)/i.exec(window.location.search);
            if (match && match.length>1) {
                var protocolRegex = new RegExp('://');
                var actionUrl = decodeURIComponent(match[1]);
                // parse URL to ensure it's relative
                var hrefHelper = document.createElement('a');
                hrefHelper.href = ((!protocolRegex.test(actionUrl) && actionUrl.charAt(0) !== '/') ? '/' : '') + actionUrl;
                helper.handleURL(cmp, hrefHelper.pathname + hrefHelper.search + hrefHelper.hash);
            } else if (/actionid=([a-zA-Z0-9]*)/i.test(window.location.search)) {
                var match = /actionid=([a-zA-Z0-9]*)/i.exec(window.location.search);
                if (match && match.length > 1) {
                    var contextId = /contextId=([a-zA-Z0-9]*)/i.exec(window.location.search);
                    var objType = /objType=([a-zA-Z0-9]*)/i.exec(window.location.search);
                    helper.getUrlForAction(cmp, match[1], (contextId && contextId.length > 1 ? contextId[1] : null), (objType && objType.length > 1 ? objType[1] : null));
                } else {
                    cmp.set('v.isOmniScriptValid', false);
                }
            } else {
                cmp.set('v.isOmniScriptValid', false);
            }
        }
    },

    setupIframeResizer: function(cmp, event, helper) {
        var actionHandler = $A.getCallback(function(data) {
            var message = data.message;
            switch (message.message) {
                case 'actionLauncher:windowopen': if (message.action.OpenURLMode__c == 'Current Window') {
                                                        var urlEvent = $A.get("e.force:navigateToURL");
                                                        urlEvent.setParams({
                                                            "url": message.path
                                                        });
                                                        urlEvent.fire();
                                                    } else {
                                                        window.open(message.path, message.params);
                                                    }
                                                    break;
                case 'omni:doneCancelAux':      helper.handleNavigation(cmp, message.type, message.destination);
                                                break;
                case 'omni:cancelGoBack':       window.history.back();
                                                break;
                default: // no-op
            }
        }); 
        var config = {
            log: true, 
            checkOrigin:false, 
            scrolling: 'auto',
            heightCalculationMethod: 'lowestElement', 
            messageCallback: actionHandler
        };
        if (cmp.get('v.maxHeight')) {
            config.maxHeight = Number(''+cmp.get('v.maxHeight').replace('px', ''));
        }
        var iframeElement = cmp.find('iframe');
        if (iframeElement) {
            iFrameResize(config, iframeElement.getElement());             
        }
    }
})