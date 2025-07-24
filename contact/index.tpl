{block name='contact-index'}
	{block name='contact-assign'}
		{if !isset($viewportImages)}
			{assign var="viewportImages" value=0}
		{/if}
	{/block}
	{block name="header"}
		{include file='layout/header.tpl'}
	{/block}
	{block name="content"}
    	<div id="ct-fr" class="ma">
			{block name='contact-headline'}
				{include file="snippets/zonen.tpl" id="opc_before_heading"}
				{if !empty($Spezialcontent->titel)}
					<h1>{$Spezialcontent->titel}</h1>
				{else}
					<h1>{lang key="contact" section="breadcrumb"}</h1>
				{/if}
				{include file="snippets/zonen.tpl" id="opc_after_heading"}
			{/block}
			{block name='contact-extension'}
    			<hr class="invisible">
    			{include file="snippets/extension.tpl"}
			{/block}
			{block name='contact-content'}
    			{if isset($step)}
					{include file="snippets/zonen.tpl" id="opc_before_form"}
					{block name='contact-content-custom-top'}
						{if !empty($Spezialcontent->oben)}
							<div class="custom_content">
								{$Spezialcontent->oben}
							</div>
						{/if}
					{/block}
					{block name='contact-content-panel'}
						<div class="panel-wrap">
							{block name='contact-content-missing'}
								{if !empty($fehlendeAngaben)}
									<div class="alert alert-danger alert-dismissible">
										<button type="button" class="close" data-dismiss="alert" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										{lang key="fillOut" section="global"}
									</div>
								{/if}
							{/block}
							{block name='contact-content-form'}
								<form name="contact" action="{get_static_route id='kontakt.php'}" method="post" class="jtl-validate">
									{$jtl_token}
									{block name='contact-content-form-fieldset-information'}
										<fieldset class="panel">
											{block name='contact-content-form-fieldset-information-headline'}
												<span class="block h4">{lang key="contact" section="global"}</span>
											{/block}
											{block name='contact-content-form-fieldset-information-salutation'}
												<div class="row">
													{if $Einstellungen.kontakt.kontakt_abfragen_anrede !== 'N'}
														<div class="col-12 col-md-6">
															<div class="form-group float-label-control{if $Einstellungen.kontakt.kontakt_abfragen_anrede === 'Y'} required{/if}">
																<label for="salutation" class="control-label">{lang key="salutation" section="account data"}</label>
																<select name="anrede" id="salutation" class="form-control" {if $Einstellungen.kontakt.kontakt_abfragen_anrede === 'Y'}required{/if}>
																	<option value="" selected="selected" {if $Einstellungen.kontakt.kontakt_abfragen_anrede === 'Y'}disabled{/if}>
																		{if $Einstellungen.kontakt.kontakt_abfragen_anrede === 'Y'}{lang key='salutation' section='account data'}{else}{lang key='noSalutation'}{/if}
																	</option>
																	<option value="w"{if isset($Vorgaben->cAnrede) && $Vorgaben->cAnrede === 'w'} selected="selected"{/if}>{lang key='salutationW'}</option>
																	<option value="m"{if isset($Vorgaben->cAnrede) && $Vorgaben->cAnrede === 'm'} selected="selected"{/if}>{lang key='salutationM'}</option>
																</select>
															</div>
														</div>
													{/if}
												</div>
											{/block}
											{block name='contact-content-form-fieldset-information-name-lastname'}
												{if $Einstellungen.kontakt.kontakt_abfragen_vorname !== 'N' || $Einstellungen.kontakt.kontakt_abfragen_nachname !== 'N'}
													<div class="row">
														{block name='contact-content-form-fieldset-information-name'}
															{if $Einstellungen.kontakt.kontakt_abfragen_vorname !== 'N'}
																<div class="col-12 col-md-6">
																	{include file="snippets/form_group_simple.tpl" options=["text", "firstName", "vorname", {$Vorgaben->cVorname}, {lang key="firstName" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_vorname}]}
																</div>
															{/if}
														{/block}
														{block name='contact-content-form-fieldset-information-lastname'}
															{if $Einstellungen.kontakt.kontakt_abfragen_nachname !== 'N'}
																<div class="col-12 col-md-6">
																	{assign var='invalidReason' value=null}
																	{if isset($fehlendeAngaben.nachname)}
																		{if $fehlendeAngaben.nachname == 1}
																			{lang assign="invalidReason" key="fillOut" section="global"}
																		{elseif $fehlendeAngaben.nachname == 2}
																			{lang assign="invalidReason" key="lastNameNotNumeric" section="account data"}
																		{/if}
																	{/if}
																	{include file="snippets/form_group_simple.tpl" options=["text" , "lastName", "nachname", {$Vorgaben->cNachname|entferneFehlerzeichen}, {lang key="lastName" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_nachname}, {$invalidReason}]}
																</div>
															{/if}
														{/block}
													</div>
												{/if}
											{/block}
											{block name='contact-content-form-fieldset-information-company'}
												{if $Einstellungen.kontakt.kontakt_abfragen_firma !== 'N'}
													<div class="row">
														<div class="col-12 col-md-6">
															{include    file="snippets/form_group_simple.tpl"
																options=[ "text" , "firm", "firma", {$Vorgaben->cFirma|entferneFehlerzeichen}, {lang key="firm" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_firma}]}
														</div>
													</div>
												{/if}
											{/block}
											{block name='contact-content-form-fieldset-information-mail'}
												<div class="row">
													<div class="col-12 col-md-6">
														{assign var='invalidReason' value=null}
														{if isset($fehlendeAngaben.email)}
															{if $fehlendeAngaben.email == 1}{lang assign="invalidReason" key="fillOut" section="global"}
															{elseif $fehlendeAngaben.email == 2}{lang assign="invalidReason" key="invalidEmail" section="global"}
															{elseif $fehlendeAngaben.email == 3}{lang assign="invalidReason" key="blockedEmail" section="global"}
															{elseif $fehlendeAngaben.email == 4}{lang assign="invalidReason" key="noDnsEmail" section="account data"}
															{elseif $fehlendeAngaben.email == 5}{lang assign="invalidReason" key="emailNotAvailable" section="account data"}{/if}
														{/if}
														{include    file="snippets/form_group_simple.tpl"
															options=[ "email" , "email", "email", {$Vorgaben->cMail}, {lang key="email" section="account data"}, true, {$invalidReason}]}
													</div>
												</div>
											{/block}
											{block name='contact-content-form-fieldset-information-phone-mobile'}
												{if $Einstellungen.kontakt.kontakt_abfragen_tel !== 'N' || $Einstellungen.kontakt.kontakt_abfragen_mobil !== 'N'}
													<div class="row">
														{block name='contact-content-form-fieldset-information-phone'}
															{if $Einstellungen.kontakt.kontakt_abfragen_tel !== 'N'}
																<div class="col-12  col-md-6">
																	{assign var='invalidReason' value=null}
																	{if isset($fehlendeAngaben.tel) && $fehlendeAngaben.tel === 1}{lang assign="invalidReason" key="fillOut" section="global"}{elseif isset($fehlendeAngaben.tel) && $fehlendeAngaben.tel === 2}{lang assign="invalidReason" key="invalidTel" section="global"}{/if}
																	{include file="snippets/form_group_simple.tpl" options=["tel" , "tel", "tel", {$Vorgaben->cTel}, {lang key="tel" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_tel}, {$invalidReason}]}
																</div>
															{/if}
														{/block}
														{block name='contact-content-form-fieldset-information-mobile'}
															{if $Einstellungen.kontakt.kontakt_abfragen_mobil !== 'N'}
																<div class="col-12 col-md-6">
																	{assign var='invalidReason' value=null}
																	{if isset($fehlendeAngaben.mobil) && $fehlendeAngaben.mobil === 1}{lang assign="invalidReason" key="fillOut" section="global"}{elseif isset($fehlendeAngaben.mobil) && $fehlendeAngaben.mobil === 2}{lang assign="invalidReason" key="invalidTel" section="global"}{/if}
																	{include file="snippets/form_group_simple.tpl" options=["tel" , "mobile", "mobil", {$Vorgaben->cMobil}, {lang key="mobile" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_mobil}, {$invalidReason}]}
																</div>
															{/if}
														{/block}
													</div>
												{/if}
											{/block}
											{block name='contact-content-form-fieldset-information-fax'}
												{if $Einstellungen.kontakt.kontakt_abfragen_fax !== 'N'}
													<div class="row">
														<div class="col-12 col-md-6">
															{assign var='invalidReason' value=null}
															{if !empty($fehlendeAngaben.fax) && $fehlendeAngaben.fax === 1}{lang assign="invalidReason" key="fillOut" section="global"}{elseif isset($fehlendeAngaben.fax) && $fehlendeAngaben.fax === 2}{lang assign="invalidReason" key="invalidTel" section="global"}{/if}
															{include file="snippets/form_group_simple.tpl" options=["tel" , "fax", "fax", {$Vorgaben->cFax}, {lang key="fax" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_fax}, {$invalidReason}]}
														</div>
													</div>
												{/if}
											{/block}
											{block name='contact-content-form-fieldset-information-checkbox'}
												{assign var=cPost_arr value=$cPost_arr|default:[]}
												{include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr}
											{/block}
										</fieldset>
									{/block}
									{block name='contact-content-form-fieldset-message'}
										<fieldset class="panel">
											{block name='contact-content-form-fieldset-message-headline'}
												<span class="h4 block">{lang key="message" section="contact"}</span>
											{/block}
											{block name='contact-content-form-fieldset-message-subject'}
												{if $betreffs}
													{if isset($fehlendeAngaben.betreff)}
														<div class="alert alert-danger">
															{lang key="fillOut" section="global"}
														</div>
													{/if}
													<div class="row">
														<div class="col-12 col-md-6">
															<div class="form-group float-label-control{if isset($fehlendeAngaben.subject)} has-error{/if} required">
																<label for="subject" class="control-label">{lang key="subject" section="contact"}</label>
																<select class="form-control" name="subject" id="subject" required>
																	<option value="" selected disabled>{lang key="subject" section="contact"}</option>
																	{foreach name=betreffs from=$betreffs item=betreff}
																		<option value="{$betreff->kKontaktBetreff}" {if $Vorgaben->kKontaktBetreff==$betreff->kKontaktBetreff}selected{/if}>{$betreff->AngezeigterName}</option>
																	{/foreach}
																</select>
																{if !empty($fehlendeAngaben.subject)}
																	<div class="form-error-msg text-danger">
																		{lang key="fillOut" section="global"}
																	</div>
																{/if}
															</div>
														</div>
													</div>
												{/if}
											{/block}
											{block name='contact-content-form-fieldset-message-textarea'}
												<div class="row">
													<div class="col-12 col-md-12">
														<div class="form-group float-label-control{if isset($fehlendeAngaben.nachricht)} has-error{/if} required">
															<label for="message" class="control-label">{lang key="message" section="contact"}</label>
															<textarea name="nachricht" class="form-control" rows="10" id="message" required>{if isset($Vorgaben->cNachricht)}{$Vorgaben->cNachricht}{/if}</textarea>
															{if !empty($fehlendeAngaben.nachricht)}
																<div class="form-error-msg text-danger">
																	{lang key="fillOut" section="global"}
																</div>
															{/if}
														</div>
													</div>
												</div>
											{/block}
										</fieldset>
									{/block}
									{block name='contact-content-form-captcha'}
										{if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
											isset($Einstellungen.kontakt.kontakt_abfragen_captcha) && $Einstellungen.kontakt.kontakt_abfragen_captcha !== 'N' && JTL\Session\Frontend::getCustomer()->getID() === 0}
											{captchaMarkup getBody=true}
										{/if}
									{/block}
									<input type="hidden" name="kontakt" value="1" />
                					{include file="snippets/zonen.tpl" id="opc_before_submit"}
									{block name='contact-content-form-mandatory-info'}
                						<p class="small text-muted">(* = {lang key='mandatoryFields'})</p>
									{/block}
									{block name='contact-content-form-privany-note'}
										<p class="privacy text-muted">
											<a href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}{/if}" class="popup small tdu">
												{lang key='privacyNotice'}
											</a>
										</p>
									{/block}
									{block name='contact-content-form-submit'}
										<button type="submit" class="btn btn-primary btn-block btn-lg">{lang key="sendMessage" section="contact"}</button>
									{/block}
								</form>
							{/block}
						</div>
					{/block}
					{block name='contact-content-custom-bottom'}
						{if !empty($Spezialcontent->unten)}
							<div class="custom_content">
								{$Spezialcontent->unten}
							</div>
						{/if}
					{/block}
    			{/if}
			{/block}
    	</div>
	{/block}
	{block name="footer"}
		{include file='layout/footer.tpl'}
	{/block}
{/block}