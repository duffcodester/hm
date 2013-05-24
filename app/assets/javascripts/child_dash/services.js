healthmonster.factory('ChildDash', function($resource) {
  return $resource('/child_dash', {},
    { 'get': { method: 'GET' } })
})

healthmonster.factory('AssignedChallenges', function($resource) {
  return $resource('/assigned_challenges/:id', {id: '@id'},
    { 'update': { method: 'PUT' } })
})
