        <div class="list">
            <div class="update-separator-grey">&nbsp;</div>
            
            <div style="float:left;width:150px;">
        	<a href="http://www.homecook.me" target="_blank"><img src="${createLinkTo(dir:'images', file:'HOMECOOKlogo-100.gif')}"/></a>
        	</div>
        	<div style="float:left;width:550px;">
        	Share your food recipes with your friends on Facebook and Twitter. Review them. Eat good tonight! Find us on twitter, <a href="http://www.twitter.com/homecookme" target="_blank">@homecookme</a> and <a href="http://www.twitter.com/mytweetmark" target="_blank">@mytweetmark.</a>  
        	</div>
        	<br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div>
	        
	        
            <g:if test="${tweetFriends}">
	        <div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
	        <h1>Twitter Feed Friends</h1>
	        </div>
	        
	        <g:each in="${tweetFriends}" status="j" var="tweetInstance">
					
	                	<div style="float:left;width:275px">  
	                		<a href="http://www.twitter.com/${tweetInstance.friendName}" target="_blank"><img src="${tweetInstance.profilePhoto}" width="48" height="48"> </a> <a href="http://www.twitter.com/${tweetInstance.friendName}" target="_blank">${tweetInstance.friendName}</a>
	                 	</div>
	                            		
	                <g:if test="${j%2}">
	                	<br class="clear"/>    
	        			<div class="update-separator-grey">&nbsp;</div>  
	                </g:if>    
	                </g:each> 
	        <br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div>    	
	        </g:if>
        
        	<g:if test="${profileRefererMap}">
			<div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
	        <h1>Profile viewers come from these sites</h1>
	        </div>
	        <br><h4>Total Views: ${views}</h4>
        	<br>
	        <div id="chart_div"></div>
	        </g:if>
        	<br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div> 
	        
        	<div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
	        <h1>Daily page views</h1>
	        </div>
	        <br>
	        <div id="chart_div2" style="float:left;width:700px;height:240px;"></div>
	        <br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div> 
	        
        	<g:if test="${tweetUrls}">
	        <div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
	        <h1>Twitter Feed Bookmarks</h1>
	        </div>
	        
	        <g:each in="${tweetUrls}" status="j" var="tweetInstance">
					<div class="update-separator">&nbsp;</div>
	                	<div style="float:left;width:150">  
	                		<a href="${tweetInstance.url}" target="_blank">${tweetInstance.url}</a>
	                 	</div>
	                    <br class="clear"/>
	                    <div style="float:left;width:150">  
	                		${tweetInstance.tweet}
	                 	</div>          		
	                    <br class="clear"/>    
	                    <div class="update-separator-grey">&nbsp;</div>    	
	                </g:each> 
	        
	        </g:if>
			<div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
			<h1>Categories</h1>
			</div>
			<br class="clear"/> 
			<div class="update-separator">&nbsp;</div>
			<!--<div class="update-separator-nobor">&nbsp;</div>-->

			<g:each in="${myCategories}" status="i" var="myCategory">
				<div style="float:left;width:100">
					<h3>${myCategory.name}</h3>
				</div>
				<br class="clear"/>
				
				<g:each in="${myCategory.tweets}" status="j" var="myTweets">
				<div class="update-separator">&nbsp;</div>
                	<div style="float:left;width:150">           	
                    	<a href="${myTweets.url}" target="_blank">${myTweets.url}</a>
                 	</div>
                            		
                    <br class="clear"/>        		
                    <div style="float:left;width:150">   
                    	<b>Description: </b>      	
                    	${myTweets.description}
                    </div>
                    <br class="clear"/>        	
                </g:each> 
                            
	            <div class="update-separator-grey">&nbsp;</div>
			</g:each>
			
			<!--<div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
			<h1>Posts</h1>
			</div>
			<br class="clear"/> 
			<div class="update-separator">&nbsp;</div>
			         
            <g:each in="${posts}" status="i" var="myPost">
            
                <g:def var="post" value="${myPost.post}"/>
                <g:def var="comments" value="${myPost.comments}"/>
                <g:def var="postVar" value="${post.id}"/>
                  
                <div style="float:left;width:150;font-size:10px" class="post">
                	<h4><g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${post.createTime}"/></h4> <h3>${post.description}</h3>
                </div>    
                <br class="clear"/>
                
                <div style="float:left;width:50">
                	
                	<div id="slidedown_demo2${postVar}" style="display:none; width:160px; height:90px; background:#ddffcc; float:left;width=350;">
                
                <div style="text-align:center;float:right;width:100;">
		  				<a href="#" class="smaller-secondary-action-link" onclick="$('slidedown_demo2${postVar}').hide(); return false;">
			            			Cancel
			            		</a>
		  				</div>
				  <div style="float:left;width=350;">
				    <g:form action="saveComment" controller="comment" method="post" >
				    <input type="hidden" id="contentId" name="contentId" value="${postVar}" />
                    <input type="hidden" id="contentType" name="contentType" value="Post" />
                    <div>
    				comment: 
    				</div>
    				<div>
    				<input type="text" id="comment" name="description" value=""/>
    				</div>
    				<div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
				    </g:form>
				  </div>
				</div>
				<br class="clear"/>
				<div>
				<ul>
				  <li><a href="#" onclick="Effect.SlideDown('slidedown_demo2${postVar}'); return false;">Add comment</a></li>
				</ul>
                </div>
                
                <br class="clear"/>
                    
                    
                <g:each in="${comments}" status="j" var="comment">
                    <div style="float:left;width:150" class="comment">
                    	<b><i>comment:</i></b> <g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${comment.createTime}"/> - ${comment.description} 
                    </div>
                	<div style="float:right;width:50">
                    	<g:if test="${session.userId==comment.userId}">
                    	<g:link class="smaller-secondary-action-link" action="deleteComment" controller="comment" params="[id: comment.id]">
                    		Remove Comment 
                    	</g:link>
                    	</g:if>
                    </div>
                    <br class="clear"/>
                </g:each>
            <div class="update-separator-grey">&nbsp;</div>    
            </g:each>-->
            
            <div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
			<h1>Blogs</h1>
			</div>
			<br class="clear"/> 
			<div class="update-separator">&nbsp;</div>
			<g:each in="${blogs}" status="i" var="blog">
				<div style="float:left;width:500;font-size:10px" class="post">
                	<h4><g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${blog.createTime}"/></h4><h3>${blog.title}</h3>
                	<br class="clear"/>
                	<div>
                	${blog.description}
                	</div>
                </div>   
                <br class="clear"/>
                <div class="update-separator-grey">&nbsp;</div>    
			</g:each> 
			<a href="#" onclick="Effect.ScrollTo('article_top'); return false;">Go to top.</a>
        </div>
        

		
        
	