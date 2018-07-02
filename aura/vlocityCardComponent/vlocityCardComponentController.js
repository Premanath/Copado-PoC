({
	doInit : function(cmp, event, helper) {
		helper.getBaseURL(cmp);
	},
    
    setupIframeResizer: function(cmp, event, helper) {
        var actionHandler = $A.getCallback(function(data) {
            var message = data.message;
            if (message.message == 'actionLauncher:windowopen') {
                switch(message.action.type) {
                    case 'Custom': 
                    case 'OmniScript':  helper.handleUrl(cmp, message.action.url);
                                        break;
                    default:            helper.getUrlForAction(cmp, message.action.Id, message.contextId, message.sObjType);
                }
            }
        });
        var config = {
            log: false, 
            checkOrigin:false, 
            scrolling: 'auto',
            heightCalculationMethod: 'lowestElement', 
            messageCallback: actionHandler
        };
        if (cmp.get('v.maxHeight')) {
            config.maxHeight = Number(''+cmp.get('v.maxHeight').replace('px', ''));
        }
        iFrameResize(config, cmp.find('iframe').getElement());             
    },
    
    handleCardEvent: function(cmp, event) {
        var layoutName = event.getParam("layoutName");
        var message = event.getParam("message");
        
		cmp.find('iframe').getElement().iFrameResizer.sendMessage({
            type: "cardevent",
            layoutName: layoutName,
            message: message
        });
    }
})