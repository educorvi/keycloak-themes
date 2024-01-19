<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false displayWide=false showAnotherWayIfPresent=true>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
            "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="robots" content="noindex, nofollow">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title>${msg("loginTitle",(realm.displayName!''))}</title>
        <#if properties.favicon!=''>
            <link rel="icon" href="${url.resourcesPath}${properties.favicon}"/>
        </#if>
        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet"/>
            </#list>
        </#if>
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
            <#--
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            <script src="${url.resourcesPath}/${script}" type="module"></script>
            -->
                <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>
    </head>

    <body class="container pt-3">
    <div class="">
        <div id="kc-header" class="${properties.kcHeaderClass!}">
            <#-- <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</div> -->
        </div>
        <div class="${properties.kcFormCardClass!} <#if displayWide>${properties.kcFormCardAccountClass!}</#if>">
            <header class="${properties.kcFormHeaderClass!}">
                <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                    <div class="text-center mt-5 mb-4" id="loginTitleDiv">
                        <#if properties.logo != ''>
                                <img id="logoImg" src="${url.resourcesPath}${properties.logo}" class="rounded-3"
                                     style="max-width: 100%"/>
                        <#else>
                            <h1>${realm.displayName}</h1>
                        </#if>

                    </div>
                <#--                    <h2 class="text-center mt-4 mb-5">${(realm.displayName!'App Name')}</h2>-->
                <#--                    <h2 class="text-center mt-4 mb-5">${client.name}</h2>-->
                <#else>
                    <#if displayRequiredFields>
                        <div class="${properties.kcContentWrapperClass!}">
                            <div class="${properties.kcLabelWrapperClass!} subtitle">
                                <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                            </div>
                            <div class="col-md-10">
                                <#nested "show-username">
                                <div class="${properties.kcFormGroupClass!}">
                                    <div id="kc-username">
                                        <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                                        <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                            <div class="kc-login-tooltip">
                                                <i class="${properties.kcResetFlowIcon!}"></i>
                                                <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <#else>
                        <#nested "show-username">
                        <p class="text-center mt-5 mb-4">
                            <img src="${url.resourcesPath}/img/shield-color.svg" height="96" width="96"
                                 class="rounded-3"/>
                        </p>
                        <div class="row">
                            <div class="col-12 col-md-6 col-lg-4 offset-md-3 offset-lg-4 mb-4">
                                <a class="btn btn-secondary mt-3 w-100" role="button"
                                   href="${url.loginRestartFlowUrl}">${msg("restartLoginTooltip")}</a>
                            </div>
                        </div>


                    </#if>
                </#if>
            </header>
            <div class="row">
                <div class="col-md-2 col-lg-3"></div>
                <div class="col-12 col-md-8 col-lg-6">
                    <div id="kc-content" class="card">

                        <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                        <#-- during login.                                                                               -->
                        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                            <#if message.type = 'success'>
                                <div class="alert alert-success mb-2">
                                    ${kcSanitize(message.summary)?no_esc}
                                </div>
                            </#if>
                            <#if message.type = 'warning'>
                                <div class="alert alert-warning mb-2">
                                    ${kcSanitize(message.summary)?no_esc}
                                </div>
                            </#if>
                            <#if message.type = 'error'>
                                <div class="alert alert-danger mb-2">
                                    ${kcSanitize(message.summary)?no_esc}
                                </div>
                            </#if>
                            <#if message.type = 'info'>
                                <div class="alert alert-primary mb-2">
                                    ${kcSanitize(message.summary)?no_esc}
                                </div>
                            </#if>
                        </#if>

                        <#nested "alert">
                        <div id="kc-content-wrapper" class="card-body">
                            <div class="row">
                                <div class="col">
                                    <h5 style="margin-top: 6px; padding-top: 3px"><#nested "header"></h5>
                                </div>
                                <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                                    <div class="col" id="kc-locale">
                                        <div class="btn-group float-end">
                                            <button class="btn btn-outline-primary dropdown-toggle" type="button"
                                                    data-bs-toggle="dropdown" aria-expanded="false"
                                                    style="padding: 6px 12px;">
                                                ${locale.current}
                                            </button>

                                            <#--                                            <button type="button" class="btn btn-outline-primary dropdown-toggle"-->
                                            <#--                                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"-->
                                            <#--                                                    style="padding: 6px 12px;">-->

                                            </button>
                                            <ul class="dropdown-menu">
                                                <#list locale.supported as l>
                                                    <li><a class="dropdown-item" href="${l.url}">${l.label}</a></li>
                                                </#list>
                                            </ul>
                                        </div>


                                        <#--                                        <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">-->
                                        <#--                                            <div class="kc-dropdown dropdown show" id="kc-locale-dropdown">-->
                                        <#--                                                <a href="#" id="kc-current-locale-link"-->
                                        <#--                                                   class="btn btn-outline-primary dropdown-toggle"-->
                                        <#--                                                   role="button" id="dropdownMenuButton" data-toggle="dropdown"-->
                                        <#--                                                   aria-haspopup="true" aria-expanded="false">${locale.current}</a>-->
                                        <#--                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">-->
                                        <#--                                                    <#list locale.supported as l>-->
                                        <#--                                                        <a class="dropdown-item" href="${l.url}">${l.label}</a>-->
                                        <#--                                                    </#list>-->
                                        <#--                                                </div>-->
                                        <#--                                            </div>-->
                                        <#--                                        </div>-->
                                    </div>
                                </#if>
                            </div>

                            <#nested "form">

                            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post"
                                      <#if displayWide>class="${properties.kcContentWrapperClass!}"</#if>>
                                    <div <#if displayWide>class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}"</#if>>
                                        <div class="${properties.kcFormGroupClass!}">
                                            <input type="hidden" name="tryAnotherWay" value="on"/>
                                            <a class="btn btn-danger mt-3 w-100" role="button" href="#"
                                               onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                                        </div>
                                    </div>
                                </form>
                            </#if>

                            <#if displayInfo>
                                <#nested "info">
                            </#if>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-lg-3"></div>
            </div>

        </div>
    </div>
    </body>
    </html>
</#macro>
