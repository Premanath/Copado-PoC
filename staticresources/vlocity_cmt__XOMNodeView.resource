(function(){  var fileNsPrefix = (function() {
    'use strict';
    var scripts = document.getElementsByTagName('script');
    var lastScript = scripts[scripts.length - 1];
    var scriptName = lastScript.src;
    var parts = scriptName.split('/');
    var thisScript = parts[parts.length - 1];
    if (thisScript === "") {
      thisScript = parts[parts.length - 2];
    }
    var lowerCasePrefix = thisScript.indexOf('__') == -1 ? '' : thisScript.substring(0, thisScript.indexOf('__') + 2);
    //check for the cached namespace first
    lowerCasePrefix = lowerCasePrefix === '' && localStorage.getItem('nsPrefix') ? localStorage.getItem('nsPrefix'): lowerCasePrefix;
    
    if(lowerCasePrefix !== ''){
        lowerCasePrefix = /__$/.test(lowerCasePrefix) ? lowerCasePrefix : lowerCasePrefix + '__';
    }
    if (lowerCasePrefix.length === 0) {
      return function() {
        //then check if the app has put a namespace and take that one as it is newer
        lowerCasePrefix = window.nsPrefix ? window.nsPrefix: lowerCasePrefix;
        //add the underscore if it doesn't have them    
        if(lowerCasePrefix !== ""){
            lowerCasePrefix = /__$/.test(lowerCasePrefix) ? lowerCasePrefix : lowerCasePrefix + '__';
        }  
        return lowerCasePrefix;
      };
    } else {
      var resolvedNs = null;
      return function() {
        if (resolvedNs) {
          return resolvedNs;
        }
        // hack to make scan SF objects for the correct case
        try {
          var tofind = lowerCasePrefix.replace('__', '');
          var name;
          var scanObjectForNs = function(object, alreadySeen) {
            if (object && object !== window && alreadySeen.indexOf(object) == -1) {
                alreadySeen.push(object);
                Object.keys(object).forEach(function(key) {
                  if (key === 'ns') {
                    // do ns test
                    if (typeof object[key] === 'string' && object[key].toLowerCase() === tofind) {
                      name = object[key] + '__';
                      return false;
                    }
                  }
                  if (Object.prototype.toString.call(object[key]) === '[object Array]') {
                    object[key].forEach(function(value) {
                      var result = scanObjectForNs(value, alreadySeen);
                      if (result) {
                          name = result;
                          return false;
                      }
                    });
                  } else if (typeof object[key] == 'object') {
                    var result = scanObjectForNs(object[key], alreadySeen);
                    if (result) {
                        name = result;
                        return false;
                    }
                  }
                  if (name) {
                    return false;
                  }
                });
                if (name) {
                  return name;
                }
            };
          }
          if(typeof Visualforce !== 'undefined') { //inside VF
            scanObjectForNs(Visualforce.remoting.Manager.providers, []);  
          } else {
            return lowerCasePrefix;
          }
          if (name) {
            return resolvedNs = name;
          } else {
            return resolvedNs = lowerCasePrefix;
          }
        } catch (e) {
          return lowerCasePrefix;
        }
      };
    }
  })();

  var fileNsPrefixDot = function() {
    var prefix = fileNsPrefix();
    if (prefix.length > 1) {
      return prefix.replace('__', '.');
    } else {
      return prefix;
    }
  };
(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var module = angular.module('vloc.xomNodeView', ['vlocity', 'mgcrea.ngStrap',  'ngSanitize']);

// require('./modules/xomnodeview/directive/NGIncludeTemplate.js');
require('./modules/xomnodeview/directive/XOMNodeViewDirective.js');
require('./modules/xomnodeview/filter/linenumber.js');
require('./modules/xomnodeview/templates/templates.js');

},{"./modules/xomnodeview/directive/XOMNodeViewDirective.js":2,"./modules/xomnodeview/filter/linenumber.js":3,"./modules/xomnodeview/templates/templates.js":4}],2:[function(require,module,exports){
angular.module('vloc.xomNodeView').directive('nodeView', ['$compile', function($compile) {

    return {

        templateUrl: 'NodeView.tpl.html',

        scope: {
            parent: '='
        },
        // replace: true,
        restrict: 'E',
        controller:  ['$scope', function($scope) {

            $scope.isNodeActive = function (activeNodes, nodeIdx) {

                // console.log ('isNodeActive', $scope, nodeIdx);
                function isNumeric(n) {
                    return !isNaN(parseFloat(n)) && isFinite(n);
                }

                if (isNumeric(activeNodes)) {
                    return activeNodes == nodeIdx;
                } else {
                    return activeNodes.indexOf (nodeIdx) >= 0;
                }

            };
            $scope.processAtrribute = function(attr) {
              if(!attr) attr = {};
              if(attr.value){
                var newValue = attr.value;
                if(attr.type === 'Date'){
                  newValue = new Date ( Date.parse(attr.value));
                  var newLocaleValue = newValue.toLocaleString();
                  var dtList = newLocaleValue.split(',');
                  newLocaleValue = dtList[0].substring(0, dtList[0].length - 4) + dtList[0].substring(dtList[0].length - 2, dtList[0].length);
                  return newLocaleValue;
                }else if(attr.type === 'Datetime'){
                  newValue = new Date ( Date.parse(attr.value));
                  var newLocaleValue = newValue.toLocaleString();
                  var dtList = newLocaleValue.split(',');
                  newLocaleValue = dtList[0].substring(0, dtList[0].length - 4) + dtList[0].substring(dtList[0].length - 2, dtList[0].length);
                  newLocaleValue = newLocaleValue + dtList[1].substring(0, dtList[1].length - 6) + dtList[1].substring(dtList[1].length - 3, dtList[1].length);
                  return newLocaleValue;
                }
                return newValue;
              }
              return "";
            };

        }],
        compile: function(tElement, tAttr) {
            var contents = tElement.contents().remove();
            var compiledContents;
            return function(scope, iElement, iAttr) {
                if(!compiledContents) {
                    compiledContents = $compile(contents);
                }
                compiledContents(scope, function(clone, scope) {
                    iElement.append(clone);
                });
            };
        }

    };

}]);

},{}],3:[function(require,module,exports){
angular.module('vloc.xomNodeView').filter('linenumber', function () {
    return function(ln) {
        return ln.replace(/^[a-zA-Z][^.]*\./, '');
    };
});
},{}],4:[function(require,module,exports){
angular.module("vloc.xomNodeView").run(["$templateCache",function($templateCache){"use strict";$templateCache.put("NodeView.tpl.html",'<div class="panel-group" ng-model="parent.activeNodes" data-allow-multiple="true" bs-collapse >\n   <div class="panel panel-default " ng-repeat="node in parent.nodes">\n       <div class="order panel-group">\n           <div class="panel-heading">\n               <h4 class="panel-title">\n                   <span bs-collapse-toggle="{{$index}}" class="icon" ng-class="{\'icon-v-right-arrow\': !isNodeActive(parent.activeNodes, $index), \'icon-v-down-arrow\': isNodeActive(parent.activeNodes, $index)}" aria-hidden="true"></span>\n                   <a href="/{{node.id}}">{{node.type}}: {{node.name}}</a>\n               </h4>\n           </div>\n           <div class="panel-collapse" bs-collapse-target="1">\n               <div class="panel-body">\n                   <div class="fields">\n                       <div class="field" ng-repeat="field in node.fields" ng-if="field.value && !field.refId && field.name==\'Line Number\'">\n                           <span class="field-label">{{field.name}}:&nbsp;</span><span class="field-value" data-toggle="tooltip" data-placement="left" title="{{field.value | linenumber}}">{{field.value | linenumber}}</span>\n                       </div>\n                       <div class="field" ng-repeat="field in node.fields" ng-if="field.value && !field.refId && field.name!=\'Line Number\'">\n                           <span class="field-label">{{field.name}}:&nbsp;</span><span class="field-value" data-toggle="tooltip" data-placement="left" title="{{field.value}}">{{field.value}}</span>\n                       </div>\n                       <div class="field" ng-repeat="field in node.fields" ng-if="field.value && !!field.refId">\n                           <span class="field-label">{{field.name}}:&nbsp;</span><span class="field-value" data-toggle="tooltip" data-placement="left" title="{{field.value}}"><a href="/{{field.refId}}">{{field.value}}</a></span>\n                       </div>\n                       <div class="field" ng-if="node.assetId">\n                           <span class="field-label">Asset/Inventory Item:&nbsp;</span><span class="field-value" data-toggle="tooltip" data-placement="left" title="{{node.assetName}}"><a href="/{{node.assetId}}">{{node.assetName}}</a></span>\n                       </div>\n                   </div>\n                   <div class="fields">\n                       <div class="field" ng-repeat="attr in node.attrs" ng-if="attr.value">\n                           <span class="field-label">{{attr.name}}:&nbsp;</span><span class="field-value" data-toggle="tooltip" data-placement="left" title="{{processAtrribute(attr)}}">{{processAtrribute(attr)}}</span>\n                       </div>\n                   </div>\n                   <node-view parent="node"></node-view>\n               </div>\n           </div>\n       </div>\n   </div>\n</div>')}]);
},{}]},{},[1]);

})();