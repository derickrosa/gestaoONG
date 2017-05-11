class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'home',view: 'painelInicial')
        "500"(view:'/error')
	}
}
