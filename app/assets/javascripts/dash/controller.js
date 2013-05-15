healthmonster.controller('DashCtrl', 
  function($scope, $resource, $http, ChildrenYour, CompletedChallenges, Challenge, Categories, AssignedChallenge) {

    $scope.selected = {};
    $scope.challenge = {};
    $scope.assigned_challenge = {};
    $scope.challenge.category_id = 1

    $scope.children = ChildrenYour.index(
      function(data) {
        //console.log('success, got children_your: ', data);
      }, function(err) {
        alert('request to children_your failed');
      });

    $scope.completed_challenges = CompletedChallenges.index(
      function(data) { //success callback
        //console.log('success, got completed_challenges: ', data);
      }, function(err) { //error callback
        alert('request to completed_challenges failed');
    });

    $scope.categories = Categories.index(
      function(data) {
      }, function(err) {
        alert('request to categores failed');
    })

    $scope.createChallenge = function() {
      console.log($scope.challenge)

      data = {challenge: $scope.challenge}

      var challenge = new Challenge(data)
      challenge.$create()
    }

    $scope.createAssignedChallenge = function() {
      challenge_data = {challenge: $scope.challenge}

      var challenge = new Challenge(challenge_data)
      challenge.$create(
        function(data) {

          assigned_challenge = {challenge_id: data.id, 
            points: $scope.assigned_challenge.points,
            child_id: $scope.selected.child.id,
            category_id: data.category_id}

          console.log($scope.selected.child)

          console.log(assigned_challenge)

          assigned_challenge_data = { assigned_challenge: assigned_challenge}


          var assigned_challenge = new AssignedChallenge(assigned_challenge_data)
          assigned_challenge.$create()

        }, function(err) {
          alert('request to challenges failed')
        })
    }

    $scope.createReward = function() {
      $scope.reward.parent_id = 1
      console.log($scope.reward)

      $http.post('/rewards/', $scope.reward)
                      .success(function(data, status) {
                             console.log("Status:"+status+" Data:"+data.name);

                                 alert("New Reward!");
                             })
                      .error(function(data, status) {
                         alert("Didn't work...");
                      });
    }

    $scope.toggle = function(task) {
      task.show = !task.show;
      return task.show;
    };
});
