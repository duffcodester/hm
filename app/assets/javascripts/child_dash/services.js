healthmonster.factory('ChildDash', function($resource) {
  return $resource('/child_dash', {},
    { 'get': { method: 'GET' } })
})