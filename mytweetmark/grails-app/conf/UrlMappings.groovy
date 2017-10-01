class UrlMappings {
    static mappings = {
      "/$userName"(controller:'myTweetMark', action:'userTweetMarks'){
    	  constraints {
    		  
    	  }
      }
      "/link/$id"(controller:'link', action:'redirectLink'){
    	  constraints {
    		  
    	  }
      }
      "/plugins/facebook-connect-0.1/xd_receiver.htm"(view:'/index.gsp'){
    	  constraints {
			 // apply constraints here
		  }
	  }
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
	  "500"(view:'/error')
	}
}
