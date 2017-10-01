

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create FeatureToggle</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">FeatureToggle List</g:link></span>
        </div>
        <div class="body">
            <h1>Create FeatureToggle</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${featureToggleInstance}">
            <div class="errors">
                <g:renderErrors bean="${featureToggleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="createTime">Create Time:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:featureToggleInstance,field:'createTime','errors')}">
                                    <g:datePicker name="createTime" value="${featureToggleInstance?.createTime}" precision="minute" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status">Status:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:featureToggleInstance,field:'status','errors')}">
                                    <input type="text" id="status" name="status" value="${fieldValue(bean:featureToggleInstance,field:'status')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:featureToggleInstance,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:featureToggleInstance,field:'name')}"/>
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
