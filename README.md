opsworks_que
====================

Fork of opsworks_delayed_job to run que with supervisor


OpsWorks Set-Up
---------------

Create a custom layer for the delayed_job instances. Add the `AWS-OpsWorks-Rails-App-Server` security group to the layer, so that the instances have the usual cache and database access. Then, assign this cookbook's custom chef recipes to OpsWorks events as follows:

* **Setup**: `opsworks_delayed_job::setup`
* **Configure**: `opsworks_delayed_job::configure`
* **Deploy**: `opsworks_delayed_job::deploy`
* **Undeploy**: `opsworks_delayed_job::undeploy`
* **Shutdown**: `opsworks_delayed_job::stop`


To Do
-----

* Attributes should be better structured (allowing customization without requiring all worker processes to be listed).


&copy; 2013-2015 Joey Aghion, Artsy. [MIT License](LICENSE).
