<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "alert">
        <#if messagesPerField.existsError('username','password')>
            <div class="alert alert-danger">
                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
            </div>
        </#if>
    <#elseif section = "form">
        <div class="row align-items-start">
            <div class="col-12 col-md-6">
                <h5>${msg("loginAccountTitle")}</h5>
                <form class="mt-4" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                      method="post">
                    <!-- Username -->

                    <div class="form-floating">
                        <#if usernameEditDisabled??>
                            <input tabindex="1" type="text"
                                   class="form-control<#if messagesPerField.existsError('username','password')> is-invalid</#if>"
                                   id="username" name="username"
                                   value="${(login.username!'')}" disabled>
                        <#else>
                            <input tabindex="1" type="text"
                                   class="form-control<#if messagesPerField.existsError('username','password')> is-invalid</#if>"
                                   id="username" name="username"
                                   value="${(login.username!'')}" autofocus placeholder="username">
                        </#if>
                        <label style="margin-bottom: 0"
                               for="username"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                        <#--                <div class="invalid-feedback">-->
                        <#--                    <#if messagesPerField.existsError('username','password')>-->
                        <#--                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}-->
                        <#--                    </#if>-->
                        <#--                </div>-->
                    </div>

                    <!-- Pw -->
                    <div class="form-floating mt-3">
                        <input tabindex="2" type="password"
                               class="form-control<#if messagesPerField.existsError('username','password')> is-invalid</#if>"
                               id="password" name="password"
                               autofocus placeholder="password">
                        <label for="password">${msg("password")}</label>
                        <#--                <div class="invalid-feedback">-->
                        <#--                    <#if messagesPerField.existsError('username','password')>-->
                        <#--                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}-->
                        <#--                    </#if>-->
                        <#--                </div>-->
                    </div>

                    <!-- Forgot pw -->
                    <#if realm.resetPasswordAllowed>
                        <p class="float-end m-0 mt-3"><a tabindex="5" class="text-decoration-none"
                                                         href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                        </p>
                    </#if>

                    <!-- Remember me -->
                    <#if realm.rememberMe && !usernameEditDisabled??>
                        <div class="form-check mt-3">
                            <#if login.rememberMe??>
                                <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe"
                                       checked>
                            <#else>
                                <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                            </#if>
                            <label class="form-check-label" for="rememberMe">
                                ${msg("rememberMe")}
                            </label>
                        </div>
                    </#if>

                    <input type="hidden" id="id-hidden-input" name="credentialId"
                           <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <button tabindex="4" type="submit" class="btn btn-primary mt-3 w-100">${msg("doLogIn")}</button>

                    <!-- Register -->
                    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                        <a href="${url.registrationUrl}" class="btn btn-secondary w-100 mt-2">${msg("doRegister")}</a>
                    </#if>
                </form>
            </div>
            <div class="col-12 col-md-6">
                <hr class="d-block d-md-none">
                <strong>Hinweise zum Extranet</strong>
                <p>Das BGHW Extranet ist ein Serviceportal für alle
                    Mitgliedsunternehmen der BGHW bzw. deren
                    Bevollmächtigten. Bitte verwenden Sie für den
                    Login die Unternehmensnummer (UNR.S) /
                    Mitgliedsnummer als Benutzername und das
                    schriftlich übersandte Extranet-Passwort.</p>
                <p>Bitte Groß- und Kleinschreibung beachten!</p>
                    <p>Bei technischen Problemen mit dem Extranet oder
                    Fragen zu Ihren Zugangsdaten nutzen Sie bitte das
                    Kontaktformular der Support-Anfrage:</p>
                <p>[link zum Supportformular in uvc.OZG]</p>
                    <p>Das Extranet der BGHW steht in der Zeit von 20.15
                    Uhr bis 21.00 Uhr wegen der täglichen
                    Datensicherung nur eingeschränkt zur Verfügung.</p>
            </div>
        </div>


        <!-- Social providers -->
        <#if realm.password && social.providers?? && (social.providers?size > 0)>
            <hr>
            <h4 class="mb-3">${msg("identity-provider-login-label")}</h4>

            <#list social.providers as p>
                <a id="social-${p.alias}" class="btn btn-light w-100"
                   type="button" href="${p.loginUrl}">
                    ${p.displayName!}
                </a>
            </#list>
        </#if>
    </#if>

</@layout.registrationLayout>
