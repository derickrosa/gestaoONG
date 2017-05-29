<%@ page import="com.acception.security.User" %>

    <div class="panel-body">
        <div id="wizard" >
            <h2> Dados Básicos </h2>
            <section>

                    <div class="form-group">
                        <label>Nome</label>
                        <g:textField class="form-control"  name="nome" value="${userInstance?.nome}" required="required"/>
                        <p class="help-block">Nome do usuário (primeiro e último nome).</p>
                    </div>

                    <div class="form-group">
                        <label>Login</label>
                        <g:textField class="form-control"  name="username" value="${userInstance?.username}"/>
                        <p class="help-block">Nome de usuário utilizado para acessar o sistema (sem espaços).</p>
                    </div>
                    <div class="form-group">
                        <label>Senha Inicial</label>
                        <g:textField class="form-control"  name="initialPassword" value="${userInstance?.initialPassword}"/>
                        <p class="help-block">A senha inicial do usuário que deverá ser alterada no primeiro acesso..</p>
                    </div>
                    <div class="form-group">
                        <label>E-mail</label>
                        <g:textField class="form-control"  name="email" value="${userInstance?.email}"/>
                        <p class="help-block">E-mail para recuperação de senha.</p>
                    </div>



            </section>

            <h2> Permissões </h2>
            <section>
                <div class="form-group">
                        <g:each var="auth" in="${authorityList}">
                            <div>
                                <g:checkBox name="${auth?.authority}"
                                            value="${edit == false ? false : userInstance?.authorities?.contains(auth)}"/>
                               ${auth?.nome}
                            </div>
                        </g:each>
                    <p class="help-block">Selecionar permissões do usuário.</p>
                    </div>

            </section>
        </div>

    </div>


