healthmonster.factory('Challenge', ['$resource', function($resource) {
  return $resource('/challenges', {},
    { 'create': { method: 'POST'}})
}])

healthmonster.factory('Reward', ['$resource', function($resource) {
  return $resource('/rewards', {},
    { 'create': { method: 'POST'}})
}])

healthmonster.factory('ChildrenYour', ['$resource', function($resource) {
  return $resource('/children_your', {}, 
    { 'index': { method: 'GET', isArray: true}}) 
}])

healthmonster.factory('CompletedChallenges', ['$resource', function($resource) {
  return $resource('/completed_challenges', {},
    { 'index': { method: 'GET', isArray: true}})
}])

healthmonster.factory('AssignedChallenge', ['$resource', function($resource) {
  return $resource('/assigned_challenges', {},
    { 'create': { method: 'POST'}})
}])

healthmonster.factory('EnabledReward', ['$resource', function($resource) {
  return $resource('/enabled_rewards', {},
    { 'create': { method: 'POST'}})
}])

//this works
/*$http.post('/challenges', data)
  .success(function(data, status) {
    console.log("Status:"+status+" Data:"+data);
    alert("New Challenge!");
  })
  .error(function(data, status) {
    alert("Didn't work...");
});*/
