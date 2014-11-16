app = angular.module "EjderYurdakul", []
define ["controllers/indexController"], (indexController)->
  app.controller "indexController", indexController
return app