# java-main

An image that can be used with Openshift's Source To Image in order to build Java/Main based maven projects.

##
Usage:

	s2i build <git repo url> fabric8/java-main <target image name>
	docker run <target image name>

## Configuring the main class

There are multiple ways of configuring the main class.

- Inside the `pom.xml` using the `docker.env.Main` property.
- By using the -e flag on s2i (e.g. s2i build `-e "JAVA_MAIN=my.mainClass"` ....).
- By setting `JAVA_MAIN` property in `.sti/environment` under the projects source.

## Customizing the build

It may be possible that the maven build needs to be customized. For example:

- To invoke custom goals.
- To skip tests.
- To provide custom configuration to the build".
- To build specific modules inside a multimodule project".
- To add debug level logging to the Maven build

The `MAVEN_ARGS` environment variable can be set to change the behaviour. By
default `MAVEN_ARGS` is set to:

  package dependency:copy-dependencies -DskipTests -e

You can override the `MAVEN_ARGS` like in the example below we tell maven to just build the project with groupId "some.groupId" and artifactId "some.artifactId" and all its module dependencies.

	s2i build -e "MAVEN_ARGS=install -pl some.groupId:some.artifactId -am" \ 
	          <git repo url> fabric8/java-main <target image name>

You can also just override the `MAVEN_DEBUG_ARGS` environment variable with:

    -e "MAVEN_DEBUG_ARGS=-X"

## Working with multimodule projects
The example above is pretty handy for multimodule projects. An other option really usefull is the OUTPUT_DIR environmental variable. This variable defines where in the source tree the output will be generated. By default the image assumes ./target. If its an other directory we need to specify the option.

A more complete version of the previous example would then be:

	s2i build -e "OUTPUT_DIR=path/to/module/target,MAVEN_ARGS=install -pl some.groupId:some.artifactId -am" \
	          <git repo url> fabric8/java-main <target image name>

### Real world examples:

	s2i build git://github.com/fabric8io/quickstarts.git fabric8/java-main fabric8/camel-cdi-mq \
	    -e "OUTPUT_DIR=quickstarts/java/camel-cdi-mq/target,MAVEN_ARGS=package dependency:copy-dependencies -Popenshift -DskipTests -pl io.fabric8.jube.images.fabric8:quickstart-java-camel-cdi-mq -amd" \
	    --loglevel=5 -r project-2.0.40


