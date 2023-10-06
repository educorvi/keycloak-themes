<#import "template.ftl" as layout>
<#import "register-commons.ftl" as registerCommons>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm','termsAccepted'); section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
            <div class="${properties.kcFormOptionsWrapperClass!}">
                <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
            </div>
        </div>
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
            <#--            First Name -->
            <div class="form-floating mt-3">
                <input type="text" id="firstName"
                       class="form-control <#if messagesPerField.existsError('firstName')> is-invalid</#if>"
                       name="firstName"
                       value="${(register.formData.firstName!'')}"
                       aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
                       autofocus
                       placeholder="${msg("firstName")}"
                />
                <label for="firstName">${msg("firstName")}</label>
                <div class="invalid-feedback">
                    ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                </div>
            </div>

            <#--            Last Name -->
            <div class="form-floating mt-3">
                <input type="text" id="lastName"
                       class="form-control <#if messagesPerField.existsError('lastName')> is-invalid</#if>"
                       name="lastName"
                       value="${(register.formData.lastName!'')}"
                       aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
                       autofocus
                       placeholder="${msg("lastName")}"
                />
                <label for="lastName">${msg("lastName")}</label>
                <div class="invalid-feedback">
                    ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                </div>
            </div>


            <#--            Email -->
            <div class="form-floating mt-3">
                <input type="email" id="email"
                       class="form-control <#if messagesPerField.existsError('email')>is-invalid</#if>" name="email"
                       value="${(register.formData.email!'')}" autocomplete="email"
                       aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                       placeholder="${msg("email")}"
                />
                <label for="email">${msg("email")}</label>
                <div class="invalid-feedback">
                    ${kcSanitize(messagesPerField.get('email'))?no_esc}
                </div>
            </div>

            <#--            Username-->
            <#if !realm.registrationEmailAsUsername>
                <div class="form-floating mt-3">
                    <input type="text" id="username"
                           class="form-control <#if messagesPerField.existsError('username')>is-invalid</#if>"
                           name="username"
                           value="${(register.formData.username!'')}" autocomplete="username"
                           aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                           placeholder="${msg("username")}"
                    />
                    <label for="username">${msg("username")}</label>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.get('username'))?no_esc}
                    </div>
                </div>
            </#if>

            <#if passwordRequired??>
                <div class="form-floating mt-3">
                    <input type="password" id="password"
                           class="form-control <#if messagesPerField.existsError('password','password-confirm')>is-invalid</#if>"
                           name="password"
                           autocomplete="new-password"
                           aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                           placeholder="${msg("password")}"
                    />
                    <label for="password">${msg("password")}</label>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.get('password'))?no_esc}
                    </div>
                </div>
                <div class="form-floating mt-3">
                    <input type="password" id="password-confirm"
                           class="form-control <#if messagesPerField.existsError('password','password-confirm')>is-invalid</#if>"
                           name="password-confirm"
                           aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                           placeholder="${msg("password-confirm")}"
                    />
                    <label for="password-confirm">${msg("passwordConfirm")}</label>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                    </div>
                </div>
            </#if>

            <@registerCommons.termsAcceptance/>

            <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
            </#if>

            <div class="${properties.kcFormGroupClass!}">

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input class="btn btn-primary mt-3 w-100"
                           type="submit" value="${msg("doRegister")}"/>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
