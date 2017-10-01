  
<div style="float:left;width:986px;">

	<div class="rounded" style="float:right;width:250px;text-align:center;background-image: url(${createLinkTo(dir:'images', file:'bg_slideshow.jpg')});">
	<div style="float:center;width:250px;text-align:center;">
	  			<h4>Quick Tip:</h4>
	  			Use tweet finder for conferences, e.g. #sxsw, #chirp, #f8, #tedx.  Or users you want to pay attention to, e.g @charitywater, @twitter.
	  			<br><br>       
	  			</div>
	</div>
	
	<div style="float:center;width:600px;">
		<h2>My Tweet Finders</h2> 
		Choose people or search terms you look at everyday. We will display 10 results and save your preferences for next time.   
	</div>
	<br class="clear"/>
	<div style="float:center;width:600px;">
	<div style="float:center;width:500px;height:50px; background:#f6f7f8;">
                 			<mytweetmark:postEditInPlace id="finder"
                 			url="[controller: 'tweetFinder', action: 'saveMyTweetFinder']"
                 			rows="1"
                 			cols="45"
                 			paramName="finder">Type either @user_name or #search_term</mytweetmark:postEditInPlace>
            </div>
    </div>
	<br>
	<br>		
    <br class="clear"/>
	<div class="update-separator">&nbsp;</div>
	<br>
	<div style="float:center;width:600px;">
						
				<g:each in="${tweetFinderInstanceList}" status="j" var="tweetFinderInstance">
				<g:def var="tweets" value="${tweetFinderInstance.tweets}"/>
				
				<div style="float:left;width:400px;font-size:16px;font-family:georgia;color:#3FCDFF;text-align:left;">
				Finder: <b>${tweetFinderInstance.finder}</b>
				</div>
				
				<div style="float:right;width:50px;">
	                    <g:link class="smaller-secondary-action-link" action="deleteTweetFinder" controller="tweetFinder" id="${tweetFinderInstance.id}">
	            			Remove&nbsp;&raquo;
	            		</g:link>
                    </div>
                <br>
                <br>
				<div style="float:left;width:600px;text-align:left;margin:10px;font-size:12px;font-family:georgia;">
				<g:each in="${tweets}" status="i" var="tweet">
				<b>${tweet.text}</b><br>
				<g:formatDate type="datetime" style="MEDIUM" date="${tweet.createdAt}"/><br>
				<br>
				</g:each>
				</div>
				
				<br class="clear"/>
			<div class="update-separator-grey">&nbsp;</div>    
                    	
                </g:each> 
    </div>
                
</div>