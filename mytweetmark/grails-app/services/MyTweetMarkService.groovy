import com.danga.MemCached.*
import ij.ImagePlus;
import twitter4j.*;
import twitter4j.http.*;

class MyTweetMarkService {

	static MemCachedClient mcc = null 
	static SockIOPool pool = null
	
	boolean transactional = true
    static final Integer MYCATEGORY_LIMIT = 5
    static final Integer MYTWEETMARK_LIMIT = 5
    
    static final Integer DISABLE = 0
    static final Integer ACTIVE = 1
    static final Integer DELETE = 2
    
    static final Integer FAILURE = 0
    static final Integer SUCCESS = 1
    
    static final Integer DEFAULT_MARKETING = 0
    static final Integer DEFAULT_COUNTRY = 1 //US
    static final String DEFAULT_IP = "" //nothing
   
    static com.maxmind.geoip.LookupService locationService = null
	static com.maxmind.geoip.Location location = null
	
	
	//using USERS_NAME for sign on.  it would be useful for high retention users
    static final String PREFIX_USERS_NAME = "USERS_NAME_"
    
	static final String PREFIX_MYCATEGORY = "MYCATEGORY_"
	static final String PREFIX_MYTWEETMARK = "MYTWEETMARK_"
	
	static final Integer ON = 1;
	static final Integer OFF = 0;
	static final Integer READ_ONLY = 2;
	
	
	def searchableService
	def imagingService
	//def twitterService
	
	static final String POST_TYPE = "Post"
	
	static final String FILE_STORAGE_PREFIX = "/usr/share/apache-tomcat-6.0.20/webapps/ROOT/images/USERPIC_"
	//static final String FILE_STORAGE_PREFIX = "C:\\Users\\home\\mytweetmark\\app\\web-app\\images\\USERPIC_"
	
	static final String HOME_REFERER = "http://www.mytweetmark.com/myTweetMark/myTweetMarks"
	static final String SEARCH_REFERER = "http://www.mytweetmark.com/myTweetMark/searchMyTweetmarks"
	static final String POST_REFERER = "http://www.mytweetmark.com/post/list"
	static final String HOME_REFERER_2 = "http://mytweetmark.com/myTweetMark/myTweetMarks"
	static final String SEARCH_REFERER_2 = "http://mytweetmark.com/myTweetMark/searchMyTweetmarks"
	static final String POST_REFERER_2 = "http://mytweetmark.com/post/list"	
	
	def FACEBOOK_API_KEY = "159bc1493d306c99cc51f4b3bf08eacb"
	def FACEBOOK_SECRET = "fb83d93a8e907f6e60185e5353f4d3ae"
	
	//String[] spamKeywords = {"\<script\>", "\</script\>"}
	
	
    /**
     * Administrator functions 
     */
     
    def isAdmin(String userName) {
    	
    	if (userName.equals("bilal")) {
    		return true
    	} else {
    		def adminAccess = AdminAccess.findWhere(name:userName,status:ACTIVE)
    		
    		if (adminAccess != null) {
    			return true
    		}
    	}
    	
    	return false
    }
     
    /**
     * The following methods are for dealing with create/delete mycategory and mytweetmark.  Update category method is for phase II
     */
    
     def createMyCategory(Long userId, MyCategory categoryObj) {
     	//assuming categoryId is provided
     	categoryObj.status 		= ACTIVE
     	categoryObj.userId 		= userId
     	
     	categoryObj.createTime  = new Date()
     	categoryObj.updateTime  = new Date()
     	
     	categoryObj.numMyTweets 	= 0
     	
     	if(!categoryObj.hasErrors() && categoryObj.save()) {
     		 incrementUserCategoryCount(categoryObj.userId)
             return SUCCESS
     	} else {
             return FAILURE
         }
     }
     
    //creates new category for the user and returns a mycategory id
    def createMyCategory(Long userId, Integer categoryId) {
    	
    	//first check how many categories currently the user has.  if 5, then no more categories.
    	
    	Integer numCategories = getNumUserCategories(userId)

    	if (numCategories >= 5) {
    		//TODO really should be throwing the right exceptions rather generic error
    		return FAILURE
    	}
    	def myCategory = new MyCategory(userId:userId, categoryId:categoryId, status:ACTIVE, createTime:new Date(), updateTime:new Date())
    	
    	if (myCategory.save()) {
    		//increment user category count
    		incrementUserCategoryCount(myCategory.userId)
    		return SUCCESS
    	} else {
    		return FAILURE
    	}
    }
    
    //deletes user category (status=delete) and all the mytweetmarks within (status=delete)
    def deleteMyCategory(Long userId, int categoryId) {
    	Integer returnVal = FAILURE
    	
    	def categoryObj = getMyCategory(userId, categoryId)
    	
    	if (categoryObj != null) {
    		categoryObj.status = DELETE
    		if  (!categoryObj.hasErrors() && categoryObj.save()) {
    			returnVal = SUCCESS
    		} else {
    			returnVal = FAILURE
    		}
    		
        	//make sure to delete all the myTweetMarks within myCategory
    		if (returnVal == SUCCESS) {
	    		List myTweetMarks = getMyTweetMarksByCategory(userId, categoryId)
	    		
	    		if (myTweetMarks != null && !myTweetMarks.isEmpty())
	    		for (int i=0; i<myTweetMarks.size(); i++) {
	    			deleteMyTweetMark(myTweetMarks.get(i))
	    		}
    		}
        	
        	//also decrement the total category count for the user
        	decrementUserCategoryCount(userId)
    	}
    	return returnVal
    }
    
    //get myCategory by Id
    def getMyCategory(Long userId, Integer categoryId) {
    	//TODO checking status
    	//return MyCategory.findWhere(userId:userId, categoryId:categoryId)
    	return MyCategory.findWhere(userId:userId, categoryId:categoryId, status:ACTIVE)
    }
    
    //get user categories
    def getMyCategories(Long userId) {
    	//return MyCategory.findAllWhere(userId:userId, status:ACTIVE)
    	return MyCategory.findAllByUserIdAndStatus(userId, ACTIVE, [sort:"createTime",order:"desc"])
    }
    
    def getNumCategoryTweets(Long userId, Integer categoryId) {
    	def myCategory = getMyCategory(userId, categoryId)
    	
    	if (myCategory != null) {
    		return myCategory.numMyTweets
    	} 
    }
    
    def incrementNumCategoryTweets(Long userId, Integer categoryId) {
    	def myCategory = getMyCategory(userId, categoryId)
    	
    	if (myCategory != null) {
    		myCategory.numMyTweets++
    		if  (!myCategory.hasErrors() && myCategory.save()) {
    			return SUCCESS
    		} else {
    			return FAILURE
    		}
    	}
    	
    	return FAILURE
    }
    
    def decrementNumCategoryTweets(Long userId, Integer categoryId) {
    	def myCategory = getMyCategory(userId, categoryId)
    	
    	if (myCategory != null) {
    		myCategory.numMyTweets--
    		if  (!myCategory.hasErrors() && myCategory.save()) {
    			return SUCCESS
    		} else {
    			return FAILURE
    		}
    	}
    	
    	return FAILURE
    }

    //get user categories, also fill in mytweetmarks using expandos or mop
    def getMyCategoriesWithMyTweetMarks(Long userId) {
		log.info("inside getMyCategoriesWithMyTweetMarks")
    	List returnCategoryWithMyTweetMarks = new ArrayList()
    	List categories = getMyCategories(userId)
    	
    	if (categories != null && !categories.isEmpty()) {
    		for (int i = 0; i < categories.size(); i++) {
    			//get all the mytweetmarks for the category
    			
    			List myTweetMarks = getMyTweetMarksByCategory(userId, categories.get(i).categoryId)
    			
    			if (getCategory(categories.get(i).categoryId)!=null && getCategory(categories.get(i).categoryId).name!=null) {
	    			def expandoCategory = new Expando()
	    			expandoCategory.name = getCategory(categories.get(i).categoryId).name
	    			expandoCategory.categoryId = categories.get(i).categoryId
	    			expandoCategory.tweets = myTweetMarks
	    			returnCategoryWithMyTweetMarks.add(expandoCategory)
    			}
    		}
    	}
    	
    	return returnCategoryWithMyTweetMarks
    }
    
    //TODO need to implement for data to be displayed for user
    def getMyCategoriesWithMyTweetMarks(String userName) {
    	println "inside getMyCategoriesWithMyTweetMarks : $userName"
    	def user
    	try {
    		user = memcachedGet(PREFIX_USERS_NAME+userName)
    	} catch (Exception e) {
    		log.error("Error accessing memcached: key " + PREFIX_USERS_NAME+userName)
    	}
    	
     	if (user == null) {
    		
    		log.info("User not found in cache, get it from db : " + userName)
    		println "User not found in cache, get it from db : $userName"
    		user = Users.findByUserName(userName)
    		
    		if (user == null) {
    			log.info("user doesn't exist in db. " + userName) 
    			println "user doesn't exist in db. $userName"
    			return null
    		} else {
    			log.info("let's put the user in cache : " + userName)
    			println "let's put the user in cache : $userName" 
    			try {
    				memcachedSet(PREFIX_USERS_NAME+userName, user)
    			} catch (Exception e) {
    				log.error("Error setting memcached: key " + PREFIX_USERS_NAME+userName)
    				println "Error setting memcached: key $PREFIX_USERS_NAME$userName"
    			}
    		}
    	} else {
    		log.info("User found in cache : " + userName)
    		println "User found in cache : $userName" 
    	}
    	return getMyCategoriesWithMyTweetMarks(user.id)
    }
    
    def createMyTweetMark(Long userId, MyTweetMark myTweetMark) {
       	if (checkForSpam(myTweetMark.description)) {
       		return FAILURE
       	}

     	//assuming categoryId is provided
     	myTweetMark.status 		= ACTIVE
     	myTweetMark.userId		= userId
     	myTweetMark.createTime  = new Date()
     	myTweetMark.updateTime  = new Date()
     	
     	if(!myTweetMark.hasErrors() && myTweetMark.save()) {
     		incrementNumCategoryTweets(myTweetMark.userId, myTweetMark.categoryId)
             return SUCCESS
     	} else {
             return FAILURE
         }
    }
    
    //creates new mytweetmark for the user.  Need a userid, category and a URL.  Should return a mytweetmark ID.  later we can add description
    def createMyTweetMark(MyTweetMark myTweetMark) {
    	//first check how many mytweetmarks currently the user has, for the mycategory.  if 5, then no more mytweetmarks.
    	
    	Integer numCategoryTweets = getNumCategoryTweets(myTweetMark.userId, myTweetMark.categoryId)
    	
    	if (numCategoryTweets >= 5) {
    		//TODO really should be throwing the right exceptions rather generic error
    		return FAILURE
    	}

    	def myTweetMarkObj = new MyTweetMark(userId:myTweetMark.userId, categoryId:myTweetMark.categoryId, url:myTweetMark.url, status:ACTIVE, createTime:new Date(), updateTime:new Date())
    	
    	if (myTweetMarkObj.save()) {
    		//increment tweetmark count in mycategory
    		incrementNumCategoryTweets(myTweetMark.userId, myTweetMark.categoryId)
    		return myTweetMarkObj.id
    	} else {
    		return FAILURE
    	}
    }
    
    //takes the mytweetmark object and extract userid, mytweetmark id to delete (status) the object.
    def deleteMyTweetMark(Long userId, Integer categoryId, Integer id) {
    	def myTweetMarkObj = getMyTweetMark(id)
    	
    	if (myTweetMarkObj != null) {
    		myTweetMarkObj.status = DELETE
    		if  (!myTweetMarkObj.hasErrors() && myTweetMarkObj.save()) {
    			//decrement tweetmark count in mycategory
    			decrementNumCategoryTweets(userId, categoryId)
    			return SUCCESS
    		} else {
    			return FAILURE
    		}
    	}
    	
    	return FAILURE
    }

    //takes the mytweetmark object and extract userid, mytweetmark id to delete (status) the object.
    def deleteMyTweetMark(MyTweetMark myTweetMark) {
    	def myTweetMarkObj = getMyTweetMark(myTweetMark.id)
    	
    	if (myTweetMarkObj != null) {
    		myTweetMarkObj.status = DELETE
    		if  (!myTweetMarkObj.hasErrors() && myTweetMarkObj.save()) {
    			//decrement tweetmark count in mycategory
    			decrementNumCategoryTweets(myTweetMark.userId, myTweetMark.categoryId)
    			return SUCCESS
    		} else {
    			return FAILURE
    		}
    	}
    	
    	return FAILURE
    }
    
    //takes the mytweetmark object and update the object.  used by phase II implementation when we add description for mytweetmark
    def updateMyTweetMark(MyTweetMark myTweetMark) {
    	if(myTweetMark.save()) {
            return SUCCESS
        } else {
            return FAILURE
        }
    }
    
    //get user mytweetmarks.  returns List
    def getMyTweetMarks(Long userId) {
    	//TODO checking active status
    	//return MyTweetMark.findAllByUserId(userId, [order:"asc"])
    	return MyTweetMark.findAllWhere(userId:userId, status:ACTIVE)
    }
    
    //get a mytweetmark object
    def getMyTweetMark(Long id) {
    	//TODO checking active
    	//return MyTweetMark.get(id)
    	return MyTweetMark.findWhere(id:id, status:ACTIVE)
    }
    
    //get user mytweetmarks, via category.  returns List
    def getMyTweetMarksByCategory(Long userId, Integer categoryId) {
    	//TODO checking for status
    	//return MyTweetMark.findAllWhere(userId:userId, categoryId:categoryId)
    	return MyTweetMark.findAllWhere(userId:userId, categoryId:categoryId, status:ACTIVE)
    }
    
    def getMyTweetMarksWithUserInfo(int offset, int max) {
 	   log.info("inside getMyTweetMarksWithUserInfo")
 	   
    		List returnMyTweetmarkWithUserInfo = new ArrayList()
    		//List posts = Post.list(max:50, order:"desc")
    		List myTweetMarks = MyTweetMark.findAllByStatus(ACTIVE, [max:max, offset:offset, sort:"createTime", order:"desc"] )

    		if (myTweetMarks != null && !myTweetMarks.isEmpty()) {
    		for (int i = 0; i < myTweetMarks.size(); i++) {
    			
    			def user = getUser(myTweetMarks.get(i).userId)
    			
    			def expandoMyTweetMark = new Expando()
    			expandoMyTweetMark.myTweetMark = myTweetMarks.get(i)
    			expandoMyTweetMark.user = user
    			returnMyTweetmarkWithUserInfo.add(expandoMyTweetMark)
    		}
    	}
    	
    	return returnMyTweetmarkWithUserInfo
    }
    
    def getMyTweetMarkCount() {
 	   return MyTweetMark.countByStatus(ACTIVE)

    }
    
    /**
     * User centric methods
     */
    
     //method used by login.  look up the user in the cache, if not there, read from db and put in cache.  also make sure password matches
    def verifyUser(String userName, String password) {
    	def user
    	try {
    		def key = PREFIX_USERS_NAME+userName
    		println "search key: $key"
    		user = memcachedGet(PREFIX_USERS_NAME+userName)
    	} catch (Exception e) {
    		log.error("Error accessing memcached: key " + PREFIX_USERS_NAME+userName)
    		e.printStackTrace()
    	}
    	
     	if (user == null) {
    		
    		log.info("User not found in cache, get it from db : " + userName)
    		println "User not found in cache, get it from db : $userName"
    		user = Users.findWhere(userName:userName, password:password, status:ACTIVE)
    		
    		if (user == null) {
    			log.info("user doesn't exist in db. " + userName) 
    			println "user doesn't exist in db. $userName"
    			return null
    		} else {
    			log.info("let's put the user in cache : " + userName)
    			println "let's put the user in cache : $userName" 
    			try {
    				def putKey = PREFIX_USERS_NAME+userName
    				println "put key: $putKey"
    				memcachedSet(PREFIX_USERS_NAME+userName, user)
    			} catch (Exception e) {
    				log.error("Error setting memcached: key " + PREFIX_USERS_NAME+userName)
    				println "Error setting memcached: key $PREFIX_USERS_NAME$userName"
    				e.printStackTrace()
    			}
    		}
    	} else {
    		log.info("User found in cache : " + userName)
    		println "User found in cache : $userName" 
    	}
    	
    	//found the user, match the password
    	if (!user.password.equals(password)) {
    		log.info("User password didn't match : " + userName)
    		println "User password didn't match : $userName"
    		try {
    			memcachedDelete(PREFIX_USERS_NAME+userName)
    		} catch (Exception e) {
    			log.error("Error deleting memcached: key " + PREFIX_USERS_NAME+userName)
    			println "Error deleting memcached: key $PREFIX_USERS_NAME$userName"
    			e.printStackTrace()
    		}
    		return null
    	}
    	return user
    }
    
    def createUser(Users userObj) {
    	//assuming userName, firstName, lastName, email and password is populated.  only userName, email and password are required.  
    	userObj.status = ACTIVE
    	userObj.marketingId = DEFAULT_MARKETING
    	
    	userObj.countryId = getUserCountry(userObj.ipAddress)
    	
    	userObj.createTime = new Date()
    	userObj.updateTime = new Date()
    	userObj.lastLogin = new Date()
    	userObj.loginTimes = 0
    	userObj.numCategories = 0
    	
    	if(!userObj.hasErrors() && userObj.save()) {
            return SUCCESS
    	} else {
            return FAILURE
        }
    }
    
    def getUser(Long userId) {
    	return Users.findWhere(id:userId, status:ACTIVE)
    	
    }
    
    def getUser(String userName) {
    	return Users.findWhere(userName:userName, status:ACTIVE)
    	
    }
    
    def updateLoginStats(Long userId) {
    	def user = getUser(userId)
    	
    	if (user != null) {
    		user.lastLogin = new Date()
    		user.loginTimes++
    		user.id = userId
    		
    		if(!user.hasErrors() && user.save()) {
                return true
            }
            else {
                return false
            }
    	}
    }
    
    def getNumUserCategories(Long userId) {
    	return getUser(userId).numCategories
    }
    
    def decrementUserCategoryCount(Long userId) {
    	def user = getUser(userId)
    	
    	if (user != null) {
    		user.numCategories--
    		if  (!user.hasErrors() && user.save()) {
    			return SUCCESS
    		} else {
    			return FAILURE
    		}
    	}
    	
    	return FAILURE
    }
    
    def incrementUserCategoryCount(Long userId) {
    	def user = getUser(userId)
    	
    	if (user != null) {
    		user.numCategories++
    		if  (!user.hasErrors() && user.save()) {
    			return SUCCESS
    		} else {
    			return FAILURE
    		}
    	}
    	
    	return FAILURE
    }
    
    //this method to be used for disabling user.  it will disable all content belonging to this user.  admin_access, blog, comment, mycategory, mytweetmark, post, users
    def disableUser(String userName) {
    	Users user = getUser(userName)
    	
    	if (user != null) {
    		user.status = DISABLE
    		
    		if(!user.hasErrors() && user.save()) {
    			System.out.println("user disabled : " + userName)
    			//if it worked, let's do disable other features for the user
    			AdminAccess adminAccess = AdminAccess.findWhere(name:userName)
    			
    			if (adminAccess != null) {
    				adminAccess.status = DISABLE
    				if(!adminAccess.hasErrors() && adminAccess.save()) {
    					System.out.println("admin access disabled: " + userName)
    				}
    			}
    			
    			//only get blogs that are active by the user
    			def blogs = Blog.findAllWhere(userId:user.id, status:ACTIVE)
    			
    			if (blogs != null && !blogs.isEmpty()) {
    				for (int i=0; i<blogs.size(); i++) {
    					blogs.get(i).status = DISABLE
    					if(!blogs.get(i).hasErrors() && blogs.get(i).save()) {
        					System.out.println("blog disabled: " + blogs.get(i).id)
        				}
    				}
    			}
    			
    			//only get Comments that are active by the user
    			def comments = Comment.findAllWhere(userId:user.id, status:ACTIVE)
    			
    			if (comments != null && !comments.isEmpty()) {
    				for (int i=0; i<comments.size(); i++) {
    					comments.get(i).status = DISABLE
    					if(!comments.get(i).hasErrors() && comments.get(i).save()) {
        					System.out.println("comment disabled: " + comments.get(i).id)
        				}
    				}
    			}
    			
    			//only get mycategory that are active by the user
    			def myCategories = MyCategory.findAllWhere(userId:user.id, status:ACTIVE)
    			
    			if (myCategories != null && !myCategories.isEmpty()) {
    				for (int i=0; i<myCategories.size(); i++) {
    					myCategories.get(i).status = DISABLE
    					if(!myCategories.get(i).hasErrors() && myCategories.get(i).save()) {
        					System.out.println("myCategories disabled: " + myCategories.get(i).userId)
        				}
    				}
    			}
    			
    			//only get mytweetmark that are active by the user
    			def myTweetmarks = MyTweetMark.findAllWhere(userId:user.id, status:ACTIVE)
    			
    			if (myTweetmarks != null && !myTweetmarks.isEmpty()) {
    				for (int i=0; i<myTweetmarks.size(); i++) {
    					myTweetmarks.get(i).status = DISABLE
    					if(!myTweetmarks.get(i).hasErrors() && myTweetmarks.get(i).save()) {
        					System.out.println("myTweetmarks disabled: " + myTweetmarks.get(i).userId)
        				}
    				}
    			}
    			
    			//only get posts that are active by the user
    			def posts = Post.findAllWhere(userId:user.id, status:ACTIVE)
    			
    			if (posts != null && !posts.isEmpty()) {
    				for (int i=0; i<posts.size(); i++) {
    					posts.get(i).status = DISABLE
    					if(!posts.get(i).hasErrors() && posts.get(i).save()) {
        					System.out.println("posts disabled: " + posts.get(i).userId)
        				}
    				}
    			}
    		}
    	}
    }
    
    def activeUser(String userName) {
    	Users user = Users.findWhere(userName:userName,status:DISABLE)
    	
    	if (user != null) {
    		user.status = ACTIVE
    		
    		if(!user.hasErrors() && user.save()) {
    			System.out.println("user active : " + userName)
    			//if it worked, let's do active other features for the user
    			AdminAccess adminAccess = AdminAccess.findWhere(name:userName)
    			
    			if (adminAccess != null) {
    				adminAccess.status = ACTIVE
    				if(!adminAccess.hasErrors() && adminAccess.save()) {
    					System.out.println("admin access active: " + userName)
    				}
    			}
    			
    			//only get blogs that are active by the user
    			def blogs = Blog.findAllWhere(userId:user.id, status:DISABLE)
    			
    			if (blogs != null && !blogs.isEmpty()) {
    				for (int i=0; i<blogs.size(); i++) {
    					blogs.get(i).status = ACTIVE
    					if(!blogs.get(i).hasErrors() && blogs.get(i).save()) {
        					System.out.println("blog active: " + blogs.get(i).id)
        				}
    				}
    			}
    			
    			//only get Comments that are active by the user
    			def comments = Comment.findAllWhere(userId:user.id, status:DISABLE)
    			
    			if (comments != null && !comments.isEmpty()) {
    				for (int i=0; i<comments.size(); i++) {
    					comments.get(i).status = ACTIVE
    					if(!comments.get(i).hasErrors() && comments.get(i).save()) {
        					System.out.println("comment active: " + comments.get(i).id)
        				}
    				}
    			}
    			
    			//only get mycategory that are active by the user
    			def myCategories = MyCategory.findAllWhere(userId:user.id, status:DISABLE)
    			
    			if (myCategories != null && !myCategories.isEmpty()) {
    				for (int i=0; i<myCategories.size(); i++) {
    					myCategories.get(i).status = ACTIVE
    					if(!myCategories.get(i).hasErrors() && myCategories.get(i).save()) {
        					System.out.println("myCategories active: " + myCategories.get(i).userId)
        				}
    				}
    			}
    			
    			//only get mytweetmark that are active by the user
    			def myTweetmarks = MyTweetMark.findAllWhere(userId:user.id, status:DISABLE)
    			
    			if (myTweetmarks != null && !myTweetmarks.isEmpty()) {
    				for (int i=0; i<myTweetmarks.size(); i++) {
    					myTweetmarks.get(i).status = ACTIVE
    					if(!myTweetmarks.get(i).hasErrors() && myTweetmarks.get(i).save()) {
        					System.out.println("myTweetmarks active: " + myTweetmarks.get(i).userId)
        				}
    				}
    			}
    			
    			//only get posts that are active by the user
    			def posts = Post.findAllWhere(userId:user.id, status:DISABLE)
    			
    			if (posts != null && !posts.isEmpty()) {
    				for (int i=0; i<posts.size(); i++) {
    					posts.get(i).status = ACTIVE
    					if(!posts.get(i).hasErrors() && posts.get(i).save()) {
        					System.out.println("posts active: " + posts.get(i).userId)
        				}
    				}
    			}
    		}
    	}
    }
    
    def getTweet(Long userId) {
    	def user = getUser(userId)
    	
    	if (user != null) {
	    	Integer tweet = user.tweet
	    	
	    	if (tweet == null) {
	    		return OFF
	    	} else {
	    		return tweet
	    	}
    	}
    	return OFF
    }
    
    def setTweet(Long userId, int tweet) {
    	def user = getUser(userId)
    	
    	if (user != null) {
    		user.tweet = tweet
    		
    		if(!user.hasErrors() && user.save()) {
    			return SUCCESS
    		} 
    	}
    	return FAILURE 
    }
    
    //this method checks if a facebook user is already in place.
    def getUserByFacebookUid(String uid) {
    	return Users.findWhere(facebookUid:uid)
    }
    /**
     * The following methods are for extracting category and countries
     * 
     */
     
    def getCountries() {
    	 return Country.getAll()
    }
    
    def getCountryByCode(String twoLetterCode) {
    	Country country = Country.findWhere(code:twoLetterCode)
    	
    	if (country != null) {
    		//found the country
    		return country.id
    	} else {
    		log.info("Country not found for two letter code: " + twoLetterCode + ", setting default country: " + DEFAULT_COUNTRY)
    		return DEFAULT_COUNTRY
    	}
    }
    
    //TODO fill in user country from geo ip lookup
    def getUserCountry(String ip) {
    	//first lets look in geo ip and get the two digit country code.  we then need to find an internal country id, from the two digit code
    	
    	String twoLetter = getCountryByIp(ip)
    	
    	if (twoLetter == null || twoLetter.equals("")) {
    		log.info("country not found for ip: " + ip + ", setting default country: " + DEFAULT_COUNTRY)
    		return DEFAULT_COUNTRY
    	} else {
    		return getCountryByCode(twoLetter)
    	}
    }
    
    def getCategories() {
    	 return Categories.findAllByStatus(ACTIVE, [sort:"orderBy", order:"asc"])
    }
    
    def getCategory(int id) {
    	return Categories.get(id)
    }
    
    /**
     * Invite centric methods
     */
     
    def getContacts(String email, String password) {
    	List<octazen.addressbook.Contact> listContacts = null
    	try {
			listContacts = octazen.addressbook.SimpleAddressBookImporter.fetchContacts(email,password)
			
		} catch (Exception e) {
			log.error(e.printStackTrace())
		}
		return listContacts
    }
    
    def updateViralAddressImported(Long userId, Integer contactsSize) {
    	def viralObj = UsersViral.findWhere(userId:userId)
    	
    	//find out whether user viral object exists, if not create it.  then update last contacts size and then increment total contacts size
    	if (!viralObj) {
    		log.info("viralObj not found, creating new")
    		viralObj = new UsersViral()
    		viralObj.userId = userId
    		viralObj.createTime = new Date()
    		viralObj.updateTime = new Date()
    		viralObj.lastTimeAddressImported = contactsSize
    		viralObj.totalAddressImported = contactsSize
    		if  (!viralObj.hasErrors() && viralObj.save()) {
        		log.info("no error creating viral object")
    			return SUCCESS
    		} else {
    			log.error("error creating viral object")
    			return FAILURE
    		}
    		
    	} else {
    		log.info("viralObj found")
    		viralObj.lastTimeAddressImported = contactsSize
    		viralObj.updateTime = new Date()
    		viralObj.totalAddressImported+=contactsSize
    		if  (!viralObj.hasErrors() && viralObj.save()) {
        		log.info("no error updating viral object")
    			return SUCCESS
    		} else {
    			log.error("error creating viral object")
    			return FAILURE
    		}
    	}
    	
    }
    
    def processInvites(Long userId, String userName) {
    	return sendSelfMyTweetMark(userId, userName)
    }
    
    def sendSelfMyTweetMark(Long userId, String userName) {
		List myCategories = getMyCategoriesWithMyTweetMarks(userId)
		
		if (myCategories != null && !myCategories.isEmpty()) {
			def bodyStr = "<b>" + userName + "'s mytweetmarks ;)</b><br><br>"
			for (int i=0; i<myCategories.size(); i++) {
				bodyStr+="<i>" + myCategories.get(i).name + "</i><br>"
				List tweets = myCategories.get(i).tweets
				if (tweets != null && !tweets.isEmpty()) {
					for (int j=0; j<tweets.size(); j++) {
						bodyStr+=tweets.get(j).url+"<br>"
						if (tweets.get(j).description != null && !tweets.get(j).description.isEmpty()) {
							bodyStr+=tweets.get(j).description+"<br>"
						}
					}
				} else {
					bodyStr+="Empty<br>"
				}
				bodyStr+="<br>"
			}
			bodyStr += "<br>Thank you for using www.mytweetmark.com :)<br>"
			log.info("$bodyStr")
			return bodyStr
		}
    }
    
    /*
     * The following methods are for geo ip lookup
     */
     
     //GetCountryByIp returns a two digit code
     def getCountryByIp(String ip) { 
    	 try {
    		 if (locationService ==null) {
    			 synchronized(locationService) {
    				 locationService = new com.maxmind.geoip.LookupService("/usr/share/maxmind/GeoIP.dat")
    			 }
    		 }
    		 
    		 if (location == null) {
    			 location = locationService.getLocation(ip)
    		 }
    		 
    		 if (location != null) {
    			 //could also return postalCode and region
    			 return location.countryCode()
    		 } else {
    			 return ""
    		 }
    	 } catch (Exception e) {
    		 log.error("Error accessing geoip lookup")
    	 } 
    	 
    	 return ""
     }
    
     /*
      * Tracking calls
      */
      
      //This method gets called everytime main index.gsp is called.  Very important method for tracking.
      def trackReferer(String referer) {

     	log.info("inside trackReferer")
     	
     	if (referer!=null && !referer.equals("")) {
 	    	def internalRefererInstance = new InternalReferer()
 	    	log.info("REFERER:" + referer)
 	    	
 	    	internalRefererInstance.url=referer
 	    	internalRefererInstance.createTime=new Date()
 	    	InternalReferer.withTransaction { s ->
	 	        if(!internalRefererInstance.hasErrors() && internalRefererInstance.save()) {
	 	            log.info("referer saved")
	 	        }
 	    	}
     	}
     }
     
     def trackExternalIp(String ip) {
    	 log.info("inside trackExternalIp")
      	
      	if (ip!=null && !ip.equals("")) {
  	    	def externalIpInstance = new ExternalIp()
  	    	log.info("IP:" + ip)
  	    	
  	    	externalIpInstance.ip=ip
  	    	externalIpInstance.createTime=new Date()
  	        if(!externalIpInstance.hasErrors() && externalIpInstance.save()) {
  	            log.info("ip saved")
  	        }
      	}
     }
     
     //url=name of user
     def trackProfileReferer(String url, String referer, long userId) {

    	 try {

	      	if (referer!=null && !referer.equals(HOME_REFERER) && !referer.equals(SEARCH_REFERER) && !referer.equals(POST_REFERER) && !referer.equals("") && url!=null && !url.equals("") && !referer.equals(HOME_REFERER_2) && !referer.equals(SEARCH_REFERER_2) && !referer.equals(POST_REFERER_2)) {
	  	    	def profileRefererInstance = new ProfileReferer()
	  	    	profileRefererInstance.name=url
	  	    	profileRefererInstance.refererUrl=referer
	  	    	profileRefererInstance.createTime=new Date()
	  	        if(!profileRefererInstance.hasErrors() && profileRefererInstance.save()) {
	  	            System.out.println("profileRefererInstance saved")
	  	        } else {
	  	        	System.out.println("profileRefererInstance not saved")
	  	        }
	  	    	
	      	}
    	 } catch (Exception e) {
    		 e.printStackTrace()
    	 }
      }
     
     /*
      * Memcached calls
      */
      
      def memcachedClientInit() {

		 synchronized(mcc) {
			try { 
				 //server list and weights
				String[] servers =
					{
					  "74.208.44.114:1124"
					};
	
				//Integer[] weights = { new Integer(1) };
	
				// grab an instance of our connection pool
				pool = SockIOPool.getInstance();
	
				// set the servers and the weights
				pool.setServers( servers );
				//pool.setWeights( weights );
	
				// set some basic pool settings
				// 5 initial, 5 min, and 250 max conns
				// and set the max idle time for a conn
				// to 6 hours
				pool.setInitConn( 1 );
				pool.setMinConn( 1 );
				pool.setMaxConn( 10 );
				pool.setMaxIdle( 1000 * 60 * 60 * 6 );
	
				// set the sleep for the maint thread
				// it will wake up every x seconds and
				// maintain the pool size
				pool.setMaintSleep( 30 );
	
				// set some TCP settings
				// disable nagle
				// set the read timeout to 3 secs
				// and don't set a connect timeout
				pool.setNagle( false );
				pool.setSocketTO( 3000 );
				pool.setSocketConnectTO( 0 );
	
				// initialize the connection pool
				pool.initialize();
	
	
				// lets set some compression on for the client
				// compress anything larger than 64k
				mcc.setCompressEnable( true );
				mcc.setCompressThreshold( 64 * 1024 );
				println "Memcached Initialized!"
			} catch (Exception e) {
				println "Exception caught: Memcached Initialized!"
				e.printStackTrace()
			}
		 }
     }
     
     def memcachedGet(String key) {
    	 if (mcc == null) {
    		 mcc = new MemCachedClient()
    		 memcachedClientInit()
    	 }
    	 return mcc.get(key)
     }
     
     def memcachedSet(String key, Object) {
    	 if (mcc == null) {
    		 mcc = new MemCachedClient()
    		 memcachedClientInit()
    	 }
    	 mcc.set(key, Object)
     }
     
     def memcachedDelete(String key) {
    	 if (mcc == null) {
    		 mcc = new MemCachedClient()
    		 memcachedClientInit()
    	 }
    	 mcc.delete(key)
     }
     
     def memcachedGetMulti(String[] keys) {
    	 if (mcc == null) {
    		 mcc = new MemCachedClient()
    		 memcachedClientInit()
    	 }
    	 //returns Map<Object>
    	 return mcc.getMulti(keys)
     }
     
     def memcachedFlushAll() {
    	 if (mcc == null) {
    		 mcc = new MemCachedClient()
    		 memcachedClientInit()
    	 }
    	 mcc.flushAll()
     }
     
     /*
      * Methods around feature toggle, turn on and off
      */
      
      def isFeatureToggleOn(String name) {
    	  
    	 def featureToggle = FeatureToggle.findWhere(name:name)
  		
		 if (featureToggle != null && featureToggle.status != OFF) {
		    return true
		 } else {
			return false
		 }
      }
     
      def isFeatureToggleReadOnly(String name) {
    	  
     	 def featureToggle = FeatureToggle.findWhere(name:name)
   		
 		 if (featureToggle != null && featureToggle.status == READ_ONLY) {
 		    return true
 		 } else {
 			return false
 		 }
       }
      
      /*
       * Search calls
       */
       
       def search(String searchTerm) {
    	  def searchResult = searchableService.search(searchTerm)
    	  
    	  def returnResults = new ArrayList()
    	  def checkIds = new ArrayList()
    	  
    	  for (i in 0..<searchResult.results.size()) {
    		  if (searchResult.results[i] instanceof Users) {
    			  Integer userId = searchResult.results[i].id
    			  
    			  if (userId != null) {
	    			  if (!doesRecordExist(userId, checkIds)) {
	    				  def user = getUser(userId)
	    				  returnResults.add(user)
	    				  checkIds.add(userId)
	    			  }
    			  }
    		  } else if (searchResult.results[i] instanceof MyTweetMark) {
    			  
    			  Integer userId = searchResult.results[i].userId
    			  
    			  if (userId != null) {
	    			  if (!doesRecordExist(userId, checkIds)) {
	    				  def user = getUser(userId)
	    				  returnResults.add(user)
	    				  checkIds.add(userId)
	    			  }
    			  }
    		  } else if (searchResult.results[i] instanceof Post) {
    			  
    			  Integer userId = searchResult.results[i].userId
    			  
    			  if (userId != null) {
	    			  if (!doesRecordExist(userId, checkIds)) {
	    				  def user = getUser(userId)
	    				  returnResults.add(user)
	    				  checkIds.add(userId)
	    			  }
    			  }
    		  } else if (searchResult.results[i] instanceof Blog) {
    			  
    			  Integer userId = searchResult.results[i].userId
    			  
    			  if (userId != null) {
	    			  if (!doesRecordExist(userId, checkIds)) {
	    				  def user = getUser(userId)
	    				  returnResults.add(user)
	    				  checkIds.add(userId)
	    			  }
    			  }
    		  } else if (searchResult.results[i] instanceof MyHash) {
    			  
    			  Integer userId = searchResult.results[i].userId
    			  
    			  if (userId != null) {
	    			  if (!doesRecordExist(userId, checkIds)) {
	    				  def user = getUser(userId)
	    				  returnResults.add(user)
	    				  checkIds.add(userId)
	    			  }
    			  }
    		  } else if (searchResult.results[i] instanceof TweetUrl) {
    			  
    			  Integer userId = searchResult.results[i].userId
    			  
    			  if (userId != null) {
	    			  if (!doesRecordExist(userId, checkIds)) {
	    				  def user = getUser(userId)
	    				  returnResults.add(user)
	    				  checkIds.add(userId)
	    			  }
    			  }
    		  } else if (searchResult.results[i] instanceof TweetFriend) {
    			  
    			  Integer userId = searchResult.results[i].userId
    			  
    			  if (userId != null) {
	    			  if (!doesRecordExist(userId, checkIds)) {
	    				  def user = getUser(userId)
	    				  returnResults.add(user)
	    				  checkIds.add(userId)
	    			  }
    			  }
    		  } else if (searchResult.results[i] instanceof AutoTweet) {
    			  
    			  Integer userId = searchResult.results[i].userId
    			  
    			  if (userId != null) {
	    			  if (!doesRecordExist(userId, checkIds)) {
	    				  def user = getUser(userId)
	    				  returnResults.add(user)
	    				  checkIds.add(userId)
	    			  }
    			  }
    		  }
    	  }
    	  return returnResults
      }
      
      def doesRecordExist(Integer id, List results) {
    	  if (!results.isEmpty()) {
	    	  for (int i = 0; i< results.size(); i++) {
	    		 if (id == results.get(i)) {
	    			 return true;
	    		 }
	    	  }
    	  }
    	  return false;
      }
      
      /**
       * The following methods are for dealing with posts
       */
      
       def createMyPost(Long userId, Post postObj) {
    	   //check here whether the data has any invalid characters.
       	if (checkForSpam(postObj.description)) {
       		return FAILURE
       	}

       	postObj.status 		= ACTIVE
       	postObj.userId 		= userId
       	
       	postObj.createTime  = new Date()
       	
       	if(!postObj.hasErrors() && postObj.save()) {
       		   return SUCCESS
       	} else {
               return FAILURE
           }
       }
      
       def getPosts(Long userId) {
	       	//return Post.findAllByUserIdAndStatus(userId, ACTIVE, [sort:"createTime",order:"desc"])
	       	
	       	log.info("inside getPosts")
	   		List returnPostsWithComments = new ArrayList()
	   		List posts = Post.findAllByUserIdAndStatus(userId, ACTIVE, [sort:"createTime",order:"desc"])
	
	   		if (posts != null && !posts.isEmpty()) {
	   			for (int i = 0; i < posts.size(); i++) {
	   			
		   			def comments = getComments(posts.get(i).id, POST_TYPE)
		   			
		   			def expandoPost = new Expando()
		   			expandoPost.post = posts.get(i)
		   			expandoPost.comments = comments
		   			returnPostsWithComments.add(expandoPost)
	   			}
	   		}
	   	
	       	return returnPostsWithComments
       }
       
//     takes the post object and extract userid, mytweetmark id to delete (status) the object.
       def deletePost(Long userId, Long id) {
    	   
       	Post postObj = getPost(id)
       	
       	if (postObj != null) {
       		
       		if (postObj.userId != userId) {
       			return FAILURE
       		}
       		postObj.status = DELETE
       		
       		if  (!postObj.hasErrors() && postObj.save()) {
       			return SUCCESS
       		} else {
       			return FAILURE
       		}
       	}
       	
       	return FAILURE
       }

       def getPost(Long id) {
       	return Post.findWhere(id:id, status:ACTIVE)
       }
       
       def getPostsWithUserInfo(int offset, int max) {
    	   log.info("inside getPostsWithUserInfo")
    	   
       		List returnPostsWithUserInfo = new ArrayList()
       		//List posts = Post.list(max:50, order:"desc")
       		List posts = Post.findAllByStatus(ACTIVE, [max:max, offset:offset, sort:"createTime", order:"desc"] )

       		if (posts != null && !posts.isEmpty()) {
       		for (int i = 0; i < posts.size(); i++) {
       			
       			def user = getUser(posts.get(i).userId)
       			
       			def expandoPost = new Expando()
       			expandoPost.post = posts.get(i)
       			expandoPost.user = user
       			expandoPost.comments = getComments(posts.get(i).id, POST_TYPE)
       			returnPostsWithUserInfo.add(expandoPost)
       		}
       	}
       	
       	return returnPostsWithUserInfo
       }
       
       def getPostCount() {
    	   return Post.countByStatus(ACTIVE)

       }
       /**
        * The following methods are for dealing with file storage
        */
        
        def uploadPhoto(Long userId, File file) {
        	println "inside uploadPhoto"
        	
        	String fileName = file.getAbsolutePath()
        	
        	println "inside $fileName"
        	
        	ImagePlus image = ImagingService.openImagePlus(fileName);
        	try {
        		ImagingService.generate100x100(image, fileName, true);
        		ImagingService.generate50x50(image, fileName, true);
        	} catch (Exception e) {
        		
        		log.error("uploadPhoto: error generating 100x100 image")
        		println "uploadPhoto: error generating 100x100 image"
        		e.printStackTrace()
        		
        	}
  	      
        }
       
        def uploadPhoto(Long userId, String url) {
        	println "inside uploadPhoto"
        	
        	println "url $url"
        	
        	ImagePlus image = ImagingService.openImagePlusUrl(url);
        	try {
        		String outputOrig = FILE_STORAGE_PREFIX + userId
        		String output100 = FILE_STORAGE_PREFIX + userId + "-01"
        		String output50 = FILE_STORAGE_PREFIX + userId + "-02"
        		ImagingService.generateImage100(image, output100, true) 
        		ImagingService.generateImage50(image, output50, true) 
        		ImagingService.generateImage650(image, outputOrig, true) 
        	} catch (Exception e) {
        		
        		log.error("uploadPhoto: error generating 100x100 image")
        		println "uploadPhoto: error generating 100x100 image"
        		e.printStackTrace()
        		
        	}
  	      
        }
        
       /** 
        * The following methods are dealing with comments
        */
        
        def getComments(Long contentId, String contentType) {
    	    Comment.findAllWhere(contentId:contentId,contentType:contentType,status:ACTIVE)
        }
       
        def createMyComment(Long userId, Comment comment) {
        	//check here whether the data has any invalid characters.
        	if (checkForSpam(comment.description)) {
        		return FAILURE
        	}
        	
        	comment.status 		= ACTIVE
        	comment.userId		= userId
        	comment.createTime  = new Date()
        	comment.updateTime  = new Date()
         	
         	if(!comment.hasErrors() && comment.save()) {
         		 return SUCCESS
         	} else {
                 return FAILURE
             }
        }
        
//      takes the comment object and extract userid to delete (status) the object.
        def deleteComment(Long userId, Long id) {
     	   
        	Comment commentObj = getComment(id)
        	
        	if (commentObj != null) {
        		
        		if (commentObj.userId != userId) {
        			return FAILURE
        		}
        		commentObj.status = DELETE
        		
        		if  (!commentObj.hasErrors() && commentObj.save()) {
        			return SUCCESS
        		} else {
        			return FAILURE
        		}
        	}
        	
        	return FAILURE
        }

        def getComment(Long id) {
           	return Comment.findWhere(id:id, status:ACTIVE)
           }
        
        /** 
         * Twitter centric methods
         */
         
         def registerTwitterer(String userName, String password) {
        	try {
        		//String photoImageUrl = twitterService.authenticateViaAPI(userName, password)
        		String photoImageUrl = null
        		Users user = new Users()
        		user.userName = userName
        		user.password = password
        		user.profilePhoto = photoImageUrl
        		createUser(user)
        		
        		if (user.profilePhoto != null && !user.profilePhoto.isEmpty()) {
	        		try {
	        			uploadPhoto(user.id, user.profilePhoto)
	        		} catch (Exception e) {
	        			System.out.println("Couldn't process image: " + user.profilePhoto)
	            		e.printStackTrace()
	        		}
        		}
        		return user.id
        		
        	} catch (Exception e) {
        		System.out.println("Failed login: " + userName)
        		e.printStackTrace()
        		return FAILURE
        	}
        }
        
         /** 
          * The following methods are dealing with blogs
          */
          
          def getBlogs(Long userId) {
      	    return Blog.findAllWhere(userId:userId,status:ACTIVE)
          }
         
          def createMyBlog(Long userId, Blog blog, boolean update) {
        	if (checkForSpam(blog.description)) {
         		return FAILURE
         	}
    	  
           	if (checkForSpam(blog.title)) {
           		return FAILURE
           	}
           	
           	blog.description.replaceAll("[^a-zA-Z0-9]+","")

        	  blog.status 		= ACTIVE
        	  blog.userId		= userId
        	  
        	  if (!update) {
        		  blog.createTime  = new Date()
        	  }
        	  
        	  blog.updateTime  = new Date()
           	
        	  
           	if(!blog.hasErrors() && blog.save()) {
           		 return SUCCESS
           	} else {
                   return FAILURE
               }
          }
          
//        takes the blog object and extract userid to delete (status) the object.
          def deleteBlog(Long userId, Long id) {
       	   
          	Blog blogObj = getBlog(id)
          	
          	if (blogObj != null) {
          		
          		if (blogObj.userId != userId) {
          			return FAILURE
          		}
          		blogObj.status = DELETE
          		
          		if  (!blogObj.hasErrors() && blogObj.save()) {
          			return SUCCESS
          		} else {
          			return FAILURE
          		}
          	}
          	
          	return FAILURE
          }

          def getBlog(Long id) {
             	return Blog.findWhere(id:id, status:ACTIVE)
             }
          
          
      /*
       * Spam methods
       */
       
       def checkForSpam(String content) {
    	  if (content != null) {
	    	  if (content.contains("<script") || content.contains("</script>")) {
	    		  return true
	    	  }
    	  }
    	  
    	  return false
      }
      
      /*
       * User Views 
       */
       
       def incrementViews(Long userId) {
    	  Views userView = Views.findWhere(userId:userId)
    	  
    	  if (userView != null) {
    		  userView.num++
    		  if  (!userView.hasErrors() && userView.save()) {
    			  return SUCCESS
    		  } else {
    			  return FAILURE
    		  }
    	  } else {
    		  userView = new Views()
    		  userView.createTime = new Date()
    		  userView.userId = userId
    		  userView.num = 1
    		  if  (!userView.hasErrors() && userView.save()) {
    			  return SUCCESS
    		  } else {
    			  return FAILURE
    		  }
    	  }
    	  return FAILURE
      }
       
      def getViews(Long userId) {
    	  Views userView = Views.findWhere(userId:userId)
    	  if (userView != null) {
    		  return userView.num
    	  } else {
    		  return 0
    	  }
      }
      
      def createMyHash(Long userId, MyHash myHash) {
     	if (checkForSpam(myHash.hash)) {
     		return FAILURE
     	}

     	myHash.status 		= ACTIVE
     	myHash.userId		= userId
     	myHash.createTime  = new Date()
     	myHash.updateTime  = new Date()
       	
       	if(!myHash.hasErrors() && myHash.save()) {
               return SUCCESS
       	} else {
               return FAILURE
           }
      }
      
      def getHash(Long id) {
       	return MyHash.findWhere(id:id, status:ACTIVE)
       }

      def getHashString(Long userId) {
    	  MyHash myHashObj = MyHash.findByUserIdAndStatus(userId, ACTIVE, [max:1, sort:"createTime", order:"desc"])
    	  
    	  if (myHashObj != null) {
    		  return myHashObj.hash
    	  } else {
    		  return ""
    	  }
      }
      
      def getMyHashes(Long userId) {
    	  return MyHash.findAllByUserIdAndStatus(userId, ACTIVE, [sort:"createTime", order:"desc"]) 
      }
      
//    takes the hash object and extract userid to delete (status) the object.
      def deleteHash(Long userId, Long id) {
   	   
      	MyHash hashObj = getHash(id)
      	
      	if (hashObj != null) {
      		
      		if (hashObj.userId != userId) {
      			return FAILURE
      		}
      		hashObj.status = DELETE
      		
      		if  (!hashObj.hasErrors() && hashObj.save()) {
      			return SUCCESS
      		} else {
      			return FAILURE
      		}
      	}
      	
      	return FAILURE
      }

      /*
       * Facebook methods
       */
       
      def isFaceBookUser(Long userId) {
    	  def user = getUser(userId)
    	  
    	  if (user != null) {
    		  if (user.facebookUid!=null && !user.facebookUid.isEmpty() && !user.facebookUid.equals("")) {
    			  return ON
    		  }
    	  }
    	  
    	  return OFF
      }
      
      def isFaceBookUser(String userName) {
    	  def user = getUser(userName)
    	  
    	  if (user != null) {
    		  if (user.facebookUid!=null && !user.facebookUid.isEmpty() && !user.facebookUid.equals("")) {
    			  return ON
    		  }
    	  }
    	  
    	  return OFF
      }
      
      def getUserPermission(Long userId) {
    	  def user = getUser(userId)
    	  
    	  if (user != null) {
    		  return user.permission
    	  }
    	  
    	  return null
      }
      
      def allowFacebook(Long userId) {
    	  def user = getUser(userId)
      	
      		if (user != null) {
      		user.permission = ON
      		if  (!user.hasErrors() && user.save()) {
      			return SUCCESS
      		} else {
      			return FAILURE
      		}
      	}
      	
      	return FAILURE
      }
      
      /*
       * Tweet Urls code
       */
       
      def getTweetUrls(long userId, int offset, int max) {
   	   log.info("inside getTweetUrls")
   	   return TweetUrl.findAllByUserIdAndStatus(userId, ACTIVE, [max:max, offset:offset, sort:"createTime", order:"desc"] )
      }
      
      def getTweetUrlCount(long userId) {
   	   return TweetUrl.countByUserIdAndStatus(userId, ACTIVE)
      }
      
//    takes the tweet url object and extract userid, mytweetmark id to delete (status) the object.
      def deleteTweetUrl(Long userId, Long id) {
   	   
      	TweetUrl tweetUrlObj = getTweetUrl(id)
      	
      	if (tweetUrlObj != null) {
      		
      		if (tweetUrlObj.userId != userId) {
      			return FAILURE
      		}
      		tweetUrlObj.status = DELETE
      		
      		if  (!tweetUrlObj.hasErrors() && tweetUrlObj.save()) {
      			return SUCCESS
      		} else {
      			return FAILURE
      		}
      	}
      	
      	return FAILURE
      }

      def getTweetUrl(Long id) {
         	return TweetUrl.findWhere(id:id, status:ACTIVE)
         }
      
      def getLastTweetUrl(Long userId) {
    	  return TweetUrl.findByUserIdAndStatus(userId, ACTIVE, [max:1, sort:"statusId", order:"desc"])
    	  
      }
      
      /*
       * Tweet Friends code
       */
       
      def getTweetFriends(long userId, int offset, int max) {
   	   log.info("inside getTweetFriends")
   	   return TweetFriend.findAllByUserIdAndStatus(userId, ACTIVE, [max:max, offset:offset, sort:"createTime", order:"desc"] )
      }
      
      def getTweetFriendCount(long userId) {
   	   return TweetFriend.countByUserIdAndStatus(userId, ACTIVE)
      }
      
//    takes the tweet url object and extract userid, mytweetmark id to delete (status) the object.
      def deleteTweetFriend(Long userId, Long id) {
   	   
      	TweetFriend tweetFriendObj = getTweetFriend(id)
      	
      	if (tweetFriendObj != null) {
      		
      		if (tweetFriendObj.userId != userId) {
      			return FAILURE
      		}
      		tweetFriendObj.status = DELETE
      		
      		if  (!tweetFriendObj.hasErrors() && tweetFriendObj.save()) {
      			return SUCCESS
      		} else {
      			return FAILURE
      		}
      	}
      	
      	return FAILURE
      }

      def getTweetFriend(Long id) {
         	return TweetFriend.findWhere(id:id, status:ACTIVE)
         }
      
      def getLastTweetFriend(Long userId) {
    	  return TweetFriend.findByUserIdAndStatusIdGreaterThan(userId, 0, [max:1, sort:"statusId", order:"desc"])
    	  
      }
      
      /*
       * Auto Tweet on and off
       */
       
       def getAutoTweet(Long userId) {
       	def user = getUser(userId)
       	
       	if (user != null) {
   	    	Integer autoTweet = user.autoTweet
   	    	
   	    	if (autoTweet == null) {
   	    		return OFF
   	    	} else {
   	    		return autoTweet
   	    	}
       	}
       	return OFF
       }
       
       def setAutoTweet(Long userId, int tweet) {
       	def user = getUser(userId)
       	
       	if (user != null) {
       		user.autoTweet = tweet
       		
       		if(!user.hasErrors() && user.save()) {
       			return SUCCESS
       		} 
       	}
       	return FAILURE 
       }
       
       /*
        * View rows summary
        */
        
       def getViewRows(long userId) {
    	   def summaries = ViewSummary.findAllByUserId(userId, [max:7, sort:"createTime", order:"desc"])
    	   
    	   if (summaries != null && !summaries.isEmpty()) {
    		   StringBuilder strBuilder = new StringBuilder()
    		   def isFirst = true
    		   
    		   for (int i=0; i< summaries.size(); i++) {
    			   if (isFirst) {
    				   isFirst = false;
    			   } else {
    				   strBuilder.append(",")
    			   }
    			   Calendar calendar = new GregorianCalendar();
    			   calendar.setTime(summaries.get(i).createTime)
    			   strBuilder.append("[new Date(" + calendar.get(Calendar.YEAR) + "," + calendar.get(Calendar.MONTH) + "," + calendar.get(Calendar.DAY_OF_MONTH) + "), " + summaries.get(i).num + "]")
    		   }
    		   System.out.println(strBuilder.toString())
    		   return strBuilder.toString()
    	   }
    	   return null
       }
       
       /**
        * Auto Tweet functions
        */
        
       def getAutoTweets(long userId, boolean delete) {
    	  def tweets = AutoTweet.findAllByUserIdAndStatus(userId, ACTIVE, [sort:"createTime", order:"desc"] )
    	  
    	  if (tweets == null || tweets.isEmpty() && delete != true) {
    		  //lets build the tweet list
    		  def categories = getMyCategories(userId)
      		
      		  if (categories != null && !categories.isEmpty()) {
      			  def user = getUser(userId)
      			  for (int j=0;j<categories.size(); j++) {
      				Categories category = getCategory(categories.get(j).categoryId)
      				
      				if (category != null) {
	      				String updateStatus = "I created category #" + category.name + " on http://www.mytweetmark.com/" + user.userName+ " #" + getHashString(userId)
	      				
	      				AutoTweet tweet = new AutoTweet()
	      				tweet.status = ACTIVE
	      				tweet.tweet = updateStatus
	      				tweet.userId = userId
	      				tweet.createTime = new Date()
	      				
	      				if(tweet.hasErrors() || !tweet.save()) {
	      	       			System.out.println("error writing out auto tweet")
	      	       		}
      				}
      			}
      			tweets = AutoTweet.findAllByUserIdAndStatus(userId, ACTIVE, [sort:"createTime", order:"desc"] )
      		}
    	  }
    	  return tweets
       }
       
       def getThisAutoTweet(Long id) {
    	  return AutoTweet.findWhere(id:id, status:ACTIVE)
       }
          
//        takes the tweet url object and extract userid, mytweetmark id to delete (status) the object.
     	def deleteAutoTweet(Long userId, Long id) {
       	   
          	AutoTweet tweetObj = getThisAutoTweet(id)
          	
          	if (tweetObj != null) {
          		
          		if (tweetObj.userId != userId) {
          			return FAILURE
          		}
          		tweetObj.status = DELETE
          		
          		if  (!tweetObj.hasErrors() && tweetObj.save()) {
          			return SUCCESS
          		} else {
          			return FAILURE
          		}
          	}
          	
          	return FAILURE
          }

     	def getAutoTweetCount(long userId) {
        	   return AutoTweet.countByUserIdAndStatus(userId, ACTIVE)
           }
     	
     	def createMyTweet(Long userId, AutoTweet tweetObj) {
     	   //check here whether the data has any invalid characters.
        	if (checkForSpam(tweetObj.tweet)) {
        		return FAILURE
        	}

        	def status = tweetObj.tweet
        	
        	try {
	        	if (status.contains("http")) {
	        		if (!status.contains("mytweetmark")) {
	        			def index = status.indexOf("http")
	        			if (index > -1) {
	        				def firstPart = status.substring(0, index)
	        				def secondPart = status.substring(index)
	        				
	        				def index2 = secondPart.indexOf(" ")
	        				def link = ""
	        				
	        				if (index2 > -1) {
	        					link = secondPart.substring(0, index2)
	        					secondPart = secondPart.substring(index2)
	        				} else {
	        					link = secondPart
	        					secondPart=""
	        				}
	        				
	        				def newLink = new Link()
	        				newLink.url = link
	        				newLink.createTime = new Date()
	        				
	        				if  (!newLink.hasErrors() && newLink.save()) {
	                  			link = "http://www.mytweetmark.com/link/"+newLink.id
	                  			status = firstPart + link + secondPart
	                  		} 
	        				
	        			}
	        		}
	        	}
        	} catch (Exception eT) {
        		eT.printStackTrace()
        		System.out.println("Error setting redirect link")
        	}
        	
        	while (status.length() > 140) {
				if (status.contains("http")) {
					def index = status.indexOf("http")
        			if (index > -1) {
        				if (index > 70) {
        					def part1 = status.substring(0, 48)+ ".. "
        					def part2 = status.substring(68)
        					if (part2.contains(" ")) {
        						def index2 = part2.indexOf(" ")
        						part2 = part2.substring(index2+1)
        					}
        					status = part1 + part2
        				} else {
        					status = status.substring(0, 138)+".."
        				}
        			}
				} else {
					status = status.substring(0,138)+".."
				}
				
			}
			tweetObj.tweet 			= status
        	tweetObj.status 		= ACTIVE
        	tweetObj.userId 		= userId
        	
        	tweetObj.createTime  = new Date()
        	
        	if(!tweetObj.hasErrors() && tweetObj.save()) {
        		   return SUCCESS
        	} else {
                return FAILURE
            }
        }
     	
     	/**
         * Tweet Finder functions
         */
         
        def getTweetFinders(long userId) {
     	  def tweetFinders = TweetFinder.findAllByUserIdAndStatus(userId, ACTIVE, [sort:"createTime", order:"desc"] )
     	  
     	  if (tweetFinders!=null && !tweetFinders.isEmpty()) {
     		  for (int i=0; i<tweetFinders.size(); i++) {
     			  def finder = tweetFinders.get(i).finder
     			  def tokenzier = new java.util.StringTokenizer(finder)
     			  finder = tokenzier.nextToken()
     			  
     			  if (finder.startsWith("@")) {
     				  //def tweets = twitterService.userTimeline(finder.substring(1))
     				  def tweets = null
     				  if (tweets!=null && tweets.size()>10) {
     					  tweets = tweets.subList(0, 10) 
     				  }
     				  
     				  tweetFinders.get(i).tweets = tweets
     				 
     			  } else if (finder.startsWith("#")) {
     				  //def tweets = twitterService.search(finder)
     				  def tweets = null
     				  
     				  if (tweets!=null && tweets.size()>10) {
     					  tweets = tweets.subList(0, 10) 
     				  }
     				  
     				 tweetFinders.get(i).tweets = tweets
     			  } 
     		  }
     	  }
     	  return tweetFinders
        }
        
        def getTweetFinder(Long id) {
     	  return TweetFinder.findWhere(id:id, status:ACTIVE)
        }
           
      	def deleteTweetFinder(Long userId, Long id) {
        	   
           	TweetFinder tweetObj = getTweetFinder(id)
           	
           	if (tweetObj != null) {
           		
           		if (tweetObj.userId != userId) {
           			return FAILURE
           		}
           		tweetObj.status = DELETE
           		
           		if  (!tweetObj.hasErrors() && tweetObj.save()) {
           			return SUCCESS
           		} else {
           			return FAILURE
           		}
           	}
           	
           	return FAILURE
           }

      	def getTweetFinderCount(long userId) {
         	   return TweetFinder.countByUserIdAndStatus(userId, ACTIVE)
            }
      	
      	def createTweetFinder(Long userId, TweetFinder tweetObj) {
      		System.out.println("inside createTweetFinder")
      		System.out.println("inside createTweetFinder, " + userId)
      		System.out.println("inside createTweetFinder, " + tweetObj.finder)
      		
      	   //check here whether the data has any invalid characters.
         	if (checkForSpam(tweetObj.finder)) {
         		return FAILURE
         	}

         	tweetObj.status 		= ACTIVE
         	tweetObj.userId 		= userId
         	
         	tweetObj.createTime  = new Date()
         	
         	if(!tweetObj.hasErrors() && tweetObj.save()) {
         		System.out.println("saved")
         		   return SUCCESS
         	} else {
         		System.out.println("not saved")
                 return FAILURE
             }
         }
      	
      	/*
         * Email Report on and off
         */
         
         def getEmailReport(Long userId) {
         	def user = getUser(userId)
         	
         	if (user != null) {
     	    	Integer emailReport = user.emailReport
     	    	
     	    	if (emailReport == null) {
     	    		return OFF
     	    	} else {
     	    		return emailReport
     	    	}
         	}
         	return OFF
         }
         
         def setEmailReport(Long userId, Integer emailReport) {
         	def user = getUser(userId)
         	
         	if (user != null) {
         		user.emailReport = emailReport
         		
         		if(!user.hasErrors() && user.save()) {
         			return SUCCESS
         		} 
         	}
         	return FAILURE 
         }
         
         def getEmailReportStats(ViewSummary summary, List mentions, List messages) {
        	 def returnStr = "<b>Daily Mytweetmark Metrics Report</b><br>"
        	 returnStr+= "----------------------------------------------<br><br>"
        	 returnStr+="Total page views: <b>" + summary.num+"</b><br>"
        	 returnStr+="Total followers: <b>" + summary.followersCount+"</b><br>"
        	 returnStr+="Total Following: <b>" + summary.friendsCount+"</b><br>"
        	 
        	 if (mentions != null && !mentions.isEmpty()) {
        		 returnStr+="<br><b>Recent mentions:</b><br>"
        		 for (int i=0; i<mentions.size();i++) {
        			 User user = mentions.get(i).getUser()
        			 if (user != null) {
        				 returnStr+="<b>" + user.getScreenName()+":</b> "
        			 }
        			 returnStr+=mentions.get(i).getText()+"<br><br>"
        		 }
        	 }
        	 
        	 if (messages != null && !messages.isEmpty()) {
        		 returnStr+="<br><b>Recent messages:</b><br>"
        		 for (int i=0; i<messages.size();i++) {
        			 returnStr+="<b>" + messages.get(i).getSenderScreenName() + ":</b> " + messages.get(i).getText()+"<br><br>"
        		 }
        	 }
        	 
        	 returnStr+="<br><b>Thank you for using http://www.mytweetmark.com</b><br>"
        	 return returnStr
         }
         
         def getRedirectLink(long id) {
       	   return Link.findWhere(id:id)
          }
}
