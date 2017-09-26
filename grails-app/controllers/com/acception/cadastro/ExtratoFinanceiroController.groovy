package com.acception.cadastro

import com.acception.cadastro.enums.StatusLancamento
import com.acception.util.Util

class ExtratoFinanceiroController {

    def exportService

    def index() {
        params?.remove('max')

        Map<String, String> pesquisa = params.pesquisa ?: params.subMap(['centroCusto.id', 'dataInicio', 'dataFinal', 'status'])
        pesquisa = Util.trimMap(pesquisa)

        Closure criteria = {
            if (pesquisa.containsKey('centroCusto.id')) {
                centroCusto {
                    idEq(pesquisa['centroCusto.id'] as Long)
                }
            }
            if (pesquisa.containsKey('dataInicio')) {
                Date dataInicio = Date.parse('dd/MM/yyyy', pesquisa.dataInicio).clearTime()
                ge('dataEmissao', dataInicio)
            }
            if (pesquisa.containsKey('dataFinal')) {
                Date dataFinal = Date.parse('dd/MM/yyyy', pesquisa.dataFinal).clearTime() + 1
                le('dataEmissao', dataFinal)
            }
            if (pesquisa.containsKey('status')) eq('statusLancamento', StatusLancamento.valueOf(pesquisa.status))
        }

        if (params?.exportFormat && params.exportFormat != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Extrato Financeiro.${params.extension}")

            def lancamentoList = Lancamento.createCriteria().list(params, criteria)

            List fields = ['dataEmissao', 'tipoLancamento.descricao', 'valor', 'papel']
            Map labels = ['dataEmissao': 'Data', 'tipoLancamento.descricao': 'Tipo', 'valor': 'Valor (R$)', 'papel': 'Origem']
            Map parameters = ["column.widths": [0.3, 0.2, 0.2, 0.5]]

            exportService.export(params.exportFormat, response.outputStream, lancamentoList, fields, labels, [:], parameters)
            return
        }

        params.max = Math.min(params.max ?: 10, 100)
        respond([lancamentoList : Lancamento.createCriteria().list(params, criteria),
                 lancamentoCount: Lancamento.createCriteria().count(criteria),
                 pesquisa       : pesquisa])
    }
}
