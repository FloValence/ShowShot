'use strict'

angular.module('showShotApp')
  .controller 'ShotCtrl', ($scope, $http, $templateCache) ->
    $scope.history = []
    
    $scope.currentShot =
      title: 'Wait for it!'
      img: 'http://placehold.it/800x600'
      url: 'http://drbl.in/jwCH'
      
    
    $scope.initialShot = () ->
      $http(
        method: 'JSONP'
        url: 'http://api.dribbble.com/shots/?callback=JSON_CALLBACK&page=1&per_page=1'
        cache: $templateCache
      ).success((data, status)->
        console.log data
        $scope.currentShot =
          title: data.shots[0].title
          img: data.shots[0].image_url
          url: data.shots[0].short_url
        $scope.initialId = data.shots[0].id
        $scope.history.push $scope.currentShot
      ).error((data, status)->
        console.log data
        console.log status
      )

    $scope.newShot = () ->
      $http(
        method: 'JSONP'
        url: 'http://api.dribbble.com/shots/'+$scope.newID+'?callback=JSON_CALLBACK'
        cache: $templateCache
      ).success((data, status)->
        console.log data
        $scope.currentShot =
          title: data.title
          img: data.image_url
          url: data.short_url
        $scope.history.push $scope.currentShot
      ).error((data, status)->
        $scope.currentShot =
          title: 'Too bad, Nothing found!!'
          img: 'http://placehold.it/800x600'
          url: 'http://drbl.in/jwCH'
      )
      
    $scope.showTheShot = (shot, $event) ->
      $event.preventDefault()
      $scope.currentShot =
          title: shot.title
          img: shot.img
          url: shot.url
    
    $scope.initialShot()