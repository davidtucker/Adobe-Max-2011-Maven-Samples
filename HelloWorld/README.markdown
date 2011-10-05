Flex-Mojos Hello World Application
================================

Your first Flex-Mojos application can be up and running in a matter of minutes.  First, please be sure you've followed the correct setup to get the needed repositories in your settings.xml file for Maven.  This is needed so that your Maven installation knows where to find Flex-mojos.  Once that is in place, you can follow these steps to get up and running with your first project.  The source code for the completed project is found in this directory as well.

1.  Run the Archetype to Create Your Project

```
mvn archetype:generate -DarchetypeRepository=http://repository.sonatype.org/content/groups/flexgroup/ -DarchetypeGroupId=org.sonatype.flexmojos -DarchetypeArtifactId=flexmojos-archetypes-application -DarchetypeVersion=3.9
```

2.  Update the pom.xml to include the correct version of the Flex SDK:

```
    <dependency>
      <groupId>com.adobe.flex.framework</groupId>
      <artifactId>flex-framework</artifactId>
      <version>4.5.0.17689</version>
      <type>pom</type>
    </dependency>
```

3.  Update the pom.xml to include the correct compiler version for the SDK you included:

```
    <plugin>
      <groupId>org.sonatype.flexmojos</groupId>
      <artifactId>flexmojos-maven-plugin</artifactId>
      <version>3.9</version>
      <extensions>true</extensions>
	  <dependencies>
		<dependency>
		  <groupId>com.adobe.flex</groupId>
		  <artifactId>compiler</artifactId>
		  <type>pom</type>
		  <version>4.5.0.17689</version>
	    </dependency>
	  </dependencies>
    </plugin>
```

4.  Update the pom.xml to include the HTML wrapper for your Flex application:

```
	<plugin>
	  <groupId>org.sonatype.flexmojos</groupId>
	  <artifactId>flexmojos-maven-plugin</artifactId>
	  <version>3.9</version>
	  <extensions>true</extensions>
		<executions>
	    <execution>
	      <goals>
	        <goal>wrapper</goal>
	      </goals>
	    </execution>
	  </executions>
	  <dependencies>
		<dependency>
		  <groupId>com.adobe.flex</groupId>
		  <artifactId>compiler</artifactId>
		  <type>pom</type>
		  <version>4.5.0.17689</version>
	    </dependency>
	  </dependencies>
	</plugin>
```

5.  Update the pom.xml to include the command used to launch the standalone version of the Flash Player (debugger):

```
	<properties>
		<flashPlayer.command>fpDebugger</flashPlayer.command>
	</properties>
```
	
6.  Once these tweaks are in place, you can build your application with `mvn clean package`.  Your `target` directory should now have your SWF and HTML file.
