rewards.controller('RewardsCommunityPoolCtrl',
  function($scope, RewardsCommunityPool) {

  $scope.rewards = RewardsCommunityPool.index()

  $scope.items_per_page = 10;
})