FROM fabric8/base-sti

MAINTAINER iocanel@gmail.com
ENV STI_SCRIPTS_URL https://raw.githubusercontent.com/fabric8io/java-main/master/.sti/bin/

CMD ["/usr/bin/usage"]
