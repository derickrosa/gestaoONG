package com.acception.fase

class ModalTagLib {
    static namespace = "modal"

    /**
     * Criar um modal do tipo fade onde um botão o ativa
     *
     * @emptyTag
     *
     * @attr id REQUIRED o id do modal
     * @attr buttonTitle o título do botão
     * @attr buttonClass a classe do botão; defaults 'primary'
     * @attr buttonIconClass a classe do ícone dentro do botão
     * @attr modalTitle REQUIRED o título do modal
     * @attr closeButton cria o botão X para fechar o modal caso verdadeito; defaults true
     */
    Closure criarUsandoBotaoAtivacao = { attrs, body ->
        String id = attrs.get('id')
        String buttonTitle = attrs.remove('buttonTitle') ?: ""
        String buttonClass = attrs.remove('buttonClass') ?: "primary"
        String buttonIconClass = attrs.remove('buttonIconClass') ?: ""

        String insideButtonHtml = buttonTitle
        if (buttonIconClass.length() > 0) {
            if (!buttonIconClass.contains("glyphicon-")) buttonClass = "glyphicon-" + buttonClass
            insideButtonHtml = "<span class=\"glyphicon ${buttonIconClass}\"></span> ${buttonTitle}"
        }

        out << "<button type=\"button\" class=\"btn btn-${buttonClass}\" data-toggle=\"modal\" data-target=\"#${id}\">"
        out << "    ${insideButtonHtml}"
        out << "</button>"

        out << criar(attrs, body)
    }

    /**
     * Criar um modal do tipo fade contendo algo no corpo.
     *
     * @emptyTag
     *
     * @attr id REQUIRED o id do modal
     * @attr modalTitle REQUIRED o título do modal
     * @attr closeButton cria o botão (X) para fechar o modal caso verdadeito; defaults true
     */
    Closure criar = { attrs, body ->
        String id = attrs.remove('id')
        String modalTitle = attrs.remove('modalTitle') ?: "Título Modal"
        boolean closeButton = attrs.containsKey('closeButton') ?: true

        out << "<div class=\"modal fade\" id=\"${id}\" tabindex=\"-1\" role=\"dialog\">"
        out << "    <div class=\"modal-dialog\" role=\"document\" style=\"z-index: 6000\">"
        out << "        <div class=\"modal-content\">"
        out << "            <div class=\"modal-header\">"
        if (closeButton) out << "                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>"
        out << "                <h4 class=\"modal-title\">${modalTitle}</h4>"
        out << "            </div>"

        out << "            <div class=\"modal-body\">"
        out << "                ${body()}"
        out << "            </div>"
        out << "        </div>"
        out << "    </div>"
        out << "</div>"
    }
}

