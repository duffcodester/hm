healthmonster.factory('ChallengesCommunityPool', ['$resource', function($resource) {
  return $resource('/challenges_community_pool', {},
    { 'index': { method: 'GET', isArray: true}})
}])
