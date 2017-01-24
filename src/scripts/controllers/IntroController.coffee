"use strict"
IntroController = [
  "$scope"
  "$log"
  "ContentProviderService"
  "SpinnerService"
  ($scope, $log, ContentProviderService, SpinnerService)->

    $log.debug "Creating IntroController"

    $scope.data = undefined

    $scope.init = ->
      ContentProviderService.get("intro")
      .then handleData, null, handleData
      true

    handleData = (response)->
      $scope.data = response
      SpinnerService.setLoading false

    @
]