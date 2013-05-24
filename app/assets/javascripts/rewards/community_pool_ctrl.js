rewards.controller('RewardsCommunityPoolCtrl',
  ['$scope', 'RewardsCommunityPool',
  function($scope, RewardsCommunityPool) {

  $scope.rewards = RewardsCommunityPool.index()

  $scope.items_per_page = 10;
}])