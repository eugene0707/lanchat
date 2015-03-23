'use strict';

controllers.controller("SendMessageController", ["$scope", "FlashAPI", function ($scope, flashAPI) {
	$scope.send = function(){
		flashAPI.sendMessage($scope.message);
		$scope.message = '';
	}
}]);
