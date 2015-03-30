'use strict';

services.factory('FlashAPI', function($rootScope, $window){
	var service = {};
	
	function flashObject(objectId){
		objectId = typeof objectId !== 'undefined' ? objectId : $rootScope.swfName;
		return $window[objectId];
	}

	$window.flashConnected = function(objectId, message){
		service.myParticipant=JSON.parse(message);
		service.myParticipant.isMe = true;
		$rootScope.$emit('flashAPI.connected', service.myParticipant);
	}

	$window.flashDisconnected = function(objectId){
		$rootScope.$emit('flashAPI.disconnected');
	}

	$window.flashConnectionFailed = function(objectId){
		$rootScope.$emit('flashAPI.connectionFailed');
	}

	$window.flashChatMessage = function(objectId, message){
		var dto=JSON.parse(message);
		dto.isMe = (dto.sender.peerId == service.myParticipant.peerId);
		$rootScope.$emit('flashAPI.chatMessage', dto);
	}

	$window.flashParticipantConnected = function(objectId, message){
		var dto=JSON.parse(message);
		$rootScope.$emit('flashAPI.participantConnected', dto);
	}

	$window.flashParticipantDisconnected = function(objectId, message){
		var dto=JSON.parse(message);
		$rootScope.$emit('flashAPI.participantDisconnected', dto);
	}

	$window.flashEcho = function(objectId, message){
		var dto=JSON.parse(message);
		$rootScope.$emit(dto.eventName, dto.data);
	}

	service.connect = function (userName){
		var dto = {userName: userName};

		flashObject().connect(JSON.stringify(dto));
	} 
	
	service.disconnect = function (){
		flashObject().disconnect();
	} 
	
	service.sendMessage = function (message){
		flashObject().sendMessage(message);
	} 
	
	
	return service;
});