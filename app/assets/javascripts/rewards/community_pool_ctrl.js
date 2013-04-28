function RewardsCommunityPoolCtrl($scope, $http) {
  $http.get('/rewards_community_pool.json').success(function(data) {
    $scope.rewards = data;
  });
}