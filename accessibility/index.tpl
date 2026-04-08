{block name='accessibility-index'}
    {block name='accessibility-index-include-header'}
        {include file='layout/header.tpl'}
    {/block}

    {block name='accessibility-index-content'}
        {if !empty($Link->getTitle())}
            {block name='accessibility-index-heading'}
                {opcMountPoint id='opc_before_heading' inContainer=false}
                {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                    <div class="title h1">
                        {$Link->getTitle()}
                    </div>
                {/container}
            {/block}
        {/if}

        {block name='accessibility-index-include-extension'}
            {include file='snippets/extension.tpl'}
        {/block}
        {if isset($step)}
            {container fluid=$Link->getIsFluid() class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            {opcMountPoint id='opc_before_form'}
            {if !empty($Link->getContent())}
                {block name='accessibility-index-custom-content-top'}
                    <div class="custom_content mb-8">
                        {$Link->getContent()}
                    </div>
                {/block}
            {/if}

            {if !empty($fehlendeAngaben)}
                {block name='accessibility-index-alert'}
                    {alert variant="danger" dismissible=true}
                    {lang key='fillOut'}
                    {/alert}
                {/block}
            {/if}
            {block name='accessibility-index-form'}
                {form name="contact"
                action="{get_static_route id='accessibility.php'}"
                method="post"
                class="contact-form jtl-validate panel mt-sm"
                addhoneypot=true
                slide=true}
                {block name='accessibility-index-form-content'}
                    <div class="required-info">{lang key='requiredInfo'}</div>
                    <hr>
                    {block name='accessibility-index-fieldset-contact'}
                        {row tag='fieldset' class="{if !empty($Link->getContent())}is-top{/if}"}
                        {col cols=12}
                        {block name='accessibility-index-legend-contact'}
                            <div class="h3">{lang key='contact'}</div>
                        {/block}
                        {/col}
                        {col cols=12}
                        {block name='accessibility-index-salution'}
                            {row}
                            {if $Einstellungen.kontakt.kontakt_abfragen_anrede !== 'N'}
                                {col cols=12 md=6}
                                {formgroup
                                label="{lang key='salutation' section='account data'}{if $Einstellungen.kontakt.kontakt_abfragen_anrede === 'O'}<span class='optional'> - {lang key='optional'}</span>{/if}"
                                label-for="salutation"
                                }
                                {select name="anrede" id="salutation" class='custom-select' required=($Einstellungen.kontakt.kontakt_abfragen_anrede === 'Y')}
                                    <option value="" selected="selected"
                                            {if $Einstellungen.kontakt.kontakt_abfragen_anrede === 'Y'}disabled{/if}>
                                        {if $Einstellungen.kontakt.kontakt_abfragen_anrede === 'Y'}{lang key='salutation' section='account data'}{else}{lang key='noSalutation'}{/if}
                                    </option>
                                    <option value="w"{if isset($Vorgaben->cAnrede) && $Vorgaben->cAnrede === 'w'} selected="selected"{/if}>{lang key='salutationW'}</option>
                                    <option value="m"{if isset($Vorgaben->cAnrede) && $Vorgaben->cAnrede === 'm'} selected="selected"{/if}>{lang key='salutationM'}</option>
                                {/select}
                                {/formgroup}
                                {/col}
                            {/if}
                            {/row}
                        {/block}
                        {if $Einstellungen.kontakt.kontakt_abfragen_vorname !== 'N' || $Einstellungen.kontakt.kontakt_abfragen_nachname !== 'N'}
                            {block name='accessibility-index-name'}
                                {row}
                                {if $Einstellungen.kontakt.kontakt_abfragen_vorname !== 'N'}
                                    {col cols=12 md=6}
                                    {block name='accessibility-index-name-firstname'}
                                        {include file='snippets/form_group_simple.tpl' options=["text", "firstName", "vorname", {$Vorgaben->cVorname}, {lang key='firstName' section='account data'}, {$Einstellungen.kontakt.kontakt_abfragen_vorname}]}
                                    {/block}
                                    {/col}
                                {/if}
                                {if $Einstellungen.kontakt.kontakt_abfragen_nachname !== 'N'}
                                    {col cols=12 md=6}
                                    {assign var=invalidReason value=null}
                                    {if isset($fehlendeAngaben.nachname)}
                                        {if $fehlendeAngaben.nachname == 1}
                                            {lang assign='invalidReason' key='fillOut'}
                                        {elseif $fehlendeAngaben.nachname == 2}
                                            {lang assign='invalidReason' key='lastNameNotNumeric' section='account data'}
                                        {/if}
                                    {/if}
                                    {block name='accessibility-index-name-last-name'}
                                        {include file='snippets/form_group_simple.tpl' options=['text' , 'lastName', 'nachname', {$Vorgaben->cNachname}, {lang key='lastName' section='account data'}, {$Einstellungen.kontakt.kontakt_abfragen_nachname}, {$invalidReason}]}
                                    {/block}
                                    {/col}
                                {/if}
                                {/row}
                            {/block}
                        {/if}

                        {if $Einstellungen.kontakt.kontakt_abfragen_firma !== 'N'}
                            {block name='accessibility-index-company'}
                                {row}
                                {col cols=12 md=6}
                                    {include file='snippets/form_group_simple.tpl' options=[ 'text' , 'firm', 'firma', {$Vorgaben->cFirma}, {lang key='firm' section='account data'}, {$Einstellungen.kontakt.kontakt_abfragen_firma}]}
                                {/col}
                                {/row}
                            {/block}
                        {/if}
                        {block name='accessibility-index-mail'}
                            {row}
                            {col cols=12}
                            {assign var=invalidReason value=null}
                            {if isset($fehlendeAngaben.email)}
                                {if $fehlendeAngaben.email == 1}{lang assign='invalidReason' key='fillOut'}
                                {elseif $fehlendeAngaben.email == 2}{lang assign='invalidReason' key='invalidEmail'}
                                {elseif $fehlendeAngaben.email == 3}{lang assign='invalidReason' key='blockedEmail'}
                                {elseif $fehlendeAngaben.email == 4}{lang assign='invalidReason' key='noDnsEmail' section='account data'}
                                {elseif $fehlendeAngaben.email == 5}{lang assign='invalidReason' key='emailNotAvailable' section='account data'}{/if}
                            {/if}
                                {include file='snippets/form_group_simple.tpl' options=['email' , 'email', 'email', {$Vorgaben->cMail}, {lang key='email' section='account data'}, true, {$invalidReason}]}
                            {/col}
                            {/row}
                        {/block}
                        {if $Einstellungen.kontakt.kontakt_abfragen_tel !== 'N' || $Einstellungen.kontakt.kontakt_abfragen_mobil !== 'N'}
                            {block name='accessibility-index-phone-mobile'}
                                {row}
                                {if $Einstellungen.kontakt.kontakt_abfragen_tel !== 'N'}
                                    {col cols=12 md=6}
                                    {assign var=invalidReason value=null}
                                    {if isset($fehlendeAngaben.tel) && $fehlendeAngaben.tel === 1}{lang assign='invalidReason' key='fillOut'}{elseif isset($fehlendeAngaben.tel) && $fehlendeAngaben.tel === 2}{lang assign='invalidReason' key='invalidTel'}{/if}
                                    {block name='accessibility-index-tel'}
                                        {include file='snippets/form_group_simple.tpl' options=['tel' , 'tel', 'tel', {$Vorgaben->cTel}, {lang key='tel' section='account data'}, {$Einstellungen.kontakt.kontakt_abfragen_tel}, {$invalidReason}]}
                                    {/block}
                                    {/col}
                                {/if}
                                {if $Einstellungen.kontakt.kontakt_abfragen_mobil !== 'N'}
                                    {col cols=12 md=6}
                                    {assign var=invalidReason value=null}
                                    {if isset($fehlendeAngaben.mobil) && $fehlendeAngaben.mobil === 1}{lang assign='invalidReason' key='fillOut'}{elseif isset($fehlendeAngaben.mobil) && $fehlendeAngaben.mobil === 2}{lang assign='invalidReason' key='invalidTel'}{/if}
                                    {block name='accessibility-index-mobile'}
                                        {include file='snippets/form_group_simple.tpl' options=['tel' , 'mobile', 'mobil', {$Vorgaben->cMobil}, {lang key='mobile' section='account data'}, {$Einstellungen.kontakt.kontakt_abfragen_mobil}, {$invalidReason}]}
                                    {/block}
                                    {/col}
                                {/if}
                                {/row}
                            {/block}
                        {/if}

                        {if $Einstellungen.kontakt.kontakt_abfragen_fax !== 'N'}
                            {block name='accessibility-index-fax'}
                                {row}
                                {col cols=12 md=6}
                                {assign var=invalidReason value=null}
                                {if !empty($fehlendeAngaben.fax) && $fehlendeAngaben.fax === 1}{lang assign='invalidReason' key='fillOut'}{elseif isset($fehlendeAngaben.fax) && $fehlendeAngaben.fax === 2}{lang assign='invalidReason' key='invalidTel'}{/if}
                                    {include file='snippets/form_group_simple.tpl' options=['tel' , 'fax', 'fax', {$Vorgaben->cFax}, {lang key='fax' section='account data'}, {$Einstellungen.kontakt.kontakt_abfragen_fax}, {$invalidReason}]}
                                {/col}
                                {/row}
                            {/block}
                        {/if}
                        {assign var=cPost_arr value=$cPost_arr|default:[]}
                        {block name='accessibility-index-include-checkbox'}
                            {include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr}
                        {/block}
                        {/col}
                        {/row}
                    {/block}
                    {block name='accessibility-index-hr'}
                        <hr class="contact-form-hr">
                    {/block}
                    {block name='accessibility-index-fieldset-message'}

                        {row tag='fieldset'}
                        {col cols=12}
                        {block name='accessibility-index-legend-message'}
                            <div class="h3">{lang key='message' section='contact'}</div>
                        {/block}
                        {/col}
                        {col cols=12}
                        {if $betreffs}
                            {block name='accessibility-index-form-subject'}
                                {if isset($fehlendeAngaben.betreff)}
                                    {alert variant="danger"}
                                    {lang key='fillOut'}
                                    {/alert}
                                {/if}
                                {row}
                                {col cols=12 md=12}
                                {formgroup
                                class="{if isset($fehlendeAngaben.subject)} has-error{/if}"
                                label="{lang key='subject' section='contact'}"
                                label-for="subject"
                                }
                                {if !empty($fehlendeAngaben.subject)}
                                    <div class="form-error-msg" aria-live="assertive" role="alert" aria-atomic="true"><i
                                                class="fas fa-exclamation-triangle"></i>
                                        {lang key='fillOut'}
                                    </div>
                                {/if}
                                {select name="subject" id="subject" class='custom-select' required=true aria-invalid="{if isset($fehlendeAngaben.subject)}true{else}false{/if}"}
                                    <option value="" selected disabled>{lang key='subject' section='contact'}</option>
                                {foreach $betreffs as $betreff}
                                    <option value="{$betreff->kKontaktBetreff}"
                                            {if $Vorgaben->kKontaktBetreff == $betreff->kKontaktBetreff || $betreff->cName === 'Barrierefreiheit'}selected{/if}>{$betreff->AngezeigterName}</option>
                                {/foreach}
                                {/select}
                                {/formgroup}
                                {/col}
                                {/row}
                            {/block}
                        {/if}
                        {block name='accessibility-index-form-message'}
                            {row}
                            {col cols=12 md=12}
                            {formgroup
                            class="{if isset($fehlendeAngaben.nachricht)} has-error{/if}"
                            label="{lang key='message' section='contact'}"
                            label-for="message"
                            }
                            {if !empty($fehlendeAngaben.nachricht)}
                                <div class="form-error-msg" aria-live="assertive" role="alert" aria-atomic="true"><i
                                            class="fas fa-exclamation-triangle"></i>
                                    {lang key='fillOut'}
                                </div>
                            {/if}
                            {textarea name="nachricht" rows="10" id="message" required=true placeholder=" " aria-invalid="{if isset($fehlendeAngaben.nachricht)}true{else}false{/if}"}{if isset($Vorgaben->cNachricht)}{$Vorgaben->cNachricht}{/if}{/textarea}
                            {/formgroup}
                            {/col}
                            {/row}
                        {/block}
                        {/col}
                        {/row}
                    {/block}
                    {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
                    isset($Einstellungen.kontakt.kontakt_abfragen_captcha) && $Einstellungen.kontakt.kontakt_abfragen_captcha !== 'N' && JTL\Session\Frontend::getCustomer()->getID() === 0}
                        {block name='accessibility-index-form-captcha'}
                            <hr>
                            {row}
                            {col cols=12 md=6 class="{if !empty($fehlendeAngaben.captcha)} has-error{/if}"}
                            {captchaMarkup getBody=true}
                                <hr>
                            {/col}
                            {/row}
                        {/block}
                    {/if}
                    {opcMountPoint id='opc_before_submit'}
                    {block name='accessibility-index-form-submit'}
                        {row}
                        {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
                            {col cols=12 class="contact-form-privacy"}
                            {block name='accessibility-index-form-submit-privacy'}
                                <p>
                                    {link href=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL() class="popup"}
                                    {lang key='privacyNotice'}
                                    {/link}
                                </p>
                            {/block}
                            {/col}
                        {/if}
                        {col cols=12}
                        {block name='accessibility-index-form-submit-button'}
                            {row}
                            {col cols=12}
                            {input type='hidden' name='kontakt' value='1'}
                            {button type='submit' variant='primary' class='btn-block'}
                            {lang key='sendMessage' section='contact'}
                            {/button}
                            {/col}
                            {/row}
                        {/block}
                        {/col}
                        {/row}
                    {/block}
                {/block}
                {/form}
                <br>
            {/block}
            {if !empty($Spezialcontent->unten)}
                {block name='accessibility-index-custom-content-bottom'}
                    <div class="custom_content">
                        {$Spezialcontent->unten}
                    </div>
                {/block}
            {/if}
            {/container}
        {/if}
    {/block}

    {block name='accessibility-index-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}