  
<div style="float:left;width:800px;">

	<div style="float:center;width:700px;">
		<h2>My Twitter Business Contacts</h2> 
		People you speak to on Twitter are your business contacts.  Choose which ones to show on your business profile.
	</div>
	<br class="clear"/>
	<div class="paginateButtons">
                <g:paginate total="${tweetFriendInstanceTotal}" />
            </div>  
    <br class="clear"/>
<div class="update-separator-grey">&nbsp;</div>
	
	<div style="float:center;width:700px;">
						
				<g:each in="${tweetFriendInstanceList}" status="j" var="tweetInstance">
				
                	<div style="float:left;width:200px;margin:10px;text-align:left;">  
                		<a href="http://www.twitter.com/${tweetInstance.friendName}" target="_blank"><img src="${tweetInstance.profilePhoto}" width="48" height="48"> </a> <a href="http://www.twitter.com/${tweetInstance.friendName}" target="_blank">${tweetInstance.friendName}</a>
                 	</div>
                    <div style="float:right;width:100px;">
	                    <g:def var="tweetId" value="${tweetInstance.id}"/>
	            		<g:link class="smaller-secondary-action-link" action="deleteMyTweetFriend" controller="tweetFriend" params="[id: tweetId]">
	            			Remove Contact
	            		</g:link>
                    </div>       		
                            		
                    <div style="float:left;width:500px;text-align:left;">   
                    	Tweet:       	
                    	${tweetInstance.tweet}
                    </div>
                    <br class="clear"/>    
                    <div class="update-separator-grey">&nbsp;</div>    	
                </g:each> 
            </div>
      <div class="paginateButtons">
                <g:paginate total="${tweetFriendInstanceTotal}" />
            </div>  
            <br class="clear"/>
</div>