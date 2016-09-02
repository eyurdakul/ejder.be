NavigationController = [
  "$scope"
  "$location"
  "$log"
  "ContentProviderService"
  ($scope, $location, $log, ContentProviderService)->

    $log.debug "Creating NavigationController"

    $scope.navigationLoaded = undefined
    $scope.links = undefined
    $scope.activeLink = undefined

    $scope.$on "$routeChangeSuccess", (event, next, current)->
      $scope.activeLink = $location.path()

    $scope.init = ->
      ContentProviderService.get("navigation")
      .then (response)->
        $scope.links =
          [
            {"target": "#intro", "path":"/intro", "text": "Intro"},
            {"target": "#clients", "path":"/clients", "text": "Projects"},
            {"target": "#skills", "path":"/skills", "text": "Skills"},
            {"target": "#contact", "path":"/contact", "text": "Contact"}
          ]
      .finally ->
        $scope.navigationLoaded = true
      true

    @
]