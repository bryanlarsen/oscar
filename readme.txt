======================
OSCAR McMaster Project
======================

-------
Vagrant
-------

```
vagrant up
vagrant ssh
cd /vagrant
sudo ./finish.sh
```

note the mysql password you choose and the oscar password which will probably be  (user: oscardoc, password: mac2002, pin: 1117)

and then point your browser at https://localhost:8443/oscar to make sure the binary install works.   It'll force you to change your oscar password.

build from source, and then replace with new artifacts:

```
mvn package -Dmaven.test.skip=true
vi /vagrant/catalina_base/webapps/oscar/WEB-INF/classes/oscar_mcmaster.properties # and change db_password to your mysql password
cd /var/lib/tomcat7/webapps
sudo mv oscar oscar.old
sudo mv oscar.war oscar.war.old
sudo ln -s /vagrant/target/oscar-14.0.0-SNAPSHOT.war oscar.war
sudo ln -s /vagrant/catalina_base/webapps/oscar .
sudo service tomcat7 restart
```

and then point your browser at https://localhost:8443/oscar

------------
Requirements  
------------
These are not necessarily requirements but the version of software used by the author of this read me at the time of this writing. Generally speaking any newer version should work.
- mysql 5.1.52
- jdk1.6.0_23
- tomcat-6.0.29
- maven 2.2.1
- ant 1.8.1

-----------
Directories
-----------
catalina_base : is a catalina_base that's provided, it can be useful as a starting point for deployments or development.
database : contains sql scripts to initialise the database schema.
docs : developer style documentation
local_repo : a maven repository for libraries not found at the publicly accessible maven repositories.
src : the source code for this project, structured in a standard maven structure.
utils : some random utilities and files we don't have anywhere else to put.

--------
Building 
--------
This is a standard maven project. "mvn package" should create a target directory and there should be a war file in there.

To test jsp compilations, as well as run pmd, run "mvn verify". You will need your CATALINA_HOME environment variable set

For developers, if you are doing testing and need to skip the junit test, pmd checks, and checkstyle checks, do "mvn -Dmaven.test.skip=true -Dcheckstyle.skip=true -Dpmd.skip=true package". You should always try to run it with full checks before committing though.


-------
Tests
------
If you run the unit tests, maven needs a live MySQL database to load the schema, and test data into, as well as to perform the checks.
The defaults are a database named 'oscar_test', and full credentials to it for user 'oscar' and password 'oscar'. You can override
these properties if they don't suit you. The properties are available in src/test/resources/over_ride_config.properties. You can make your
own file and run maven with -Doscar_override_properties=/<full_path>/myoverrides.properties and those values will take prescendence.

-------------
NetBeans Note
-------------
If you are running the unit tests, and using your own override properties file in Netbeans, use 
-DargLine="-Doscar_override_properties=/<full_path>/myoverrides.properties"


Add this to a netbeans build.xml file for it to build and run.

<target name="-post-compile">
        <echo message="deleting hbm.xml files from src directory." />
            <delete>
                <fileset dir="${build.classes.dir}/src/" includes="**/*.hbm.xml"/>
            </delete>
</target>
    
