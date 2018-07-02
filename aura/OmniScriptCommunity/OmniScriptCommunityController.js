({
    doInit : function(cmp, event, helper) {
        helper.getBaseURL(cmp, cmp.get('v.recordId'), cmp.get('v.type'), cmp.get('v.subtype'), cmp.get('v.language'));
    },
    setupIframeResizer: function(cmp, event, helper) {
        var config = {
            log: true, 
            checkOrigin:false, 
            scrolling: 'auto',
            heightCalculationMethod: 'lowestElement', 
            messageCallback : function(data) {
                var message = data.message;
                switch (message.message) {
                    case 'omni:doneCancelAux':  helper.handleNavigation(cmp, message.type, message.destination);
                                                break;
                    case 'omni:cancelGoBack':   window.history.back();
                                                break;
                    default: // no-op
                }
            }
        };
        if (cmp.get('v.height')) {
            config.maxHeight = Number(''+cmp.get('v.height').replace('px', ''));
        }
        var iframeElement = cmp.find('iframe');
        if (iframeElement) {
            iFrameResize(config, iframeElement.getElement());             
        }
    }
})