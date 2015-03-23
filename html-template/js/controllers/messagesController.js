'use strict';

controllers.controller("MessagesController", ["$scope", "FlashAPI", function ($scope, flashAPI) {
	
	$scope.messages = new Array();
	
	$scope.$onRootScope('flashAPI.chatMessage', function(event, data){
		$scope.messages.push(data);
		$scope.$apply();
	});	

}]);
