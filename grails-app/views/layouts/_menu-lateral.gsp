<li>
    <a href="#"><i class="fa fa-fw fa-table"></i> Cadastros<span class="fa arrow"></span></a>
    <ul class="nav nav-second-level">
        <li><g:link controller="centroCusto" action="index">Centro de Custo</g:link></li>
        <li><g:link controller="atividade" action="index">Atividade</g:link></li>
        <li><g:link controller="linhaAcao" action="index">Linha de Ação</g:link></li>
        <li><g:link controller="financiador" action="index">Financiador</g:link></li>
        <li><g:link controller="funcionario" action="index">Funcionário</g:link></li>
        <li><g:link controller="fornecedor" action="index">Fornecedor</g:link></li>
    </ul>
</li>

<li>
    <a href="#"><i class="fa fa-legal fa-fw"></i> Financeiro<span class="fa arrow"></span></a>
    <ul class="nav nav-second-level">
    <li><g:link controller="orcamento" action="index">Orçamentos</g:link></li>
    <li><g:link controller="despesa">Despesas</g:link></li>
    <li><g:link controller="adiantamento" action="index">Adiantamentos</g:link></li>
    <li><g:link controller="lancamento" action="index">Lançamentos</g:link></li>
    </ul>
</li>

<li>
    <a href="#"><i class="fa fa-line-chart fa-fw"></i> Relatórios<span class="fa arrow"></span></a>
    <ul class="nav nav-second-level">
        <li><g:link controller="relatorioAtividade" action="index">Relatório de Atividade</g:link></li>
        <li><a href="#">Relatório de Movimentação Financeira</a></li>
        <li><a href="#">Relatório de Financiadores</a></li>
    </ul>
</li>

<sec:ifAnyGranted roles="ROLE_SUPORTE">
    <li>
        <a href="#"><i class="fa fa-cogs fa-fw"></i> Sistema<span class="fa arrow"></span></a>
        <ul class="nav nav-second-level">
            <li><g:link controller="console" target="Console">Console</g:link></li>
        </ul>
    </li>
</sec:ifAnyGranted>

<li>
    <a href="#"><i class="fa fa-shield fa-fw"></i> Segurança<span class="fa arrow"></span></a>
    <ul class="nav nav-second-level">
        <li><g:link controller="user" class="submenu-logado" action="meuUsuario">Meu Usuário</g:link></li>
        <sec:ifAnyGranted roles="ROLE_SUPORTE, ROLE_ADMINISTRADOR_SISTEMA">
            <li><g:link controller="user" action="index" class="submenu-logado">Cadastro de Usuários</g:link></li>
            <li><g:link controller="role" class="submenu-logado" action="index">Perfis de Acesso</g:link></li>
        </sec:ifAnyGranted>
    </ul>
</li>