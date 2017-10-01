import com.google.code.facebookapi.*;

class TweetFinderController {

	static final String MY_TOGGLE = "TweetFinder";

	def myTweetMarkService
	def twitterService
	def facebookConnectService
	def user
	Integer displaySend
	Integer isFaceBookUser
	def tweetFinderInstanceList
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        redirect(action: "list", params: params)
    }

    def list = {
		if (session.userName == null) {
    		flash.message = "Please login to do this operation.";
    		redirect(uri:"/")
    		return
    	}
		tweetFinderInstanceList = myTweetMarkService.getTweetFinders(session.userId)
        isFaceBookUser = myTweetMarkService.isFaceBookUser(session.userId)
        user = myTweetMarkService.getUser(session.userName)
    }

    def create = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def tweetFinderInstance = new TweetFinder()
        tweetFinderInstance.properties = params
        return [tweetFinderInstance: tweetFinderInstance]
    }

    def save = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def tweetFinderInstance = new TweetFinder(params)
        if (tweetFinderInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'tweetFinder.label', default: 'TweetFinder'), tweetFinderInstance.id])}"
            redirect(action: "show", id: tweetFinderInstance.id)
        }
        else {
            render(view: "create", model: [tweetFinderInstance: tweetFinderInstance])
        }
    }

    def show = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def tweetFinderInstance = TweetFinder.get(params.id)
        if (!tweetFinderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tweetFinder.label', default: 'TweetFinder'), params.id])}"
            redirect(action: "list")
        }
        else {
            [tweetFinderInstance: tweetFinderInstance]
        }
    }

    def edit = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def tweetFinderInstance = TweetFinder.get(params.id)
        if (!tweetFinderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tweetFinder.label', default: 'TweetFinder'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [tweetFinderInstance: tweetFinderInstance]
        }
    }

    def update = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def tweetFinderInstance = TweetFinder.get(params.id)
        if (tweetFinderInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tweetFinderInstance.version > version) {
                    
                    tweetFinderInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tweetFinder.label', default: 'TweetFinder')] as Object[], "Another user has updated this TweetFinder while you were editing")
                    render(view: "edit", model: [tweetFinderInstance: tweetFinderInstance])
                    return
                }
            }
            tweetFinderInstance.properties = params
            if (!tweetFinderInstance.hasErrors() && tweetFinderInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tweetFinder.label', default: 'TweetFinder'), tweetFinderInstance.id])}"
                redirect(action: "show", id: tweetFinderInstance.id)
            }
            else {
                render(view: "edit", model: [tweetFinderInstance: tweetFinderInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tweetFinder.label', default: 'TweetFinder'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def tweetFinderInstance = TweetFinder.get(params.id)
        if (tweetFinderInstance) {
            try {
                tweetFinderInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tweetFinder.label', default: 'TweetFinder'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tweetFinder.label', default: 'TweetFinder'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tweetFinder.label', default: 'TweetFinder'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def deleteTweetFinder = {
		if (session.userName == null) {
    		flash.message = "Please login to do this operation.";
    		redirect(uri:"/")
    		return
    	}
		
		if (myTweetMarkService.isFeatureToggleReadOnly(MY_TOGGLE)) {
			flash.message = "Cannot delete tweet finder at this time.  Please try again later.";
			redirect(action:'myTweetMarks',controller:'myTweetMark')
			return
		} else {
		
			if (params.id != null) {
				def returnVal = myTweetMarkService.deleteTweetFinder(session.userId, Long.valueOf(params.id))
				
				if (returnVal == MyTweetMarkService.SUCCESS) {
					
					flash.message = "Successfully removed tweet finder.";
				} else {
					flash.message = "Cannot remove tweet finder at this time.  Please try again later.";
				}
			}
			
			redirect(action:'list',controller:'tweetFinder')
		}
	}
    
    def saveMyTweetFinder = {
		
		if (session.userName == null) {
    		flash.message = "Please login to do this operation.";
    		redirect(uri:"/")
    	}
		
		def tweetObj = new TweetFinder(params)
		def sessionDesc = session.finder
		def tweet = tweetObj.finder
		System.out.println("saveMyTweetFinder, tweet = " + tweet)
		if (tweet!=null) {
			if (tweet.equals("Oops, can't save same finder again")) {
				render "Oops, can't save this finder"
				return
			} else if (tweet.equals("Finder stored!  Hit refresh on the page to see it")) {
				render "Oops, can't save this finder"
				return
			} else if (tweet.length()>50) {
				render "Oops, can't save this finder"
				return
			} else if (!tweet.startsWith("@") && !tweet.startsWith("#")) {
				render "Must start with @ or #"
				return
			} else if (tweet.equals("Must start with @ or #")) {
				render "Oops, can't save this finder"
				return
			} else if (tweet.equals("Oops, can't save this finder")) {
				render "Oops, can't save this finder"
				return
			} else if (tweet.equals("Click here to add new finder")) {
				render "Oops, can't save this finder"
				return
			} else if (tweet.equals("")) {
				render "Oops, can't save this finder"
				return
			} else if (sessionDesc!=null) {
				if (sessionDesc.equals(tweet)) {
					render "Oops, can't save same finder again"
					return
				} 
			} 
		} else {
			render "Oops, can't save this finder"
			return
		}
		if (myTweetMarkService.createTweetFinder(session.userId, tweetObj) == MyTweetMarkService.SUCCESS) {
			session.finder = tweetObj.finder
			System.out.println("successful in storing finder")
		} else {
			render "Oops, can't save this finder"
			return
		}
		
		render "Finder stored!"
	}
}
