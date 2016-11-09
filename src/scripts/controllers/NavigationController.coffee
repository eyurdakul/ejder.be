"use strict"
NavigationController = [
  "$scope"
  "$location"
  "$log"
  "ContentProviderService"
  ($scope, $location, $log, ContentProviderService)->

    $log.debug "Creating NavigationController"

    $scope.navigationLoaded = undefined
    $scope.data = undefined
    $scope.activeLink = undefined

    $scope.$on "$routeChangeSuccess", ->
      $scope.activeLink = $location.path()

    $scope.init = ->
      ContentProviderService.get("navigation")
      .then handleData, null, handleData
      .finally ->
        $scope.navigationLoaded = true
      true

    handleData = (response)->
      $scope.data = response
      $log.debug $scope.data.external

    @
]