
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
                
                <!--
            	<br>
                <div style="float:left;width:650px;font-size:14px;text-align:left;margin:10px;">
                <b>${myBlog.description}</b>
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
			<g:each in="${myCategories}" status="i" var="myCategory">
				<div style="float:left;width:200px;margin:10px;text-align:left;">
					<h4>${myCategory.name}</h4>
				</div>
				<g:each in="${myCategory.tweets}" status="j" var="myTweets">
				<div class="update-separator">&nbsp;</div>
                	<div style="float:left;width:650px;text-align:left;font-size:12px;margin:10px;">           	
                    	<a href="${myTweets.url}" target="_blank">${myTweets.url}</a>
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
			<br class="clear"/> 
				<div class="update-separator-grey">&nbsp;</div>
				
			<a href="#" onclick="Effect.ScrollTo('article_top'); return false;">Go to top.</a>
</div>