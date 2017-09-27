import com.acception.cadastro.Adiantamento
import com.acception.cadastro.Arquivo
import com.acception.cadastro.Cidade
import com.acception.cadastro.Estado
import com.acception.cadastro.Lancamento
import com.acception.security.Role
import grails.converters.JSON
import grails.util.Environment
import org.codehaus.groovy.grails.web.mapping.LinkGenerator

class BootStrap {
    def grailsApplication
    def fixtureLoader
    LinkGenerator grailsLinkGenerator

    def init = { servletContext ->
        systemInicialLog()
        loadFixtures()
        loadPerfisAcesso()
        registerMarchallers()
    }
    def destroy = {
    }


    void systemInicialLog() {
        def version = grailsApplication.metadata['app.version']
        log.info "-------------------------------------"
        log.info "Gerência da FASE versão: $version"
        log.info "(C) Acception 2017"
        log.info "-------------------------------------"
        log.info "System initialized..."
        log.info "Environment: ${Environment.current.name}"
    }

    void loadFixtures() {
        if (Estado.count() == 0)
            fixtureLoader.load("all_estados")
        if (Cidade.count() == 0) {
            fixtureLoader.load("cidades_ab")
            fixtureLoader.load("cidades_cde")
            fixtureLoader.load("cidades_gm")
            fixtureLoader.load("cidades_p")
            fixtureLoader.load("cidades_r")
            fixtureLoader.load("cidades_st")
        }
        if (Role.count() == 0)
            fixtureLoader.load("users")
    }

    void loadPerfisAcesso() {
        if (!Role.findByAuthority('ROLE_SUPORTE')) {
            def role = new Role(nome: 'Suporte Acception', authority: 'ROLE_SUPORTE')
            role.save(flush: true, failOnError: true)
        }
        if (!Role.findByAuthority('ROLE_FINANCIADOR')) {
            def role = new Role(nome: 'Financiador', authority: 'ROLE_FINANCIADOR')
            role.save(flush: true, failOnError: true)
        }
        if (!Role.findByAuthority('ROLE_RESPONSAVEL')) {
            def role = new Role(nome: 'Responsável', authority: 'ROLE_RESPONSAVEL')
            role.save(flush: true, failOnError: true)
        }
        if (!Role.findByAuthority('ROLE_FUNCIONARIO')) {
            def role = new Role(nome: 'Funcionário', authority: 'ROLE_FUNCIONARIO')
            role.save(flush: true, failOnError: true)
        }

        if (!Role.findByAuthority('ROLE_ADMINISTRADOR_SISTEMA')) {
            def role = new Role(nome: 'Administrador do Sistema', authority: 'ROLE_ADMINISTRADOR_SISTEMA')
            role.save(flush: true, failOnError: true)
        }
    }

    void registerMarchallers() {
        JSON.registerObjectMarshaller(Arquivo) {
            [
                    id  : it.id,
                    name: it.fileName,
                    size: it.size,
                    type: it.contentType,
                    icon: ['image/png', 'image/jpeg', 'image/jpg', 'image/gif'].contains(it.contentType) ?
                            "${grailsLinkGenerator.link(controller: 'arquivo', action: 'download', id: it.id, absolute: true)}?${System.currentTimeMillis()}" :
                            "${grailsLinkGenerator.contextPath}/assets/fileinput/document.png"
            ]
        }

        JSON.registerObjectMarshaller(Lancamento) {
            [
                    'data'  : it.dataEmissao.format('dd/MM/yyyy'),
                    'tipo'  : it.eventoFinanceiro instanceof Adiantamento ? "Pagamento Adiantado" : it.tipoLancamento.descricao,
                    'valor' : it.valor,
                    'origem': it.papel ? it.papel.toString() : ''
            ]
        }
    }
}
