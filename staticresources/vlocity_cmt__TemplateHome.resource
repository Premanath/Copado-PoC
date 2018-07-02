(function(){var fileNsPrefix=function(){"use strict";var scripts=document.getElementsByTagName("script");var lastScript=scripts[scripts.length-1];var scriptName=lastScript.src;var parts=scriptName.split("/");var thisScript=parts[parts.length-1];if(thisScript===""){thisScript=parts[parts.length-2]}var lowerCasePrefix=thisScript.indexOf("__")==-1?"":thisScript.substring(0,thisScript.indexOf("__")+2);lowerCasePrefix=lowerCasePrefix===""&&localStorage.getItem("nsPrefix")?localStorage.getItem("nsPrefix"):lowerCasePrefix;if(lowerCasePrefix!==""){lowerCasePrefix=/__$/.test(lowerCasePrefix)?lowerCasePrefix:lowerCasePrefix+"__"}if(lowerCasePrefix.length===0){return function(){lowerCasePrefix=window.nsPrefix?window.nsPrefix:lowerCasePrefix;if(lowerCasePrefix!==""){lowerCasePrefix=/__$/.test(lowerCasePrefix)?lowerCasePrefix:lowerCasePrefix+"__"}return lowerCasePrefix}}else{var resolvedNs=null;return function(){if(resolvedNs){return resolvedNs}try{var tofind=lowerCasePrefix.replace("__","");var name;var scanObjectForNs=function(object,alreadySeen){if(object&&object!==window&&alreadySeen.indexOf(object)==-1){alreadySeen.push(object);Object.keys(object).forEach(function(key){if(key==="ns"){if(typeof object[key]==="string"&&object[key].toLowerCase()===tofind){name=object[key]+"__";return false}}if(Object.prototype.toString.call(object[key])==="[object Array]"){object[key].forEach(function(value){var result=scanObjectForNs(value,alreadySeen);if(result){name=result;return false}})}else if(typeof object[key]=="object"){var result=scanObjectForNs(object[key],alreadySeen);if(result){name=result;return false}}if(name){return false}});if(name){return name}}};if(typeof Visualforce!=="undefined"){scanObjectForNs(Visualforce.remoting.Manager.providers,[])}else{return lowerCasePrefix}if(name){return resolvedNs=name}else{return resolvedNs=lowerCasePrefix}}catch(e){return lowerCasePrefix}}}}();var fileNsPrefixDot=function(){var prefix=fileNsPrefix();if(prefix.length>1){return prefix.replace("__",".")}else{return prefix}};
(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
angular.module('templatehome', ['sldsangular', 'drvcomp', 'ngTable', 'vlocity', 'infinite-scroll']);

require('./modules/templatehome/controller/TemplateHome.js');

},{"./modules/templatehome/controller/TemplateHome.js":2}],2:[function(require,module,exports){
angular.module('templatehome')
.controller('templatehome', ['$drvExport', '$sldsPrompt', '$scope', 'remoteActions',
                             '$filter', '$rootScope', '$drvImport', '$localizable', '$sldsModal',
    function($drvExport, $sldsPrompt, $scope, remoteActions, $filter, $rootScope, $drvImport, $localizable, $sldsModal) {

        'use strict';

        remoteActions.getBaseDatapacks('DP_TEMPLATES_').then(
            function(packs){
                console.log('packs ',packs);
                $scope.additionalTableButtons = $scope.additionalTableButtons || [];
                angular.forEach(packs, function(pack, index) {
                    $localizable('InstallDataPack', 'Install {1}', pack.Name.replace('DP_TEMPLATES_',''))
                        .then(function(label) {
                            var tableButton = {
                                text: label,
                                click: function() {
                                    $drvImport({
                                        scope: $scope,
                                        mode: 'staticresource',
                                        dataPackDataPublicId: pack.Name,
                                        dataPackDataPublicSource: 'Vlocity Resource',
                                        onImportComplete: function() {
                                            $rootScope.$broadcast('reload.table', 'template-home');
                                        }
                                    });
                                }
                            };
                            $scope.additionalTableButtons.push(tableButton);
                        });
                });
            },
            function(error){
                console.log(error);
        });

        $scope.defaultColumns = [{
            field: 'Name',
            additionalFields: [fileNsPrefix() + 'Version__c'],
            getValue: function($scope, row) {
                if (typeof sforce != "undefined" && sforce.one) {
                    return '<a onclick="sforce.one.navigateToURL(\'' + window.templatesNewUrl + '?id=' + row.Id + '\')">' +
                                        row.Name + ' (Version ' +
                                row[fileNsPrefix() + 'Version__c'] + ')</a>';
                } else {
                    return '<a href="' + window.templatesNewUrl + '?id=' + row.Id + '">' + row.Name + ' (Version ' +
                                row[fileNsPrefix() + 'Version__c'] + ')</a>';
                }
            },
            resizable: true
        }, {
            field: fileNsPrefix() + 'Type__c',
            getValue: function() {
                return '';
            },
            resizable: true
        }, {
            id: 'last-modifed-date',
            resizable: true,
            width: 140,
            field: 'LastModifiedDate',
            getGroupValue: function($scope, $group) {
                return $filter('date')($group.data[0].LastModifiedDate, 'short');
            },
            getValue: function($scope, row) {
                return $filter('date')(row.LastModifiedDate, 'short');
            }
        }, {
            id: 'last-modifed-by',
            resizable: true,
            width: 140,
            field: 'LastModifiedById',
            getGroupValue: function($scope, $group) {
                return $group.data[0].LastModifiedBy ? $group.data[0].LastModifiedBy.Name : '';
            },
            getValue: function($scope, row) {
                return row.LastModifiedBy ? row.LastModifiedBy.Name : '';
            }
        }, {
            field: fileNsPrefix() + 'Active__c',
            shrink: true,
            dynamic: true,
            getGroupSortValue: function($scope, $group) {
                var hasAnActiveEntry = false;
                _.forEach($group.data, function(row) {
                    if (row[fileNsPrefix() + 'Active__c']) {
                        hasAnActiveEntry = true;
                        return false;
                    }
                });
                return hasAnActiveEntry
            },
            getValue: function($scope, row) {
                if (row[fileNsPrefix() + 'Active__c']) {
                    return '<span class="slds-icon_container" title="Is Active"><slds-svg-icon sprite="\'utility\'" icon="\'success\'" size="\'x-small\'"  extra-classes="\'slds-icon-text-default \'"></slds-svg-icon></span>';
                }
            },
            getGroupValue: function($scope, $group) {
                var hasAnActiveEntry = false;
                _.forEach($group.data, function(row) {
                    if (row[fileNsPrefix() + 'Active__c']) {
                        hasAnActiveEntry = true;
                        return false;
                    }
                });
                if (hasAnActiveEntry) {
                    return '<span class="slds-icon_container" title="Is Active"><slds-svg-icon sprite="\'utility\'" icon="\'success\'" size="\'x-small\'"  extra-classes="\'slds-icon-text-default \'"></slds-svg-icon></span>';
                }
            },
            resizable: false,
            width: 90
        }];

        $localizable('DeleteTemplate', 'Delete Template?')
            .then(function(label) {
                $scope.rowActions = [{
                    type: 'export',
                    drvType: 'VlocityUITemplate'
                }, {
                    type: 'delete',
                    promptTitle: label,
                    promptContent: function(row) {
                        return $localizable('DeleteTemplateConfirmation', 'Are you sure you want to delete this Template?<br/> <br/>"{1} (Version {2})" ', row.Name, row[fileNsPrefix() + 'Version__c']);
                    },
                    hide: function(row, group) {
                        return row[fileNsPrefix() + 'Active__c'];
                    }
                }];
            });

    }]);
},{}]},{},[1]);

})();