healthmonster.controller('ChildDashCtrl',
  function($scope, ChildDash, AssignedChallenges, EnabledRewards) {
    var display_success = function(msg) {
      $scope.error_message = null
      $scope.success_message = msg
    }

    var display_error = function(msg) {
      $scope.success_message = null
      $scope.error_message = msg
    }

    ChildDash.get({},
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
      to_update = AssignedChallenges.get({id: assigned_challenge.id}, 
        function() { //success
          to_update.accepted = true

          to_update.$update({}, 
            function() {
              var index = $scope.assigned_challenges.indexOf(assigned_challenge);
              $scope.assigned_challenges.splice(index, 1);
              $scope.accepted_challenges.push(to_update)

              display_success('Challenge Accepted!')
            }
          )
        }, function(data) { //error
          alert('request to /assigned_challenges failed')
        }
      )
    }

    $scope.rejectAssignedChallenge = function(assigned_challenge) {
      to_update = AssignedChallenges.get({id: assigned_challenge.id}, 
        function() {
          to_update.rejected = true
          to_update.accepted = false
          to_update.$update({},
            function() {
              var indexAssigned = $scope.assigned_challenges.indexOf(assigned_challenge);
              var indexAccepted = $scope.accepted_challenges.indexOf(assigned_challenge);
    
              if (indexAssigned != -1) {
                $scope.assigned_challenges.splice(indexAssigned, 1);
              } else if (indexAccepted != -1) {
                $scope.accepted_challenges.splice(indexAccepted, 1);
              } else {
                alert("can't find assigned_challenge")
              }

              display_success('Challenge Rejected')
            }
          )
        }, function(data) {
          alert('request to /assigned_challenges failed')
        }
      )
    }

    $scope.completeAssignedChallenge = function(accepted_challenge) {
      to_update = AssignedChallenges.get({id: accepted_challenge.id}, 
        function() {
          to_update.completed = true
          to_update.accepted  = false
          to_update.$update({},
            function() {
              var index = $scope.accepted_challenges.indexOf(accepted_challenge);
              $scope.accepted_challenges.splice(index, 1);
              display_success('Challenge Completed!')
            }
          )
        }, function(data) {
          alert('request to /assigned_challenges failed')
        }
      )
    }

    $scope.redeemEnabledReward = function(enabled_reward) {
      to_update = EnabledRewards.get({id: enabled_reward.id}, 
        function() { //success
          to_update.redeemed = true
          to_update.$update({},
            function(enabled_reward_response) {
              if (enabled_reward_response.error) {
                display_error(enabled_reward_response.error)

              } else {
                var index = $scope.enabled_rewards.indexOf(enabled_reward);
                $scope.enabled_rewards.splice(index, 1);

                $scope.child.points -= enabled_reward.points
                display_success('Reward Redeemed!')
              }
            }
          )
        }, function(data) { //error
          alert('request to /assigned_challenges failed')
        }
      )
    }

    $scope.removeEnabledReward = function(enabled_reward) {
      to_update = EnabledRewards.get({id: enabled_reward.id}, 
        function() {
          to_update.$remove()

          var index = $scope.enabled_rewards.indexOf(enabled_reward);
          $scope.enabled_rewards.splice(index, 1);

          display_success('Reward Removed')
        }, function(data) {
          alert('request to /assigned_challenges failed')
        }
      )
    }

    /*this.something = function() {}
    return $scope.Ctrl = this*/
  }
)