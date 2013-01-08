# HealthMonster Rails App ![HealthMonster](http://d3nf22m6d68s6c.cloudfront.net/622637/958174/1341028381/50.png)

Most recent deployment running at [healthmonster.herokuapp.com](http://healthmonster.herokuapp.com "HealthMonster")  
App based on [HealthMonster.net](http://healthmonster.net "HealthMonster.net")

### Authors ###
  Kelton M.  
  Josh D.

### Notes ###
-  12/22/12 - We may have to change sessions_helper.rb in 
   the future.  Currently it has methods for current_user
   that only look up a "Parent", but use "user" as a local
   variable in the methods.
-  12/24/12 - Refer to [daringfireball](http://daringfireball.net/projects/markdown/syntax#p "markdown") markdown help for README.md styling.
-  12/25/12 - I got the signout to work. You have to go into the rails console and type "Parent.all.each { |parent| parent.save(validate: false) }" which tells Active Record to skip the validations. (See Chapter 8 above Fig 8.9). I created the challenge model and controller. I have created a page when you can create a challenge at /create_callenge/. All tests are currently passing for what has been done so far. There is no link to the create_challenge page yet, only can get to it by typing in address. Then we will work it into the relations with parents, etc. 
-  Why did we use --drb in .rspec for sample_app? It causes error for rspec tests when running spork.  Also, guard is still not working and spork appears not to have effect on test speed.
-  Add schema info to challenge model files as in parent model files.  (Can't remember the command.)
-  Could use some rspec test refactoring.
-  1/1/13 - Changed challenges point_value to int datatype and associated validations. Working on trying to display challenges from db. Changed create_challenge_path to new_challenge_path since route was redundant. Link to Browse challenges displays all challenges in db in ordered list.
-  1/2/13 - One thing to consider is we will have two versions of the database, one local and one on heroku. We can pull and push but it overwrites the existing one on either end as far as I can tell right now.
-  1/4/13 - DB relational stuff working well.  We need to figure out points stuff...does it make sense to assign points to every challenge?  How do rewards work into this?  This needs work...
-  1/6/13 - When migrating DB, make sure to restart the heroku server, "heroku restart".
-  For challenges, should have a name and a description.  Should not be created with points.  Also, do points come from rewards or challenges?
-  Should child have a unique email or username?
-  Add questions for steve section
-  1/7/13 - Brought parent model up to date thru 9.3 (parents index complete)

## Acceptance Criteria ##
NYS  = not yet started  
TWIP = test writing in progress  
TWC  = test writing complete  
ITIP = implementation and testing in progress  
ITC  = implementation and testing complete  

### Work Progress ###
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
ITC  - sign in and sign out pages (on chap 8.2.5 Signin upon signup)  
ITC  - add Challenges controller  
ITC  - add Challenge model  
ITC  - integrate Challenge into database  
ITC  - change db to have point_value as fixnum  
ITC  - add indexes to challenge_name for db to ensure uniqueness  
NYS  - remove index for duplicate challenges
NYS  - setup view for parent challenges ("Your" link)  
ITIP  - add Child controller  
ITIP  - add Child model   
NYS  - add Child signin  
ITIP  - DB relational stuff  

### Client Defined Acceptance Criteria ###
ITC  - Parent can register  
ITC  - Parent has a login (email address for user name)  
ITC  - Parent can create a challenge  
ITC  - Parent assigns points to a challenge  
ITC  - Maximum points that can be assigned to a challenge is 99 points. Max reward points 9999  
NYS  - Parent registers a child. Child and parent relationship is static  
NYS  - Child has a login  
NYS  - Parent can reset a child's password  
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
NYS  - System resets Parent's password upon request  
NYS  - Child can search community pool for challenges (not rewards) and send it to parent as a challenge they would like to do  