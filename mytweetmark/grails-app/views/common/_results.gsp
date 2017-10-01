
        <div class="list">
            
            <br class="clear"/> 
			<div class="update-separator">&nbsp;</div>
			
            <div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
			<h1>My Categories</h1>
			</div>
			
            <div id="slidedown_demo" style="display:none; width:130px; height:80px; background:#ddffcc; text-align:center;float:right;width:350;" class="topic">
	            <div style="text-align:center;float:right;width:100;">
	  				<a href="#" class="secondary-action-link" onclick="$('slidedown_demo').hide(); return false;">
		            			Cancel
		            		</a>
	  				</div>
  				<div style="float:right;width=350;">
    				<g:form action="saveMyCategory" controller="myCategory" method="post" >
    				<!--<div class="post">
    				Category:
    				</div>-->
    				<div>
    				<g:select optionKey="id" optionValue="name" name="categoryId" from="${categories}" value="${categoryId}"/>
    				</div>
    				<div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                	</div>
    				</g:form>
  				</div>
  				
			</div>
			<br class="clear"/>
			<div class="update-separator">&nbsp;</div>
			
			<div style="float:left;" class="topic">
				<ul>
		  			<li><a href="#" onclick="Effect.SlideDown('slidedown_demo'); return false;"><img src="${createLinkTo(dir:'images', file:'newcategory.gif')}" title="Add Category"/></a></li>
		  			<!--<li><a href="#" onclick="$('slidedown_demo').hide(); return false;">Cancel</a></li>-->
				</ul>
            </div>
            <!--
            <div style="float:right;width:50" class="topic">
                        	<g:link url="[action:'create',controller:'myCategory']">
                        	<b>Add New Category</b>
                        	</g:link>
            </div>-->
            
            <br class="clear"/>
            
			
			<!--<div class="update-separator-nobor">&nbsp;</div>-->

			<g:each in="${myCategories}" status="i" var="myCategory">
				<div style="float:left;width:100">
					<h3>${myCategory.name}</h3>
				</div>
				<div style="float:right;width:50">
					<g:def var="categoryVar" value="${myCategory.categoryId}"/>
	                            
	            	<!--<g:link action="deleteMyCategory" controller="myCategory" params="[categoryId: categoryVar]">
	            		<img src="${createLinkTo(dir:'images', file:'OverlayRemove.png')}" width="15" height="15" title="Remove Category"/>
	            	</g:link>-->
	            	<g:link class="smaller-secondary-action-link" action="deleteMyCategory" controller="myCategory" params="[categoryId: categoryVar]">
	            		Remove Category
	            	</g:link>
				</div>
				<br class="clear"/>
				
				<div style="float:left;width:50">
					<!--
	            	<g:link class="secondary-action-link" action="create" controller="myTweetMark" params="[categoryId: categoryVar]">
	            		Add New myTweetMark
	            	</g:link>
	            	-->
	            	
					<div id="grow_demo${categoryVar}" style="display:none; width:160px; height:120px; background:#ddffcc;float:left;width=350;">
						<div style="text-align:center;float:right;width:100;">
		  				<a href="#" class="secondary-action-link" onclick="$('grow_demo${categoryVar}').hide(); return false;">
			            			Cancel
			            		</a>
		  				</div>
						<div style="float:left;width=350;">
		    				<g:form action="saveMyTweetMark" method="post" >
		    				<input type="hidden" id="categoryId" name="categoryId" value="${categoryVar}" />
		    				<div>
		    				url: 
		    				</div>
		    				<div>
		    				<input type="text" id="url" name="url" value=""/>
		    				</div>
		    				<div>
		    				description: 
		    				</div>
		    				<div>
		    				<input type="text" id="description2" name="description" value=""/>
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
					  <li><a href="#" onclick="Effect.Grow('grow_demo${categoryVar}'); return false;"><img src="${createLinkTo(dir:'images', file:'newbookmark.gif')}" title="Add Bookmark"/></a></li>
					</ul>
	            	</div>
				</div>
				
				
				<br class="clear"/>
				<g:each in="${myCategory.tweets}" status="j" var="myTweets">
				<div class="update-separator">&nbsp;</div>
                	<div style="float:left;width:150">           	
                    	<a href="${myTweets.url}" target="_blank">${myTweets.url}</a>
                 	</div>
                    <div style="float:right;width:50">
	                    <g:def var="category2Var" value="${myTweets.categoryId}"/>
	            		<g:def var="myTweetVar" value="${myTweets.id}"/>
	            		<!--<g:link action="deleteMyTweetMark" controller="myTweetMark" params="[categoryId: category2Var, id: myTweetVar]">
	            			<img src="${createLinkTo(dir:'images', file:'Remove.png')}" width="10" height="10" title="Remove myTweetMark"/>
	            		</g:link>-->
	            		<g:link class="smaller-secondary-action-link" action="deleteMyTweetMark" controller="myTweetMark" params="[categoryId: category2Var, id: myTweetVar]">
	            			Remove bookmark
	            		</g:link>
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
			
			<br class="clear"/> 
			<div class="update-separator">&nbsp;</div>
			
			<!--
			<div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
			<h1>My Posts</h1> 
			</div>
			
			<br class="clear"/>
			<div class="update-separator">&nbsp;</div>
			
			<div style="float:left;width:350px;height:40px; background:#ddffcc; border:1px solid #c5e2f8;" class="topic">
                 			<mytweetmark:postEditInPlace id="description"
                 			url="[controller: 'post', action: 'saveMyPost']"
                 			rows="1"
                 			cols="45"
                 			paramName="description">Click here to add new post</mytweetmark:postEditInPlace>
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
                <div style="float:right;width:50">
                	<g:link class="smaller-secondary-action-link" action="deleteMyPost" controller="post" params="[id: postVar]">
                		Remove Post 
                	</g:link>
                </div>
                <br class="clear"/>
                
                <div id="slidedown_demo2${postVar}" style="display:none; width:160px; height:90px; background:#ddffcc; float:left;width=350;">
                
                <div style="text-align:center;float:right;width:100;">
		  				<a href="#" class="secondary-action-link" onclick="$('slidedown_demo2${postVar}').hide(); return false;">
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
            </g:each>
            
            <br class="clear"/>
			<div class="update-separator">&nbsp;</div>-->
			
			<div style="float:left;width:700px; height:30px; background:#c5e2f8; border:1px solid #ddffcc;">
			<h1>My Blogs</h1>
			</div>
			
			<div id="appear_demo" style="display:none; width:590px; height:340px; background:#ddffcc; text-align:center;float:left;" class="topic">
	            <div style="text-align:center;float:left;width:100;">
	  				<a href="#" class="secondary-action-link" onclick="$('appear_demo').hide(); return false;">
		            			Cancel
		            		</a>
	  				</div>
  				<div style="float:left;width:500px;">
    				<g:form action="saveMyBlog" controller="blog" method="post" >
    				
    				<div>
    				title: 
    				</div>
    				<div>
    				<input type="text" id="title" name="title" value=""/>
    				</div>
    				<div>
    				<textarea id="blog" name="description" rows="14" cols="58"></textarea>
    				</div>
    				<div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
    				</g:form>
  				</div>
  				
			</div>
			
			<br class="clear"/>
			<div class="update-separator">&nbsp;</div>
			
			<div style="float:left; border:1px solid #c5e2f8;" class="topic">
				<ul>
		  			<li><a href="#" onclick="Effect.Appear('appear_demo'); return false;"><img src="${createLinkTo(dir:'images', file:'newblog.gif')}" title="Add Blog"/></a></li>

				</ul>
            </div>
            
            
			<br class="clear"/> 
			<g:each in="${blogs}" status="i" var="blog">
				<g:def var="blogVar" value="${blog.id}"/>
				<div style="float:left;width:500;font-size:10px" class="post">
                	<h4><g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${blog.createTime}"/></h4><h3>${blog.title}</h3>
                	<div style="float:right;width:50">
                	<g:link class="smaller-secondary-action-link" action="deleteMyBlog" controller="blog" params="[id: blogVar]">
                		Remove Blog 
                	</g:link>
                </div>
                	<br class="clear"/>
                	<div style="font-size:9px">
                	${blog.description}
                	</div>
                </div>
                <br class="clear"/>
                <div class="update-separator-grey">&nbsp;</div>       
			</g:each>
			<a href="#" onclick="Effect.ScrollTo('article_top'); return false;">Go to top.</a>
        </div>
