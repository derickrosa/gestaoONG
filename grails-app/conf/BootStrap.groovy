import com.acception.security.Role
import grails.util.Environment

class BootStrap {
    def grailsApplication
    def fixtureLoader

    def init = { servletContext ->
        systemInicialLog()
        loadFixtures()
        loadPerfisAcesso()
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

    def loadPerfisAcesso() {
      if(!Role.findByAuthority('ROLE_SUPORTE')){
          def role = new Role(nome: 'Suporte Acception',authority: 'ROLE_SUPORTE')
          role.save(flush:true,failOnError:true)
      }
          if(!Role.findByAuthority('ROLE_FINANCIADOR')){
          def role = new Role(nome: 'Financiador',authority: 'ROLE_FINANCIADOR')
          role.save(flush:true,failOnError:true)
      }
          if(!Role.findByAuthority('ROLE_RESPONSAVEL')){
          def role = new Role(nome: 'Responsável',authority: 'ROLE_RESPONSAVEL')
          role.save(flush:true,failOnError:true)
      }
          if(!Role.findByAuthority('ROLE_FUNCIONARIO')){
          def role = new Role(nome: 'Funcionário',authority: 'ROLE_FUNCIONARIO')
          role.save(flush:true,failOnError:true)
      }

        if(!Role.findByAuthority('ROLE_ADMINISTRADOR_SISTEMA')){
          def role = new Role(nome: 'Administrador do Sistema',authority: 'ROLE_ADMINISTRADOR_SISTEMA')
          role.save(flush:true,failOnError:true)
      }
    }

}
