The Scrum 5000 application is here for your scrum pleasure!
===========================================================

Use Scrum 5000 to set a sprint, and keep track of daily activites, by user.

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
