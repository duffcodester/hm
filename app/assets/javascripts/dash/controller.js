#= require ../../../../vendor/assets/javascripts/angular.min

var dash = angular.module('dash', []);

dash.factory('SelectedChild', function () {
    return {
        name: ""
    };
});

function DashCtrl($scope, $http, SelectedChild) {
  $http.get('/children_your.json').success( function(data) {
    $scope.children = data;
    console.log("Children: " + data[0].username);
  });


  $http.get('/completed_challenges.json').success( function(data) {
    $scope.completed_challenges = data;
    console.log("Success get completed_challenges");
  })
}
