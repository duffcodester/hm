healthmonster.factory('Challenge', ['$resource', function($resource) {
  return $resource('/challenges', {},
    { 'create': { method: 'POST'}})
}])

healthmonster.factory('Reward', function($resource) {
  return $resource('/rewards', {},
    { 'create': { method: 'POST'}})
})

healthmonster.factory('ChildrenYour', ['$resource', function($resource) {
  return $resource('/children_your', {}, 
    { 'index': { method: 'GET', isArray: true}}) 
}])

healthmonster.factory('CompletedChallenges', function($resource) {
  return $resource('/completed_challenges', {},
    { 'index': { method: 'GET', isArray: true}})
})

healthmonster.factory('AssignedChallenge', function($resource) {
  return $resource('/assigned_challenges', {},
    { 'create': { method: 'POST'}})
})

healthmonster.factory('EnabledReward', function($resource) {
  return $resource('/enabled_rewards', {},
    { 'create': { method: 'POST'}})
})

appModule.factory('sharedApplication', ['$rootScope','$http',function($rootScope, $http) {

}]);

//this works
/*$http.post('/challenges', data)
  .success(function(data, status) {
    console.log("Status:"+status+" Data:"+data);
    alert("New Challenge!");
  })
  .error(function(data, status) {
    alert("Didn't work...");
});*/
