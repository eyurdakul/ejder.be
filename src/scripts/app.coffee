"use strict"
app = angular.module "EjderBe", ["ngRoute", "ui.bootstrap", "ngAnimate", "ngSanitize"]

#controllers
app.controller "NavigationController", NavigationController
app.controller "FooterController", FooterController
app.controller "IntroController", IntroController
app.controller "ProjectsController", ProjectsController
app.controller "SkillsController", SkillsController
app.controller "ContactController", ContactController

#services
app.service "ContentProviderService", ContentProviderService
app.service "SocketService", SocketService
app.service "SpinnerService", SpinnerService

#factories
app.factory "ErrorLogFactory", ErrorLogFactory
app.factory "lodash", ["$window", ($window)->
  $window._
]

#filters
app.filter "chunk", ["lodash", (_)->
  _.memoize (arr, size)->
    _.chunk arr, size
  , (arr, size)->
    JSON.stringify(arr) + size
]

#directives
app.directive "loadingModal", LoadingModalDirective
app.directive "projectInfo", ProjectInfoDirective

app.provider "$exceptionHandler",
  $get: ["ErrorLogFactory", (ErrorLogFactory)->
    ErrorLogFactory
  ]

app.config ["$routeProvider", ($routeProvider)->
  $routeProvider
  .when "/intro",
    templateUrl: "load/intro"
    controller: "IntroController"
  .when "/projects",
    templateUrl: "load/projects"
    controller: "ProjectsController"
  .when "/skills",
    templateUrl: "load/skills"
    controller: "SkillsController"
  .when "/contact",
    templateUrl: "load/contact"
    controller: "ContactController"
  .otherwise
    redirectTo: "/intro"
]
