  
<div style="float:left;width:800px;">

	<div style="float:center;width:700px;">
		<h2>UnFollowers</h2> 
		People you follow that don't follow you back. Unfollow maximum is 50 per hour because of Twitter rate limit.
	</div>
	<br class="clear"/>
	<div class="paginateButtons">
                <g:paginate total="${unFollowersInstanceTotal}" />
            </div>  
    <br class="clear"/>
<div class="update-separator-grey">&nbsp;</div>
	
	<div style="float:center;width:700px;">
						
				<g:each in="${unFollowersList}" status="j" var="unFollowerInstance">
				
                	<div style="float:left;width:200px;margin:10px;text-align:left;">  
                		<a href="http://www.twitter.com/${unFollowerInstance.screenName}" target="_blank"><img src="${unFollowerInstance.miniProfileImageURL}" width="48" height="48"> </a> <a href="http://www.twitter.com/${unFollowerInstance.screenName}" target="_blank">${unFollowerInstance.screenName}</a>
                 	</div>
                    <div style="float:right;width:100px;">
	                    <g:def var="screenName" value="${unFollowerInstance.screenName}"/>
	            		<g:link class="smaller-secondary-action-link" action="deleteUnFollower" controller="myTweetMark" params="[screenName: screenName]"><img border="0" src="${createLinkTo(dir:'images', file:'UnFollowButton.png')}" title="Unfollow"/></g:link>
	            			
                    </div>       		
                            		
                    <div style="float:left;width:500px;text-align:left;">   
                    	Description:       	
                    	${unFollowerInstance.description}
                    </div>
                    <br class="clear"/>    
                    <div class="update-separator-grey">&nbsp;</div>    	
                </g:each> 
            </div>
      <div class="paginateButtons">
                <g:paginate total="${unFollowersInstanceTotal}" />
            </div>  
            <br class="clear"/>
</div>