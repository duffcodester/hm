dash.factory('ChildrenYour', function($resource) {
  return $resource('/children_your.json', {}, 
    { 'index': { method: 'GET', isArray: true}}); 
});

dash.factory('CompletedChallenges', function($resource) {
  return $resource('/completed_challenges.json', {},
    { 'index': { method: 'GET', isArray: true}});
});

dash.factory('Challenges', function($resource) {
  return $resource('/challenges', {},
    { 'create': { method: 'POST'}})
})

dash.factory('AssignedChallenges', function($resource) {
  return $resource('/assigned_challenges', assigned_challenge_data,
    { 'create': { method: 'POST'}})
})
