grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.fork = [
    // configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
    //  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

    // configure settings for the test-app JVM, uses the daemon by default
    test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    // configure settings for the run-app JVM
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the run-war JVM
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the Console UI JVM
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        mavenLocal()
        grailsCentral()
        mavenCentral()
        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"

        mavenRepo "http://repo.grails.org/grails/plugins"
        mavenRepo "http://repo.grails.org/grails/core"
        mavenRepo "http://acceptiondev.com.br/artifactory/plugins-release-local"
        mavenRepo "http://acceptiondev.com.br/artifactory/libs-release-local"
        mavenRepo "http://jaspersoft.artifactoryonline.com/jaspersoft/third-party-ce-artifacts/"
        mavenRepo "http://repo.grails.org/grails/plugins"
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
        // runtime 'mysql:mysql-connector-java:5.1.29'
        // runtime 'org.postgresql:postgresql:9.3-1101-jdbc41'

        runtime 'org.postgresql:postgresql:9.3-1101-jdbc41'
        test "org.grails:grails-datastore-test-support:1.0.2-grails-2.4"
        compile 'org.apache.poi:poi-ooxml:3.7'
        compile 'commons-beanutils:commons-beanutils:1.8.3'
        compile 'org.apache.commons:commons-lang3:3.1'
    }

    plugins {
        compile ":spring-security-core:2.0-RC5"
        // plugins for the build system only
        build ":tomcat:7.0.55.2" // or ":tomcat:8.0.20"
        // plugins needed at runtime but not for compilation
        //runtime ":hibernate4:4.3.8.1" // or ":hibernate:3.6.10.18"

        runtime ":hibernate4:4.3.8.1"
        runtime ":database-migration:1.4.0"
        runtime ":jquery:1.11.1"
        compile "org.grails.plugins:jquery-ui:1.10.4"
        runtime ':console:1.5.5'
        runtime ":fixed-flat-file:0.4.1"

        // plugins for the compile step
        compile ":scaffolding:2.1.2"
        compile "org.grails.plugins:export:1.6"
        compile ':cache:1.1.8'
        compile ":asset-pipeline:2.1.5"
        compile ":fixtures:1.3"
        compile ":twitter-bootstrap:3.3.4"
        compile ":mail:1.0.7"
        compile ":quartz:1.0.2"
        compile ":audit-logging:1.0.7"
        compile ":simple-captcha:1.0.0"
        compile ":rest:0.8"
        compile "org.grails.plugins:jxl:0.54"
    }
}
