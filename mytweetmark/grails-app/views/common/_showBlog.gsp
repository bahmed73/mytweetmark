
<div style="background-color:#fff;text-align:left;margin:40px;width:900px;">
<div style="margin:20px;">              
              <g:if test="${user.profilePhoto}">
		        <div style="float:left;width:60px;">
		        <br>
		        <g:link url="/$user.userName"><img src="${user.profilePhoto}" width="48" height="48" class="profile_border"></g:link>    
		        </div>
		        <br class="clear"/>
		        
	        </g:if>
	        <div style="float:left;width:650px;">
	        	<h3><g:link url="/$user.userName">${user.userName}</g:link></h3>
	        	</div>
	        <br class="clear"/>
	        <br>
	        
	        <div class="fb-share-button" data-href="http://www.mytweetmark.com/blog/show/${blogInstance.id}" data-type="button"></div>
	        <br>
	        <br>
	        <a href="http://www.mytweetmark.com/blog/show/${blogInstance.id}" class="twitter-share-button" data-lang="en" data-count="none">Tweet</a>
			<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script> 
			<div class="update-separator-grey">&nbsp;</div>
				
			  <div style="float:left;text-align:center;">
              	<h1><span style="color:#000000">${blogInstance.title}</span></h1>
              	
              </div>
              <br class="clear"/>	
              
              <div style="float:left;font-size:16px;font-family:'Alegreya Sans', sans-serif;color:#000000;">
              	${blogInstance.description}
                <br />
              </div>
            	
              
	        <br class="clear"/> 
			<div class="update-separator-grey">&nbsp;</div>
			<div style="float:left;width:650px;">
	        <h2><g:link url="/$user.userName">Back to ${user.userName}</g:link></h2>
	        </div>
			<br class="clear"/> 
			<div class="update-separator-grey">&nbsp;</div>
			
	            <a href="#" onclick="Effect.ScrollTo('article_top'); return false;">Go to top.</a>
</div>          
</div>