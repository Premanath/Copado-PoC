vlocity.cardframework.registerModule.controller('initApiSettingsController', ['$rootScope', function($rootScope) {

	$rootScope.apiSettings = {

		// the following settings fpr API used in Cart and the Config Panel
		'addToCartAPIRequiresPricing': true,
		'addToCartAPIRequiresValidation': true,
		'cloneAPIRequiresPricing': true,
		'cloneAPIRequiresValidation': true,
		'updateAPIRequiresPricing': true,
		'updateAPIRequiresValidation': true,
		'modifyAttributesAPIRequiresPricing': true,
		'modifyAttributesAPIRequiresValidation': true,
		'deleteAPIRequiresPricing': true,
		'deleteAPIRequiresValidation': true,

		// the following settings for API used in Product List
		'addToCartAPIInProductListRequiresPricing': true,
		'addToCartAPIInProductListRequiresValidation': true

	};

	$rootScope.vlocityCPQ.features = {

        enablePromotions : false,
        enablePricing: false

	};

}]);