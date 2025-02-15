~~~~~~
type=post
title=Deploying GitBlit on JBoss/Wildfly
creator=rollinhand
date=2014-03-20
category=DevOps
~~~~~~
If you want to use GitBlit on a JBoss/Wildfly-based Java EE application server, 
deployment is a little bit tricky. This guide describes how you can deploy GitBlit 
with ease on JBoss/Wildfly.

<!--more-->

**Note:** In this detailed description I will always use Wildfly as synonym for Wildfly 
and JBoss servers. At the end of the article we will have a look at the special settings 
for Wildfly on Windows. The* gitblit-1.4.0.war* was renamed to *gitblit.war*.

GitBlit can be configured over its 
[depoyment descriptor web.xml](http://gitblit.com/setup_war.html "Setup documentation of GitBlit") 
to use a persistent directory for its configuration files. This will also help to keep 
configuration if newer versions of GitBlit are deployed to Wildfly. But if you place your 
gitblit.war into the deployments directory of Wildfly, the deployed archive is not 
persistent. If you modify the web.xml and set the** env-entry** for the **baseFolder** 
it is overwritten after redeployment.

See example:

```
<env-entry>
	<description>The base folder is used to specify the root location of your Gitblit data.</description>
	<env-entry-name>baseFolder</env-entry-name>
	<env-entry-type>java.lang.String</env-entry-type>
	<env-entry-value>/opt/gitblit/cfg</env-entry-value>
</env-entry>
```

For further reading, I define GitBlit's **baseFolder** as */opt/gitblit/cfg*.

Therefore Wildfly does not allow or has a mechanism to reset environment entries with 
runtime settings, the solution to deploy GitBlit or any other web application with 
environment entries, is to define a [deployment overlay](https://docs.jboss.org/author/display/WFLY8/Deployment+Overlays?_sscc=t "JBoss documentation=Deployment Overlays"). 
The Wildfly documentation states="Deployment overlays are our way of 'overlaying' 
content into an existing deployment, without physically modifying the contents of 
the deployment archive. Possible use cases include swapping out deployment descriptors, 
modifying static web resources to change the branding of an application, or even 
replacing jar libraries with different versions."

Follow these steps to create your own deployment overlay for GitBlit and redeploy the 
web archive again:

1. Ensure your new configuration directory for GitBlit exists.
2. Deploy GitBlit while copying the *gitblit.war* to the Folder deployments under domain or standalone depending on the mode you drive Wildfly.
3. After the archive is deployed, change to the extracted files under *tmp/vfs*. For e.g.* tmp/vfs/temp/tempfa47ccfd18779c0f/gitblit.war-47947744fb40cde3*.
4. Copy the file *WEB-INF/web.xml* to */opt/gitblit/web.xml* or to your desired directory.
5. Modify the copied *web.xml* and change the **env-entry-value** to your folder you expect the gitblit configuration to reside. In this example the value is changed to */opt/gitblit/cfg*.
6. Now comes the complicated part. You have to use the Wildfly command line interface to define your deployment overlay for GitBlit. Start Wildfly command line interface on the server with **jboss-cli.sh -c**.
7. Execute the following command (change parameters as needed):
```
deployment-overlay add --name=GitBlitOverlay --content=/WEB-INF/web.xml=/opt/gitblit/web.xml --deployments=gitblit.war --redeploy-affected.
```
8. The overlay is created and the archive is deployed once again. GitBlit copies 
its *gitblit.properties* and other files to the newly created directory */opt/gitblit/cfg*.

Now you can configure GitBlit as needed and your configuration is saved.

### For Windows Users:
The jboss-cli on Windows behaves very strange. If you define an overlay on Windows, 
make sure you are on the top of the drive your newly created directory lives. Executed 
then the command line interface of Wildfly on root level:
```
cd \
C:\wildfly\bin\jboss-cli.bat -c
```

Execute the command from step 7 with relative path. Don't use a drive letter.
