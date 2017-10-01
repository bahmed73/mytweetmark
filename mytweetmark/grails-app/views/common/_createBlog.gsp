<div style="margin:40px;width:650px;float:left;">
<div class="rounded" style="float:left;">
			<h2>Create Blog</h2>
			</div>
			<br class="clear"/> 
			<div class="update-separator-grey">&nbsp;</div>
			
<g:form method="post" enctype="multipart/form-data">
<div style="float:left;">
              <div style="float:left;width:50" class="post"><h4>Title:</h4></div>
              upto 100 characters.<br>
			  <div style="margin-left:50px;">
              	<input maxlength="100" name="title" size="50" type="text" value="" />
                <br />
              </div>
            

              <div style="float:left;width:50" class="post"><h4>Description:</h4></div>
              upto 50000 characters.<br>
              <div style="margin-left:50px;">
              	<textarea name="description" cols=50 rows=6></textarea>
                <br />
              </div>

            <div style="float:left;font-size:14px" class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                </div>
          
</g:form>
</div>