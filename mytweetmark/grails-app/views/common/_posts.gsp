<g:javascript library="scriptaculous" />    
<div class="body">

	<div style="float:left;width:700px; height:45px; background:#c5e2f8; border:1px solid #ddffcc;">
		<h1>Community Posts</h1> 
		<div class="comment">
		<!--<b>New to mytweetmark?  Click profile on top right, create some content and share :)</b>-->
		</div>
	</div>
	<br class="clear"/>
	<div class="update-separator-grey">&nbsp;</div>
	<br class="clear"/>
	<div class="paginateButtons">
                <g:paginate total="${postInstanceTotal}" />
            </div>  
    <br class="clear"/>
<div class="update-separator-grey">&nbsp;</div>
	
	<div class="list">
		<g:each in="${postInstanceList}" status="i" var="postInstance">
			<g:def var="post" value="${postInstance.post}"/>
        	<g:def var="user" value="${postInstance.user}"/>
        	<g:def var="comments" value="${postInstance.comments}"/>
        	<g:def var="postVar" value="${post.id}"/>
        	
        	<div style="float:left;width:50">
        		<g:link url="/$user.userName">
        		<img src="${user.profilePhoto}" width="48" height="48"> 
            	</g:link>
        	</div>
        	<div style="float:left;width:150" class="post">
        		<b>post by <g:link url="/$user.userName">${user.userName}</g:link>: </b> <g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${postInstance.post.createTime}"/> - ${postInstance.post.description}
        	</div>
        	
        	<div style="float:right;width:50">
        		<g:if test="${session.userId==post.userId}">
                	<!--<g:link action="deleteMyPost" controller="post" params="[id: post.id]">
                		<img src="${createLinkTo(dir:'images', file:'Forbiden.png')}" width="15" height="15" title="Remove Post"/>
                	</g:link>-->
                	<g:link action="deleteMyPost" controller="post" params="[id: post.id]">
                		Remove Post 
                	</g:link>
            	</g:if>
        	</div>
        	<br class="clear"/>
        	
        	<div style="float:left;width:50">
        		
            	<!--<g:link action="create" controller="comment" params="[contentId: post.id]">
            		Add comment
            	</g:link>-->
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
        	</div>
        	<br class="clear"/>
        	
        	<g:each in="${comments}" status="j" var="comment">
            	<div style="float:left;width:150" class="comment">
                	<b><i>comment:</i></b> <g:formatDate format="yyyy-MM-dd hh:mm:ss" date="${comment.createTime}"/> - ${comment.description} 
                </div>
                <div style="float:right;width:50">
                	<g:if test="${session.userId==comment.userId}">
	                	<!--<g:link action="deleteComment" controller="comment" params="[id: comment.id]">
	                		<img src="${createLinkTo(dir:'images', file:'Stop.png')}" width="10" height="10" title="Remove Comment"/>
	                	</g:link>-->
	                	<g:link action="deleteComment" controller="comment" params="[id: comment.id]">
	                		Remove Comment 
	                	</g:link>
                	</g:if>
                </div>
             	<br class="clear"/>   
             </g:each>
                        
        	<div class="update-separator-grey">&nbsp;</div> 
		</g:each>
     </div>
     <br class="clear"/>
     <div class="paginateButtons">
                <g:paginate total="${postInstanceTotal}" />
            </div>  
            <br class="clear"/>
</div>