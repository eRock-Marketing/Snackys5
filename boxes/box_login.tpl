{block name='boxes-box-login'}
{if $isMobile && $oBox->getPosition() == 'left'}
{else}
    <section id="sidebox{$oBox->getID()}" class="box box-login box-normal panel">
        {block name='boxes-box-login-title'}
            <div class="h5 panel-heading dpflex-a-c">
                {if empty($smarty.session.Kunde)}{lang key='login'}{else}{lang key='hello'} {$smarty.session.Kunde->cVorname} {$smarty.session.Kunde->cNachname|entferneFehlerzeichen}{/if}
                {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
            </div>
        {/block}
        {block name='boxes-box-login-content'}
            <div class="panel-body">
            {if empty($smarty.session.Kunde->kKunde)}
                {block name='boxes-box-login-form'}
                    {form action="{get_static_route id='jtl.php' secure=true}" method="post" class="form box_login jtl-validate" slide=true}
                        {block name='boxes-box-login-form-data'}
                            {input type="hidden" name="login" value="1"}
                            {include file='snippets/form_group_simple.tpl'
                                options=[
                                    'email', "email-box-login-{$oBox->getID()}", 'email', null,{lang key='emailadress'}, true, null, 'email', 'sm'
                                ]
                            }
                            {include file='snippets/form_group_simple.tpl'
                                options=[
                                    'password', "password-box-login-{$oBox->getID()}", 'passwort', null,
                                    {lang key='password' section='account data'}, true, null, 'current-password', 'sm'
                                ]
                            }
                        {/block}
                        {if isset($showLoginCaptcha) && $showLoginCaptcha}
                            {block name='boxes-box-login-form-captcha'}
                                {formgroup class="simple-captcha-wrapper"}
                                    {captchaMarkup getBody=true}
                                {/formgroup}
                            {/block}
                        {/if}
                        {block name='boxes-box-login-form-submit'}
                            {formgroup}
                                {if !empty($oRedirect->cURL)}
                                    {foreach $oRedirect->oParameter_arr as $oParameter}
                                        {input type="hidden" name=$oParameter->Name value=$oParameter->Wert}
                                    {/foreach}
                                    {input type="hidden" name="r" value=$oRedirect->nRedirect}
                                    {input type="hidden" name="cURL" value=$oRedirect->cURL}
                                {/if}
                                {button type="submit" name="speichern" value="1" variant="primary" block=true class="submit" size="sm"}
                                    {lang key='login' section='checkout'}
                                {/button}
                            {/formgroup}
                        {/block}
                        {block name='boxes-box-login-form-links'}
                            <small class="block mb-xs">
                            {link class="resetpw box-login-resetpw" href="{get_static_route id='pass.php' secure=true}"}
                                {lang key='forgotPassword'}
                            {/link}
                            </small>
                            <span class="block h5 mb-xxs">{lang key='newHere'}</span>
                            {link class="register btn btn-block btn-sm" href="{get_static_route id='registrieren.php'}"}
                                {lang key='registerNow'}
                            {/link}
                        {/block}
                    {/form}
                {/block}
            {else}
                {block name='boxes-box-login-actions'}
                <ul class="blanklist">
                    <li class="nav-it">
                        <a href="{get_static_route id='jtl.php' secure=true}" title="{lang key='myAccount'}" class="dpflex-a-c dpflex-j-b">
                            {lang key='myAccount'}
                            <span class="img-ct icon icon-wt">
                                <svg>
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-user"></use>
                                </svg>
                            </span>
                        </a>
                    </li>
                    <li class="nav-it">
                        <a href="{get_static_route id='jtl.php' params=['bestellungen' => 1]}" class="dpflex-a-c dpflex-j-b">
                            {lang key="orders" section="account data"}
                            <span class="img-ct icon icon icon-wt">
                                <svg>
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
                                </svg>
                            </span>
                        </a>
                    </li>
                    <li class="nav-it">
                        <a href="{get_static_route id='jtl.php' params=['editRechnungsadresse' => 1]}" class="dpflex-a-c dpflex-j-b">
                            {lang key="addresses" section="account data"}
                            <span class="img-ct icon icon icon-wt">
                                <svg>
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-house"></use>
                                </svg>
                            </span>
                        </a>
                    </li>
                    <li class="nav-it">
                    {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
                        <li class="nav-it">
                            <a href="{get_static_route id='jtl.php' params=['wllist' => 1]}" class="dpflex-a-c dpflex-j-b">
                                {lang key="wishlists" section="account data"}
                                <span class="img-ct icon icon icon-wt">
                                    <svg>
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-heart"></use>
                                    </svg>
                                </span>
                            </a>
                        </li>
                    {/if}
                    <li class="nav-it">
                        <a href="{get_static_route id='jtl.php' params=['bewertungen' => 1]}" class="dpflex-a-c dpflex-j-b">
                            {lang key='allRatings'}
                            <span class="img-ct icon icon icon-wt">
                                <svg>
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-reviews"></use>
                                </svg>
                            </span>
                        </a>
                    </li>
                </ul>
                <hr class="hr-sm invisible">
                 <a href="{get_static_route id='jtl.php' secure=true}?logout=1" title="{lang key='logOut'}" class="btn btn-block btn-sm">{lang key='logOut'}</a>
                {/block}
            {/if}
            </div>
        {/block}
    </section>
{/if}
{/block}