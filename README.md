# Talk to Me

A small and lagely pointless project to allow my family to get a Mac
to talk to my nephew via their phones with ease.

## The `say` command on OSX

Ok, I won't lie, there are much easier ways of doing this then a
Ruby on Rails app, but then, do you really want to explain to 
your family how to use SSH on their phones and then use the command
line enough to make a 3 and 1½ years old childen have a full on 
converstaion with a computer? You really don't turst me.

Also this is a good excuse to use some of the features in Rails 5.
This project uses ActiveJob and ActiveChannel to bring things 
together. And CoffeeScript. Mmmmm CoffeeScript.

## Requirements

* macOS or a system with a `say` command that responds to `-v`
* Ruby 3.2.1

## Usage

### Running the Application

As this application is still in development, running isn't a simple
one liner to get things going, this will change in future though.

1) Clone the Repo

`$ git clone https://github.com/hiniko/talk-to-me.git`

2) Install gem requiremnts

`$ bundle`

3) Run the server in one terminal

```
➜  talk_to_me git:(master) rails server         
=> Booting Puma          
=> Rails 5.1.2 application starting in development on http://localhost:3000                         
=> Run `rails server -h` for more startup options 
Puma starting in single mode...                   
* Version 3.9.1 (ruby 2.3.1-p112), codename: Private Caller                                         
* Min threads: 5, max threads: 5                  
* Environment: development                        
* Listening on tcp://0.0.0.0:3000                 
Use Ctrl-C to stop  
```

4) Run the worker in a console process in another terminal 

```
$ rails console
Running via Spring preloader in process 8994      
Loading development environment (Rails 5.1.2)     
[1] pry(main)> SayServiceJob.perform_now  
```
  
5) Point your browser to `http://localhost:3000` and have fun!

### Hints with using Talk To Me

* The status box shows you the current state of the say process as well as the connection state to the server process. It will tell you if you're connected or not, or is the server is currently speaking or waitng before speaking again.

* If you are focused on the text box, you can use the up and down arrow keys to select a message you sent earlier. Like a command history.

## Contributions

If you wish contribute feel free to clone this repo and send Pull Requests!