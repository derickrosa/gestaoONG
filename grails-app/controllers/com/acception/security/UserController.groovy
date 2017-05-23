package com.acception.security

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = false)
@Secured('permitAll')
class UserController {
    def springSecurityService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    //Isso nao é chamado em nenhum lugar!!
    def auth() {
        if (springSecurityService.authentication?.authorities*.authority.contains('ROLE_CA')) {
            redirect(controller: 'consulta')
            return
        }

        /*
        if(SpringSecurityUtils.ifAnyGranted('ROLE_ADMINISTRADORA'))
            session['tipoPrograma'] = springSecurityService.currentUser?.papel?.tiposPrograma[0]
        else {
            def programas = springSecurityService.currentUser?.papel?.programas
            if (programas?.size() == 1) {
                session.programa = programas[0]
            } else if (programas?.size() > 1) {
                chain(controller: "home", action: "index", model: [listaProgramas: programas]);
            }
        }
        */
        redirect(controller: 'home', action: 'painelInicial')
    }

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

    def changePassword(Long id, String password, String confirmPassword, String changePassword) {
        def user = User.get(id)
        if (!password) {
            response.status = 500
            render text: "A senha não pode ser vazia"
            return
        }
        if (password != confirmPassword) {
            response.status = 500
            render text: "Confirmação da senha não confere com a senha informada"
            return
        }
        if (user) {
            user.password = password
            if (changePassword) {
                user.initialPassword = null
            }
            if (!user.save(flush: true)) {
                log.debug "Erro ao salvar usuario #${id}"
                user.errors.allErrors.each { log.debug it }
                response.status = 500
                render text: "Erro ao salvar usuário"
                return

            }

            def r = [success: true, message: 'Senha alterada com sucesso']
            render r as JSON
        } else {
            response.status = 404
            render text: "Usuário #${id} não encontrado"
            return
        }
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

    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view: 'create'
            return
        }


        userInstance.password = params.initialPassword
        userInstance.save flush: true

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

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
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

    def isSamePassword() {
        def user = User.get(params.userID)

        print(springSecurityService.passwordEncoder.isPasswordValid(user.password, params.password, null))

        render([isSamePassword: springSecurityService.passwordEncoder.isPasswordValid(user.password, params.password, null)] as JSON)
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
