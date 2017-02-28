"use strict"
ProjectDetailService = [
  "$log"
  ($log)->
    $log.debug "Creating ProjectDetailService"

    project = true

    setProject = (curProject)->
      project = curProject

    getProject = ->
      project

    setProject: setProject
    getProject: getProject
]