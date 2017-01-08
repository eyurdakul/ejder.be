"use strict"
app = angular.module "EjderBe", ["ngRoute", "ui.bootstrap", "ngAnimate", "ngSanitize"]

#controllers
app.controller "NavigationController", NavigationController
app.controller "FooterController", FooterController
app.controller "IntroController", IntroController
app.controller "ClientsController", ClientsController
app.controller "SkillsController", SkillsController
app.controller "ContactController", ContactController

#services
app.service "ContentProviderService", ContentProviderService
app.service "SocketService", SocketService
app.service "SpinnerService", SpinnerService

#factories
app.factory "ErrorLogFactory", ErrorLogFactory

#directives
app.directive "loadingModal", LoadingModalDirective

app.provider "$exceptionHandler",
  $get: ["ErrorLogFactory", (ErrorLogFactory)->
    ErrorLogFactory
  ]

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
  .otherwise
    redirectTo: "/intro"
]
