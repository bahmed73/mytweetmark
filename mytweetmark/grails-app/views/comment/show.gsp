

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Comment</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Comment List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Comment</g:link></span>
        </div>
        <div class="body">
            <h1>Show Comment</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:commentInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">User Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:commentInstance, field:'userId')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Status:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:commentInstance, field:'status')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Create Time:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:commentInstance, field:'createTime')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Content Type:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:commentInstance, field:'contentType')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Update Time:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:commentInstance, field:'updateTime')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Content Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:commentInstance, field:'contentId')}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${commentInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>