bepasty-formula
===============

A SaltStack formula for easy
(bepasty-server)[https://github.com/bepasty/bepasty-server] installation.

It installs bepasty with a new user called bepasty into its home (/home/bepasty) and configures supervisor to start a gunicorn instance. It does _not_ set up nginx or another webserver as reverse proxy. The gunicorn instance binds to 0.0.0.0:5000 so you can even run your webserver on another host (keep in mind to set up the firewall correctly). It sets up filesystem storage to /home/bepasty/storage. It's tested on Debian Wheezy.

Consult SaltStack doc for documentation how to use it.

Sometimes the state doesn't reload supervisor correctly - no idea why. If you
only get Error 500 try to reload the supervisor ('supervisorctl reload bepasty')
