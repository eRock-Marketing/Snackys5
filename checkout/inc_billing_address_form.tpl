{block name='checkout-inc-billing-address-form'}
<fieldset class="panel">
    <span class="h4 block">
        {if isset($checkout)}
            {lang key="proceedNewCustomer" section="checkout"}
        {else}
            {lang key="address" section="account data"}
        {/if}
    </span>
    {* salutation / title *}
    <div class="row">
        {if $Einstellungen.kunden.kundenregistrierung_abfragen_anrede !== 'N'}
            <div class="col-12 col-md-6">
                <div class="form-group float-label-control{if isset($fehlendeAngaben.anrede)} has-error{/if} {if $Einstellungen.kunden.kundenregistrierung_abfragen_anrede === 'Y'}required{/if}">
                    <label for="salutation" class="control-label">{lang key="salutation" section="account data"}</label>
                    <select name="anrede" id="salutation" class="form-control" {if $Einstellungen.kunden.kundenregistrierung_abfragen_anrede === 'Y'}required{/if}
					autocomplete="billing sex">
                        <option value="" selected="selected" disabled>
							{if $Einstellungen.kunden.kundenregistrierung_abfragen_anrede === 'Y'}{lang key='salutation' section='account data'}{else}{lang key='noSalutation'}{/if}
						</option>
                        <option value="w" {if isset($cPost_var['anrede']) && $cPost_var['anrede'] === 'w'}selected="selected"{elseif isset($Kunde->cAnrede) && $Kunde->cAnrede === 'w'}selected="selected"{/if}>{lang key='salutationW'}</option>
                        <option value="m" {if isset($cPost_var['anrede']) && $cPost_var['anrede'] === 'm'}selected="selected"{elseif isset($Kunde->cAnrede) && $Kunde->cAnrede === 'm'}selected="selected"{/if}>{lang key='salutationM'}</option>
                    </select>
                    {if isset($fehlendeAngaben.anrede)}
                        <div class="form-error-msg text-danger">
                            {lang key="fillOut" section="global"}
                        </div>
                    {/if}
                </div>
            </div>
        {/if}

        {if $Einstellungen.kunden.kundenregistrierung_abfragen_titel !== 'N'}
            <div class="col-12 col-md-6">
                {if isset($cPost_var['titel'])}
                    {assign var='inputVal_title' value=$cPost_var['titel']}
                {elseif isset($Kunde->cTitel)}
                    {assign var='inputVal_title' value=$Kunde->cTitel}
                {/if}
                <div class="form-group float-label-control{if isset($fehlendeAngaben.titel)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_titel === 'Y'} required{/if}">
                    <label for="title" class="control-label">{lang key="title" section="account data"}</label>
                    <input 
                    type="text" 
                    name="titel" 
                    value="{$inputVal_title|default:null}"
                    id="title" 
                    class="form-control" 
                    placeholder="{lang key="title" section="account data"}" 
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_titel === 'Y'}required{/if} 
				    {if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternTitel)}pattern="{$snackyConfig.patternTitel}"{/if}
				    spellcheck="false" 
				    autocorrect="off"
                    >
                    {if isset($fehlendeAngaben.titel)}
                        <div class="form-error-msg text-danger">
                            {lang key="fillOut" section="global"}
                        </div>
                    {/if}
                </div>
            </div>
        {/if}
    </div>
    {* firstname lastname *}
    <div class="row">   
        <div class="col-12 col-md-6">
            {if isset($cPost_var['vorname'])}
                {assign var='inputVal_firstName' value=$cPost_var['vorname']}
            {elseif isset($Kunde->cVorname)}
                {assign var='inputVal_firstName' value=$Kunde->cVorname}
            {/if}
            <div class="form-group float-label-control{if isset($fehlendeAngaben.vorname)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_pflicht_vorname === 'Y'} required{/if}">
                <label for="firstName" class="control-label">{lang key="firstName" section="account data"}</label>
                <input 
                type="text" 
                name="vorname" 
                value="{$inputVal_firstName|default:null}"
                id="firstName" 
                class="form-control" 
                placeholder="{lang key="firstName" section="account data"}" 
                {if $Einstellungen.kunden.kundenregistrierung_pflicht_vorname === 'Y'} required{/if} 
				{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternVorname)}pattern="{$snackyConfig.patternVorname}"{/if}
				spellcheck="false" 
				autocorrect="off"
                >
                {if isset($fehlendeAngaben.vorname)}
                    <div class="form-error-msg text-danger">
                        {if $fehlendeAngaben.vorname == 1}
                            {lang key="fillOut" section="global"}
                        {elseif $fehlendeAngaben.vorname == 2}
                            {lang key="firstNameNotNumeric" section="account data"}
                        {/if}
                    </div>
                {/if}
            </div>
        </div>
        <div class="col-12 col-md-6">
            {if isset($cPost_var['nachname'])}
                {assign var='inputVal_lastName' value=$cPost_var['nachname']}
            {elseif isset($Kunde->cNachname)}
                {assign var='inputVal_lastName' value=$Kunde->cNachname|entferneFehlerzeichen}
            {/if}
            <div class="form-group float-label-control{if isset($fehlendeAngaben.nachname)} has-error{/if} required">
                <label for="lastName" class="control-label">{lang key="lastName" section="account data"}</label>
                <input 
                type="text" 
                name="nachname" 
                value="{$inputVal_lastName|default:null}"
                id="lastName" 
                class="form-control" 
                placeholder="{lang key="lastName" section="account data"}" 
                required  
				{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternNachname)}pattern="{$snackyConfig.patternNachname}"{/if}
				spellcheck="false" 
				autocorrect="off" 
                >
                {if isset($fehlendeAngaben.nachname)}
                    <div class="form-error-msg text-danger">
                        {if $fehlendeAngaben.nachname == 1}
                             {lang key="fillOut" section="global"}
                        {elseif $fehlendeAngaben.nachname == 2}
                            {lang key="lastNameNotNumeric" section="account data"}
                        {/if}
                    </div>
                {/if}
            </div>
        </div>
    </div>
    {* firm / firmtext *}
    <div class="row">
        {if $Einstellungen.kunden.kundenregistrierung_abfragen_firma !== 'N'}
        <div class="col-12 col-md-6">
            {if isset($cPost_var['firma'])}
                {assign var='inputVal_firm' value=$cPost_var['firma']}
            {elseif isset($Kunde->cFirma)}
                {assign var='inputVal_firm' value=$Kunde->cFirma|entferneFehlerzeichen}
            {/if}
            <div class="form-group float-label-control{if isset($fehlendeAngaben.firma)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'Y'} required{/if}">
                <label for="firm" class="control-label">{lang key="firm" section="account data"}</label>
                <input 
                type="text" 
                name="firma" 
                value="{$inputVal_firm|default:null}"
                id="firm" 
                class="form-control" 
                placeholder="{lang key="firm" section="account data"}" 
                {if $Einstellungen.kunden.kundenregistrierung_abfragen_firma === 'Y'} required{/if} 
				spellcheck="false" 
				autocorrect="off"
                >
                {if isset($fehlendeAngaben.firma)}
                    <div class="form-error-msg text-danger">
                        {lang key="fillOut" section="global"}
                    </div>
                {/if}
            </div>
        </div>
        {/if}

        {if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz !== 'N'}
        <div class="col-12 col-md-6">
            {if isset($cPost_var['firmazusatz'])}
                {assign var='inputVal_firmext' value=$cPost_var['firmazusatz']}
            {elseif isset($Kunde->cZusatz)}
                {assign var='inputVal_firmext' value=$Kunde->cZusatz|entferneFehlerzeichen}
            {/if}
            <div class="form-group float-label-control{if isset($fehlendeAngaben.firmazusatz)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'Y'} required{/if}">
                <label for="firmext" class="control-label">{lang key="firmext" section="account data"}</label>
                <input 
                type="text" 
                name="firmazusatz" 
                value="{$inputVal_firmext|default:null}"
                id="firmext"
                class="form-control" 
                placeholder="{lang key="firmext" section="account data"}"
                {if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz === 'Y'} required{/if}
				spellcheck="false" 
				autocorrect="off" 
                />
                {if isset($fehlendeAngaben.firmazusatz)}
                    <div class="form-error-msg text-danger">
                        {lang key="fillOut" section="global"}
                    </div>
                {/if}
            </div>
        </div>
        {/if}
    </div>
    {* street / number *}
    <div class="row">
        <div class="col-12 col-md-6">
            {if isset($cPost_var['strasse'])}
                {assign var='inputVal_street' value=$cPost_var['strasse']}
            {elseif isset($Kunde->cStrasse)}
                {assign var='inputVal_street' value=$Kunde->cStrasse|entferneFehlerzeichen}
            {/if}
            <div class="form-group float-label-control{if isset($fehlendeAngaben.strasse)} has-error{/if} required">
                <label class="control-label" for="street">{lang key="street" section="account data"}</label>
                <input 
                type="text" 
                name="strasse" 
                value="{$inputVal_street|default:null}"
                id="street" 
                class="form-control" 
                placeholder="{lang key="street" section="account data"}" 
                required  
				{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternStrasse)}pattern="{$snackyConfig.patternStrasse}"{/if}
				spellcheck="false" 
				autocorrect="off"  
                >
                {if isset($fehlendeAngaben.strasse)}
                    <div class="form-error-msg text-danger">
                        {lang key="fillOut" section="global"}
                    </div>
                {/if}
            </div>
        </div>

        <div class="col-12 col-md-6">
            {if isset($cPost_var['hausnummer'])}
                {assign var='inputVal_streetnumber' value=$cPost_var['hausnummer']}
            {elseif isset($Kunde->cHausnummer)}
                {assign var='inputVal_streetnumber' value=$Kunde->cHausnummer}
            {/if}
            <div class="form-group float-label-control{if isset($fehlendeAngaben.hausnummer)} has-error{/if} required">
                <label class="control-label" for="streetnumber">{lang key="streetnumber" section="account data"}</label>
                <input 
                type="text" 
                name="hausnummer" 
                value="{$inputVal_streetnumber|default:null}"
                id="streetnumber" 
                class="form-control" 
                placeholder="{lang key="streetnumber" section="account data"}" 
                required  
				{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternHausnummer)}pattern="{$snackyConfig.patternHausnummer}"{/if} 
				spellcheck="false" 
				autocorrect="off"
                >
                {if isset($fehlendeAngaben.hausnummer)}
                    <div class="form-error-msg text-danger">
                        {lang key="fillOut" section="global"}
                    </div>
                {/if}
            </div>
        </div>
    </div>
    {* adress addition *}
    {if $Einstellungen.kunden.kundenregistrierung_abfragen_adresszusatz !== 'N'}
        <div class="row">
            <div class="col-12 col-md-6">
                {if isset($cPost_var['adresszusatz'])}
                    {assign var='inputVal_street2' value=$cPost_var['adresszusatz']}
                {elseif isset($Kunde->cAdressZusatz)}
                    {assign var='inputVal_street2' value=$Kunde->cAdressZusatz}
                {/if}
                <div class="form-group float-label-control{if isset($fehlendeAngaben.adresszusatz)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_adresszusatz === 'Y'} required{/if}">
                    <label class="control-label" for="street2">{lang key="street2" section="account data"}</label>
                    <input 
                    type="text" 
                    name="adresszusatz" 
                    value="{$inputVal_street2|default:null}"
                    id="street2" 
                    class="form-control"
                    placeholder="{lang key="street2" section="account data"}" 
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_adresszusatz === 'Y'} required{/if}
					{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternAdresszusatz)}pattern="{$snackyConfig.patternAdresszusatz}"{/if} 
				    spellcheck="false" 
				    autocorrect="off"
                    />
                    {if isset($fehlendeAngaben.adresszusatz)}
                        <div class="form-error-msg text-danger">
                            {lang key="fillOut" section="global"}
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    {/if}
    {* country *}
    {if isset($cPost_var['land'])}
        {assign var='cIso' value=$cPost_var['land']}
    {elseif !empty($Kunde->cLand)}
        {assign var='cIso' value=$Kunde->cLand}
    {else}
        {assign var='cIso' value=$shippingCountry}
    {/if}
    <div class="row">
        <div class="col-12 col-md-6">
            <div class="form-group float-label-control required{if isset($fehlendeAngaben.land)} has-error{/if}">
                <label class="control-label" for="country">{lang key="country" section="account data"}</label>
                <select name="land" id="country" class="country_input form-control" required
				 autocomplete="billing country">
                <option value="" disabled>{lang key="country" section="account data"}</option>
                {foreach $laender as $land}
                        <option value="{$land->getISO()}" {if $cIso === $land->getISO()}selected="selected"{/if}>{$land->getName()}</option>
                {/foreach}
                </select>
                {if isset($fehlendeAngaben.land)}
                    <div class="form-error-msg text-danger">
                        {lang key="fillOut" section="global"}
                    </div>
                {/if}
            </div>
        </div>
    {if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'N'}
    </div>
    {/if} {* close row if there won't follow another form-group *}

    {if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland !== 'N'}
        {getStates cIso=$cIso assign='oStates'}
        {if isset($cPost_var['bundesland'])}
            {assign var='cState' value=$cPost_var['bundesland']}
        {elseif !empty($Kunde->cBundesland)}
            {assign var='cState' value=$Kunde->cBundesland}
        {else}
            {assign var='cState' value=''}
        {/if}
        <div class="col-12 col-md-6">
            <div class="form-group float-label-control{if isset($fehlendeAngaben.bundesland)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y'} required{/if}">
                <label class="control-label" for="state">{lang key="state" section="account data"}</label>
                {if !empty($oStates)}
                    <select
                    title="{lang key=pleaseChoose}"
                    name="bundesland"
                    id="state"
                    class="form-control state-input"
                    autocomplete="billing address-level1"
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y'} required{/if}
                    >
                        <option value="" selected disabled>{lang key='pleaseChoose'}</option>
                        {foreach $oStates as $oState}
                            <option value="{$oState->cCode}" {if $cState === $oState->cName || $cState === $oState->cCode}selected{/if}>{$oState->cName}</option>
                        {/foreach}
                    </select>
                {else}
                    <input
                    type="text"
                    title="{lang key=pleaseChoose}"
                    name="bundesland"
                    value="{$cState}"
                    id="state"
                    class="form-control"
                    placeholder="{lang key='state' section='account data'}"
                    autocomplete="billing address-level1"
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y'} required{/if}
                    >
                {/if}
                {if isset($fehlendeAngaben.bundesland)}
                    <div class="form-error-msg text-danger">
                        {lang key="fillOut" section="global"}
                    </div>
                {/if}
            </div>
        </div>
    </div>{* close row for country *}
    {/if}
    {* zip / city *}
    <div class="row">
        <div class="col-12 col-md-6">
            <div class="form-group float-label-control{if isset($fehlendeAngaben.plz)} has-error{/if} required">
                <label class="control-label" for="postcode">{lang key="plz" section="account data"}</label>
                <input 
                type="text" 
                name="plz" 
                value="{if isset($cPost_var['plz'])}{$cPost_var['plz']}{elseif isset($Kunde->cPLZ)}{$Kunde->cPLZ}{/if}"
                id="postcode"
                class="postcode_input form-control"
                placeholder="{lang key="plz" section="account data"}"
                required
				{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternPLZ)}pattern="{$snackyConfig.patternPLZ}"{/if}
				spellcheck="false" 
				autocorrect="off"
				autocomplete="billing postal-code"
                >
                {if isset($fehlendeAngaben.plz)}
                    <div class="form-error-msg text-danger">
                        {if $fehlendeAngaben.plz >= 2}
                            {lang key="checkPLZCity" section="checkout"}
                        {else}
                            {lang key="fillOut" section="global"}
                        {/if}
                    </div>
                {/if}
            </div>
        </div>
        
        <div class="col-12 col-md-6">
            <div class="form-group float-label-control required{if isset($fehlendeAngaben.ort)} has-error{/if}">
                <label class="control-label" for="city">{lang key="city" section="account data"}</label>
                <input 
                type="text" 
                name="ort" 
                value="{if isset($cPost_var['ort'])}{$cPost_var['ort']}{elseif isset($Kunde->cOrt)}{$Kunde->cOrt}{/if}"
                id="city" 
                class="city_input form-control typeahead"
                placeholder="{lang key="city" section="account data"}" 
                required 
				{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternOrt)}pattern="{$snackyConfig.patternOrt}"{/if}
				spellcheck="false" 
				autocorrect="off"
				autocomplete="billing address-level2"
                >
                {if isset($fehlendeAngaben.ort)}
                    <div class="form-error-msg text-danger">
                        {if $fehlendeAngaben.ort==3}
                             {lang key="cityNotNumeric" section="account data"}
                        {else}
                            {lang key="fillOut" section="global"}
                        {/if}
                    </div>
                {/if}
            </div>
        </div>
    </div>
    {* UStID *}
    {if $Einstellungen.kunden.kundenregistrierung_abfragen_ustid !== 'N'}
    <div class="row">
        <div class="col-12 col-md-6">
            <div class="form-group float-label-control{if isset($fehlendeAngaben.ustid)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_ustid === 'Y'} required{/if}">
                <label class="control-label" for="ustid">{lang key="ustid" section="account data"}</label>
                <input 
                type="text" 
                name="ustid" 
                value="{if isset($cPost_var['ustid'])}{$cPost_var['ustid']}{elseif isset($Kunde->cUSTID)}{$Kunde->cUSTID}{/if}"
                id="ustid" 
                class="form-control" 
                placeholder="{lang key="ustid" section="account data"}" 
                {if $Einstellungen.kunden.kundenregistrierung_abfragen_ustid === 'Y'} required{/if} 
				{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternUst)}pattern="{$snackyConfig.patternUst}"{/if}
				spellcheck="false" 
				autocorrect="off"
                >
                {if isset($fehlendeAngaben.ustid)}
                <div class="form-error-msg text-danger">
                    {if $fehlendeAngaben.ustid == 1}
                        {lang key="fillOut" section="global"}
                    {elseif $fehlendeAngaben.ustid == 2}
                        {assign var=errorinfo value=","|explode:$fehlendeAngaben.ustid_err}
                        {if $errorinfo[0] == 100}{lang key='ustIDError100' section='global'}{/if}
                        {if $errorinfo[0] == 110}{lang key='ustIDError110' section='global'}{/if}
                        {if $errorinfo[0] == 120}{lang key='ustIDError120' section='global'}{$errorinfo[1]}{/if}
                        {if $errorinfo[0] == 130}{lang key='ustIDError130' section='global'}{$errorinfo[1]}{/if}
                    {elseif $fehlendeAngaben.ustid == 4}
                        {assign var=errorinfo value=","|explode:$fehlendeAngaben.ustid_err}
                        {lang key='ustIDError200' section='global'}{$errorinfo[1]}
					{elseif $fehlendeAngaben.ustid == 5}
                        {lang key="ustIDCaseFive" section="global"}
                    {/if}
                </div>
                {/if}
            </div>
        </div>
    </div>
    {/if}
</fieldset>

<fieldset class="panel">
   <span class="h4 block">{lang key="contactInformation" section="account data"}</span>
    {* E-Mail *}
    <div class="row">
        <div class="col-12 {if $Einstellungen.kunden.direct_advertising !== 'Y'}col-md-6{/if}">
            {if isset($cPost_var['email'])}
                {assign var='inputVal_email' value=$cPost_var['email']}
            {elseif isset($Kunde->cMail)}
                {assign var='inputVal_email' value=$Kunde->cMail}
            {/if}
            <div class="form-group float-label-control required{if isset($fehlendeAngaben.email)} has-error{/if}">
                <label class="control-label" for="email">{lang key="email" section="account data"}</label>
                <input 
                type="email" 
                name="email"
                value="{$inputVal_email|default:null}"
                id="email" 
                class="form-control"
                placeholder="{lang key="email" section="account data"}" 
                required 
				spellcheck="false" 
				autocorrect="off"
                >
                {if isset($fehlendeAngaben.email) || isset($fehlendeAngaben.email_vorhanden)}
                <div class="form-error-msg text-danger">
                    {if $fehlendeAngaben.email == 1}
                        {lang key="fillOut" section="global"}
                    {elseif $fehlendeAngaben.email == 2}
                        {lang key="invalidEmail" section="global"}
                    {elseif $fehlendeAngaben.email == 3}
                        {lang key="blockedEmail" section="global"}
                    {elseif $fehlendeAngaben.email == 4}
                        {lang key="noDnsEmail" section="account data"}
                    {elseif $fehlendeAngaben.email == 5 || $fehlendeAngaben.email_vorhanden == 1}
                        {lang key="emailNotAvailable" section="account data"}
                    {/if}
                </div>
                {/if}
            </div>
        </div>
        {if $Einstellungen.kunden.direct_advertising === 'Y'}
            {block name='checkout-inc-billing-address-form-direct-advertising'}
                <div class="col-12 text-muted bottom15">
                    <small>{lang key="directAdvertising" section="checkout"}</small>
                </div>
            {/block}
        {/if}
    </div>
    {* phone & fax *}
    {if $Einstellungen.kunden.kundenregistrierung_abfragen_tel !== 'N' || $Einstellungen.kunden.kundenregistrierung_abfragen_fax !== 'N'}
        <div class="row">
            {if $Einstellungen.kunden.kundenregistrierung_abfragen_tel !== 'N'}
            <div class="col-12 col-md-6">
                {if isset($cPost_var['tel'])}
                    {assign var='inputVal_tel' value=$cPost_var['tel']}
                {elseif isset($Kunde->cTel)}
                    {assign var='inputVal_tel' value=$Kunde->cTel}
                {/if}
                <div class="form-group float-label-control{if isset($fehlendeAngaben.tel)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_tel === 'Y'} required{/if}">
                    <label class="control-label" for="tel">{lang key="tel" section="account data"}</label>
                    <input 
                    type="tel" 
                    name="tel" 
                    value="{$inputVal_tel|default:null}"
                    id="tel" 
                    class="form-control"
                    placeholder="{lang key="tel" section="account data"}" 
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_tel === 'Y'} required{/if} 
					{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternTelefon)}pattern="{$snackyConfig.patternTelefon}"{/if}
				    spellcheck="false" 
				    autocorrect="off"
                    />
                    {if isset($fehlendeAngaben.tel)}
                    <div class="form-error-msg text-danger">
                        {if $fehlendeAngaben.tel == 1}
                            {lang key="fillOut" section="global"}
                        {elseif $fehlendeAngaben.tel == 2}
                            {lang key="invalidTel" section="global"}
                        {/if}
                    </div>
                    {/if}
                </div>
            </div>
            {/if}

            {if $Einstellungen.kunden.kundenregistrierung_abfragen_fax !== 'N'}
            <div class="col-12 col-md-6">
                {if isset($cPost_var['fax'])}
                    {assign var='inputVal_fax' value=$cPost_var['fax']}
                {elseif isset($Kunde->cFax)}
                    {assign var='inputVal_fax' value=$Kunde->cFax}
                {/if}
                <div class="form-group float-label-control{if isset($fehlendeAngaben.fax)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_fax === 'Y'} required{/if}">
                    <label class="control-label" for="fax">{lang key="fax" section="account data"}</label>
                    <input 
                    type="tel" 
                    name="fax" 
                    value="{$inputVal_fax|default:null}"
                    id="fax" 
                    class="form-control"
                    placeholder="{lang key="fax" section="account data"}" 
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_fax === 'Y'} required{/if}
					{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternFax)}pattern="{$snackyConfig.patternFax}"{/if}
				    spellcheck="false" 
				    autocorrect="off"
                    />
                    {if isset($fehlendeAngaben.fax)}
                        <div class="form-error-msg text-danger">
                            {if $fehlendeAngaben.fax == 1}
                                {lang key="fillOut" section="global"}
                            {elseif $fehlendeAngaben.fax == 2}
                                {lang key="invalidTel" section="global"}
                            {/if}
                        </div>
                    {/if}
                </div>
            </div>
            {/if}
        </div>
    {/if}

    {if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil !== 'N' || $Einstellungen.kunden.kundenregistrierung_abfragen_www !== 'N'}
        <div class="row">
            {if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil !== 'N'}
                <div class="col-12 col-md-6">
                    {if isset($cPost_var['mobil'])}
                        {assign var='inputVal_mobile' value=$cPost_var['mobil']}
                    {elseif isset($Kunde->cMobil)}
                        {assign var='inputVal_mobile' value=$Kunde->cMobil}
                    {/if}
                    <div class="form-group float-label-control{if isset($fehlendeAngaben.mobil)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil === 'Y'} required{/if} ">
                        <label class="control-label" for="mobile">{lang key="mobile" section="account data"}</label>
                        <input 
                        type="tel" 
                        name="mobil" 
                        value="{$inputVal_mobile|default:null}"
                        id="mobile" 
                        class="form-control"
                        placeholder="{lang key="mobile" section="account data"}" 
                        {if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil === 'Y'} required{/if} 
						{if $snackyConfig.formvalidActive === '0' && isset($snackyConfig.patternMobil)}pattern="{$snackyConfig.patternMobil}"{/if}
						spellcheck="false" 
						autocorrect="off"
                        />
                        {if isset($fehlendeAngaben.mobil)}
                            <div class="form-error-msg text-danger">
                                {if $fehlendeAngaben.mobil == 1}
                                    {lang key="fillOut" section="global"}
                                {elseif $fehlendeAngaben.mobil == 2}
                                    {lang key="invalidTel" section="global"}
                                {/if}
                            </div>
                        {/if}
                    </div>
                </div>
            {/if}

            {if $Einstellungen.kunden.kundenregistrierung_abfragen_www !== 'N'}
                <div class="col-12 col-md-6">
                    {if isset($cPost_var['www'])}
                        {assign var='inputVal_www' value=$cPost_var['www']}
                    {elseif isset($Kunde->cWWW)}
                        {assign var='inputVal_www' value=$Kunde->cWWW}
                    {/if}
                    <div class="form-group float-label-control{if isset($fehlendeAngaben.www)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_www === 'Y'} required{/if}">
                        <label class="control-label" for="www">{lang key="www" section="account data"}</label>
                        <input 
                        type="url" 
                        name="www" 
                        value="{$inputVal_www|default:null}"
                        id="www" 
                        class="form-control"
                        placeholder="{lang key="www" section="account data"}" 
                        {if $Einstellungen.kunden.kundenregistrierung_abfragen_www === 'Y'} required{/if} 
						spellcheck="false" 
						autocorrect="off"
                        />
                        {if isset($fehlendeAngaben.www)}
                            <div class="form-error-msg text-danger">
                                {lang key="fillOut" section="global"}
                            </div>
                        {/if}
                    </div>
                </div>
            {/if}
        </div>
    {/if}

    {if $Einstellungen.kunden.kundenregistrierung_abfragen_geburtstag !== 'N'}
        <div class="row">
            <div class="col-12 col-md-6">
                {if isset($cPost_var['geburtstag'])}
                    {assign var='inputVal_birthday' value=$cPost_var['geburtstag']}
                {elseif isset($Kunde->dGeburtstag_formatted)}
                    {assign var='inputVal_birthday' value=$Kunde->dGeburtstag_formatted}
                {/if}
                <div class="form-group float-label-control{if isset($fehlendeAngaben.geburtstag)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_geburtstag === 'Y'} required{/if}">
                    <label class="control-label" for="birthday">{lang key="birthday" section="account data"}</label>
                    <input 
                    type="date"
                    name="geburtstag"
                    value="{$inputVal_birthday|default:null|date_format:"%Y-%m-%d"}"
                    id="birthday" 
                    class="birthday form-control" 
                    placeholder="{lang key="birthdayFormat" section="account data"}"
                    {if $Einstellungen.kunden.kundenregistrierung_abfragen_geburtstag === 'Y'} required{/if} 
				    spellcheck="false" 
				    autocorrect="off"
                    >
                    {if isset($fehlendeAngaben.geburtstag)}
                        <div class="form-error-msg text-danger">
                            {if $fehlendeAngaben.geburtstag == 1}
                                {lang key="fillOut" section="global"}
                            {elseif $fehlendeAngaben.geburtstag == 2}
                                {lang key="invalidDateformat" section="global"}
                            {elseif $fehlendeAngaben.geburtstag == 3}
                                {lang key="invalidDate" section="global"}
                            {/if}
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    {/if}
</fieldset>
{if $Einstellungen.kundenfeld.kundenfeld_anzeigen === 'Y' && $oKundenfeld_arr->count() > 0}
<fieldset class="panel">
    <div class="row">
        <div class="col-12 col-md-6">
            {if $step === 'formular' || $step === 'edit_customer_address' || $step === 'Lieferadresse' || $step === 'rechnungsdaten'}
                {if ($step === 'formular' || $step === 'edit_customer_address') && isset($Kunde)}
                    {assign var="customerAttributes" value=$Kunde->getCustomerAttributes()}
                {/if}
                {foreach $oKundenfeld_arr as $oKundenfeld}
                    {assign var="kKundenfeld" value=$oKundenfeld->getID()}
                    {if isset($customerAttributes[$kKundenfeld])}
                        {assign var="cKundenattributWert" value=$customerAttributes[$kKundenfeld]->getValue()}
                        {assign var="isKundenattributEditable" value=$customerAttributes[$kKundenfeld]->isEditable()}
                    {else}
                        {assign var="cKundenattributWert" value=''}
                        {assign var="isKundenattributEditable" value=true}
                    {/if}
                    <div class="form-group float-label-control{if isset($fehlendeAngaben.custom[$kKundenfeld])} has-error{/if}{if $oKundenfeld->isRequired()} required{/if}">
                        <label class="control-label" for="custom_{$kKundenfeld}">{$oKundenfeld->getLabel()}</label>
                         {if $oKundenfeld->getType() !== \JTL\Customer\CustomerField::TYPE_SELECT}
                            <input
                            type="{if $oKundenfeld->getType() === \JTL\Customer\CustomerField::TYPE_NUMBER}number{elseif $oKundenfeld->getType() === \JTL\Customer\CustomerField::TYPE_DATE}date{else}text{/if}"
                            name="custom_{$kKundenfeld}"
                            id="custom_{$kKundenfeld}"
                            value="{$cKundenattributWert}"
                            class="form-control"
                            placeholder="{$oKundenfeld->getLabel()}"
                            {if $oKundenfeld->isRequired()} required{/if}
                            data-toggle="floatLabel"
                            data-value="no-js"
                            {if !$isKundenattributEditable}readonly{/if}/>
                        {else}
                            <select name="custom_{$kKundenfeld}" class="form-control{if $oKundenfeld->isRequired()} required{/if}" 
							{if !$isKundenattributEditable}disabled{/if}{if $oKundenfeld->isRequired()} required{/if}>
                                <option value="" selected disabled>{lang key="pleaseChoose" section="global"}</option>
                                {foreach $oKundenfeld->getValues() as $oKundenfeldWert}
                                     <option value="{$oKundenfeldWert}" {if ($oKundenfeldWert == $cKundenattributWert)}selected{/if}>{$oKundenfeldWert}</option>
                                {/foreach}
                            </select>
                        {/if}
                        {if isset($fehlendeAngaben.custom[$kKundenfeld])}
                            <div class="form-error-msg text-danger">
                                {if $fehlendeAngaben.custom[$kKundenfeld] === 1}
                                    {lang key="fillOut" section="global"}
                                {elseif $fehlendeAngaben.custom[$kKundenfeld] === 2}
                                    {lang key="invalidDateformat" section="global"}
                                {elseif $fehlendeAngaben.custom[$kKundenfeld] === 3}
                                    {lang key="invalidDate" section="global"}
                                {elseif $fehlendeAngaben.custom[$kKundenfeld] === 4}
                                    {lang key="invalidInteger" section="global"}
                                {/if}
                            </div>
                        {/if}
                    </div>
                {/foreach}
            {/if}
        </div>
    </div>
</fieldset>
{/if}
{if !isset($fehlendeAngaben)}
    {assign var=fehlendeAngaben value=array()}
{/if}
{if !isset($cPost_arr)}
    {assign var=cPost_arr value=array()}
{/if}
{hasCheckBoxForLocation nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr bReturn="bHasCheckbox"}
{if $bHasCheckbox}
<fieldset class="panel">
    {include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr}
</fieldset>
{/if}
{if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true)
&& isset($Einstellungen.kunden.registrieren_captcha) && $Einstellungen.kunden.registrieren_captcha !== 'N' && empty($Kunde->kKunde)}
    <hr>
    <div class="form-group float-label-control{if isset($fehlendeAngaben.captcha) && $fehlendeAngaben.captcha != false} has-error{/if}">
        {captchaMarkup getBody=true}
    </div>
    <hr>
{/if}
{/block}