<html>
<head>
    <title><g:message code="springSecurity.login.title"/></title>
    <link href="${assetPath(src: 'bootstrap/css/bootstrap.css')}" rel="stylesheet"/>
    <link href="${assetPath(src: 'login.css')}" rel="stylesheet"/>
    <link href="${assetPath(src: 'magic.css')}" rel="stylesheet"/>
</head>

<!-- BEGIN BODY -->
<body>

<!-- PAGE CONTENT -->
<div class="container">
    <div class="text-center">
        <img src="${assetPath(src: 'logo-fase.png')}" alt=" Logo"/>
    </div>

    <div class="tab-content">
        <div id="login" class="tab-pane active">



            <form action="${postUrl}" class="form-signin" method='POST' id='loginForm' autocomplete='off'>
                <p class="text-muted text-center btn-block btn btn-primary btn-rect">
                    Entre com usuário e senha
                </p>

                <input type='text' class='form-control' name='j_username' id='username' placeholder="Usuário"/>
                <input type='password' class='form-control' name='j_password' id='password' placeholder="Senha"/>

            %{--    <p id="remember_me_holder">
                    <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me'
                           <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                    <label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
                </p>--}%

                <button class="btn text-muted text-center btn-danger" type="submit">Entrar</button>
            </form>
        </div>

    <g:if test='${flash.message}'>
        <p class="text-muted text-center ">${flash.message}</div>
    </g:if>
      %{--  <div id="forgot" class="tab-pane">
            <form action="${postUrl}" class="form-signin">
                <p class="text-muted text-center btn-block btn btn-primary btn-rect">Entre com um e-mail válido</p>
                <input type="email" required="required" placeholder="Your E-mail" class="form-control"/>
                <br/>
                <button class="btn text-muted text-center btn-success" type="submit">Recuperar Senha</button>
            </form>
        </div>--}%
    </div>

    <div class="text-center">
        <ul class="list-inline">
            <li><a class="text-muted" href="#login" data-toggle="tab">Login</a></li>
            <li><a class="text-muted" href="#forgot" data-toggle="tab">Esqueci a senha</a></li>
        </ul>
    </div>

</div>

<!--END PAGE CONTENT -->

<!-- PAGE LEVEL SCRIPTS -->
<script src="${assetPath(src: 'plugins/jquery-2.0.3.min.js')}"></script>
<script src="${assetPath(src: 'plugins/bootstrap/bootstrap.js')}"></script>
<script src="${assetPath(src: 'login.js')}"></script>

<!--END PAGE LEVEL SCRIPTS -->
<script type='text/javascript'>
    (function () {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
</script>
</body>
</html>
