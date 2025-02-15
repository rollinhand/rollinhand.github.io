type=post
title=Downgrade Jenkins Git Plugin
creator=rollinhand
date=2014-05-15
category=DevOps
~~~~~~
If you also encounter problems with Jenkins' Git plugin I tell you in this post how you 
can manually downgrade the plugin to a prior version.&nbsp;

<!--more-->

Many users on the mailing list of Jenkins encounter massive problems and missing features 
with the new Jenkins Git plugin since version 2.0. Very significant problems relate to 
the check mechanism for changes in sub-directories or the missing expansion of environment 
variables. These are all features you get back if you migrate to version 1.5.0. 
Here is the guide how to do it.

To avoid side effects while downgrading the needed plugins, stop your standalone Jenkins 
server or the web container Jenkins is running in. Follow these steps:

* Change to the plugins directory of Jenkins and remove the following files and directories=
__git-client.jpi, git-client, git.jpi, git__.
* Download git-client 1.9.0 and git 1.5.0 directly from Jenkins Update server and copy 
the files __git-client.hpi__ and __git.hpi__ into the plugins directory or use the upload 
feature in Jenkins. See attached Links at the end of the article for the right URLs
to get the new plugins.
* Fire Jenkins up.

After Jenkins is started, you have to reconfigure all your jobs using Git repositories. 
The section in config.xml for Git has changed in Git plugin 2.0 which is not compatible 
with prior versions. To ease up work on configurations change every line in **config.xml** 
from __git@2.2.1__ to __git@1.5.0__ as shown below:

```
scm class="hudson.plugins.git.GitSCM" plugin="git@2.2.1"
scm class="hudson.plugins.git.GitSCM" plugin="git@1.5.0"
```

After changing these values your repository URLs are restored and most of the global 
settings. Specific settings like "Included Regions" or subdirectories for Checkout 
must be added manually.

The changes take effect if you select the option **Load configuration from disk** on **Manage Jenkins**.
