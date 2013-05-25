rewards.factory('Reward', ['$resource', function($resource) {
  return $resource('/rewards', {},
    { 'create': { method: 'POST'}})
})]

rewards.factory('RewardsCommunityPool', ['$resource', function($resource) {
  return $resource('/rewards_community_pool', {},
    { 'index': { method: 'GET', isArray: true}})
}])
