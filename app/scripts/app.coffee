'use strict'

angular.module('showShotApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/shot',
        templateUrl: 'views/shot.html'
        controller: 'ShotCtrl'
      .otherwise
        redirectTo: '/'
