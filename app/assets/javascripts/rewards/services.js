rewards.factory('Reward', function($resource) {
  return $resource('/rewards', {},
    { 'create': { method: 'POST'}})
})

rewards.factory('RewardsCommunityPool', function($resource) {
  return $resource('/rewards_community_pool', {},
    { 'index': { method: 'GET', isArray: true}})
})
