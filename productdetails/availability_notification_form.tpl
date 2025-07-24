{block name='productdetails-availability-notification-form'}
<div class="panel-wrap">
    {if isset($position) && $position === 'popup'}
        {if isset($Artikelhinweise) && count($Artikelhinweise) > 0}
            <div class="alert alert-danger alert-dismissible">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                {foreach $Artikelhinweise as $Artikelhinweis}
                    {$Artikelhinweis}
                {/foreach}
            </div>
        {/if}
    {/if}
    <form action="{if !empty($Artikel->cURLFull)}{$Artikel->cURLFull}{else}{$ShopURL}/{/if}" method="post" id="article_availability{$Artikel->kArtikel}" class="jtl-validate">
        {$jtl_token}
        <fieldset>
            {if $Einstellungen.$tplscope.benachrichtigung_abfragen_vorname !== 'N' || $Einstellungen.$tplscope.benachrichtigung_abfragen_nachname !== 'N'}
                {if $Einstellungen.$tplscope.benachrichtigung_abfragen_vorname !== 'N'}
                    <div class="form-group float-label-control{if !empty($fehlendeAngaben_benachrichtigung.vorname)} has-error{/if}{if $Einstellungen.$tplscope.benachrichtigung_abfragen_vorname === 'Y'} required{/if}">
                        <label for="article_availability{$Artikel->kArtikel}_firstName" class="control-label">
                            {lang key="firstName" section="account data"}
                        </label>
                        <input type="text" class="form-control" name="vorname" value="{if isset($Benachrichtigung->cVorname)}{$Benachrichtigung->cVorname}{/if}" id="article_availability{$Artikel->kArtikel}_firstName"{if $Einstellungen.$tplscope.benachrichtigung_abfragen_vorname === 'Y'} required{/if}>
                        {if !empty($fehlendeAngaben_benachrichtigung.vorname)}
                            <div class="form-error-msg text-danger">
                                {lang key="fillOut" section="global"}
                            </div>
                        {/if}
                    </div>
                {/if}
                {if $Einstellungen.$tplscope.benachrichtigung_abfragen_nachname !== 'N'}
                    <div class="form-group float-label-control{if !empty($fehlendeAngaben_benachrichtigung.nachname)} has-error{/if}{if $Einstellungen.$tplscope.benachrichtigung_abfragen_nachname === 'Y'} required{/if}">
                        <label for="article_availability{$Artikel->kArtikel}_lastName" class="control-label">
                            {lang key="lastName" section="account data"}
                        </label>
                        <input type="text" class="form-control" name="nachname" value="{if isset($Benachrichtigung->cNachname)}{$Benachrichtigung->cNachname|entferneFehlerzeichen}{/if}" id="article_availability{$Artikel->kArtikel}_lastName"{if $Einstellungen.$tplscope.benachrichtigung_abfragen_nachname === 'Y'} required{/if}>
                        {if !empty($fehlendeAngaben_benachrichtigung.nachname)}
                            <div class="form-error-msg text-danger">
                                {lang key="fillOut" section="global"}
                            </div>
                        {/if}
                    </div>
                {/if}
            {/if}
            <div class="form-group float-label-control{if !empty($fehlendeAngaben_benachrichtigung.email)} has-error{/if} required">
                <label for="article_availability{$Artikel->kArtikel}_email" class="control-label">
                    {lang key="email" section="account data"}
                </label>
                <input type="email" class="form-control" name="email" value="{if isset($Lieferadresse->cMail)}{$Lieferadresse->cMail}{/if}" id="article_availability{$Artikel->kArtikel}_email" required>
                {if !empty($fehlendeAngaben_benachrichtigung.email)}
                    <div class="form-error-msg text-danger">
                        {if $fehlendeAngaben_benachrichtigung.email == 1}
                            {lang key="fillOut" section="global"}
                        {elseif $fehlendeAngaben_benachrichtigung.email == 2}
                            {lang key="invalidEmail" section="global"}
                        {elseif $fehlendeAngaben_benachrichtigung.email == 3}
                            {lang key="blockedEmail" section="global"}
                        {/if}
                    </div>
                {/if}
            </div>
    
            {if isset($fehlendeAngaben_benachrichtigung)}
                {include file='snippets/checkbox.tpl' nAnzeigeOrt=$smarty.const.CHECKBOX_ORT_FRAGE_VERFUEGBARKEIT cPlausi_arr=$fehlendeAngaben_benachrichtigung cPost_arr=null}
            {else}
                {include file='snippets/checkbox.tpl' nAnzeigeOrt=$smarty.const.CHECKBOX_ORT_FRAGE_VERFUEGBARKEIT cPlausi_arr=null cPost_arr=null cIDPrefix="article_availability{$Artikel->kArtikel}"}
            {/if}
    
        </fieldset>
        {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
            isset($Einstellungen.$tplscope.benachrichtigung_abfragen_captcha) && $Einstellungen.$tplscope.benachrichtigung_abfragen_captcha !== 'N' && empty($smarty.session.Kunde->kKunde)}
            {captchaMarkup getBody=true}
        {/if}                
        <p class="small text-muted">(* = {lang key='mandatoryFields'})</p>
        <p class="privacy text-muted">
            <a href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}{/if}" class="popup small tdu">
                {lang key='privacyNotice'}
            </a>
        </p>
        <input type="hidden" name="a" value="{if $Artikel->kVariKindArtikel}{$Artikel->kVariKindArtikel}{else}{$Artikel->kArtikel}{/if}" />
        <input type="hidden" name="show" value="1" />
        <input type="hidden" name="benachrichtigung_verfuegbarkeit" value="1" />
        <button type="submit" value="{lang key="requestNotification" section="global"}" class="btn btn-primary btn-block btn-lg" >{lang key="requestNotification" section="global"}</button>
    </form>
</div>
{/block}