'use strict'

angular.module('showShotApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config ($routeProvider) ->
    $routeProvider
      .when '/Yo',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/',
        templateUrl: 'views/shot.html'
        controller: 'ShotCtrl'
      .otherwise
        redirectTo: '/'
