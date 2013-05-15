healthmonster.factory('ChallengesCommunityPool', function($resource) {
  return $resource('/challenges_community_pool', {},
    { 'index': { method: 'GET', isArray: true}})
})
