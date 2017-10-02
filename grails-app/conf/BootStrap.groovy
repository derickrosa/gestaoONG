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
        if (Role.count() == 0) fixtureLoader.load("users")
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
