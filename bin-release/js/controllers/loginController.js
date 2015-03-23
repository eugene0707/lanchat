'use strict';

controllers.controller("LoginController", ["$scope", "FlashAPI", function ($scope, flashAPI) {
	
	$scope.login = function(){
		flashAPI.connect($scope.userName);
	}
	
	$scope.logoff = function(){
		flashAPI.disconnect();
	}
}]);
