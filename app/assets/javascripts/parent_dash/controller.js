healthmonster.controller('DashCtrl', 
  ['$scope', 'ChildrenYour', 'CompletedChallenges', 'Challenge',
  'Categories', 'AssignedChallenge', 'Reward', 'EnabledReward',
  function($scope, ChildrenYour, CompletedChallenges, Challenge, 
  Categories, AssignedChallenge, Reward, EnabledReward) {

    clearNotifications = function() {  
      $scope.challenge_errors = []
      $scope.reward_errors = []
      $scope.challenge_success = null
      $scope.reward_success = null
    }

    resetModels = function() {
      $scope.selected.task = null
      $scope.challenge = {}
      $scope.reward = {}
      $scope.assigned_challenge = {}
      $scope.enabled_reward = {}
    }

    $scope.selected = {}
    $scope.selected.child = {}
    clearNotifications()
    resetModels()

    $scope.children = ChildrenYour.index(
      function(data) {
      }, function(err) {
        alert('request to children_your failed');
      });

    $scope.completed_challenges = CompletedChallenges.index(
      function(data) { //success callback
      }, function(err) { //error callback
        alert('request to /completed_challenges failed');
    });

    $scope.categories = Categories.index(
      function(data) {
      }, function(err) {
        alert('request to /categories failed');
    })

    $scope.createAssignedChallenge = function() {
      var challenge = new Challenge({challenge: $scope.challenge})

      challenge.$create(function(challenge_response) {
        if (challenge_response.errors) {
          $scope.challenge_errors.push.apply($scope.challenge_errors, challenge_response.errors)
        }

        assigned_challenge_data = {challenge_id: challenge_response.id, 
          points: $scope.assigned_challenge.points,
          child_id: $scope.selected.child.id,
          category_id: challenge_response.category_id}

        var assigned_challenge = new AssignedChallenge({assigned_challenge: assigned_challenge_data})

        assigned_challenge.$create(function(assigned_challenge_response) {
          clearNotifications()

          if (assigned_challenge_response.errors) {
            $scope.challenge_errors.push.apply($scope.challenge_errors, assigned_challenge_response.errors)
          } else {
            $scope.challenge_success = "Challenge Assigned!"
            resetModels()
          }
        }, function(assigned_challenge_err) {
          alert('request to /assigned_challenges failed')
        })
      }, function(err) {
        alert('request to /challenges failed')
      })
    }

    $scope.createEnabledReward = function() {
      var reward = new Reward({reward: $scope.reward})

      reward.$create(function(reward_response) {
        if (reward_response.errors) {
          $scope.reward_errors.push.apply($scope.reward_errors, reward_response.errors)
        }

        enabled_reward_data = {reward_id: reward_response.id,
          points: $scope.enabled_reward.points,
          child_id: $scope.selected.child.id}

        var enabled_reward = new EnabledReward({enabled_reward: enabled_reward_data})

        enabled_reward.$create(function(enabled_reward_response) {
          clearNotifications()

          if (enabled_reward_response.errors) {
            $scope.reward_errors.push.apply($scope.reward_errors, enabled_reward_response.errors)
          } else {
            $scope.reward_success = "Reward Enabled!"
            resetModels()
          }

        }, function(err) {
          alert('request to /enabled_rewards failed')
        })
      }, function(err) {
        alert('request to /rewards failed')
      })
    }
}]);
