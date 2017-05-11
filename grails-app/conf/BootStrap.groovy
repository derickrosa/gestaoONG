import com.acception.security.Role
import grails.util.Environment

class BootStrap {
    def grailsApplication
    def fixtureLoader

    def init = { servletContext ->
        systemInicialLog()
        loadFixtures()
    }
    def destroy = {
    }

    def systemInicialLog() {
        def version = grailsApplication.metadata['app.version']
        log.info "-------------------------------------"
        log.info "Gerência da FASE versão: $version"
        log.info "(C) Acception 2017"
        log.info "-------------------------------------"
        log.info "System initialized..."
        log.info "Environment: ${Environment.current.name}"
    }

    def loadFixtures() {
        if (Role.count() == 0)
            fixtureLoader.load("users")
    }

}
