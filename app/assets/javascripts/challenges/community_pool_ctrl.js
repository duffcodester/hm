healthmonster.controller('ChallengesCommunityPoolCtrl',
  function($scope, ChallengesCommunityPool, Categories) {

  $scope.challenges = ChallengesCommunityPool.index()

  $scope.categories = Categories.index(
      function(data) {
      }, function(err) {
        alert('request to categores failed')
  })

  $scope.items_per_page = 10;
})
