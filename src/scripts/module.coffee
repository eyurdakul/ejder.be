define(["config/settings", "controllers/testController"], ($config, testController)->
  console.log "Loaded module"
  app = angular.module "EjderYurdakul", [$config]
  app.controller "testController", testController
  return app
)