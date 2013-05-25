healthmonster.factory('ChildDash', ['$resource', function($resource) {
  return $resource('/child_dash', {},
    { 'get': { method: 'GET' } })
}])

healthmonster.factory('AssignedChallenges', ['$resource', function($resource) {
  return $resource('/assigned_challenges/:id', {id: '@id'},
    { 'update': { method: 'PUT' } })
}])

healthmonster.factory('EnabledRewards', ['$resource', function($resource) {
  return $resource('/enabled_rewards/:id', {id: '@id'},
    { 'update': { method: 'PUT' } })
}])
