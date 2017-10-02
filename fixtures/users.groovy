import com.acception.security.Role
import com.acception.security.User
import com.acception.security.UserRole

/**
 * Created by andersonmarques on 18/08/15.
 */

fixture {
    roleSuporte(Role, authority: "ROLE_SUPORTE", nome: "Suporte", descricao: "Suporte Técnico do sistema (via Acception). Possui controle total do sistema.", nivelAcesso: 0)
    roleAdministrador(Role, authority: "ROLE_ADMINISTRADOR", nome: "Administrador", descricao: "Suporte Técnico do sistema (via Fase). Possui controle total do sistema.", nivelAcesso: 1)
    roleFinanciador(Role, authority: "ROLE_FINANCIADOR", nome: "Financiador", descricao: "Financiador do sistema.", nivelAcesso: 2)
    roleResponsavel(Role, authority: "ROLE_RESPONSAVEL", nome: "Responsável", descricao: "", nivelAcesso: 2)
    roleFuncionario(Role, authority: "ROLE_FUNCIONARIO", nome: "Funcionário", descricao: "Funcionário padrão do sistema.", nivelAcesso: 3)

    userSuporte(User, nome: 'Acception Tecnologia', username: 'suporte.acception', password: '@cceptionn0t3', email:'desenvolvimento@acception.com.br', enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
}

post {
    UserRole.create userSuporte, roleSuporte, true
}