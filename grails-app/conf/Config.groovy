// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }


grails.gorm.default.constraints = {
    '*'(nullable: true, blank: true)
}

grails.databinding.dateFormats = [
        'dd/MM/yyyy', 'ddMMyyyy', 'yyyy-MM-dd HH:mm:ss.S', "yyyy-MM-dd'T'hh:mm:ss'Z'"
]

beans {
    cacheManager {
        shared = true
    }

}

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
                      all          : '*/*', // 'all' maps to '*' or the first available format in withFormat
                      atom         : 'application/atom+xml',
                      css          : 'text/css',
                      csv          : 'text/csv',
                      form         : 'application/x-www-form-urlencoded',
                      html         : ['text/html', 'application/xhtml+xml'],
                      js           : 'text/javascript',
                      json         : ['application/json', 'text/json'],
                      multipartForm: 'multipart/form-data',
                      rss          : 'application/rss+xml',
                      text         : 'text/plain',
                      hal          : ['application/hal+json', 'application/hal+xml'],
                      xml          : ['text/xml', 'application/xml',
                      ], pdf       : 'application/pdf',
                      rtf          : 'application/rtf',
                      ods          : 'application/vnd.oasis.opendocument.spreadsheet',
                      rtf          : 'application/rtf',
                      excel        : 'application/vnd.ms-excel'
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        // filteringCodecForContentType.'text/html' = 'html'
    }
}


grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password','initialPassword']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

grails.plugins.twitterbootstrap.fixtaglib = true
grails.plugins.twitterbootstrap.defaultBundle = 'bundle_bootstrap'


environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
    }
}

// log4j configuration
log4j.main = {
    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
            'org.codehaus.groovy.grails.web.pages', //  GSP
            'org.codehaus.groovy.grails.web.sitemesh', //  layouts
            'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
            'org.codehaus.groovy.grails.web.mapping', // URL mapping
            'org.codehaus.groovy.grails.commons', // core / classloading
            'org.codehaus.groovy.grails.plugins', // plugins
            'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
            'org.springframework',
            'org.hibernate',
            'net.sf.ehcache.hibernate',
            'grails.app.services.org.grails.plugin.resource',
            'grails.app.taglib.org.grails.plugin.resource',
            'grails.app.resourceMappers.org.grails.plugin.resource'

    debug  	'grails.app',
            'org.apache.camel.support',
            'org.apache.camel.file',
            'org.apache.commons.net',
            'com.acception'
            'gerencia.fase'

    info 'org.springframework.security'


    appenders {
        console name: "stdout", layout: pattern(conversionPattern: '[%d{yyyy-MM-dd hh:mm:ss.SSS}][%t][%X{username}@%X{ip}] %p %c{1} - %m%n')
    }
}

grails.plugin.console.enabled = true

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.useSwitchUserFilter = true
grails.plugin.springsecurity.password.algorithm = 'bcrypt'
grails.plugin.springsecurity.userLookup.userDomainClassName = 'com.acception.security.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'com.acception.security.UserRole'
grails.plugin.springsecurity.authority.className = 'com.acception.security.Role'
grails.plugin.springsecurity.successHandler.alwaysUseDefault = true
grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/home/painelInicial'

def allRoles = ['ROLE_SUPORTE','ROLE_FINANCIADOR','ROLE_RESPONSAVEL','ROLE_FUNCIONARIO','ROLE_ADMINISTRADOR_SISTEMA']

grails.plugin.springsecurity.controllerAnnotations.staticRules = [
        '/j_spring_security_switch_user'                             : ['ROLE_SUPORTE', 'ROLE_ADMINISTRADOR_SISTEMA', 'isFullyAuthenticated()'],
        '/j_spring_security_exit_user'                               : ['ROLE_SUPORTE', 'ROLE_ADMINISTRADOR_SISTEMA', 'isFullyAuthenticated()'],
	'/':                ['permitAll'],
	'/index':           allRoles,
	'/home/**':           allRoles,
	'/centroCusto/**':           allRoles,
	'/anexo/**':           allRoles,
	'/user/**':           ['ROLE_SUPORTE','ROLE_ADMINISTRADOR_SISTEMA'],
    '/financiador/**':    allRoles,
    '/financiador/findSolicitacoes': allRoles,
    '/responsavel/**':   ['ROLE_SUPORTE','ROLE_ADMINISTRADOR_SISTEMA'],
    '/funcionario/**':   ['ROLE_SUPORTE','ROLE_ADMINISTRADOR_SISTEMA'],
    '/fornecedor/**':    ['ROLE_SUPORTE','ROLE_ADMINISTRADOR_SISTEMA'],
    '/linhaAcao/**':    ['ROLE_SUPORTE','ROLE_ADMINISTRADOR_SISTEMA'],
    '/atividade/**':    ['ROLE_SUPORTE','ROLE_ADMINISTRADOR_SISTEMA'],
    '/relatorioAtividade/**':    ['ROLE_SUPORTE','ROLE_ADMINISTRADOR_SISTEMA'],
    '/cidade/cidadePorEstado/**':    ['ROLE_SUPORTE','ROLE_ADMINISTRADOR_SISTEMA'],
	'/console/**':           ['ROLE_SUPORTE'],
	'/plugins/console*/**':           ['ROLE_SUPORTE'],
	'/role/**':           ['ROLE_SUPORTE','ROLE_ADMINISTRADOR_SISTEMA'],
	'/layouts':           allRoles,
	'/index.gsp':       allRoles,
	'/assets/**':       ['permitAll'],
	'/recuperarSenha/**':       ['permitAll'],
	'/**/js/**':        ['permitAll'],
	'/**/css/**':       ['permitAll'],
	'/**/images/**':    ['permitAll'],
	'/**/favicon.ico':  ['permitAll'],
	'/img/**':  ['permitAll']
]

