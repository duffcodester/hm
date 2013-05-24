healthmonster.controller('ChildDashCtrl',
  function($scope, ChildDash, AssignedChallenges) {

    ChildDash.get(
      {},
      function(dash_data) { //success
        $scope.child = dash_data.child
        $scope.assigned_challenges = dash_data.assigned_challenges
        $scope.accepted_challenges = dash_data.accepted_challenges
        $scope.enabled_rewards = dash_data.enabled_rewards
      },
      function(dash_data) { //error
        alert('request to /child_dash failed')
      }
    )

    $scope.acceptAssignedChallenge = function(assigned_challenge) {

      to_update = AssignedChallenges.get({id: assigned_challenge.id}, function() { //success

        console.log(to_update)

        to_update.accepted = true
        to_update.$update()

        console.log('success')

      })


    }

    /*this.something = function() {}
    return $scope.Ctrl = this*/

  }
)