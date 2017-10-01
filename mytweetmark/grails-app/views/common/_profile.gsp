<div style="float:left;width:680px;margin-left:20px;">
<g:if test="${!blogs}">
	<div style="float:left;width:200px;margin:10px;text-align:left;font-size:16px;">
			<h2>My Blogs</h2> 
			</div>
</g:if>			
			<div class="update-separator">&nbsp;</div>
			<br class="clear"/>
            <g:each in="${blogs}" status="i" var="myBlog">
            
                 
                <div style="float:left;width:650px;font-size:10px;text-align:left;margin:10px;">
                <h3><g:link action="show" controller="blog" id="${myBlog.id}">${myBlog.title}</g:link></h3>
                <g:formatDate type="datetime" style="MEDIUM" date="${myBlog.createTime}"/> 
                </div>    
                <div style="float:right;width:50">
                	<g:link class="smaller-secondary-action-link" action="deleteMyBlog" controller="blog" id="${myBlog.id}">
                		<img border="0" src="${createLinkTo(dir:'images', file:'RemoveButton.png')}" title="Remove Blog"/>
                	</g:link>
                </div>
                <div style="float:right;width:50">
            	<g:link class="smaller-secondary-action-link" action="edit" controller="blog" id="${myBlog.id}">
            		<img border="0" src="${createLinkTo(dir:'images', file:'EditButton.png')}" title="Edit Blog"/>
            	</g:link>
            	</div>
            
				<!--            
            	<br>
                <div style="float:left;width:650px;font-size:14px;text-align:left;margin:10px;">
                Description: <b>${myBlog.description}</b>
                </div>
                -->
                
                
                <br class="clear"/>
                    
                    
                
            <div class="update-separator-grey">&nbsp;</div>    
            </g:each>
            
            <!--
			<div style="float:left;width:400px;margin:10px;text-align:left;font-size:16px;">
			<h3>My Business Categories on Twitter</h3> 
			</div>
			<div class="update-separator">&nbsp;</div>
			<br class="clear"/>
			<div class="rounded" id="slidedown_demo" style="display:none; width:240px; height:100px; background:#f6f7f8; text-align:left;float:right;border:1px solid #c5e2f8;" class="topic">
            	<div style="text-align:center;float:right;width:100;">
  				<a href="#" class="secondary-action-link" onclick="$('slidedown_demo').hide(); return false;">
	            			Cancel
	            		</a>
  				</div>
				<div style="float:left;width:350;">
					<g:form action="saveMyCategory" controller="myCategory" method="post" >
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
					<a href="#" onclick="Effect.SlideDown('slidedown_demo'); return false;">Enter business category here &raquo;</a>
		  			
				
            </div>
            
            <br class="clear"/>
            <div class="update-separator-grey">&nbsp;</div>
            
			<g:each in="${myCategories}" status="i" var="myCategory">
				<div style="float:left;width:200px;margin:10px;text-align:left;">
					<h4>${myCategory.name}</h4>
				</div>
				
				<div style="float:right;width:50">
					<g:def var="categoryVar" value="${myCategory.categoryId}"/>
	                            
	            	
	            	<g:link class="smaller-secondary-action-link" action="deleteMyCategory" controller="myCategory" params="[categoryId: categoryVar]">
	            		Remove Category
	            	</g:link>
				</div>
				<br class="clear"/>
				
				<div style="float:left;width:50">
					
	            	
					<div class="rounded" id="grow_demo${categoryVar}" style="display:none; width:240px; height:180px; background:#f6f7f8;float:right;border:1px solid #c5e2f8;text-align:left;">
						<div style="text-align:center;float:right;width:100;">
		  				<a href="#" class="secondary-action-link" onclick="$('grow_demo${categoryVar}').hide(); return false;">
			            			Cancel
			            		</a>
		  				</div>
						<div style="float:left;width:350px;">
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
					  <a href="#" onclick="Effect.Grow('grow_demo${categoryVar}'); return false;">Enter New Business Link</a>
					</div>
				</div>
				
				
				<br class="clear"/>
				
				<g:each in="${myCategory.tweets}" status="j" var="myTweets">
				<div class="update-separator">&nbsp;</div>
                	<div style="float:left;width:500px;text-align:left;font-size:12px;margin:10px;">           	
                    	<a href="${myTweets.url}" target="_blank">${myTweets.url}</a>
                 	</div>
                    <div style="float:right;width:100px;">
	                    <g:def var="category2Var" value="${myTweets.categoryId}"/>
	            		<g:def var="myTweetVar" value="${myTweets.id}"/>
	            		<g:link class="smaller-secondary-action-link" action="deleteMyTweetMark" controller="myTweetMark" params="[categoryId: category2Var, id: myTweetVar]">
	            			Remove Link
	            		</g:link>
                    </div>             		
                    <br class="clear"/>        		
                    <div style="float:left;width:650px;text-align:left;font-size:14px;margin:10px;">   
                    	Description:       	
                    	<b>${myTweets.description}</b>
                    </div>
                    
                    <br class="clear"/>        	
                </g:each> 
                <br class="clear"/> 
				<div class="update-separator-grey">&nbsp;</div>
			</g:each>
			-->
			<a href="#" onclick="Effect.ScrollTo('article_top'); return false;">Go to top.</a>
</div>

