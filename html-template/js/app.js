'use strict';

var app = angular.module('lanChat', ['swfobject', 'ui.router', 'luegg.directives', 'services', 'controllers']);
var controllers = angular.module('controllers',[]);
var services = angular.module('services', [])

app.config(function ($stateProvider, $urlRouterProvider) {
  $urlRouterProvider.otherwise('/');
//  $stateProvider
//  .state('home', {
//    url: '/',
//    templateUrl: 'partial.html'
//  })
  $stateProvider
    .state('chat', {
        abstract: true,
        url: '/',
        template: '<ui-view/>',
        controller: 'MainController'
    })
    .state('chat.login', {
    	url: '',
        templateUrl: 'js/views/chat.login.html',
        controller: 'LoginController'
    })
    .state('chat.room', {
    	url: '',
        views:{
        	'': {
        		templateUrl: "js/views/chat.room.html",
        		controller: 'LoginController'
        	},
        	'messages@chat.room':{
        		templateUrl: "js/views/chat.room.messages.html",
        		controller: 'MessagesController'
        	},
        	'send@chat.room':{
        		templateUrl: "js/views/chat.room.send.html",
        		controller: 'SendMessageController'
        	},
        	'participants@chat.room':{
        		templateUrl: "js/views/chat.room.participants.html",
        		controller: 'ParticipantsController'

        	}
        }
    })

});

app.config(['$provide', function($provide){
    $provide.decorator('$rootScope', ['$delegate', function($delegate){

        Object.defineProperty($delegate.constructor.prototype, '$onRootScope', {
            value: function(name, listener){
                var unsubscribe = $delegate.$on(name, listener);
                this.$on('$destroy', unsubscribe);

                return unsubscribe;
            },
            enumerable: false
        });


        return $delegate;
    }]);
}]);