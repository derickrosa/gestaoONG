<div class="row">
    <div class="form-group col-md-6">
        <label for="authority">
            <g:message code="role.authority.label" default="Authority"/>
        </label>
        <g:textField class="form-control"  name="authority" value="${roleInstance?.authority}"/>
    </div>

    <div class="form-group col-md-6">
        <label for="nome">
            <g:message code="role.nome.label" default="Nome"/>
        </label>
        <g:textField class="form-control"  name="nome" value="${roleInstance?.nome}"/>
    </div>
    <div class="form-group col-md-12">
        <label for="descricao">
            <g:message code="role.descricao.label" default="Descrição"/>
        </label>
        <g:textArea class="form-control" rows="4" name="descricao" value="${roleInstance?.descricao}"/>
    </div>
</div>