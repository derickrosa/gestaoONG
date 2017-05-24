package com.acception.cadastro

import com.acception.security.User
import grails.converters.JSON

class HomeController {
    def springSecurityService

    def index() {
        redirect(action: 'painelInicial')
    }

    def painelInicial(){
        render(view: 'painelInicial')
    }

    def passwordChangeAjax() {
        User user = springSecurityService.currentUser
        def mustChange = false
        if (!user.containsAuthorities('ROLE_SUPORTE')) {
           if(!user.initialPassword){
            if (springSecurityService.passwordEncoder.isPasswordValid(user.password, user.initialPassword, null)) {
                mustChange = true
            }
           }
        } else {
            mustChange = false
        }
        def r = [mustChange: mustChange]
        log.debug(r)
        render r as JSON
    }
}
