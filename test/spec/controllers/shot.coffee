'use strict'

describe 'Controller: ShotCtrl', () ->

  # load the controller's module
  beforeEach module 'showShotApp'

  ShotCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ShotCtrl = $controller 'ShotCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
