"use strict"
ProjectInfoDirective = ["$log", "ProjectDetailService", ($log, ProjectDetailService)->

  $log.debug "Creating ProjectInfoDirective"

  restrict: "E"
  transclude: false
  replace: true
  scope:
    project: "=project"
  templateUrl: "directive/ProjectInfoTemplate.html"
  link: (scope, elem, attrs)->
    scope.moreInfo = ->
      ProjectDetailService.setProject scope.project
    true
]
