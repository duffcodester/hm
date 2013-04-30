dash.factory('ChildrenYour', function($resource) {
  return $resource('/children_your.json', {}, 
    { 'index': { method: 'GET', isArray: true}}); 
});

dash.factory('CompletedChallenges', function($resource) {
  return $resource('/completed_challenges.json', {},
    { 'index': { method: 'GET', isArray: true}});
});
