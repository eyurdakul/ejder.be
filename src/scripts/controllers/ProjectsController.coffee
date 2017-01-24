"use strict"
ProjectsController = [
  "$scope"
  "$log"
  "$filter"
  "ContentProviderService"
  "SpinnerService"
  ($scope, $log, $filter, ContentProviderService, SpinnerService)->

    $log.debug "Creating ProjectsController"

    $scope.data = undefined

    $scope.init = ->
      SpinnerService.setLoading true
      ContentProviderService.get("projects")
      .then handleData, null, handleData
      true

    handleData = (response)->
      $scope.data = response
      SpinnerService.setLoading false

    @
]
