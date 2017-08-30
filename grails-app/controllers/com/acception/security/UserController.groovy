package com.acception.security

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = false)
class UserController {
    def springSecurityService
    static allowedMethods = [save: "POST", update: "PUT", changePassword: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def userList
        def userCount

        def criteria = {

        }
        userList = User.createCriteria().list(params, criteria)
        userCount = User.createCriteria().count(criteria)
        [userInstanceList: userList, userInstanceCount: userCount]
    }

    def show(User userInstance) {
        respond userInstance
    }

    def changePassword() {
        User user = User.get(params.long('id'))
        String senha = params['senha']
        String confirmarSenha = params['confirmarSenha']

        if(user == null || senha?.isEmpty() || confirmarSenha?.isEmpty()){
            response.status = NOT_ACCEPTABLE.value()
            respond([error: "Parâmetros insuficientes."])
            return
        }
        else if(!senha.equals(confirmarSenha)){
            response.status = NOT_ACCEPTABLE.value()
            respond([error: "Senhas são diferentes."])
            return
        }

        user.password = senha
        user.save()

        response.status = OK.value()
        respond([msg: 'Senha alterada com sucesso'])
    }

    def create() {
        def roleList = []
        User currentUser = springSecurityService.currentUser
        if (currentUser.containsAuthorities('ROLE_ADMINISTRADOR_SISTEMA') || currentUser.containsAuthorities('ROLE_SUPORTE')) {
            roleList = Role.list()
        }
        [userInstance: new User(params), authorityList: roleList, edit: false]
    }

    def meuUsuario() {
        def user = springSecurityService.currentUser
        [userInstance: user]
    }

    def edit(User userInstance) {
        return [userInstance: userInstance, authorityList: Role.list(), edit: true]
    }

    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view: 'edit'
            return
        }
        log.debug("Parametros: ${params}.")

        for (role in Role.list()) {
            if (params["${role.authority}"]) {
                UserRole auth = new UserRole(user: userInstance, role: role)
                auth.save(flush: true)
            } else {
                def existingLink = UserRole.findByUserAndRole(userInstance, role)
                if (existingLink) {
                    existingLink.delete(flush: true)
                }
            }
        }

        userInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: OK] }
        }
    }

    def isSamePassword() {
        def user = User.get(params.long('userID'))
        respond([isSamePassword: springSecurityService.passwordEncoder.isPasswordValid(user.password, params.password.toString(), null)])
    }

    @Transactional
    def delete(User userInstance) {
        log.debug("Removendo usuário.")
        if (userInstance == null) {
            notFound()
            return
        }
        try {
            UserRole.findAllByUser(userInstance).each { ur ->
                ur.delete(flush: true)
            }

            userInstance.delete(flush: true)

        } catch (Exception e) {
            flash.message = "Não foi possível excluir o usuário, pois ele está relacionado a um papel. Primeiro desassioce-o das suas permissões ou o desative ao invés de excluí-lo."
        }
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
