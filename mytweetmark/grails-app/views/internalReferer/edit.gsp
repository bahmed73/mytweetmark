

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit InternalReferer</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">InternalReferer List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New InternalReferer</g:link></span>
        </div>
        <div class="body">
            <h1>Edit InternalReferer</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${internalRefererInstance}">
            <div class="errors">
                <g:renderErrors bean="${internalRefererInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${internalRefererInstance?.id}" />
                <input type="hidden" name="version" value="${internalRefererInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="url">Url:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:internalRefererInstance,field:'url','errors')}">
                                    <input type="text" id="url" name="url" value="${fieldValue(bean:internalRefererInstance,field:'url')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createTime">Create Time:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:internalRefererInstance,field:'createTime','errors')}">
                                    <g:datePicker name="createTime" value="${internalRefererInstance?.createTime}" precision="minute" ></g:datePicker>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
