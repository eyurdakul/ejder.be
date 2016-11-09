"use strict"
FooterController = [
  "$scope"
  "$log"
  ($scope, $log)->

    $log.debug "Creating FooterController"

    $scope.collapsed = true

    $scope.toggle = ->
      $scope.collapsed = not $scope.collapsed

    @
]