'use strict';

services.factory('FlashAPI', function($rootScope, $window){
	var service = {};
	
	function flashObject(objectId){
		objectId = typeof objectId !== 'undefined' ? objectId : $rootScope.swfName;
		return $window[objectId];
	}

	$window.flashConnected = function(objectId, message){
		service.myParticipant=JSON.parse(message);
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
		flashObject().connect(userName);
/*
		var dto = {
			eventName: 'flashAPI.connected',
			data: {
				userName: userName,
				id: '56uubw5657u'
			}
		}
		service.myParticipant=dto.data;
		flashObject().echo(JSON.stringify(dto));
*/
	} 
	
	service.disconnect = function (){
		flashObject().disconnect();
/*
		var dto = {
			eventName: 'flashAPI.disconnected',
			data: {}
		}
		flashObject().echo(JSON.stringify(dto));
*/
	} 
	
	service.sendMessage = function (message){
		flashObject().sendMessage(message);
/*
		var dto = {
			eventName: 'flashAPI.chatMessage',
			data: {
				sender: {
					userName: 'user fio',
					peerId: '56uubw5657u'
				},
				message: message
			}
		}
		
		flashObject().echo(JSON.stringify(dto));
*/
	} 
	
	
	return service;
});