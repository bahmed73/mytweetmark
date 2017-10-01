class LinkController {

	static final String MY_TOGGLE = "Link";

	def myTweetMarkService
	def twitterService
	def facebookConnectService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        redirect(action: "list", params: params)
    }

    def list = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [linkInstanceList: Link.list(params), linkInstanceTotal: Link.count()]
    }

    def create = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def linkInstance = new Link()
        linkInstance.properties = params
        return [linkInstance: linkInstance]
    }

    def save = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def linkInstance = new Link(params)
        if (linkInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'link.label', default: 'Link'), linkInstance.id])}"
            redirect(action: "show", id: linkInstance.id)
        }
        else {
            render(view: "create", model: [linkInstance: linkInstance])
        }
    }

    def show = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def linkInstance = Link.get(params.id)
        if (!linkInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'link.label', default: 'Link'), params.id])}"
            redirect(action: "list")
        }
        else {
            [linkInstance: linkInstance]
        }
    }

    def edit = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def linkInstance = Link.get(params.id)
        if (!linkInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'link.label', default: 'Link'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [linkInstance: linkInstance]
        }
    }

    def update = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def linkInstance = Link.get(params.id)
        if (linkInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (linkInstance.version > version) {
                    
                    linkInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'link.label', default: 'Link')] as Object[], "Another user has updated this Link while you were editing")
                    render(view: "edit", model: [linkInstance: linkInstance])
                    return
                }
            }
            linkInstance.properties = params
            if (!linkInstance.hasErrors() && linkInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'link.label', default: 'Link'), linkInstance.id])}"
                redirect(action: "show", id: linkInstance.id)
            }
            else {
                render(view: "edit", model: [linkInstance: linkInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'link.label', default: 'Link'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def linkInstance = Link.get(params.id)
        if (linkInstance) {
            try {
                linkInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'link.label', default: 'Link'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'link.label', default: 'Link'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'link.label', default: 'Link'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def redirectLink = {
		def longId = params.id
		System.out.println("inside redirectLink: " + longId)
		if (longId != null) {
			try {
				def redirectLink = myTweetMarkService.getRedirectLink(Long.valueOf(longId))
				if (redirectLink != null && !redirectLink.url.isEmpty()) {
					redirect(url:redirectLink.url)
					return 
				} else {
					flash.message = "Couldn't find the link. Please try again.";
    				redirect(uri:"/")
    				return
				}
			} catch (Exception e) {
				System.out.println("inside redirectLink: Error1")
				flash.message = "Couldn't find the link. Please try again.";
	    		redirect(uri:"/")
	    		return
			}
		} else {
			flash.message = "Couldn't find the link. Please try again.";
    		redirect(uri:"/")
    		return
		}
	}
}
