"use strict"
ProjectInfoDirective = ["$log", ($log)->

  $log.debug "Creating ProjectInfoDirective"

  restrict: "E"
  transclude: false
  replace: true
  scope:
    client: "=client"
  templateUrl: "directive/ProjectInfoTemplate.html"
  link: (scope, elem, attrs)->
    scope.image = scope.client.image
    $log.debug scope.client
]
