Feature: Signing Adult In

	Scenario: Unsuccessful Adult Login
		Given A user visits the signin page
		When he submits invalid signin information
		Then he should see an error message

	Scenario: Successful Adult Login
		Given A user visits the signin page
			And the user has an account
			And the user submits valid signin information
		Then he should see his profile page
			And he should see the signout link