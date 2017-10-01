import com.google.code.facebookapi.*;

class MyTweetMarkController {
    
	static final String MY_TOGGLE = "MyTweetMark";
	
	def myTweetMarkService
	def twitterService
	def facebookConnectService
	
	def beforeInterceptor = {
		
	}
	
	List myCategories
	List searchResults
	String photoUrl
	String firstName
	String lastName
	String userName
	List posts
	List blogs
	String searchTerm
	Long views
	String myHash
	Integer displaySend
	List myHashes
	def myTweetMarkInstanceList 
	def myTweetMarkInstanceTotal
	List categories
	Integer isFaceBookUser
	Integer permission
	List tweetUrls
	List tweetFriends
	def profileRefererInstanceTotal
	def profileRefererMap
	Integer autoTweet
	def viewSummaryInstanceTotal
	def viewSummaryList
	def user
	def pageViewChange
	def pageViewChangePercentage
	def followersChange
	def followersChangePercentage
	def followerSummaryInstanceTotal
	def followerSummaryList
	def emailReport
	def totalFollowers
	def totalFollowing
	def viewSummary
	def unFollowersInstanceTotal
	def unFollowersList
	
	//TODO refactor all user objects in one call, user object to minimize query permission, isFaceBookUser and displaySend
	
	def process = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
		MyTweetMarkService.serviceMethod()
	}
	
    def index = { 
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
    		flash.message = "Please login as administrator to do this operation.";
    		redirect(uri:"/")
    	}
		redirect(action:list,params:params) 
	}

    // the delete, save and update actions only accept POST requests
    def static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
		if (session.userName == null) {
    		flash.message = "Please login to do this operation.";
    		redirect(uri:"/")
    	}
        params.max = Math.min( params.max ? params.max.toInteger() : 5,  100)
        if (params.offset == null) {
        	params.offset = 0
        }
        Integer paramInt = Integer.valueOf(params.offset) 
        myHash = myTweetMarkService.getHashString(session.userId)    
        myTweetMarkInstanceList = myTweetMarkService.getMyTweetMarksWithUserInfo(paramInt, params.max)
        myTweetMarkInstanceTotal = myTweetMarkService.getMyTweetMarkCount()
        displaySend = myTweetMarkService.getTweet(session.userId)
        myHashes = myTweetMarkService.getMyHashes(session.userId)
        userName = session.userName
        isFaceBookUser = myTweetMarkService.isFaceBookUser(session.userId)
        autoTweet = myTweetMarkService.getAutoTweet(session.userId)
    }

    def profile = {
		if (session.userName == null) {
		    flash.message = "Please login to do this operation.";
		    redirect(uri:"/")
		    return
		} else {
			myCategories = myTweetMarkService.getMyCategoriesWithMyTweetMarks(session.userId)
			user = myTweetMarkService.getUser(session.userId)
			if (user != null) {
				session.profile = false
				//posts = myTweetMarkService.getPosts(session.userId)
				//blogs = myTweetMarkService.getBlogs(session.userId)
				views = myTweetMarkService.getViews(user.id)
				myHash = myTweetMarkService.getHashString(user.id)
				displaySend = myTweetMarkService.getTweet(user.id)
				//myHashes = myTweetMarkService.getMyHashes(user.id)
				categories = myTweetMarkService.getCategories()
				isFaceBookUser = myTweetMarkService.isFaceBookUser(user.id)
				permission = myTweetMarkService.getUserPermission(user.id)
				autoTweet = myTweetMarkService.getAutoTweet(user.id)
				return myCategories
			} 
		}
        
    }
    
	def show = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
		    flash.message = "Please login as administrator to do this operation.";
		    redirect(uri:"/")
		}
        def myTweetMarkInstance = MyTweetMark.get( params.id )

        if(!myTweetMarkInstance) {
            flash.message = "MyTweetMark not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ myTweetMarkInstance : myTweetMarkInstance ] }
    }

    def delete = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
		    flash.message = "Please login as administrator to do this operation.";
		    redirect(uri:"/")
		}
        def myTweetMarkInstance = MyTweetMark.get( params.id )
        if(myTweetMarkInstance) {
            myTweetMarkInstance.delete()
            flash.message = "MyTweetMark ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "MyTweetMark not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
		    flash.message = "Please login as administrator to do this operation.";
		    redirect(uri:"/")
		}
        def myTweetMarkInstance = MyTweetMark.get( params.id )

        if(!myTweetMarkInstance) {
            flash.message = "MyTweetMark not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ myTweetMarkInstance : myTweetMarkInstance ]
        }
    }

    def update = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
		    flash.message = "Please login as administrator to do this operation.";
		    redirect(uri:"/")
		}
        def myTweetMarkInstance = MyTweetMark.get( params.id )
        if(myTweetMarkInstance) {
            myTweetMarkInstance.properties = params
            if(!myTweetMarkInstance.hasErrors() && myTweetMarkInstance.save()) {
                flash.message = "MyTweetMark ${params.id} updated"
                redirect(action:show,id:myTweetMarkInstance.id)
            }
            else {
                render(view:'edit',model:[myTweetMarkInstance:myTweetMarkInstance])
            }
        }
        else {
            flash.message = "MyTweetMark not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
		if (session.userName == null) {
		    flash.message = "Please login as administrator to do this operation.";
		    redirect(uri:"/")
		}
        def myTweetMarkInstance = new MyTweetMark()
        myTweetMarkInstance.properties = params
        return ['myTweetMarkInstance':myTweetMarkInstance]
    }

    def save = {
		if (session.userName == null || !myTweetMarkService.isAdmin(session.userName)) {
		    flash.message = "Please login as administrator to do this operation.";
		    redirect(uri:"/")
		}
        def myTweetMarkInstance = new MyTweetMark(params)
        if(!myTweetMarkInstance.hasErrors() && myTweetMarkInstance.save()) {
            flash.message = "MyTweetMark ${myTweetMarkInstance.id} created"
            redirect(action:show,id:myTweetMarkInstance.id)
        }
        else {
            render(view:'create',model:[myTweetMarkInstance:myTweetMarkInstance])
        }
    }
	
	def myTweetMarks = {
		//lets first get all the categories for the user.  for each category, let's fill in mytweetmarks using Expandos.  Let's then return the results to the view
		//the view should use the _results page to display them.  _results should iterate through mycategories.  For each category, use the expandos to pull out tweetmarks
        
		if (!myTweetMarkService.isFeatureToggleOn(MY_TOGGLE)) {
			flash.message = "MyTweetMark not available.  Contact Us and email the details of the error.";
    		redirect(uri:"/")
    		return
		} else if (session.userName != null) {
			myCategories = myTweetMarkService.getMyCategoriesWithMyTweetMarks(session.userId)
			user = myTweetMarkService.getUser(session.userId)
			if (user != null) {
				firstName = user.firstName
				lastName = user.lastName
				userName = user.userName
				session.profile = false
				//posts = myTweetMarkService.getPosts(session.userId)
				blogs = myTweetMarkService.getBlogs(session.userId)
				views = myTweetMarkService.getViews(user.id)
				myHash = myTweetMarkService.getHashString(user.id)
				displaySend = myTweetMarkService.getTweet(user.id)
				myHashes = myTweetMarkService.getMyHashes(user.id)
				categories = myTweetMarkService.getCategories()
				isFaceBookUser = myTweetMarkService.isFaceBookUser(user.id)
				permission = myTweetMarkService.getUserPermission(user.id)
				autoTweet = myTweetMarkService.getAutoTweet(user.id)
				def lastTwo = ViewSummary.findAllByUserId(user.id, [max:2, sort:"createTime", order:"desc"])
				viewSummary = ViewSummary.findAllByUserId(user.id, [max:1, sort:"createTime", order:"desc"])
				
				if (lastTwo != null && lastTwo.size()==2) {
					pageViewChange = lastTwo.get(0).num - lastTwo.get(1).num
					pageViewChangePercentage = pageViewChange/lastTwo.get(0).num
				} 
				return myCategories
			} 
		} 
			
		flash.message = "User not authenticated";
		redirect(uri:"/")
		
	}
	
	def userTweetMarks = {
			
		if (!myTweetMarkService.isFeatureToggleOn(MY_TOGGLE)) {
			flash.message = "MyTweetMark not available.  Contact Us and email the details of the error.";
    		redirect(uri:"/")
    		return
		} else {
		
			user = myTweetMarkService.getUser(params.userName)
			
			if (user == null && session.userName!=null) {
				user = myTweetMarkService.getUser(session.userName)
				myCategories = myTweetMarkService.getMyCategoriesWithMyTweetMarks(session.userName)
			} else {
				myCategories = myTweetMarkService.getMyCategoriesWithMyTweetMarks(params.userName)
			}
			
			if (user == null) {
				flash.message = "Cannot find user: $params.userName";
				redirect(action:'myTweetMarks',controller:'myTweetMark')
				return
			} else {
				firstName = user.firstName
				lastName = user.lastName
				userName = user.userName
				//posts = myTweetMarkService.getPosts(user.id)
				blogs = myTweetMarkService.getBlogs(user.id)
				myTweetMarkService.incrementViews(user.id)
				views = myTweetMarkService.getViews(user.id)
				myHash = myTweetMarkService.getHashString(user.id)
				myHashes = myTweetMarkService.getMyHashes(user.id)
				isFaceBookUser = myTweetMarkService.isFaceBookUser(user.id)
				tweetUrls = myTweetMarkService.getTweetUrls(user.id, 0, 20)
				tweetFriends = myTweetMarkService.getTweetFriends(user.id, 0, 20)
				myTweetMarkService.trackProfileReferer(userName, request.getHeader("REFERER"), user.id)
				profileRefererInstanceTotal = ProfileReferer.countByName(user.userName)
				viewSummary = ViewSummary.findAllByUserId(user.id, [max:1, sort:"createTime", order:"desc"])
				
		        def profileRefererList = ProfileReferer.findAllByName(user.userName)
		        
		        if (profileRefererList != null && !profileRefererList.isEmpty()) {
			        profileRefererMap = new HashMap<String, Integer>()
			        for (int i=0; i<profileRefererList.size(); i++ ) {
			        	def referer
			        	if (profileRefererList.get(i).refererUrl.contains("http://")) {
			        		referer = profileRefererList.get(i).refererUrl.substring(7)
			        	}
			        	
			        	if (referer!=null) {
				        	def index = referer.indexOf('/')
				        	
				        	if (index > 0) {
				        		referer = referer.substring(0, index)
				        	}
				        	
				        	if (profileRefererMap.get(referer)!=null) {
				        		//exists, increment count
				        		def countRef = profileRefererMap.get(referer)
				        		profileRefererMap.remove(referer)
				        		profileRefererMap.put(referer, countRef+1)
				        	} else {
				        		profileRefererMap.put(referer, 1)
				        	}
			        	}
			        }
		        }
				
				viewSummaryInstanceTotal = ViewSummary.countByUserId(user.id)
				
				if (viewSummaryInstanceTotal > 30) {
					viewSummaryInstanceTotal = 30;
				}
		        
				viewSummaryList = ViewSummary.findAllByUserId(user.id, [max:30, sort:"createTime", order:"desc"])
		        
				def lastTwo = ViewSummary.findAllByUserId(user.id, [max:2, sort:"createTime", order:"desc"])
				
				if (lastTwo != null && lastTwo.size()==2) {
					pageViewChange = lastTwo.get(0).num - lastTwo.get(1).num
					pageViewChangePercentage = pageViewChange/lastTwo.get(0).num
				} 
				
				if (myCategories == null) {
					flash.message = "User categories not found.";
					redirect(action:'myTweetMarks',controller:'myTweetMark')
					return 
				} else {
					session.profile = true
					//render(view:"myTweetMarks", model:myCategories)
				}
			}
		}
	}
	
	def analytics = {
//		lets first get all the categories for the user.  for each category, let's fill in mytweetmarks using Expandos.  Let's then return the results to the view
		//the view should use the _results page to display them.  _results should iterate through mycategories.  For each category, use the expandos to pull out tweetmarks
        
		if (!myTweetMarkService.isFeatureToggleOn(MY_TOGGLE)) {
			flash.message = "MyTweetMark not available.  Contact Us and email the details of the error.";
    		redirect(uri:"/")
    		return
		} else if (session.userName != null || params.id != null) {
			
			def loggedIn = false
			
			if (session.userName != null) {
				user = myTweetMarkService.getUser(session.userName)
				loggedIn = true
			} else if (params.id != null){
				user = myTweetMarkService.getUser(params.id)
			}
			
			if (loggedIn) {
				isFaceBookUser = myTweetMarkService.isFaceBookUser(user.id)
				autoTweet = myTweetMarkService.getAutoTweet(user.id)
				emailReport = myTweetMarkService.getEmailReport(user.id)
			}
			
			if (user != null) {
				
				//posts = myTweetMarkService.getPosts(session.userId)
				views = myTweetMarkService.getViews(user.id)
				profileRefererInstanceTotal = ProfileReferer.countByName(user.userName)
		        
		        def profileRefererList = ProfileReferer.findAllByName(user.userName)
		        
		        if (profileRefererList != null && !profileRefererList.isEmpty()) {
			        profileRefererMap = new HashMap<String, Integer>()
			        for (int i=0; i<profileRefererList.size(); i++ ) {
			        	def referer
			        	if (profileRefererList.get(i).refererUrl.contains("http://")) {
			        		referer = profileRefererList.get(i).refererUrl.substring(7)
			        	}
			        	
			        	if (referer != null) {
				        	def index = referer.indexOf('/')
				        	
				        	if (index > 0) {
				        		referer = referer.substring(0, index)
				        	}
				        	
				        	if (profileRefererMap.get(referer)!=null) {
				        		//exists, increment count
				        		def countRef = profileRefererMap.get(referer)
				        		profileRefererMap.remove(referer)
				        		profileRefererMap.put(referer, countRef+1)
				        	} else {
				        		profileRefererMap.put(referer, 1)
				        	}
			        	}
			        }
		        }
				
				viewSummaryInstanceTotal = ViewSummary.countByUserId(user.id)
				
				if (viewSummaryInstanceTotal > 30) {
					viewSummaryInstanceTotal = 30;
				}
		        
				viewSummaryList = ViewSummary.findAllByUserId(user.id, [max:30, sort:"createTime", order:"desc"])
		        
				def lastTwo = ViewSummary.findAllByUserId(user.id, [max:2, sort:"createTime", order:"desc"])
				
				if (lastTwo != null && lastTwo.size()==2) {
					pageViewChange = lastTwo.get(0).num - lastTwo.get(1).num
					pageViewChangePercentage = pageViewChange/lastTwo.get(0).num
					totalFollowers =  lastTwo.get(0).followersCount
					totalFollowing = lastTwo.get(0).friendsCount
						
					
				}
				
				if (viewSummaryList != null && !viewSummaryList.isEmpty()) {
					followerSummaryInstanceTotal = 0;
					followerSummaryList = new java.util.LinkedList()
					for (int i=0; i<viewSummaryList.size(); i++) {
						if (viewSummaryList.get(i).followersCount != null) {
							followerSummaryInstanceTotal++;
							followerSummaryList.add(viewSummaryList.get(i))
						}
					}
					
					if (followerSummaryList != null && followerSummaryList.size()>1) {
						followersChange = followerSummaryList.get(0).followersCount - followerSummaryList.get(1).followersCount
						followersChangePercentage = followersChange/followerSummaryList.get(0).followersCount
					}
				}
			} 
		
		} else {
			
			flash.message = "Cannot obtain analytics.";
			redirect(uri:"/")
			return
		}
	}
	
	def saveMyTweetMark = {
		if (session.userName == null) {
    		flash.message = "Please login to do this operation.";
    		redirect(uri:"/")
    	}
		
		if (myTweetMarkService.isFeatureToggleReadOnly(MY_TOGGLE)) {
			flash.message = "Cannot save my tweetmarks at this time.  Please try again later.";
			redirect(action:'myTweetMarks',controller:'myTweetMark')
			return
		} else {
		
			def tweetMarkObj = new MyTweetMark(params)
			if (myTweetMarkService.createMyTweetMark(session.userId, tweetMarkObj) == MyTweetMarkService.SUCCESS) {
				String categoryName = null;
				Categories category = Categories.findWhere(id:tweetMarkObj.categoryId)
				if (category != null) {
					categoryName = category.name + " business links"
				} else {
					categoryName = "business links"
				}
				
				if (myTweetMarkService.getTweet(session.userId) == MyTweetMarkService.ON) {
					if (myTweetMarkService.isFaceBookUser(session.userId)) {
						try {
							if (facebookConnectService.isLoggedIn(request)) {
								FacebookJsonRestClient client = facebookConnectService.getFacebookClient()
								if (client.users_hasAppPermission(Permission.STATUS_UPDATE)) {
									client.users_setStatus("sharing my " + categoryName + " on http://www.mytweetmark.com/" + session.userName+ "  Come check it out! #" + myTweetMarkService.getHashString(session.userId), false);
								}
							} 
						} catch (Exception e) {
							System.out.println("Exception caught obtaining facebook")
							e.printStackTrace()
						}
					} else if (session.twitter != null) {
						try {
							session.twitter.updateStatus("My #" + categoryName + " on http://www.mytweetmark.com/" + session.userName+ " #" + myTweetMarkService.getHashString(session.userId))
						} catch (Exception e) {
							e.printStackTrace()
						}
			    		
					} 
					
				}
	    		flash.message = "business link created successfully";
			} else {
				flash.message = "business link creation failure";
			}
			
			redirect(action:'myTweetMarks',controller:'myTweetMark')
		}
	}
    
	def deleteMyTweetMark = {
		if (session.userName == null) {
    		flash.message = "Please login to do this operation.";
    		redirect(uri:"/")
    	}
		
		if (myTweetMarkService.isFeatureToggleReadOnly(MY_TOGGLE)) {
			flash.message = "Cannot save my tweetmarks at this time.  Please try again later.";
			redirect(action:'myTweetMarks',controller:'myTweetMark')
			return
		} else {
		
			if (params.categoryId != null && params.id != null) {
				myTweetMarkService.deleteMyTweetMark(session.userId, Integer.valueOf(params.categoryId), Integer.valueOf(params.id))
			}
			
			redirect(action:'myTweetMarks',controller:'myTweetMark')
		}
	}
	
	def searchMyTweetmarks = {
		if (!myTweetMarkService.isFeatureToggleOn(MY_TOGGLE)) {
			flash.message = "MyTweetMark not available.  Contact Us and email the details of the error.";
    		redirect(uri:"/")
    		return
		} else {
		
			def searchParam = params.search
			searchTerm = searchParam
			userName=session.userName
			myHashes = myTweetMarkService.getMyHashes(session.userId)
			displaySend = myTweetMarkService.getTweet(session.userId)
			myHash = myTweetMarkService.getHashString(session.userId)
			isFaceBookUser = myTweetMarkService.isFaceBookUser(session.userId)
			autoTweet = myTweetMarkService.getAutoTweet(session.userId)
			if (searchParam == null || (searchParam.length() == 0)) {
				flash.message = "Please provide a search term."
				redirect(action:'myTweetMarks')
				return
				
			} else {
			
				try {
					searchResults = myTweetMarkService.search(searchParam)
				} catch (Exception e) {
					flash.message = "Error executing search."
					redirect(action:'myTweetMarks')
				}
			}
    	}
	}
	
	def unFollowers = {
		def unFollowers
		
		if (!myTweetMarkService.isFeatureToggleOn(MY_TOGGLE)) {
			flash.message = "MyTweetMark not available.  Contact Us and email the details of the error.";
    		redirect(uri:"/")
    		return
		} else {
			
			myHash = myTweetMarkService.getHashString(session.userId)    
	        displaySend = myTweetMarkService.getTweet(session.userId)
	        userName = session.userName
	        isFaceBookUser = myTweetMarkService.isFaceBookUser(session.userId)
	        autoTweet = myTweetMarkService.getAutoTweet(session.userId)
	        user = myTweetMarkService.getUser(session.userName)
			
			try {
				if (session.twitter != null) {
					if (session.unFollowers == null ) {
						unFollowers = twitterService.getUnfollowers(session.twitter)
						session.unFollowers = unFollowers
					} else {
						unFollowers = session.unFollowers
					}
					if (unFollowers != null && !unFollowers.isEmpty()) {
						System.out.println("The unFollowers = " + unFollowers.size())
						unFollowersList = twitterService.getPaginatedList(session.twitter, params.offset, params.max, unFollowers)
						unFollowersInstanceTotal = unFollowers.size()
					} else {
						unFollowersInstanceTotal = 0
						session.unFollowers = null
					}
				}
			} catch (Exception ee) {
				System.out.println("Error finding followers");
				ee.printStackTrace();
				flash.message = "Error finding followers.";
				redirect(action:'myTweetMarks')
			}
		}
	}
	
	def deleteUnFollower = {
		//param.screenName
		//unfollow the screen name. return to unfollowers page.
		//def unFollowers
		
		if (!myTweetMarkService.isFeatureToggleOn(MY_TOGGLE)) {
			flash.message = "MyTweetMark not available.  Contact Us and email the details of the error.";
    		redirect(uri:"/")
    		return
		} else {
			
			myHash = myTweetMarkService.getHashString(session.userId)    
	        displaySend = myTweetMarkService.getTweet(session.userId)
	        userName = session.userName
	        isFaceBookUser = myTweetMarkService.isFaceBookUser(session.userId)
	        autoTweet = myTweetMarkService.getAutoTweet(session.userId)
	        user = myTweetMarkService.getUser(session.userName)
			
			try {
				if (session.twitter != null) {
					if (params.screenName != null) {
						if (session.unFollowCount == null) {
							session.unFollowCount = 0
						}
						session.unFollowCount++
						
						if (session.unFollowCount > 50) {
							flash.message = "Can't unfollow over 50 this quickly. Try again in an hour. "
							redirect(action:'unFollowers')
							return
						}
						twitterService.unFollow(session.twitter, params.screenName)
						
						if (session.unFollowers != null) {
							def unFollowers = session.unFollowers
							unFollowers.remove(params.screenName)
							session.unFollowers = unFollowers
							
							if (session.unFollowers.size() == 0) {
								session.unFollowers = null
							}
						}
						flash.message = "Unfollowed: " + params.screenName
						redirect(action:'unFollowers')
					}
				} 
				
			} catch (Exception ee) {
				System.out.println("Error unfollowing");
				ee.printStackTrace()
				flash.message = "Error unfollowing"
				redirect(action:'unFollowers')
			}
		}
	}
}
