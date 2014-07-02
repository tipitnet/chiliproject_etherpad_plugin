Chiliproject Etherpad plugin
============================

This plugin allows the integration of Etherpad into Chiliproject.

## How it works

On the server side, it adds a new controller that takes care of managing user's integrations, groups and pads creation. To do this, it uses the etherpad-lite gem. Each project on Chili side is associated with a group on Etherpad.
On the client side, the integration is handled by the jQuery plugin, which generates an iframe pointing to the Etherpad instance.


## Plugin Installation

It is a regular Chiliproject plugin. All that is needed is to just drop the plugin into */vendor/plugins/chiliproject_etherpad* and set the following 3 environment variables:

* PAD_HOST: your Etherpad location (e.g. http://etherpad.youdomain.com)
* PAD_KEY: your Etherpad API key
* PAD_DOMAIN: the main domain under your Chiliproject and Etherpad instances that are running. 
  * This is a restriction of the plugin because Chiliproject needs to run in the same main domain as your Etherpad instance. 
  * If your Etherpad instance is running under *etherpad.yourdomain.com* and your Chiliproject instance is running under *chiliproject.your.com*, then PAD_DOMAIN should be set to ".yourdomain.com"

## Etherpad configuration

On Etherpad ensure *requireSession* is set to *false*.

