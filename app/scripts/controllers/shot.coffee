'use strict'

localStore = new Lawnchair 'Shots', (local) ->

angular.module('showShotApp')
  .controller 'ShotCtrl', ($scope, $http, $templateCache) ->
    $scope.histor = []
    
    $scope.historList = ()->
      return $scope.histor
    
    $scope.loadShots = ()->
      localStore.keys (keys)->
        chargement = []
        for k in keys
          localStore.get k, (shot)->
            $scope.histor.push
              title:shot.title
              img:shot.img
              url:shot.url
            
        $scope.initialShot()
    
    $scope.currentShot =
      title: 'Wait for it!'
      img: 'http://placehold.it/800x600'
      url: 'http://drbl.in/jwCH'
      key: 3
    
    $scope.initialShot = (hist) ->
      if hist
        $scope.histor.push hist
      $http(
        method: 'JSONP'
        url: 'http://api.dribbble.com/shots/everyone/?callback=JSON_CALLBACK&page=1&per_page=1'
        cache: $templateCache
      ).success((data, status)->
        $scope.currentShot = {}
        $scope.currentShot =
          title: data.shots[0].title
          img: data.shots[0].image_url
          url: data.shots[0].short_url
          key: data.shots[0].id
        localStore.save $scope.currentShot
        $scope.histor.push $scope.currentShot
        $scope.initialId = data.shots[0].id
      ).error((data, status)->
        console.log data
        console.log status
      )
      
      

    $scope.newShot = () ->
      $scope.currentShot =
        title: 'Loading, Please Wait'
        img: 'http://placehold.it/800x600'
        url: '#/'
      $http(
        method: 'JSONP'
        url: 'http://api.dribbble.com/shots/'+$scope.newID+'?callback=JSON_CALLBACK'
        cache: $templateCache
      ).success((data, status)->
        $scope.currentShot =
          title: data.title
          img: data.image_url
          url: data.short_url
          key: data.id
        $scope.histor.push $scope.currentShot
        localStore.save $scope.currentShot
      ).error((data, status)->
        $scope.currentShot =
          title: 'Too bad, Nothing found!!'
          img: 'http://placehold.it/800x600'
          url: '#/'
      )
      
    $scope.showTheShot = (shot, $event) ->
      $event.preventDefault()
      $('body').animate { scrollTop: 0 + $('.container.lil .row').height() + 20}, 400
      $scope.currentShot =
          title: shot.title
          img: shot.img
          url: shot.url
          key: shot.key
          
    $scope.loadShots()
          
          