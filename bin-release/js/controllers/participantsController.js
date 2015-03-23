'use strict';

controllers.controller("ParticipantsController", ["$scope", "FlashAPI", function ($scope, flashAPI) {
	
	$scope.participants = [flashAPI.myParticipant];
	
	$scope.$onRootScope('flashAPI.participantConnected', function(event, data){
		$scope.participants.push(data);
	});	

	$scope.$onRootScope('flashAPI.participantDisconnected', function(event, data){
		$scope.participants.shift();
	});	

}]);
