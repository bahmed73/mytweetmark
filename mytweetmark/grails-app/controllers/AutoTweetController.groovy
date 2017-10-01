import com.google.code.facebookapi.*;

class AutoTweetController {

	static final String MY_TOGGLE = "AutoTweet";

	def myTweetMarkService
	def twitterService
	def facebookConnectService
	def user
	Integer displaySend
	Integer isFaceBookUser
	def autoTweetInstance
	def autoTweetInstanceList
	Integer autoTweet
	def autoTweetCount

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
        autoTweetInstanceList = myTweetMarkService.getAutoTweets(session.userId, session.delete)
        autoTweetCount = myTweetMarkService.getAutoTweetCount(session.userId)
        displaySend = myTweetMarkService.getTweet(session.userId)
        isFaceBookUser = myTweetMarkService.isFaceBookUser(session.userId)
        autoTweet = myTweetMarkService.getAutoTweet(session.userId)
        user = myTweetMarkService.getUser(session.userName)
        
    }

    def create = {
    	if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def autoTweetInstance = new AutoTweet()
        autoTweetInstance.properties = params
        return [autoTweetInstance: autoTweetInstance]
    }

    def save = {
    	if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def autoTweetInstance = new AutoTweet(params)
        if (autoTweetInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'autoTweet.label', default: 'AutoTweet'), autoTweetInstance.id])}"
            redirect(action: "show", id: autoTweetInstance.id)
        }
        else {
            render(view: "create", model: [autoTweetInstance: autoTweetInstance])
        }
    }

    def show = {
    	if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def autoTweetInstance = AutoTweet.get(params.id)
        if (!autoTweetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'autoTweet.label', default: 'AutoTweet'), params.id])}"
            redirect(action: "list")
        }
        else {
            [autoTweetInstance: autoTweetInstance]
        }
    }

    def edit = {
    	if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def autoTweetInstance = AutoTweet.get(params.id)
        if (!autoTweetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'autoTweet.label', default: 'AutoTweet'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [autoTweetInstance: autoTweetInstance]
        }
    }

    def update = {
    	if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def autoTweetInstance = AutoTweet.get(params.id)
        if (autoTweetInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (autoTweetInstance.version > version) {
                    
                    autoTweetInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'autoTweet.label', default: 'AutoTweet')] as Object[], "Another user has updated this AutoTweet while you were editing")
                    render(view: "edit", model: [autoTweetInstance: autoTweetInstance])
                    return
                }
            }
            autoTweetInstance.properties = params
            if (!autoTweetInstance.hasErrors() && autoTweetInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'autoTweet.label', default: 'AutoTweet'), autoTweetInstance.id])}"
                redirect(action: "show", id: autoTweetInstance.id)
            }
            else {
                render(view: "edit", model: [autoTweetInstance: autoTweetInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'autoTweet.label', default: 'AutoTweet'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
    	if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
        def autoTweetInstance = AutoTweet.get(params.id)
        if (autoTweetInstance) {
            try {
                autoTweetInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'autoTweet.label', default: 'AutoTweet'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'autoTweet.label', default: 'AutoTweet'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'autoTweet.label', default: 'AutoTweet'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def deleteAutoTweet = {
		if (session.userName == null) {
    		flash.message = "Please login to do this operation.";
    		redirect(uri:"/")
    		return
    	}
		
		if (myTweetMarkService.isFeatureToggleReadOnly(MY_TOGGLE)) {
			flash.message = "Cannot delete auto tweet at this time.  Please try again later.";
			redirect(action:'myTweetMarks',controller:'myTweetMark')
			return
		} else {
		
			if (params.id != null) {
				def returnVal = myTweetMarkService.deleteAutoTweet(session.userId, Long.valueOf(params.id))
				
				if (returnVal == MyTweetMarkService.SUCCESS) {
					session.delete = true
	          		
					flash.message = "Successfully removed auto tweet.";
				} else {
					flash.message = "Cannot remove auto tweet at this time.  Please try again later.";
				}
			}
			
			redirect(action:'list',controller:'autoTweet')
		}
	}
    
    def saveMyTweet = {
		
		if (session.userName == null) {
    		flash.message = "Please login to do this operation.";
    		redirect(uri:"/")
    	}
		
		def tweetObj = new AutoTweet(params)
		def sessionDesc = session.tweet
		def tweet = tweetObj.tweet
		if (tweet!=null) {
			if (tweet.equals("Oops, can't save same tweet again")) {
				render "Oops, can't save this tweet"
				return
			} else if (tweet.equals("Tweet stored!  Hit refresh on the page to see it")) {
				render "Oops, can't save this tweet"
				return
			} else if (tweet.equals("Oops, can't save this tweet")) {
				render "Oops, can't save this tweet"
				return
			} else if (tweet.equals("Click here to add new tweet")) {
				render "Oops, can't save this tweet"
				return
			} else if (tweet.equals("")) {
				render "Oops, can't save this tweet"
				return
			} else if (sessionDesc!=null) {
				if (sessionDesc.equals(tweet)) {
					render "Oops, can't save same tweet again"
					return
				} 
			} 
		} else {
			render "Oops, can't save this tweet"
			return
		}
		if (myTweetMarkService.createMyTweet(session.userId, tweetObj) == MyTweetMarkService.SUCCESS) {
			session.tweet = tweetObj.tweet
			
			def status = session.tweet
			
			if (myTweetMarkService.getTweet(session.userId) == MyTweetMarkService.ON) {
				if (session.twitter != null) {
					if (status.length() > 140) {
						status = status.substring(0,140)
					}
					try {
						session.twitter.updateStatus(status)
					} catch (Exception e) {
						e.printStackTrace()
						return
					}
					
				} 
			}
			
		} else {
			render "Oops, can't save this tweet"
			return
		}
		
		render "Auto Tweet setup correctly."
	}
}
