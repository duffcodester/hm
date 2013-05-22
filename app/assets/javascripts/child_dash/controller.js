healthmonster.controller('ChildDashCtrl',
  function($scope, ChildDash) {

    dash_data = ChildDash.get()

    copy = {"child":{"age_group":"10-12+","avatar":"hm_hero_home","created_at":"2013-05-10T22:54:43Z","id":4,"parent_id":1,"password_digest":"$2a$10$hQrlbeD8du3e.7rFEg5Im.dMDHwd7DL5rZ7MeLLA5WATEXXI7l32m","points":905,"remember_token":"t36rY85u-iW1Be9cpmf2pA","updated_at":"2013-05-10T22:54:43Z","username":"child"},"assigned_challenges":[{"accepted":false,"category_id":5,"challenge_id":21,"child_id":4,"completed":false,"created_at":"2013-05-10T22:54:43Z","id":15,"parent_id":1,"points":990,"rejected":false,"updated_at":"2013-05-10T22:54:43Z","validated":false},{"accepted":false,"category_id":4,"challenge_id":10,"child_id":4,"completed":false,"created_at":"2013-05-10T22:54:43Z","id":20,"parent_id":1,"points":967,"rejected":false,"updated_at":"2013-05-10T22:54:43Z","validated":false},{"accepted":false,"category_id":4,"challenge_id":12,"child_id":4,"completed":false,"created_at":"2013-05-10T22:54:43Z","id":23,"parent_id":1,"points":162,"rejected":false,"updated_at":"2013-05-10T22:54:44Z","validated":false},{"accepted":false,"category_id":1,"challenge_id":5,"child_id":4,"completed":false,"created_at":"2013-05-10T22:54:43Z","id":24,"parent_id":1,"points":774,"rejected":false,"updated_at":"2013-05-10T22:54:43Z","validated":false},{"accepted":false,"category_id":1,"challenge_id":40,"child_id":4,"completed":false,"created_at":"2013-05-15T21:48:32Z","id":40,"parent_id":1,"points":123,"rejected":false,"updated_at":"2013-05-15T21:48:32Z","validated":false},{"accepted":false,"category_id":1,"challenge_id":50,"child_id":4,"completed":false,"created_at":"2013-05-16T21:20:50Z","id":43,"parent_id":1,"points":9,"rejected":false,"updated_at":"2013-05-16T21:20:50Z","validated":false},{"accepted":false,"category_id":1,"challenge_id":55,"child_id":4,"completed":false,"created_at":"2013-05-16T21:27:50Z","id":46,"parent_id":1,"points":89,"rejected":false,"updated_at":"2013-05-16T21:27:50Z","validated":false}],"accepted_challenges":[{"accepted":true,"category_id":4,"challenge_id":11,"child_id":4,"completed":false,"created_at":"2013-05-10T22:54:43Z","id":11,"parent_id":1,"points":390,"rejected":false,"updated_at":"2013-05-10T22:54:43Z","validated":false},{"accepted":true,"category_id":3,"challenge_id":2,"child_id":4,"completed":false,"created_at":"2013-05-10T22:54:44Z","id":34,"parent_id":1,"points":919,"rejected":false,"updated_at":"2013-05-10T22:54:44Z","validated":false}],"enabled_rewards":[{"child_id":4,"created_at":"2013-05-10T22:54:44Z","id":16,"parent_id":1,"points":658,"redeemed":false,"reward_id":16,"updated_at":"2013-05-10T22:54:44Z"},{"child_id":4,"created_at":"2013-05-10T22:54:44Z","id":17,"parent_id":1,"points":449,"redeemed":false,"reward_id":25,"updated_at":"2013-05-10T22:54:44Z"},{"child_id":4,"created_at":"2013-05-10T22:54:44Z","id":19,"parent_id":1,"points":194,"redeemed":false,"reward_id":15,"updated_at":"2013-05-10T22:54:44Z"},{"child_id":4,"created_at":"2013-05-10T22:54:44Z","id":20,"parent_id":1,"points":680,"redeemed":false,"reward_id":27,"updated_at":"2013-05-10T22:54:44Z"},{"child_id":4,"created_at":"2013-05-10T22:54:44Z","id":22,"parent_id":1,"points":196,"redeemed":false,"reward_id":26,"updated_at":"2013-05-10T22:54:44Z"},{"child_id":4,"created_at":"2013-05-10T22:54:44Z","id":26,"parent_id":1,"points":925,"redeemed":false,"reward_id":3,"updated_at":"2013-05-10T22:54:44Z"},{"child_id":4,"created_at":"2013-05-16T13:39:14Z","id":32,"parent_id":1,"points":123,"redeemed":false,"reward_id":45,"updated_at":"2013-05-16T13:39:14Z"},{"child_id":4,"created_at":"2013-05-16T21:07:24Z","id":34,"parent_id":1,"points":99,"redeemed":false,"reward_id":49,"updated_at":"2013-05-16T21:07:24Z"}]}

    var getKeys = function(obj){
      var keys = [];
      for(var key in obj){
        keys.push(key);
      }
      return keys;
    }

    console.log(copy.child)
    console.log(typeof copy)
    console.log(typeof dash_data)
    console.log(typeof "string")

    $scope.dash_data = dash_data
    console.log(dash_data.child)
    console.log(Object.keys(dash_data))
    console.log(getKeys(dash_data))

    $scope.child = dash_data["child"]
    $scope.assigned_challenges = dash_data.assigned_challenges
    $scope.accepted_challenges = dash_data.accepted_challenges
    $scope.enabled_rewards = dash_data.enabled_rewards

    $scope.test = "TEST" 


  }
)