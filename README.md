The Scrum 5000 application is here for your scrum pleasure!
===========================================================

Use Scrum 5000 to set a sprint, and keep track of daily activites, by user.

#Initial setup
rhc create-app cron ruby-2.0 -a scrumapp

#Configuration
Please see the config/database.yml file for database and application variables that need to be set prior to running the application. On linux, this can be acheived by running

```
export OPENSHIFT_APP_NAME=myname
```

 in the environment where the application will run. If deploying on OpenShift, please use

```
rhc env set <Variable>=<Value> <Variable2>=<Value2> -a App_Name
```

In addition to setting the OPENSHIFT* variables in the config/database.yml file,
please also be sure to set the OPENSHIFT_DATA_DIR variable if using this application outside of OpenShift (if running on OpenShift, this value will be set for you). This is the area where the database dumps are to be stored for later retrieval.

#Database Dumps
In conjunction with the cron cartridge on OpenShift (or normal cron on a *nix system) the application can perform a dump of the database to a plain yaml file. This is done by way of the yaml\_db gem. To use this in OpenShift, you'll need to run

```
rhc ssh <app-name>
```
followed by
```
scl enable ror40 "bundle exec rake db:data:dump"
```
If running a standalone rails instance, simply run
```
rake db:data:dump
```
This will store a file in the top-level 'db' folder of the rails application (in OpenShift, this is found under $OPENSHIFT\_REPO\_DIR/db as data.yml. To restore your application from a previous dump, simply run

```
rhc ssh <app-name>
```
followed by
```
scl enable ror40 "bundle exec rake db:data:load"
```
If running a standalone rails instance,
```
rake db:data:load
```

#Bot integration
This application provides integration with an IRC bot, which will allow a user to receive timely and persistent reminders to complete their scrum. It will also allow the user to file a scrum directly from the IRC channel they are in. For more information, see [cucubot](https://github.com/cjryan/cucubot)

##Fuzzy Match
As an additional feature, scrum5000 uses the fuzzy\_match gem, which will try to match a user's IRC nick to the user database in the scrum5000 application. Commonly, IRC users will indicate status by appending _afk or _mtg to their nick. Fuzzy match will attempt to reconcile, for example, joe\_mtg to the 'joe' user in scrum5000.
