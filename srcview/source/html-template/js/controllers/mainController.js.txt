'use strict';

controllers.controller("MainController", ["$scope", "$state", "FlashAPI", function ($scope, $state, flashAPI) {
	
	$scope.$onRootScope('flashAPI.disconnected', function(event, data){
		$state.go('chat.login');
	});	

	$scope.$onRootScope('flashAPI.connected', function(event, data){
		$state.go('chat.room');
	});
}]);