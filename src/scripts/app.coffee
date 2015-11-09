app = angular.module "EjderBe", ["ui.bootstrap", "ngLodash", "sn.skrollr"]

#init controllers
app.controller "NavigationController", NavigationController
app.controller "IntroController", IntroController

#init services
app.factory "BackendConnectionService", BackendConnectionService

#config
app.config ["snSkrollrProvider", (snSkrollrProvider)->
  snSkrollrProvider.config =
    smoothScrolling : true
]

angular.element(document).ready ->
  console.debug "document is ready"