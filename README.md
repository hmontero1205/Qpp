[Q++; Office hours done right.](https://github.com/hmontero1205/Qpp)
====================================================================
Hans Montero \<hjm2133@columbia.edu>  
Matthew Broughton \<mb4207@columbia.edu>  
Evan Mesterhazy \<etm2131@columbia.edu>  

[Heroku Deployment](https://enigmatic-shelf-31249.herokuapp.com)

[Iteration 1 Release](https://github.com/hmontero1205/Qpp/releases/tag/v1.0)  
[Iteration 2 Release](https://github.com/hmontero1205/Qpp/releases/tag/v2.0)

Code Coverage: 💯%

Dependencies
------------
Mostly handled by `bin/bundle update && bin/bundle install`.

Manually install postgresql. We use it for ActionCable. On Linux, you may have
to create a user for yourself see
[here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04)
for more details.

Please also install geckodriver, as it is needed for our cucumber tests.  e.g.
`brew install geckodriver` on MacOS or see
[this](https://github.com/mozilla/geckodriver/releases).

Main Features
-------------
Here's a list of the main features Q++ offers as of now!
- Clean and usable interface for creating, listing, and searching office hours.
- TA login portal for OH management
- Enable/disable OH
- Live waitqueue: see how long you've been waiting for!
  - Students can enqueue/dequeue themselves
  - TAs can enqueue/dequeue anybody
  - Timer keeps track of your wait time
  - See who is ahead of you
  - Add a little blurb about why you're at OH so others can help faster!
- Live chat: talk to others while you wait!
  - Follow up on queue entries with your own advice
  - Solve other people's problems if you know the answer
  - Save other people time, too!

Future Features
---------------
- Zoom integration! Instead of only offering a Zoom link on a page, embed a Zoom meeting directly onto the OH page. This will make for a one-tab experience for OH.
- Add support for markdown in the chat
- Advanced OH management: recurring meetings

Walkthrough
-----------
Start up a local server (via `rails s`) or visit the heroku deployment. Here's a
walkthrough of the features we currently support. If deploying locally, please
run all migrations (via `rails db:migrate`).

### Live Waitqueue
1. As a TA, you must register with the service in order to create new OH event.
   Start by registering and logging in.
2. Once you are logged in as a TA, schedule an office hour session! You should
   now have the option to do so back on the home page. We aren't integrating
   with Zoom yet so just put in a Zoom link when prompted for Zoom info.
3. Go to the page for the OH you just created. You should see an enable/disable
   button on the bottom. By default, OH start off as disabled which means
   students will not be able to enqueue themselves.
4. Open an incognito tab and navigate to the same OH page. Since you aren't
   logged in here, you are effectively in "student mode". Since the OH isn't
   enabled yet, you can't enqueue yourself!
5. Back on the TA tab, hit enable OH. You should now see that the queue
   functionality is online.
6. Back on the student tab, enqueue yourself! Using ActionCable, we implemented
   live events. Updates to the queue are published to all visitors without
   having to refresh the page. Each queue entry has a timer saying how long the
   student has been waiting since enqueuing themselves. Feel free to make more
   queue entries!
7. Only the TA has the power to dequeue students right now (in the future the
   enqueuer will also be able to remove themselves). Back on the TA tab, remove
   some queue entries by clicking the X-button. All tabs should see that the
   queue entries were removed!
8. When the TA decides that OH is over, they simply deactivate the OH by hitting
   the deactivate button at the bottom of the OH view. This will remove all
   queue entries and disable the queue feature.
9. We also support the rest of the CRUD operations for OH. That is, a TA can
   also delete an OH session or update OH attributes.

### Chat
1. Once you have an OH session going with some queue entries, click the "Thread" button.
2. On the side, you should see a chatbox open up. This is where the per-student conversation happens!
3. Either as a TA or a student, send a message. The chatbox will update to include your message.
4. If you have any other tabs open, you'll see that the chat show up if you had the thread open.
5. The OH view will update even if you don't have the specific chatbox open. Next to every queue entry, you'll see the message count in each thread update as new messages come in. This allows anyone to stay updated on the conversation!
6. Threads are deleted once the queue entry is deleted. In the future, we'll add some sort of archive feature so students joining OH late can see what past questions were.