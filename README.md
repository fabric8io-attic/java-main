# java-main

An image that can be used with Openshift's Source To Image in order to build Java/Main based maven projects.

##
Usage:
	sti build <git repo url> fabric8/java-main <target image name>
	docker run <target image name>

## Configuring the main class

There are multiple ways of configuring the main class.

- Inside the pom.xml using the docker.env.Main property.
- By using the -e flag on sti (e.g. sti build -e "JAVA_MAIN=my.mainClass" ....).
- By setting JAVA_MAIN property in .sti/environment under the projects source.

## Customizing the build

It may be possible that the maven build needs to be customized. For example:

- To invoke custom goals.
- To skip tests.
- To provide custom configuration to the build".
- To build specific modules inside a multimodule project".

In any case you can pass the MAVEN_ARGS environmental variable. 

In the example below we tell maven to just build the project with groupId "some.groupId" and artifactId "some.artifactId" and all its module dependencies.

	sti build -e "MAVEN_ARGS=install -pl some.groupId:some.artifactId -am" <git repo url> fabric8/java-main <target image name>
	

## Working with multimodule projects
The example above is pretty handy for multimodule projects. An other option really usefull is the OUTPUT_DIR environmental variable. This variable defines where in the source tree the output will be generated. By default the image assumes ./target. If its an other directory we need to specify the option.

A more complete version of the previous example would then be:


	sti build -e "OUTPUT_DIR=path/to/module/target,MAVEN_ARGS=install -pl some.groupId:some.artifactId -am" <git repo url> fabric8/java-main <target image name>





