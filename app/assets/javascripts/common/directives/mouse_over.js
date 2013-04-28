#= require ../../../../../vendor/assets/javascripts/angular.min

var healthmonster = angular.module('HealthMonster', [])

healthmonster.directive("accept_mouse_over", function () {
  return function(scope, element) {
    element.bind("mouseenter", function () {
      
    })
  }
})