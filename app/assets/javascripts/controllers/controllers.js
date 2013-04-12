function ChallengesCommunityPoolCtrl($scope, $http) {
  $http.get('challenges_community_pool.json').success(function(data) {
    $scope.challenges = data;
  });
}

/*function RewardCtrl($scope, $http) {
  $http.post('rewards/create').success();
}*/

function RewardCtrl($scope, $http) {
   console.log('I am in RewardCtrl');

   $scope.createReward = function(data) {  
                   data = { reward: { name: $scope.reward.name, description: $scope.reward.description } }

                   //data = {quote: $scope.quote };


                   console.log('creating reward: '+JSON.stringify(data));
                   //$http.defaults.headers.post["Content-Type"]   = "application/x-www-form-urlencoded";
                   //$http.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
 
                   $http.post('/rewards', data)
                       .success(function(data, status) {
                             console.log("Status:"+status+" Data:"+data);

                                 alert("New Reward!");
                                 $scope.worked = "It worked!";
                             })
                       .error(function(data, status) {
                         alert("Didn't work...");
                        });
}};
//  $http.post('/someUrl', data).success(successCallback);

//{"category_id":null,"created_at":"2013-02-15T16:36:52Z","description":"for a half hour","id":3,"name":"watch tv","parent_id":1,"public":true,"updated_at":"2013-02-15T16:36:52Z"}
