(function(){var fileNsPrefix=function(){"use strict";var scripts=document.getElementsByTagName("script");var lastScript=scripts[scripts.length-1];var scriptName=lastScript.src;var parts=scriptName.split("/");var thisScript=parts[parts.length-1];if(thisScript===""){thisScript=parts[parts.length-2]}var lowerCasePrefix=thisScript.indexOf("__")==-1?"":thisScript.substring(0,thisScript.indexOf("__")+2);lowerCasePrefix=lowerCasePrefix===""&&localStorage.getItem("nsPrefix")?localStorage.getItem("nsPrefix"):lowerCasePrefix;if(lowerCasePrefix!==""){lowerCasePrefix=/__$/.test(lowerCasePrefix)?lowerCasePrefix:lowerCasePrefix+"__"}if(lowerCasePrefix.length===0){return function(){lowerCasePrefix=window.nsPrefix?window.nsPrefix:lowerCasePrefix;if(lowerCasePrefix!==""){lowerCasePrefix=/__$/.test(lowerCasePrefix)?lowerCasePrefix:lowerCasePrefix+"__"}return lowerCasePrefix}}else{var resolvedNs=null;return function(){if(resolvedNs){return resolvedNs}try{var tofind=lowerCasePrefix.replace("__","");var name;var scanObjectForNs=function(object,alreadySeen){if(object&&object!==window&&alreadySeen.indexOf(object)==-1){alreadySeen.push(object);Object.keys(object).forEach(function(key){if(key==="ns"){if(typeof object[key]==="string"&&object[key].toLowerCase()===tofind){name=object[key]+"__";return false}}if(Object.prototype.toString.call(object[key])==="[object Array]"){object[key].forEach(function(value){var result=scanObjectForNs(value,alreadySeen);if(result){name=result;return false}})}else if(typeof object[key]=="object"){var result=scanObjectForNs(object[key],alreadySeen);if(result){name=result;return false}}if(name){return false}});if(name){return name}}};if(typeof Visualforce!=="undefined"){scanObjectForNs(Visualforce.remoting.Manager.providers,[])}else{return lowerCasePrefix}if(name){return resolvedNs=name}else{return resolvedNs=lowerCasePrefix}}catch(e){return lowerCasePrefix}}}}();var fileNsPrefixDot=function(){var prefix=fileNsPrefix();if(prefix.length>1){return prefix.replace("__",".")}else{return prefix}};
(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
/*
 * Assets app using Card Framework and CPQ Hybrid
 */
angular.module('assets', ['vlocity', 'CardFramework' , 'sldsangular', 'ngSanitize', 'forceng', 'tmh.dynamicLocale', 'cfp.hotkeys', 'hybridCPQ'])

.run(['$rootScope', 'dataService', 'configService', '$window','userProfileService','tmhDynamicLocale',
         function($rootScope, dataService, configService, $window, userProfileService, tmhDynamicLocale) {
        'use strict';

        $rootScope.nsPrefix = fileNsPrefix();

        $rootScope.vlocityAssets = $rootScope.vlocityAssets || {};

        $rootScope.vlocityAssets.customSettings = $rootScope.vlocityAssets.customSettings || {};

}]);

require('./modules/hybridCPQ/controller/assets/AssetsController.js');
require('./modules/hybridCPQ/controller/assets/AssetsInfoPanelController.js');
require('./modules/hybridCPQ/controller/assets/AssetsMainController.js');
require('./modules/hybridCPQ/controller/assets/AssetsProductItemController.js');
require('./modules/hybridCPQ/factory/assets/AssetsService.js');

},{"./modules/hybridCPQ/controller/assets/AssetsController.js":2,"./modules/hybridCPQ/controller/assets/AssetsInfoPanelController.js":3,"./modules/hybridCPQ/controller/assets/AssetsMainController.js":4,"./modules/hybridCPQ/controller/assets/AssetsProductItemController.js":5,"./modules/hybridCPQ/factory/assets/AssetsService.js":6}],2:[function(require,module,exports){
angular.module('assets')
.controller('AssetsController', ['$scope', '$rootScope', '$log', 'pageService', 'dataService', 'CPQResponsiveHelper',
    function($scope, $rootScope, $log, pageService, dataService, CPQResponsiveHelper) {

    $scope.params = pageService.params;
    $scope.isMobileTablet = CPQResponsiveHelper.mobileTabletDevice;

    $rootScope.cartId = $scope.params.id;

    //Config panel is hidden on page load
    $scope.isConfigAttrsPanelEnabled = false;

    $scope.init = function() {
        $log.debug('Initializing the AssetsController');
        if (typeof Visualforce !== 'undefined') {
            $rootScope.forcetkClient = new forcetk.Client();
            $rootScope.forcetkClient.setSessionToken(sessionId);
        }
        $rootScope.vlocityAssets.enableChangeToCartButton = false;
        $rootScope.vlocityAssets.enableMoveButton = false;
    };

    // Event listener to enable the config panel
    $scope.$on('vlocity.cpq.config.configpanelenabled', function(event, isConfigEnabled, itemObject, refreshMode) {
        // If the config panel is open and refreshMode is true, don't close the config panel. It avoids the FOUC.
        if (!(refreshMode && $scope.isConfigAttrsPanelEnabled)) {
            $scope.isConfigAttrsPanelEnabled = isConfigEnabled;
        }
    });

    dataService.getCustomSettings($rootScope.nsPrefix + 'CpqConfigurationSetup__c').then(
        function(data) {
            $log.debug('retrieved custom setting ',data);
            $rootScope.vlocityAssets = $rootScope.vlocityAssets || {};
            $rootScope.vlocityAssets.customSettings = $rootScope.vlocityAssets.customSettings || {};
            angular.forEach(data, function(customSetting) {
                $rootScope.vlocityAssets.customSettings[customSetting.Name] = customSetting[$rootScope.nsPrefix + 'SetupValue__c'];
            });
            $log.debug($rootScope.vlocityAssets);
        },
        function(err) {
            $log.debug('error retrieving custom setting ',err);
        }
    );

}]);

},{}],3:[function(require,module,exports){
angular.module('assets')
.controller('AssetsInfoPanelController', ['$scope','$rootScope', 'pageService',
    function($scope, $rootScope, pageService) {

    $scope.attributesObj = null;
    $scope.configItemObject = null; // Under $scope because Telus PS team needs to access it from template
    var itemObject;

    /*********** CPQ CART ITEM CONFIG EVENTS ************/
    $scope.$on('vlocity.cpq.config.configpanelenabled', function(event, isConfigEnabled, data) {
        var  itemKeys, lookupItem, editableItem, lookupDisplayValueItemKey, cartId, lineItemId;

        if (isConfigEnabled && data.itemObject) {
            itemObject = data.itemObject;
            $scope.configItemObject = angular.copy(itemObject);
            $scope.attributesObj = itemObject.attributeCategories && itemObject.attributeCategories.records || [];

            itemKeys = _.keys(itemObject);
            $scope.lookupItemList = [];
            $scope.editableItemList = [];
            cartId = pageService.params.id;
            lineItemId = itemObject.Id.value;
            angular.forEach(itemKeys, function(key) {
                if (itemObject[key].editable && !itemObject[key].hidden) {
                    if (itemObject[key].dataType === 'REFERENCE') {
                        lookupItem = angular.copy(itemObject[key]);
                        lookupDisplayValueItemKey = key.slice(0, -1) + 'r';
                        // if lookup field has null value in the __c object, then it would not have the __r object
                        if (itemObject[lookupDisplayValueItemKey]) {
                            lookupItem.displayValue = itemObject[lookupDisplayValueItemKey].Name;
                        } else {
                            lookupItem.displayValue = '';
                            $scope.configItemObject[lookupDisplayValueItemKey] = {'Id': null, 'Name': null};
                        }
                        lookupItem.cartId = cartId;
                        lookupItem.lineItemId = lineItemId;
                        $scope.lookupItemList.push(lookupItem);
                    } else {
                        editableItem = angular.copy(itemObject[key]);
                        $scope.editableItemList.push(editableItem);
                    }
                }
            });
        }
    });
    /*********** END CPQ CART ITEM CONFIG EVENTS ************/

    /**
     * close: Closes attributes configuration panel for line item in cart
     * @param  {object} itemObject
     */
    $scope.close = function() {
        // Publishes event to enable the config panel
        $rootScope.$broadcast('vlocity.cpq.config.configpanelenabled', false);
    };

}]);

},{}],4:[function(require,module,exports){
angular.module('assets')
.controller('AssetsMainController', ['$scope', '$rootScope', '$log', '$sldsToast', 'AssetsService', 'CPQService', 'CPQPricingViewsViaCardStatesService',
 function($scope, $rootScope, $log, $sldsToast, AssetsService, CPQService, CPQPricingViewsViaCardStatesService) {

    $scope.viewOpen = false;
    $scope.tabSelected = 'Assets';
    $scope.currentPricingView = 1;

    $scope.getStateData = function(cards) {
        if (cards && cards[0].states) {
            // Assign CPQPricingViewsViaCardStatesService into $rootScope variable:
            if (!($rootScope.pricingViews && $rootScope.pricingViews.statesData.length )) {
                $rootScope.pricingViews = new CPQPricingViewsViaCardStatesService($scope, cards[0].states);
            }
        } else {
            $log.debug('There is no data for PricingView');
        }
    };

    $scope.selectAssests = function(item, selected) {
        angular.forEach(item, function(value,kay) {
            value.obj.selected = selected;
        });
        console.log('!!! selected Assets', item);
    };

    $scope.changePricingView = function(index) {
        $rootScope.$broadcast('cpq-pricing-view-changed', index);
        if (index !== 0) {
            $scope.pricingViewLabel = $rootScope.pricingViews.cpqPricingViews[index].label;
            $scope.currentPricingView = index;
            $rootScope.$broadcast('cpq-non-cart-tab-selected', $scope.attrs.showProductList);
        } else {
            $rootScope.$broadcast('cpq-cart-tab-selected');
        }
    };

    /* Custom Labels */
    $scope.customLabels = {};
    var labelsArray = ['CPQPromotions', 'CPQCartIsEmpty', 'ASSETChangeToQuote', 'ASSETChangeToOrder', 'ASSETMove'];
    CPQService.setLabels(labelsArray, $scope.customLabels);
    var toastCustomLabels = {};
    var toastLabelsArray =  ['ASSETChangeError','ASSETNoItemSelected','ASSETMoreThanOneItemSelected'];
    // Custom labels for toast messages
    CPQService.setLabels(toastLabelsArray, toastCustomLabels);
    /* End Custom Labels */

    $scope.assetChangeToQuote = function(accountId, assetIncludeType) {
        var assetIdsSelected = AssetsService.getAssetIdsSelected();
        var assetTypeSelected, changeToQuoteOSTargetUrl;
        if (assetIncludeType === 'noContractAssets') {
            assetTypeSelected = ':all:';
        } else if (assetIncludeType === 'allAssets') {
            assetTypeSelected = ':all:';
        } else if (assetIncludeType === 'billedAssets') {
            assetTypeSelected = ':billing:';
        } else if (assetIncludeType === 'serviceAssets') {
            assetTypeSelected = ':service:';
        }
        changeToQuoteOSTargetUrl = '/apex/OmniScriptUniversalPage?id=' + accountId + assetTypeSelected + assetIdsSelected +
                '#/OmniScriptType/MACD/OmniScriptSubType/ChangeToQuote/OmniScriptLang/English/ContextId/' + accountId + assetTypeSelected + assetIdsSelected +
                '/PrefillDataRaptorBundle//true';
        if (AssetsService.selectedAssetIdsForModification.length === 0) {
            $sldsToast({
                title: toastCustomLabels['ASSETChangeError'],
                content: toastCustomLabels['ASSETNoItemSelected'],
                severity: 'error',
                icon: 'warning',
                autohide: true,
                show: CPQService.toastEnabled('error')
            });
        } else {
            window.parent.location.href = changeToQuoteOSTargetUrl;
        }
    };

    $scope.assetChangeToOrder = function() {
        var assetIdsSelected = AssetsService.getAssetIdsSelected();
        var changeToOrderOSTargetUrl = '/apex/MACDFdo?id=' + assetIdsSelected +
                '#/OmniScriptType/MACD/OmniScriptSubType/FDO/OmniScriptLang/English/ContextId/' + assetIdsSelected +
                '/PrefillDataRaptorBundle//true';
        if (AssetsService.selectedAssetIdsForModification.length === 0) {
            $sldsToast({
                title: toastCustomLabels['ASSETChangeError'],
                content: toastCustomLabels['ASSETNoItemSelected'],
                severity: 'error',
                icon: 'warning',
                autohide: true,
                show: CPQService.toastEnabled('error')
            });
        } else {
            window.parent.location.href = changeToOrderOSTargetUrl;
        }
    };

    $scope.assetMove = function() {
        var assetIdsSelected = AssetsService.getAssetIdsSelected();
        var moveOSTargetUrl = '/apex/MoveInAccount?id=' + assetIdsSelected;
        if (AssetsService.selectedAssetIdsForModification.length === 0) {
            $sldsToast({
                title: toastCustomLabels['ASSETChangeError'],
                content: toastCustomLabels['ASSETNoItemSelected'],
                severity: 'error',
                icon: 'warning',
                autohide: true,
                show: CPQService.toastEnabled('error')
            });
        } else if (AssetsService.selectedAssetIdsForModification.length > 1) {
            $sldsToast({
                title: toastCustomLabels['ASSETChangeError'],
                content: toastCustomLabels['ASSETMoreThanOneItemSelected'],
                severity: 'error',
                icon: 'warning',
                autohide: true,
                show: CPQService.toastEnabled('error')
            });
        } else {
            window.parent.location.href = moveOSTargetUrl;
        }
    };

}]);

},{}],5:[function(require,module,exports){
angular.module('assets')
.controller('AssetsProductItemController', ['$scope', '$rootScope', '$log', '$timeout', 'AssetsService', 'CPQService', '$sldsModal', 'CPQCardinalityService', 'CPQItemDetailsService', 'CPQCartItemCrossActionService', 'CPQPricingViewsViaCardStatesService', 'CPQLevelBasedApproachService', 'CPQResponsiveHelper', '$sldsPrompt', '$sldsToast', 'PromiseQueueFactory', '$q', '$filter',
    function($scope, $rootScope, $log, $timeout, AssetsService, CPQService, $sldsModal, CPQCardinalityService, CPQItemDetailsService, CPQCartItemCrossActionService, CPQPricingViewsViaCardStatesService, CPQLevelBasedApproachService, CPQResponsiveHelper, $sldsPrompt, $sldsToast, PromiseQueueFactory, $q, $filter) {

        $scope.isMobileTablet = CPQResponsiveHelper.mobileTabletDevice;
        // isSelected set to true when user opens a config attributes for edit:
        $scope.isSelected = false;
        //Modals Associated with Actions
        $scope.cellActions = {
            pricedetail : {
                layout : 'cpq-product-cart-item-cell-detail',
            },
            applydiscount : {
                layout : 'cpq-product-cart-item-cell-pricing',
            }
        };

        $scope.clickOnAssetCheckbox = function(object) {
            AssetsService.recordAssetSelectedForModification(object);
            if (AssetsService.getNumberOfAssetsSelected() === 0) {
                $rootScope.vlocityAssets.enableChangeToCartButton = false;
                $rootScope.vlocityAssets.enableMoveButton = false;
            } else if (AssetsService.getNumberOfAssetsSelected() === 1) {
                $rootScope.vlocityAssets.enableChangeToCartButton = true;
                $rootScope.vlocityAssets.enableMoveButton = true;
            } else if (AssetsService.getNumberOfAssetsSelected() > 1) {
                $rootScope.vlocityAssets.enableChangeToCartButton = true;
                $rootScope.vlocityAssets.enableMoveButton = false;
            }
        };

        // Invoked Action associated with cell. Prompt user with desired modal defined in CellActions
        $scope.applyAction = function(field, type) {
            var action = field.actions[type];
            var modalScope = $scope.$new();
            var cartItemCellDetailsModal;
            /* Custom Labels */
            modalScope.customLabels = {};
            var labelsArray = ['CPQClose','CPQApply','CPQDetails'];
            CPQService.setLabels(labelsArray, modalScope.customLabels);
            /* End Custom Labels */

            modalScope.isDetailLayoutLoaded = false;
            modalScope.saving = false;
            modalScope.layout = $scope.cellActions[type].layout;
            modalScope.editable = field.editable;
            modalScope.title = field.label;
            modalScope.value = field.value;
            modalScope.obj = $scope.$parent.obj;
            if (type === 'applydiscount') {
                cartItemCellDetailsModal = $sldsModal({
                    backdrop: 'static',
                    scope: modalScope,
                    templateUrl: 'CPQCartItemCellModal.tpl.html',
                    show: true
                });
            } else if (type === 'pricedetail') {    
                CPQService.invokeAction(action).then(
                    function(data) {
                        if (data.records) {
                            modalScope.records = data.records[0][field.fieldName][type];
                            cartItemCellDetailsModal = $sldsModal({
                                backdrop: 'static',
                                scope: modalScope,
                                templateUrl: 'CPQCartItemCellModal.tpl.html',
                                show: true
                            });
                        }
                }, function(error) {
                    $scope.notificationHandler.handleError(error);
                    $scope.isListLoading = false;
                });
            }    
        };

        //Enter full screen if child level reaches 5 
        $scope.fullScreen = function(level, show) {
            if (show && level > 4 && $scope.attrs.showProductList) {
                $rootScope.$broadcast('cpq-hide-product-list');
            }
        };


        /* Siblings of non root item use the same intance of cartItemController
         * Exposing selected item id to the scope for comparision in templates
         * isSelectedItemObjId is used in border highlighting logic of the selected item */
        $scope.isSelectedItemObjId = '';

        //is expand mode enabled?
        $scope.expandMode = ($rootScope.vlocityAssets.customSettings['Product Configuration Mode'] ? ($rootScope.vlocityAssets.customSettings['Product Configuration Mode'].toLowerCase() === 'expand') : false);

        /*********** CPQ CART ITEM EVENTS ************/
        var unbindEvents = [];

        //Modal events for cross rules update.
        //Accepts dynamic function arguments
        unbindEvents[unbindEvents.length] = $scope.$on('vlocity.cpq.cartitem.actions', function(event, actionType, obj) {
            crossAction (event, actionType, obj);
        });

        // When the config panel is closed, set the isSelected variable to false
        // Removes selected border for line item
        unbindEvents[unbindEvents.length] = $scope.$on('vlocity.cpq.config.configpanelenabled', function(event, isConfigEnabled) {
            if (!isConfigEnabled) {
                $scope.isSelected = false;
                $scope.isSelectedItemObjId = '';
            }
        });

        /*********** END CPQ CART ITEM EVENTS ************/

        // Assign CPQPricingViewsViaCardStatesService into $scope variable
        if ($rootScope.pricingViews === undefined) {
            $rootScope.pricingViews = new CPQPricingViewsViaCardStatesService($scope);
        }

        $scope.$on('$destroy', function() {
            if ($scope.isSelected) {
                //Publish an event to close the config panel
                $rootScope.$broadcast('vlocity.cpq.config.configpanelenabled', false);
            }

            //Removes all listeners
            unbindEvents.forEach(function (fn) {
                fn();
            });
            
        });


        function setupViewModel(records) {
            $log.debug('PROCESS RECORDS BEFORE: ', records);
            if (!records) {
                return;
            }
            $scope.viewModelRecords = [];

            if (records.lineItems && records.lineItems.records) {
                angular.forEach(records.lineItems.records, function(value) {
                    $scope.viewModelRecords.push(value);
                });
            }

            if (records.childAssets && records.childAssets.records) {
                angular.forEach(records.childAssets.records, function(childProd) {
                    $scope.viewModelRecords.push(childProd);
                });
            }

            if (records.productGroups && records.productGroups.records) {
                angular.forEach(records.productGroups.records, function(value) {
                    $scope.viewModelRecords.push(value);
                });
            }
            $log.debug('PROCESS RECORDS AFTER: ', $scope.viewModelRecords);
        }

        if (!angular.isArray($scope.records)) {
            setupViewModel($scope.records);
        }

        /**
         * config: Launches attributes configuration for line item in cart
         * @param  {object} itemObject
        */
        $scope.config = function(parent, itemObject) {
            var refreshMode = true;
            // Refresh opened vdf in config panel if any, to avoid FOUC. Dont refresh the entire config panel
            $rootScope.$broadcast('vlocity.cpq.config.configpanelenabled', false, null, refreshMode);

            // Run after the current call stack is executed
            $timeout(function() {
                $scope.isSelected = true;
                $scope.isSelectedItemObjId = itemObject.Id;
                // Publishes Event to enable the config panel
                $rootScope.$broadcast('vlocity.cpq.config.configpanelenabled', true, {'parent': parent, 'itemObject': itemObject});
            }, 0);
        };

        function crossAction (event, type, data) {
            // var toBeAddedLineItem, parentInCardData, grandParentInCardData, productGroupParentInCardData, productGroupParentFromAPI, sessionStorageLayoutLoaded;

            //WIP cross actions feature
            switch (type) {
                case 'viewmodel':
                    // Update view model after preview modal is closed
                    if ($scope.$parent.obj && (data.item.Id.value === $scope.$parent.obj.Id.value) && (data.item.Id.scopeId === $scope.$parent.obj.Id.scopeId)) {
                        setupViewModel(data.item);
                    }
                    // Publish an event to update data if configpanel enabled for this item
                    if ($scope.isSelected) {
                        $rootScope.$broadcast('vlocity.cpq.config.configpanelenabled', true, data.item);
                    }
                    break;
            }
        }

        // Level Based Approach
        $scope.determineChildProdOpenOrCloseInitially = function(childProd) {
            // if custom setting dictates node to open initially (if possible)
            if ($scope.expandMode) {
                return CPQLevelBasedApproachService.determineChildProdOpenOrCloseInitially(childProd);
            // if custom setting dictates node to close initially
            } else {
                // Display close icon
                return false;
            }
        };

        $scope.determineChildProdOpenOrCloseAfterClick = function(childProd, childProdState) {
            return CPQLevelBasedApproachService.determineChildProdOpenOrCloseAfterClick(childProd, childProdState, null, $scope.$id);
        };

        $scope.determineIfChildProdOpenOrCloseIconShouldBeHidden = function(childProd) {
            return CPQLevelBasedApproachService.determineIfChildProdOpenOrCloseIconShouldBeHidden(childProd);
        };

        $scope.checkIfChildProdHasChildren = function(childProd) {
            return CPQLevelBasedApproachService.checkIfChildProdHasChildren(childProd);
        };
        // End Level Based Approach

    }
]);

},{}],6:[function(require,module,exports){
angular.module('hybridCPQ')
.factory('AssetsService', ['$log',
    function($log) {

    return {

        selectedAssetIdsForModification : [],

        recordAssetSelectedForModification : function(item) {
            if (!_.includes(this.selectedAssetIdsForModification, item.Id.value)) {
                this.selectedAssetIdsForModification.push(item.Id.value);
            } else {
                _.pull(this.selectedAssetIdsForModification, item.Id.value);
            }
        },

        getNumberOfAssetsSelected : function() {
            return this.selectedAssetIdsForModification.length;
        },

        getAssetIdsSelected : function() {
            var i;
            var selectedAssetIds = '';
            for (i = 0; i < this.selectedAssetIdsForModification.length; i++) {
                selectedAssetIds += this.selectedAssetIdsForModification[i];
                if (i < this.selectedAssetIdsForModification.length - 1) {
                    selectedAssetIds += '+';
                }
            }
            return selectedAssetIds;
        }

    };
}]);

},{}]},{},[1]);

})();