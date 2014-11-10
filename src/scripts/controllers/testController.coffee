define [], ()->
  testController = ($scope)->
    console.log "TestController is loaded"
    $scope.test = "Ejder Yurdakul"
  testController
