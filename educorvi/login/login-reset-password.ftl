<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <form id="kc-reset-password-form" class="${properties.kcFormClass!} mt-4" action="${url.loginAction}"
              method="post">
            <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                <div class="${properties.kcFormOptionsWrapperClass!}">
                    <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                </div>
            </div>
            <div class="form-floating mt-3">
                <input type="text" id="username" name="username"
                       class="form-control<#if messagesPerField.existsError('username')> is-invalid</#if>" autofocus
<#--                       value="${(auth.attemptedUsername!'')}"-->
                       aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                <label for="username"
                       class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                <div class="invalid-feedback">
                    <#if messagesPerField.existsError('username')>
                        ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                    </#if>
                </div>
            </div>
            <input class="btn btn-primary mt-3 w-100" type="submit" value="${msg("doSubmit")}"/>
        </form>
    <#elseif section = "info" >
        <div class="alert alert-info mt-4" role="alert">
            <#if realm.duplicateEmailsAllowed>
                ${msg("emailInstructionUsername")}
            <#else>
                ${msg("emailInstruction")}
            </#if>
        </div>

    </#if>
</@layout.registrationLayout>
