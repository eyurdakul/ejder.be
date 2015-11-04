IntroController = [
  "$scope"
  "$log"
  "BackendConnectionService"
  ($scope, $log, BackendConnectionService)->
    $log.debug "Creating IntroController"
    BackendConnectionService.get("intro").then (data)->
      $scope.viewdata = data.data
]