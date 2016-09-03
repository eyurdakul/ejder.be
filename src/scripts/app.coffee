app = angular.module "EjderBe", ["ngRoute", "ui.bootstrap"]

#controllers
app.controller "MainController", MainController
app.controller "NavigationController", NavigationController
app.controller "IntroController", IntroController
app.controller "ClientsController", ClientsController
app.controller "SkillsController", SkillsController
app.controller "ContactController", ContactController

#services
app.service "ContentProviderService", ContentProviderService

#directives
#TODO loading directive, send message directive

app.config ["$routeProvider", ($routeProvider)->
  $routeProvider
  .when "/intro",
    templateUrl: "load/intro"
    controller: "IntroController"
  .when "/clients",
    templateUrl: "load/clients"
    controller: "ClientsController"
  .when "/skills",
    templateUrl: "load/skills"
    controller: "SkillsController"
  .when "/contact",
    templateUrl: "load/contact"
    controller: "ContactController"
  .otherwise ->
    redirectTo
]
