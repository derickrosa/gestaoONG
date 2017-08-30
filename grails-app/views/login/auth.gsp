<html>
<head>
    <meta name="layout" content="layout-publico"/>
    <title>Entrar na FASE</title>
</head>

<body>
    <div class="col-md-4 col-md-offset-4">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Gestão Fundo Dema</h3>
            </div>

            <div class="panel-body">
                <div class="thumbnail">
                    <img src="${assetPath(src: 'fase/logo.png')}"/>
                </div>
                <g:if test="${flash?.message}">
                    <div class="alert alert-danger">${flash.message}</div>
                </g:if>

                <form action="${postUrl}" class="form-signin" method='POST' id='loginForm' autocomplete='off'>
                    <div class="form-group input-group">
                        <span class="input-group-addon"><i class="fa fa-user fa-fw"></i></span>
                        <input class="form-control" type="text" placeholder="Nome do Usuário" name="j_username" id="username" autofocus>
                    </div>

                    <div class="form-group input-group">
                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                        <input class="form-control" placeholder="Senha" name="j_password" id="password" type="password">
                    </div>

                    <div class="checkbox">
                        <label>
                            <input name="${rememberMeParameter}" id="remember_me" type="checkbox" ${hasCookie ? 'checked' : ''}>Permanecer conectado
                        </label>
                    </div>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">
                        <i class="fa fa-sign-in" aria-hidden="true"></i> Entrar
                    </button>
                </form>

            </div>

            <div class="panel-footer">
                <g:link controller="register" action="forgotPassword">Esqueceu sua senha?</g:link>
            </div>
        </div>
    </div>
</body>
</html>
