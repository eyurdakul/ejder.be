"use strict"
ProjectDetailDirective = ["$log", "ProjectDetailService", ($log, ProjectDetailService)->

  $log.debug "Creating ProjectDetailDirective"

  restrict: "E"
  transclude: false
  replace: true
  templateUrl: "directive/ProjectDetailTemplate.html"
  link: (scope, elem, attrs)->
    scope.project = undefined
    scope.hideDetail = true
    scope.loadProject = ->
      $log.debug scope.project
      scope.hideDetail = false
    scope.unloadProject = ->
      $log.debug "unloading"
      scope.hideDetail = true
    scope.$watch ->
      return ProjectDetailService.getProject()
    , (project)->
      scope.project = project
      scope.loadProject()
]
