import com.acception.security.Role
import com.acception.security.User
import com.acception.security.UserRole

/**
 * Created by andersonmarques on 18/08/15.
 */

fixture {
    roleSuporte(Role, authority: "ROLE_SUPORTE", nome: "Suporte")
    userSuporte(User, nome: 'Acception Tecnologia', username: 'suporte.acception', password: 'jmml72', initialPassword:"jmml72", email:'acception.tests@gmail.com', enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
}
post {
    UserRole.create userSuporte, roleSuporte, true
}