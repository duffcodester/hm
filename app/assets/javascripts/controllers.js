function ChallengesCommunityPoolCtrl($scope, $http) {
  $http.get('challenges_community_pool.json').success(function(data) {
    $scope.challenges = data;
  });
}