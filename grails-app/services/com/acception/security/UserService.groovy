package com.acception.security

import grails.transaction.Transactional

@Transactional
class UserService {

    User save(User user, List roles) {
        if (!user.save(flush: true)) throw new RuntimeException("Erro de regra de negócio em User.")

        List<Role> roleList = roles.collect { Role.get(it as Long) }

        if (roleList.size() > 0) {
            UserRole.findAllByUser(user).each { it.delete(flush: true) }

            roleList.each { role ->
                UserRole userRole = new UserRole(user, role)
                userRole.save()
            }
        }

        user
    }

    void delete(User user) {
        UserRole.findAllByUser(user).each { ur ->
            ur.delete(flush: true)
        }

        user.delete(flush: true)
    }
}
