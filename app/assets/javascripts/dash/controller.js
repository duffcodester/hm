var dash = angular.module('dash', ['ngResource']);

dash.controller('DashCtrl', 
  function($scope, ChildrenYour, CompletedChallenges) {

    $scope.children = ChildrenYour.index(
      function(data) {
        console.log('success, got children_your: ', data);
      }, function(err) {
        alert('request to children_your failed');
      });

    $scope.completed_challenges = CompletedChallenges.index(
      function(data) { //success callback
        console.log('success, got completed_challenges: ', data);
      }, function(err) { //error callback
        alert('request failed');
    });

    $scope.selected = {};
});

/*dash.directive('select-child', function() {
  return function(scope, element, attrs) {
    element.bind('click', function() {
      console.log('clicked');
      //$scope.selected = child;
     // $scope.attrs = attrs;
    })
  }
})*/

dash.directive('select', function() {
  return {
    restrict: "A",
    scope: false,
    link: function(scope, element, attrs) {
      element.bind('click', function() {
        scope.selected.child = jQuery.parseJSON(attrs.select);
        scope.$apply();
  
        if (attrs.select != scope.selected) {
          other_elements = angular.element(document.querySelectorAll('tr[select]')); //probably just need [select]

          for (var i = 0; i < other_elements.length; i++) {
            jQuery(other_elements[i]).css('background', 'none');
          }

          element.css('background', '#F3E2A9');
        }
      });
    }
  };
});
