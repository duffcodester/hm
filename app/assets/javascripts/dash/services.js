healthmonster.factory('Challenge', function($resource) {
  return $resource('/challenges', {},
    { 'create': { method: 'POST'}})
})

healthmonster.factory('ChildrenYour', function($resource) {
  return $resource('/children_your', {}, 
    { 'index': { method: 'GET', isArray: true}}) 
})

healthmonster.factory('CompletedChallenges', function($resource) {
  return $resource('/completed_challenges', {},
    { 'index': { method: 'GET', isArray: true}})
})

healthmonster.factory('AssignedChallenge', function($resource) {
  return $resource('/assigned_challenges', {},
    { 'create': { method: 'POST'}})
})

//this works
/*$http.post('/challenges', data)
  .success(function(data, status) {
    console.log("Status:"+status+" Data:"+data);
    alert("New Challenge!");
  })
  .error(function(data, status) {
    alert("Didn't work...");
});*/
