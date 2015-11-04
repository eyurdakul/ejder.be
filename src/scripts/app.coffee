app = angular.module "EjderBe", ["ui.bootstrap", "ngFitText"]
app.controller "IntroController", IntroController
app.factory "BackendConnectionService", BackendConnectionService

angular.element(document).ready ->
  console.debug "document is ready"