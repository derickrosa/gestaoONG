package com.acception.cadastro

class HomeController {

    def index() {
        redirect(action: 'painelInicial')
    }

    def painelInicial(){
        render(view: 'painelInicial')
    }
}
