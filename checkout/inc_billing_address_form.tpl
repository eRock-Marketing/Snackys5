{block name='checkout-inc-billing-address-form'}
	{block name='address-form-adress-info'}
		<fieldset class="panel">
			{block name='address-form-adress-info-title'}
				<legend class="h4 block">
					{if isset($checkout)}
						{lang key="proceedNewCustomer" section="checkout"}
					{else}
						{lang key="address" section="account data"}
					{/if}
				</legend>
				<div class="required-info small mb-xxs">{lang key='requiredInfo' section='custom'}</div>
			{/block}
			{block name='address-form-salutation-title'}
				<div class="row">
					{block name='address-form-salutation'}
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
										<div class="form-error-msg text-danger" aria-live="assertive" role="alert" aria-atomic="true">
											{lang key="fillOut" section="global"}
										</div>
									{/if}
								</div>
							</div>
						{/if}
					{/block}
					{block name='address-form-title'}
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
									{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternTitel)}pattern="{$snackyConfig.patternTitel}"{/if}
									spellcheck="false" 
									autocorrect="off" 
									maxlength="64"
									>
									{if isset($fehlendeAngaben.titel)}
										<div class="form-error-msg text-danger">
											{lang key="fillOut" section="global"}
										</div>
									{/if}
								</div>
							</div>
						{/if}
					{/block}
				</div>
			{/block}
			{block name='address-form-firstname-lastname'}
				<div class="row">
					{block name='address-form-firstname'}
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
								{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternVorname)}pattern="{$snackyConfig.patternVorname}"{/if}
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
					{/block}
					{block name='address-form-lastname'}
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
								{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternNachname)}pattern="{$snackyConfig.patternNachname}"{/if}
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
					{/block}
				</div>
			{/block}
			{block name='address-form-firm-firmtext'}
				<div class="row">
					{block name='address-form-firm'}
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
									maxlength="128"
									>
									{if isset($fehlendeAngaben.firma)}
										<div class="form-error-msg text-danger">
											{lang key="fillOut" section="global"}
										</div>
									{/if}
								</div>
							</div>
						{/if}
					{/block}
					{block name='address-form-firmtext'}
						{if $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz !== 'N'}
							<div class="col-12 col-md-6">
                                {if isset($cPost_var['firmazusatz'])}
                                    {assign var=inputVal_firmext value=$cPost_var['firmazusatz']}
                                {elseif isset($Kunde->cZusatz)}
                                    {assign var=inputVal_firmext value=$Kunde->cZusatz}
                                {/if}
                                {block name='checkout-inc-billing-address-form-company-additional'}
                                    {include file='snippets/form_group_simple.tpl'
                                        options=[
                                            'text', 'firmext', 'firmazusatz',
                                            {$inputVal_firmext|default:null}, {lang key='firmext' section='account data'},
                                            $Einstellungen.kunden.kundenregistrierung_abfragen_firmazusatz, null,
                                            'billing organization ext', null, 60
                                        ]
                                    }
                                {/block}
							</div>
						{/if}
					{/block}
				</div>
			{/block}
			{block name='address-form-street-number'}
				<div class="row">
					{block name='address-form-street'}
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
								{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternStrasse)}pattern="{$snackyConfig.patternStrasse}"{/if}
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
					{/block}
					{block name='address-form-number'}
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
								{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternHausnummer)}pattern="{$snackyConfig.patternHausnummer}"{/if} 
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
					{/block}
				</div>
			{/block}
			{block name='address-form-address-addition'}
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
								{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternAdresszusatz)}pattern="{$snackyConfig.patternAdresszusatz}"{/if} 
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
			{/block}
			{block name='address-form-country-bundesland'}
				{if isset($cPost_var['land'])}
					{$countryISO=$cPost_var['land']}
				{elseif !empty($Kunde->cLand)}
					{$countryISO=$Kunde->cLand}
				{elseif !empty($Einstellungen.kunden.kundenregistrierung_standardland)}
					  {$countryISO=$Einstellungen.kunden.kundenregistrierung_standardland}
				{else}
					{$countryISO=$shippingCountry}
				{/if}
				{getCountry iso=$countryISO assign='selectedCountry'}
				<div class="row">
					{block name='address-form-country'}
						<div class="col-12 col-md-6">
							<div class="form-group float-label-control required{if isset($fehlendeAngaben.land)} has-error{/if}">
								<label class="control-label" for="billing_address-country">{lang key="country" section="account data"}</label>
								<select name="land" id="billing_address-country" class="country_input form-control js-country-select" required
								 autocomplete="billing country">
								<option value="" disabled>{lang key="country" section="account data"}</option>
								{foreach $countries as $country}
									{if $country->isPermitRegistration()}
										<option value="{$country->getISO()}" {if $selectedCountry->getISO() === $country->getISO()}selected="selected"{/if}>{$country->getName()}</option>
									{/if}
								{/foreach}
								</select>
								{if isset($fehlendeAngaben.land)}
									<div class="form-error-msg text-danger" aria-live="assertive" role="alert" aria-atomic="true">
										{lang key="fillOut" section="global"}
									</div>
								{/if}
							</div>
						</div>
					{/block}
					{block name='address-form-bundesland'}
						{if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland !== 'N'}
							{if isset($cPost_var['bundesland'])}
								{assign var=selectedState value=$cPost_var['bundesland']}
							{elseif !empty($Kunde->cBundesland)}
								{assign var=selectedState value=$Kunde->cBundesland}
							{else}
								{assign var=selectedState value=''}
							{/if}
							<div class="col-12 col-md-6">
								<div class="form-group float-label-control{if isset($fehlendeAngaben.bundesland)} has-error{/if}{if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y'} required{/if}">
									<label class="control-label" for="billing_address-state">{lang key="state" section="account data"}<span class="state-optional optional {if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y' || $selectedCountry->isRequireStateDefinition()}hidden{/if}"> - {lang key='optional'}</span></label>
									{if !empty($selectedCountry)}
										<select
										title="{lang key=pleaseChoose}"
										name="bundesland"
										id="billing_address-state"
										class="form-control state-input"
										autocomplete="billing address-level1"
										data-defaultoption="{lang key=pleaseChoose}"
										{if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y' || $selectedCountry->isRequireStateDefinition()} required{/if}
										>
											<option value="" selected disabled>{lang key='pleaseChoose'}</option>
											{foreach $selectedCountry->getStates() as $state}
												<option value="{$state->getISO()}" {if $selectedState === $state->getName() || $selectedState === $state->getISO()}selected{/if}>{$state->getName()}</option>
											{/foreach}
										</select>
									{else}
										<input
										type="text"
										title="{lang key=pleaseChoose}"
										name="bundesland"
										value="{$selectedState}"
										id="state"
										class="form-control"
										placeholder="{lang key='state' section='account data'}"
										autocomplete="billing address-level1"
										{if $Einstellungen.kunden.kundenregistrierung_abfragen_bundesland === 'Y' || $selectedCountry->isRequireStateDefinition()} required{/if}
										>
									{/if}
									{if isset($fehlendeAngaben.bundesland)}
										<div class="form-error-msg text-danger" aria-live="assertive" role="alert" aria-atomic="true">
											{lang key="fillOut" section="global"}
										</div>
									{/if}
								</div>
							</div>
						{/if}
					{/block}
				</div>
			{/block}
			{block name='address-form-zip-city'}
				<div class="row">
					{block name='address-form-zip'}
						<div class="col-12 col-md-6">
							<div class="form-group float-label-control typeahead-required{if isset($fehlendeAngaben.plz)} has-error{/if} required">
								<label class="control-label" for="postcode">{lang key="plz" section="account data"}</label>
								<input 
								type="text" 
								name="plz" 
								value="{if isset($cPost_var['plz'])}{$cPost_var['plz']}{elseif isset($Kunde->cPLZ)}{$Kunde->cPLZ}{/if}"
								id="postcode"
								class="postcode_input form-control"
								placeholder="{lang key="plz" section="account data"}"
								required
								{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternPLZ)}pattern="{$snackyConfig.patternPLZ}"{/if}
								spellcheck="false" 
								autocorrect="off"
								autocomplete="billing postal-code" 
								maxlength="20"
								>
								{if isset($fehlendeAngaben.plz)}
									<div class="form-error-msg text-danger" aria-live="assertive" role="alert" aria-atomic="true">
										{if $fehlendeAngaben.plz >= 2}
											{lang key="checkPLZCity" section="checkout"}
										{else}
											{lang key="fillOut" section="global"}
										{/if}
									</div>
								{/if}
							</div>
						</div>
					{/block}
					{block name='address-form-city'}
						<div class="col-12 col-md-6">
							<div class="form-group float-label-control required typeahead-required{if isset($fehlendeAngaben.ort)} has-error{/if}">
								<label class="control-label" for="city">{lang key="city" section="account data"}</label>
								<input 
								type="text" 
								name="ort" 
								value="{if isset($cPost_var['ort'])}{$cPost_var['ort']}{elseif isset($Kunde->cOrt)}{$Kunde->cOrt}{/if}"
								id="city" 
								class="city_input form-control"
								placeholder="{lang key="city" section="account data"}" 
								required 
								{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternOrt)}pattern="{$snackyConfig.patternOrt}"{/if}
								spellcheck="false" 
								autocorrect="off"
								autocomplete="billing address-level2"
								>
								{if isset($fehlendeAngaben.ort)}
									<div class="form-error-msg text-danger" aria-live="assertive" role="alert" aria-atomic="true">
										{lang key="fillOut" section="global"}
									</div>
								{/if}
							</div>
						</div>
					{/block}
				</div>
			{/block}
			{block name='address-form-ustid'}
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
								{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternUst)}pattern="{$snackyConfig.patternUst}"{/if}
								spellcheck="false" 
								autocorrect="off" 
								maxlength="20"
								>
								{if isset($fehlendeAngaben.ustid)}
								<div class="form-error-msg text-danger" aria-live="assertive">
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
									{elseif $fehlendeAngaben.ustid == 6}
										{lang key='ustIDErrorMaxRequests' section='global'}
									{/if}
								</div>
								{/if}
							</div>
						</div>
					</div>
				{/if}
			{/block}
		</fieldset>
	{/block}
	{block name='address-form-contact-info'}
		<fieldset class="panel">
			{block name='address-form-contact-info-title'}
		   		<legend class="h4 block">{lang key="contactInformation" section="account data"}</legend>
			{/block}
			{block name='address-form-mail'}
				<div class="row">
					{block name='address-form-mail-form'}
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
					{/block}
					{block name='address-form-mail-advertising'}
						{if $Einstellungen.kunden.direct_advertising === 'Y'}
							{block name='checkout-inc-billing-address-form-direct-advertising'}
								<div class="col-12 text-muted bottom15">
									<small>{lang key="directAdvertising" section="checkout"}</small>
								</div>
							{/block}
						{/if}
					{/block}
				</div>
			{/block}
			{block name='address-form-phone-fax'}
				{if $Einstellungen.kunden.kundenregistrierung_abfragen_tel !== 'N' || $Einstellungen.kunden.kundenregistrierung_abfragen_fax !== 'N'}
					<div class="row">
						{block name='address-form-phone'}
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
										{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternTelefon)}pattern="{$snackyConfig.patternTelefon}"{/if}
										spellcheck="false" 
										autocorrect="off" 
										maxlength="45"
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
						{/block}
						{block name='address-form-fax'}
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
										{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternFax)}pattern="{$snackyConfig.patternFax}"{/if}
										spellcheck="false" 
										autocorrect="off" 
										maxlength="45"
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
						{/block}
					</div>
				{/if}
			{/block}
			{block name='address-form-mobile-www'}
				{if $Einstellungen.kunden.kundenregistrierung_abfragen_mobil !== 'N' || $Einstellungen.kunden.kundenregistrierung_abfragen_www !== 'N'}
					<div class="row">
						{block name='address-form-mobile'}
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
										{if $snackyConfig.formvalidActive === '0' && !empty($snackyConfig.patternMobil)}pattern="{$snackyConfig.patternMobil}"{/if}
										spellcheck="false" 
										autocorrect="off" 
										maxlength="30"
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
						{/block}
						{block name='address-form-www'}
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
						{/block}
					</div>
				{/if}
			{/block}
			{block name='address-form-birthday'}
				{if $Einstellungen.kunden.kundenregistrierung_abfragen_geburtstag !== 'N'}
					<div class="row">
						<div class="col-12 col-md-6">
							{if isset($cPost_var['geburtstag'])}
								{assign var=inputVal_birthday value=$cPost_var['geburtstag']|date_format:'Y-m-d'}
							{elseif isset($Kunde->dGeburtstag_formatted)}
								{assign var=inputVal_birthday value=$Kunde->dGeburtstag_formatted|date_format:'Y-m-d'}
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
			{/block}
		</fieldset>
	{/block}
	{block name='address-form-custom-customer-fields'}
		{if $Einstellungen.kundenfeld.kundenfeld_anzeigen === 'Y' && $oKundenfeld_arr->count() > 0}
			<fieldset class="panel">
				{block name='address-form-custom-customer-fields-title'}
					   <legend class="h4 block">{lang key="customerFields" section="custom"}</legend>
				{/block}
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
									{block name='address-form-custom-customer-fields-forms'}
										{if $oKundenfeld->getType() !== \JTL\Customer\CustomerField::TYPE_SELECT}
											{block name='address-form-custom-customer-fields-forms-input'}
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
											{/block}
										{else}
											{block name='address-form-custom-customer-fields-forms-select'}
												<select name="custom_{$kKundenfeld}" id="custom_{$kKundenfeld}" class="form-control{if $oKundenfeld->isRequired()} required{/if}" 
												{if !$isKundenattributEditable}disabled{/if}{if $oKundenfeld->isRequired()} required{/if}>
													<option value="" selected disabled>{lang key="pleaseChoose" section="global"}</option>
													{foreach $oKundenfeld->getValues() as $oKundenfeldWert}
														 <option value="{$oKundenfeldWert}" {if ($oKundenfeldWert == $cKundenattributWert)}selected{/if}>{$oKundenfeldWert}</option>
													{/foreach}
												</select>
											{/block}
										{/if}
									{/block}
									{block name='address-form-custom-customer-fields-forms-missing'}
										{if isset($fehlendeAngaben.custom[$kKundenfeld])}
											<div class="form-error-msg text-danger" aria-live="assertive"><i class="fas fa-exclamation-triangle">
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
									{/block}
								</div>
							{/foreach}
						{/if}
					</div>
				</div>
			</fieldset>
		{/if}
	{/block}
	{if !isset($fehlendeAngaben)}
		{assign var=fehlendeAngaben value=[]}
	{/if}
	{if !isset($cPost_arr)}
		{assign var=cPost_arr value=[]}
	{/if}
	{block name='address-form-checkboxes'}
		{hasCheckBoxForLocation nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr bReturn="bHasCheckbox"}
		{if $bHasCheckbox}
			<fieldset class="panel">
				<legend class="h4 block">{lang key="checkboxFields" section="custom"}</legend>
				{include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr}
			</fieldset>
		{/if}
	{/block}
	{block name='address-form-captcha'}
	{if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true)
	&& isset($Einstellungen.kunden.registrieren_captcha) && $Einstellungen.kunden.registrieren_captcha !== 'N' && empty($Kunde->kKunde)}
		<div class="form-group float-label-control{if isset($fehlendeAngaben.captcha) && $fehlendeAngaben.captcha != false} has-error{/if}">
			{captchaMarkup getBody=true}
		</div>
	{/if}
	{/block}
{/block}