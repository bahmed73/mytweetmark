<g:hasErrors bean="${usersInstance}">
            <div class="errors">
                <g:renderErrors bean="${usersInstance}" as="list" />
            </div>
            </g:hasErrors>

<div class="rounded" style="float:left;width:800px;">
			<div style="float:left;width:100px;">
			<h2>Settings</h2>
			</div>
			<br class="clear"/> 
			<div class="update-separator">&nbsp;</div>
			<div style="float:left;width:800px;">
			Please tell us something about yourself. 
			</div>
</div>
			<br class="clear"/> 
			<div class="update-separator">&nbsp;</div>
			
<g:form method="post" enctype="multipart/form-data">
<input type="hidden" name="id" value="${usersInstance?.id}" />
<div style="float:left;width:800px;">

<div style="float:left;width:200px" class="post"><h3>Profile Color:</h3></div><br>

<div style="float:left;width:30px;height:30px; background:#FFEFEF; border:1px solid #c5e2f8;color:#7cba53">
&nbsp;
</div>
<div style="float:left;width:40px;font-size:10px">
<g:radio name="color" value="FFEFEF"/><br>Red
</div>

<div style="float:left;width:30px;height:30px; background:#FFF0DF; border:1px solid #c5e2f8;color:#7cba53">
&nbsp;
</div>
<div style="float:left;width:40px;font-size:10px">
<g:radio name="color" value="FFF0DF"/><br>Orange
</div>

<div style="float:left;width:30px;height:30px; background:#FFFFDF; border:1px solid #c5e2f8;color:#7cba53">
&nbsp;
</div>
<div style="float:left;width:40px;font-size:10px">
<g:radio name="color" value="FFFFDF"/><br>Yellow
</div>

<div style="float:left;width:30px;height:30px; background:#EFFFF1; border:1px solid #c5e2f8;color:#7cba53">
&nbsp;
</div>
<div style="float:left;width:40px;font-size:10px">
<g:radio name="color" value="EFFFF1"/><br>Green
</div>

<div style="float:left;width:30px;height:30px; background:#EFEFEF; border:1px solid #c5e2f8;color:#7cba53">
&nbsp;
</div>
<div style="float:left;width:40px;font-size:10px">
<g:radio name="color" value="EFEFEF"/><br>Blue
</div>

<div style="float:left;width:30px;height:30px; background:#C2CAEF; border:1px solid #c5e2f8;color:#7cba53">
&nbsp;
</div>
<div style="float:left;width:40px;font-size:10px">
<g:radio name="color" value="C2CAEF"/><br>Big Blue
</div>

<div style="float:left;width:30px;height:30px; background:#E4C2EF; border:1px solid #c5e2f8;color:#7cba53">
&nbsp;
</div>
<div style="float:left;width:40px;font-size:10px">
<g:radio name="color" value="E4C2EF"/><br>Purple<br>
</div>

<div style="float:left;width:30px;height:30px; background:#FFFFFF; border:1px solid #c5e2f8;color:#7cba53">
&nbsp;
</div>
<div style="float:left;width:40px;font-size:10px">
<g:radio name="color" value="FFFFFF"/><br>White<br>
</div>

<br class="clear"/> 
<div class="update-separator">&nbsp;</div>

              <div style="float:left;width:200px" class="post"><h4>First Name:</h4>upto 50 characters.</div> 
              <div style="float:left;width:100px;">
              	<input maxlength="50" name="firstName" size="20" type="text" value="${fieldValue(bean:usersInstance,field:'firstName')}" />
                <br />
              </div>
            
<br class="clear"/> 
<div class="update-separator">&nbsp;</div>
              <div style="float:left;width:200px" class="post"><h4>Last Name:</h4>upto 50 characters.</div>
              <div style="float:left;width:100px;">
              	<input maxlength="50" name="lastName" size="20" type="text" value="${fieldValue(bean:usersInstance,field:'lastName')}" />
                <br />
              </div>
            <br class="clear"/> 
<div class="update-separator">&nbsp;</div>

<div style="float:left;width:200px" class="post"><h4>Business Name:</h4>upto 50 characters.</div> 
              <div style="float:left;width:100px;">
              	<input maxlength="50" name="businessName" size="20" type="text" value="${fieldValue(bean:usersInstance,field:'businessName')}" />
                <br />
              </div>
            
<br class="clear"/> 
<div class="update-separator">&nbsp;</div>

<div style="float:left;width:200px" class="post"><h4>Business Address:</h4>upto 100 characters.</div> 
              <div style="float:left;width:100px;">
              	<input maxlength="50" name="businessAddress" size="20" type="text" value="${fieldValue(bean:usersInstance,field:'businessAddress')}" />
                <br />
              </div>
            
<br class="clear"/> 
<div class="update-separator">&nbsp;</div>
              
<div style="float:left;width:200px" class="post"><h4>Business Phone:</h4>upto 50 characters.</div> 
              <div style="float:left;width:100px;">
              	<input maxlength="50" name="businessPhone" size="20" type="text" value="${fieldValue(bean:usersInstance,field:'businessPhone')}" />
                <br />
              </div>
            
<br class="clear"/> 
<div class="update-separator">&nbsp;</div>
              
              

              <div style="float:left;width:200px" class="post"><h4>Password:</h4>upto 100 characters.</div>
              
              <div style="float:left;width:100px;">
              	<input maxlength="100" name="password" size="20" type="password" value="${fieldValue(bean:usersInstance,field:'password')}" />
                <br />
              </div>
           <br class="clear"/> 
<div class="update-separator">&nbsp;</div>

              <div style="float:left;width:200px" class="post"><h4>Email:</h4>upto 100 characters.</div>
              
              <div style="float:left;width:100px;">
              	<input maxlength="100" name="email" size="20" type="text" value="${fieldValue(bean:usersInstance,field:'email')}" />
                <br />
              </div>
            <br class="clear"/> 
<div class="update-separator">&nbsp;</div>
            <div style="float:left;width:200px" class="post"><h4>Website:</h4>upto 2048 characters.</div>
              
              <div style="float:left;width:100px;">
              	<input maxlength="2048" name="website" size="20" type="text" value="${fieldValue(bean:usersInstance,field:'website')}" />
                <br />
              </div>
              <br class="clear"/> 
<div class="update-separator">&nbsp;</div>
              <div style="float:left;width:200px" class="post"><h4>Blog:</h4>upto 2048 characters.</div>
              
              <div style="float:left;width:100px;">
              	<input maxlength="2048" name="blog" size="20" type="text" value="${fieldValue(bean:usersInstance,field:'blog')}" />
                <br />
              </div>
              <br class="clear"/> 
<div class="update-separator">&nbsp;</div>
              <div style="float:left;width:200px" class="post"><h4>About Me:</h4>upto 150 characters.</div>
              
              <div style="float:left;width:100px;">
              <input id="eBann" name="aboutMe" value="${usersInstance?.aboutMe}" size="20" maxlength="150" onKeyUp="toCount('eBann','sBann','{CHAR} characters left',150);"/>
               
      			<br>
      			<span id="sBann" class="minitext">150 characters left.</span>	
                <br />
              </div>
              
              <br class="clear"/> 
<div class="update-separator">&nbsp;</div>
              
              <div style="float:left;width:200px" class="post"><h4>Member Level:</h4>We will contact you before billing for premium.</div>

<div style="float:left;width:50px;">
Free
</div>
<div style="float:left;width:50px;font-size:10px">
<g:radio name="memberLevel" value="0"/><br>
</div>

<div style="float:left;width:50px;">
Premium
</div>
<div style="float:left;width:50px;font-size:10px">
<g:radio name="memberLevel" value="1"/><br>
</div>

<br class="clear"/> 
<div class="update-separator">&nbsp;</div>

            <!--<div style="float:left;width:50" class="post"><h3>Upload Profile Image (JPG):</h3></div>
                                
                                <div>
                                    <input type="file" name="myFile" />
                                </div>-->
  <br class="clear"/> 
<div class="update-separator">&nbsp;</div>                 

            <div style="float:left;font-size:14px" class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                </div>
</div>          
</g:form>
