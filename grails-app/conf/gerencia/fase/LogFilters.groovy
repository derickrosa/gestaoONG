package gerencia.fase

import org.apache.log4j.MDC

class LogFilters {
    def springSecurityService
    def filters = {
        logUserFilters(controller: '*', action: '*') {
            before = {
                def user=springSecurityService.currentUser
                MDC.put("username", user?.username ?: 'ANON')
                def ip=request.remoteAddr
                MDC.put('ip',ip ?: '')
                log.debug "C: $controllerName A: $actionName P: $params"
            }
            afterView = { e ->
                MDC.remove 'username'
                MDC.remove 'ip'
            }
        }
    }
}
