healthmonster.directive('selectTask', function() {
  return {
    restrict: "A",
    scope: false,
    link: function(scope, element, attrs) {
      element.bind('click', function() {
        if (scope.selected.task == attrs.selectTask) {
          scope.selected.task = 'none'
        } else {
          scope.selected.task = attrs.selectTask
        }
        
        scope.$apply()
      })
    }
  }
})

healthmonster.directive('selectChild', function() {
  return {
    restrict: "A",
    scope: false,
    link: function(scope, element, attrs) {
      element.bind('click', function() {
        scope.selected.child = jQuery.parseJSON(attrs.selectChild)
        scope.$apply();
  
        if (attrs.select != scope.selected) {
          other_elements = angular.element(document.querySelectorAll('tr[select-child]')); //probably just need [select]

          for (var i = 0; i < other_elements.length; i++) {
            jQuery(other_elements[i]).css('background', 'none');
          }

          element.css('background', '#F3E2A9');
        }
      });
    }
  };
});
