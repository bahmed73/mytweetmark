class ViewSummaryController {

	def myTweetMarkService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    		return
    	}
        redirect(action: "list", params: params)
    }

    def list = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    		return
    	}
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [viewSummaryInstanceList: ViewSummary.list(params), viewSummaryInstanceTotal: ViewSummary.count()]
    }

    def create = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    		return
    	}
        def viewSummaryInstance = new ViewSummary()
        viewSummaryInstance.properties = params
        return [viewSummaryInstance: viewSummaryInstance]
    }

    def save = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    		return
    	}
        def viewSummaryInstance = new ViewSummary(params)
        if (viewSummaryInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'viewSummary.label', default: 'ViewSummary'), viewSummaryInstance.id])}"
            redirect(action: "show", id: viewSummaryInstance.id)
        }
        else {
            render(view: "create", model: [viewSummaryInstance: viewSummaryInstance])
        }
    }

    def show = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    		return
    	}
        def viewSummaryInstance = ViewSummary.get(params.id)
        if (!viewSummaryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'viewSummary.label', default: 'ViewSummary'), params.id])}"
            redirect(action: "list")
        }
        else {
            [viewSummaryInstance: viewSummaryInstance]
        }
    }

    def edit = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    		return
    	}
        def viewSummaryInstance = ViewSummary.get(params.id)
        if (!viewSummaryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'viewSummary.label', default: 'ViewSummary'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [viewSummaryInstance: viewSummaryInstance]
        }
    }

    def update = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    		return
    	}
        def viewSummaryInstance = ViewSummary.get(params.id)
        if (viewSummaryInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (viewSummaryInstance.version > version) {
                    
                    viewSummaryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'viewSummary.label', default: 'ViewSummary')] as Object[], "Another user has updated this ViewSummary while you were editing")
                    render(view: "edit", model: [viewSummaryInstance: viewSummaryInstance])
                    return
                }
            }
            viewSummaryInstance.properties = params
            if (!viewSummaryInstance.hasErrors() && viewSummaryInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'viewSummary.label', default: 'ViewSummary'), viewSummaryInstance.id])}"
                redirect(action: "show", id: viewSummaryInstance.id)
            }
            else {
                render(view: "edit", model: [viewSummaryInstance: viewSummaryInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'viewSummary.label', default: 'ViewSummary'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    		return
    	}
        def viewSummaryInstance = ViewSummary.get(params.id)
        if (viewSummaryInstance) {
            try {
                viewSummaryInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'viewSummary.label', default: 'ViewSummary'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'viewSummary.label', default: 'ViewSummary'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'viewSummary.label', default: 'ViewSummary'), params.id])}"
            redirect(action: "list")
        }
    }
}
