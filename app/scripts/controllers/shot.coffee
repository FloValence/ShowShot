'use strict'

angular.module('showShotApp')
  .controller 'ShotCtrl', ($scope, $http, $templateCache) ->
    $scope.history = [
      {
        title: 'HTML5 Boilerplate'
        img: 'http://placehold.it/800x600'
        url: '/#/shot'
      }
      {
        title:'AngularJS'
        img: 'http://placehold.it/800x600'
        url: '/#/shot'
      }
      {
        title: 'Karma'
        img: 'http://placehold.it/800x600'
        url: '/#/shot'
      }
      {
        title: 'iPhone - iOS Daily Verse Bible App'
        img: 'http://d13yacurqjgara.cloudfront.net/users/4605/screenshots/1326449/snap.png'
        url: 'http://drbl.in/jwCH'
      }
    ]
    
    $scope.currentShot =
      title: 'iPhone - iOS Daily Verse Bible App'
      img: 'http://d13yacurqjgara.cloudfront.net/users/4605/screenshots/1326449/snap.png'
      url: 'http://drbl.in/jwCH'

    $scope.newShot = () ->
      #$scope.history.push
      #  title:$scope.newID,
      #  img:'placehold.it/800x600'
        
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
        console.log data
        console.log status
      )
      
    $scope.showTheShot = (shot, $event) ->
      $event.preventDefault()
      $scope.currentShot =
          title: shot.title
          img: shot.img
          url: shot.url