var dash = angular.module('dash', ['ngResource']);

dash.controller('DashCtrl', 
  function($scope, $resource, $http, ChildrenYour, CompletedChallenges) {
    $scope.selected = {};

    $scope.children = ChildrenYour.index(
      function(data) {
        //console.log('success, got children_your: ', data);
      }, function(err) {
        alert('request to children_your failed');
      });

    $scope.completed_challenges = CompletedChallenges.index(
      function(data) { //success callback
        //console.log('success, got completed_challenges: ', data);
      }, function(err) { //error callback
        alert('request failed');
    });

    $scope.createChallenge = function() {
      $scope.challenge.parent_id = 1
      $scope.challenge.category_id = parseInt($scope.challenge.category_id)
      console.log($scope.challenge)

      $http.post('/challenges', $scope.challenge)
      .success(function(data, status) {
                             console.log("Status:"+status+" Data:"+data);
                                 alert("New Challenge!");
                             })
                       .error(function(data, status) {
                         alert("Didn't work...");
      });
    }

    $scope.createReward = function() {
      $scope.reward.parent_id = 1
      console.log($scope.reward)

      $http.post('/rewards/', $scope.reward)
                      .success(function(data, status) {
                             console.log("Status:"+status+" Data:"+data.name);

                                 alert("New Reward!");
                             })
                      .error(function(data, status) {
                         alert("Didn't work...");
                      });
    }
  /*  $scope.create_challenge = function() {
      $scope.challenge.parent_id = 1
      challenge = $resource('/challenges', $scope.challenge, { 'create': { method: 'POST'}})
      console.log(challenge)
    }*/

    $scope.toggle = function(task) {
      task.show = !task.show;
      return task.show;
    };
});
