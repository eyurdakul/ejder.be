"use strict"
ProjectInfoDirective = ["$log", ($log)->

  $log.debug "Creating ProjectInfoDirective"

  restrict: "E"
  transclude: false
  replace: true
  scope:
    project: "=project"
  templateUrl: "directive/ProjectInfoTemplate.html"
  link: (scope, elem, attrs)->
    scope.image = scope.project.image
]
