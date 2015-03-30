'use strict';

controllers.controller("ParticipantsController", ["$scope", "FlashAPI", function ($scope, flashAPI) {
	
	$scope.participants = [flashAPI.myParticipant];
	$scope.$apply();
	
	$scope.$onRootScope('flashAPI.participantConnected', function(event, data){
		$scope.participants.push(data);
		$scope.$apply();
	});	

	$scope.$onRootScope('flashAPI.participantDisconnected', function(event, data){
		for(var i=$scope.participants.length-1; i>-1; i--) {
    		if( $scope.participants[i].peerId == data.peerId){
    			$scope.participants.splice(i, 1);
				$scope.$apply();
				break;
    		}
		}	
	});	

}]);
