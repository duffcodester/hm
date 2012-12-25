HealthMonster Rails App

Most recent deployment running at healthmonster.herokuapp.com
Based on HealthMonster.net

Authors ================================================
  Kelton M.
  Josh D.

Notes ==================================================
12/22/12 - We may have to change sessions_helper.rb in 
  the future.  Currently it has methods for current_user
  that only look up a "Parent", but use "user" as a local
  variable in the methods. 
12/23/12 - Updated the parent controller to sign in upon sign up. Currently working on the sign out.

12/25/12 - I got the signout to work. You have to go into the rails console and type "Parent.all.each { |parent| parent.save(validate: false) }" which tells Active Record to skip the validations. (See Chapter 8 above Fig 8.9). I created the challenge model and controller. I have created a page when you can create a challenge at /create_callenge/. All tests are currently passing for what has been done so far. There is no link to the create_challenge page yet, only can get to it by typing in address. Then we will work it into the relations with parents, etc. 

Acceptance Criteria ====================================

NYS  = not yet started
TWIP = test writing in progress
TWC  = test writing complete
ITIP = implementation and testing in progress
ITC  = implementation and testing complete

Work Progress =========================================
setup git
setup dev env
setup test env
ITC  - add StaticPages controller
ITC  - add static home page
ITC  - add Parents controller
ITC  - add Parent model
ITC  - write Parent model tests
ITC  - add Parent signup
ITC  - write Parent signup tests
ITC - sign in and sign out pages (on chap 8.2.5 Signin upon signup)
TWIP  - add Challenges controller
TWIP  - add Challenge model
TWIP  - integrate Challenge into database

Client Defined Acceptance Criteria ====================
NYS  - Parent can create a challenge
NYS  - Parent assigns points to a challenge
NYS  - Parent assigns a challenge to one or more children
NYS  - Parent can search a community pool of challenges for a challenge
NYS  - Parent can add a challenge to the community pool
NYS  - Challenges can be assigned one or more age ranges (6-8, 8-10, 10-12+, All)
NYS  - Parent can create a reward
NYS  - Parent can add a reward to a community pool
NYS  - Parent can search a community pool for rewards
NYS  - Parent can validate a completed challenge from a child
NYS  - Child can accept a pending challenge assigned by a parent
NYS  - Child can mark a challenge completed
NYS  - Child can reject a challenge
NYS  - Child can select a reward with available points (reward must be enabled by parent)
NYS  - Content Provider can generate challenges
NYS  - Parent can subscribe a child to a content provider (premium)
NYS  - Parent will have a dashboard that they can select each child and see a dashboard of activity including a pie chart with type of challenges completed, points earned, etc
NYS  - Parent will have a queue where activities they need to do go. Such as notification to validate a challenge
NYS  - Parent can register
NYS  - Parent registers a child. Child and parent relationship is static
NYS  - Parent has a login (email address for user name)
NYS  - Child has a login
NYS  - Parent can reset a child's password
NYS  - System resets Parent's password upon request
NYS  - Maximum points that can be assigned to a challenge is 99 points. Max reward points 9999
NYS  - Child can search community pool for challenges (not rewards) and send it to parent as a challenge they would like to do