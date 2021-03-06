

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create Views</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Views List</g:link></span>
        </div>
        <div class="body">
            <h1>Create Views</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${viewsInstance}">
            <div class="errors">
                <g:renderErrors bean="${viewsInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="num">Num:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:viewsInstance,field:'num','errors')}">
                                    <input type="text" id="num" name="num" value="${fieldValue(bean:viewsInstance,field:'num')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createTime">Create Time:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:viewsInstance,field:'createTime','errors')}">
                                    <g:datePicker name="createTime" value="${viewsInstance?.createTime}" precision="minute" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="userId">User Id:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:viewsInstance,field:'userId','errors')}">
                                    <input type="text" id="userId" name="userId" value="${fieldValue(bean:viewsInstance,field:'userId')}" />
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
