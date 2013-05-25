'use strict';

rewards.controller('RewardCtrl', ['$scope', '$http', 'Reward',
  function($scope, $http, Reward) {
  console.log('I am in RewardCtrl');

  $scope.createReward = function(data) {  
    data = { reward: { name: $scope.reward.name, description: $scope.reward.description, public: true } }

    console.log('creating reward: '+JSON.stringify(data));
    //$http.defaults.headers.post["Content-Type"]   = "application/x-www-form-urlencoded";
    //$http.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');

    var reward = new Reward(data)
    reward.$create()
 
    //this works
    /*$http.post('/rewards', data)
      .success(function(data, status) {
        console.log("Status:"+status+" Data:"+data);
      })
      .error(function(data, status) {
        alert("Didn't work...");
    });*/
}}])
