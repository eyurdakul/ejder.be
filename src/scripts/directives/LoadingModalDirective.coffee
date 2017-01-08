"use strict"
LoadingModalDirective = ["$log", "SpinnerService", ($log, SpinnerService)->

  $log.debug "Creating LoadingModalDirective"

  restrict: "E"
  transclude: false
  replace: true
  templateUrl: "directive/LoadingModalTemplate.html"
  link: (scope, elem, attrs)->

    scope.isLoading = SpinnerService.getLoading()
    scope.$watch ->
      return SpinnerService.getLoading()
    , (newVal)->
      scope.isLoading = newVal
]