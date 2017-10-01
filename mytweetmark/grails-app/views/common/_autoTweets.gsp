  
<div class="rounded" style="float:left;width:986px;">

	<div class="rounded" style="float:right;width:250px;text-align:center;background-image: url(${createLinkTo(dir:'images', file:'bg_slideshow.jpg')});">
	
	<div style="float:center;width:250px;text-align:center;">
	
	  			<h4>Quick Tip:</h4>
	  			<div style="margin:3px;">
	  			Create tweets that are relevant.  Use useful hash tags, i.e. # term that are relevant for your business in the auto tweets.  E.g. #facebook, #twitter, #farmersmarket, #food. Create links to your content and put them here as auto tweets. Find websites, videos, photos, social media profiles, etc. and setup as auto tweets for non-stop marketing. Measure the timing of the auto tweets by time stamps on twitter.
	  			</div>
	  			<br><br>
	  			<h4>Toggle Automatic Tweets</h4>
	  			<g:if test="${autoTweet==0}">
				<div style="float:center;">
				  <g:link action="autoTweetOn" controller="users">
					            		<img src="${createLinkTo(dir:'images', file:'bluebutton_autotweeton.png')}" title="Start sending auto tweets"/>
					            	</g:link>
				</div>
				</g:if>
				<g:else>
				<div style="float:center;">
				  <g:link action="autoTweetOff" controller="users">
					            		<img src="${createLinkTo(dir:'images', file:'bluebutton_autotweetoff.png')}" title="Stop sending auto tweets"/>
					            	</g:link>
				</div>
				</g:else> 
				<br><br>         
	  			</div>
	</div>
	
	<div style="float:center;width:700px;">
	
		<h2>My Auto Tweets</h2>
		<div class="rounded" style="float:center;margin: 5px; width:700px;border:1px solid #cfcfcf;background:#f3ecd5;height:100px;"> 
		<b>You are allowed 100 auto tweets.  Our algorithms will schedule tweets by optimization across businesses.  NEVER any spam.  We will randomly pick your tweets and periodically send them out.</b>
		</div>
	</div>
	<br class="clear"/>
	<g:if test="${autoTweetCount<100}">
	<div style="float:center;width:700px;">
	<div class="rounded" style="float:center;width:700px;font-size:14px;border:2px solid #E0F0FB; ">
                 			<mytweetmark:postEditInPlace id="tweet"
                 			url="[controller: 'autoTweet', action: 'saveMyTweet']"
                 			rows="1"
                 			cols="45"
                 			paramName="tweet">Click here to add new tweet</mytweetmark:postEditInPlace>
            </div>
    </div>
	<br>
	<br>		
    <br class="clear"/>
	<div class="update-separator">&nbsp;</div>
	</g:if>
	<br>
	<div style="float:center;width:700px;">
						
				<g:each in="${autoTweetInstanceList}" status="j" var="autoTweetInstance">
				<div style="float:left;width:700px;font-size:10px;text-align:left;margin:10px;">
                Created: <g:formatDate type="datetime" style="MEDIUM" date="${autoTweetInstance.createTime}"/> 
                </div>  
                	<div style="float:left;width:700px;text-align:left;margin:10px;font-size:16px;font-family:georgia;color:#3FCDFF;">
                		<mytweetmark:convertURLtoLink text="${autoTweetInstance.tweet}">
       					</mytweetmark:convertURLtoLink>   
                    	
                    </div>
                    
                    <div style="float:right;width:50px;">
	                    <g:link class="smaller-secondary-action-link" action="deleteAutoTweet" controller="autoTweet" id="${autoTweetInstance.id}">
	            			<img border="0" src="${createLinkTo(dir:'images', file:'RemoveButton.png')}" title="Remove Auto Tweet"/>
                	</g:link>
                    </div>     
                    
                    <br class="clear"/>    
                    <div class="update-separator-grey">&nbsp;</div>    	
                </g:each> 
            </div>
            <br class="clear"/>
</div>