Chiliproject Etherpad plugin
============================

This plugin allow to integrate Etherpad into Chiliproject.

How it works

On the server side, it adds a new controller that takes care of managing users integration, groups and pads creation. To do this, it uses the etherpad-lite gem. Each project on Chili side is associated with a group on Etherpad.
On the client side, the integration is handled by the jQuery plugin., which generates an iframe pointing to Etherpad instance.


## Plugin Installation

It is a regular Chiliproject plugin, just drop the plugin into /vendor/plugins/chiliproject_etherpad and set the following 3 environment variables.

* PAD_HOST: your Etherpad location (e.g. http://etherpad.youdomain.com)
* PAD_KEY: your Etherpad API key
* PAD_DOMAIN: the main domain under you Chiliproject and Etherpad instances are running. This is a restriction of the plugin, your Chiliproject should run in the same main domain that you Etherpad instance. If your Etherpad instance in running under etherpad.yourdomain.com and you Chiliprojec instance is running under chiliproject.your.com, then PAD_DOMAIN should be set to ".yourdomain.com"

## Etherpad configuration

On Etherpad just ensure to set requireSession to false.

