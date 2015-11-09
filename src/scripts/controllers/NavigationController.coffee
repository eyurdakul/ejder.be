NavigationController = [
  "$scope"
  "$log"
  ($scope, $log)->
    $log.debug "Creating NavigationController"
    $scope.showNavigation = true
]