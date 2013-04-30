#= require jquery
#= require ../../vendor/assets/javascripts/angular
#= require ../../vendor/assets/javascripts/angular-resource
#= require helpers/angular-mocks
#= require dash/controller

describe('DashCtrl', function() {
  var scope, ctrl, $httpBackend;
  var children = [{"age_group":"6-8","avatar":null,"created_at":"2013-02-15T14:30:55Z","id":1,"parent_id":1,"password_digest":"$2a$10$aoTfwANODSAaL6MdIZtCjung39Q89xXTsKFQWxYDmMnT1DvZ3516.","points":1151,"remember_token":"OPrgR7h0f0o5c5R3MQGaLA","updated_at":"2013-03-23T00:09:56Z","username":"my_child"},{"age_group":"8-10","avatar":null,"created_at":"2013-03-01T17:44:13Z","id":2,"parent_id":1,"password_digest":"$2a$10$WQutrxR0b2/uzzgze4165OM3okUZRUkc6b0o3XDtH.vmsn.RNuwP.","points":0,"remember_token":"8E2rUZzrX70g0GEzkUiPiw","updated_at":"2013-03-01T17:44:45Z","username":"another_child"}];
  var completed_challenges = [{"accepted":false,"category_id":1,"challenge_id":1,"child_id":1,"completed":true,"created_at":"2013-03-24T09:32:26Z","id":7,"parent_id":1,"points":100,"rejected":false,"updated_at":"2013-03-31T05:28:38Z","validated":false}];

  beforeEach(inject(function(_$httpBackend_, $rootScope, $controller){
    $httpBackend = _$httpBackend_;
    $httpBackend.expectGET('/children_your.json').respond(children);
    $httpBackend.expectGET('/completed_challenges.json').respond(completed_challenges);

    scope = $rootScope.$new();
    ctrl = $controller(DashCtrl, {$scope: scope});
  }));

  it('should create "children" model with 2 children fetched from xhr', function() {
    expect(scope.children).toBeUndefined();
    $httpBackend.flush();

    expect(scope.children).toEqual(children);
  });

  it('should create "completed_challenges" model fetched from xhr', function() {
    expect(scope.completed_challenges).toBeUndefined();
    $httpBackend.flush();

    expect(scope.completed_challenges).toEqual(completed_challenges);
  });

});

/*    it('should set the default value of orderProp model', function() {
      expect(scope.orderProp).toBe('age');
    }); */
