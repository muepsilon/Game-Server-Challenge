== Scrabble Game Server 
Allows you to create,join and start new NxN grid scrabble multi player game.

Steps you may want to follow:

1. Ruby version - 2.2.x
2. Install gems using bundle
3. Install bower components
4. Create Databases
5. Run migrations
6. Build dictionary table using system's /usr/share/dict/words file
7. For websocket configuration refer to 
[websocket-rails](https://github.com/websocket-rails/websocket-rails/wiki/Installation-and-Setup)

---
    bundle install
    bower install
    rake db:create
    rake db:migrate
    rake one_timers:build_dict_words
---
