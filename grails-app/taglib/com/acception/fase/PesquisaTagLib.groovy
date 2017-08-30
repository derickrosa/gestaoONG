package com.acception.fase

class PesquisaTagLib {
    static namespace = "pesquisa"

    /**
     * Cria um painel padrão para as partes de pesquisa.
     *
     * @emptyTag
     *
     * @attr controller o controller que será chamado; defaults controller da view
     * @attr action a action que deverá ser chamada; defaults 'index'
     */
    Closure painel = { attr, body ->
        Map formParams = [
            controller: attr.remove('controller') ?: controllerName,
            action    : attr.remove('action') ?: 'index'
        ]

        out << "<script type=\"application/javascript\">"
        out << "    function limparPesquisa() {"
        out << "        var form = event.srcElement.closest(\"form\");"
        out << "        if (form) {form.reset();\$(form).find(\"input\").val(\"\");form.submit();}"
        out << "    }"
        out << "</script>"

        String insideForm =
                "   <div class=\"row\">" +
                "       ${body()}" +
                "   </div>" +
                "   <div class=\"text-right\">\n" +
                "        <button class=\"btn btn-info\" type=\"submit\">\n" +
                "            <i class=\"glyphicon glyphicon-search\"></i>\n" +
                "            Procurar\n" +
                "        </button>\n" +
                "        <button class=\"btn btn-default\" type=\"button\" onclick=\"limparPesquisa()\">\n" +
                "            <i class=\"glyphicon glyphicon-erase\"></i>\n" +
                "            Limpar\n" +
                "        </button>\n" +
                "    </div>"

        out << form(formParams, insideForm)
        out << "<hr/>"
    }
}
