{block name='checkout-inc-shipping-address'}
	{block name='ship-address-assigns'}
		{if isset($fehlendeAngaben.shippingAddress)}
			{assign var='fehlendeAngabenShipping' value=$fehlendeAngaben.shippingAddress}
		{else}
			{assign var="fehlendeAngabenShipping" value=null}
		{/if}
		{assign var="showShippingAddress" value=(isset($Lieferadresse) || !empty($kLieferadresse) || isset($forceDeliveryAddress))}
		{if $snackyConfig.hideShippingaddress == '1'}
			{assign var="showShippingAddress" value=false}
		{/if}
	{/block}
	{block name='ship-address-toggle-adress'}
		<div class="form-group checkbox control-toggle{if isset($forceDeliveryAddress)} hidden{/if}" id="checkout_register_shipping_address_div">
			<input type="hidden" name="shipping_address" value="1">
			<label for="checkout_register_shipping_address" class="btn-block mt-sm{if isset($forceDeliveryAddress)} hidden{/if}" data-toggle="collapse" data-target="#select_shipping_address">
				<input id="checkout_register_shipping_address" class="radio-checkbox" type="checkbox" name="shipping_address" value="0"{if !$showShippingAddress} checked="checked"{/if} />
				<span class="control-label label-default">
					{lang key="shippingAdressEqualBillingAdress" section="account data"}
				</span>
			</label>
		</div>
	{/block}
	{block name="checkout-enter-shipping-address"}
		<div id="select_shipping_address" class="mt-md{if $showShippingAddress || isset($smarty.get.editLieferadresse)} collapse show{/if}"{if $showShippingAddress || isset($smarty.get.editLieferadresse)} style="display:block;"{/if}>
    		{block name="checkout-enter-shipping-address-body"}
    			{if JTL\Session\Frontend::getCustomer()->getID() > 0 && isset($Lieferadressen) && $Lieferadressen|count > 0}
					<fieldset>
					{block name='ship-address-choose-headline'}
        				<legend class="h4">{lang key="deviatingDeliveryAddress" section="account data"}</legend>
					{/block}
					{block name='ship-address-choose-address'}
        				<div class="card mt-xs sa-card">
            				<div class="card-body">
            					{foreach $Lieferadressen as $adresse}
									{block name='ship-address-choose-address-item'}
										{$checkAddress = (isset($shippingAddressPresetID) && ($shippingAddressPresetID == $adresse->kLieferadresse))
											|| (!isset($shippingAddressPresetID) && (
												$kLieferadresse == $adresse->kLieferadresse
												|| ($kLieferadresse != -1 && $kLieferadresse != $adresse->kLieferadresse &&
												$adresse->nIstStandardLieferadresse == 1)
											)
										)}
										{block name='ship-address-choose-address-itemmodal'}
                							<div class="modal modal-dialog" id="shipadress{$adresse@iteration}" tabindex="-1">
                    							<div class="modal-content">
													{block name='ship-address-choose-address-item-modal-header'}
                        								<div class="modal-header">
                            								<div class="modal-title h5">
                                								{lang key="shippingAdress" section="account data"}
                            								</div>
                            								<button type="button" class="close-btn" data-dismiss="modal" aria-label="{lang key='close' section='account data'}">
                            								</button>
                        								</div>
													{/block}
													{block name='ship-address-choose-address-item-modal-body'}
                        								<div class="modal-body">
															{if $adresse->cFirma}{$adresse->cFirma}<br>{/if}
															<strong>{if $adresse->cTitel}{$adresse->cTitel}{/if} {$adresse->cVorname} {$adresse->cNachname}</strong><br>
															{$adresse->cStrasse} {$adresse->cHausnummer}<br>
															{$adresse->cPLZ} {$adresse->cOrt}<br>
															{include file='checkout/inc_delivery_address.tpl' Lieferadresse=$adresse hideMainInfo=true}
														</div>
													{/block}
                    							</div>
                							</div>
										{/block}
										{block name='ship-address-choose-address-item-list'}
                							<div class="flx-ac item">
												{block name='ship-address-choose-address-item-label'}
													<label class="flx-ac m0 stc-radio w100" for="delivery{$adresse->kLieferadresse}" data-toggle="collapse" data-target="#register_shipping_address.show">
														{block name='ship-address-choose-address-item-radio'}
															<span class="stc-input mr-xxs">
																<input class="radio-checkbox" type="radio" name="kLieferadresse" value="{$adresse->kLieferadresse}" id="delivery{$adresse->kLieferadresse}" {if $checkAddress}checked{/if}>
																<span class="stc-radio-btn"></span>
															</span>
														{/block}
														{block name='ship-address-choose-address-item-infos'}
															<span class="payship-content">
																<small class="block text-muted">{if $adresse->cFirma}{$adresse->cFirma|entferneFehlerzeichen}{/if}</small> 
																<strong class="block">{$adresse->cVorname} {$adresse->cNachname|entferneFehlerzeichen}</strong> 
																<small class="block text-muted">{$adresse->cStrasse|entferneFehlerzeichen} {$adresse->cHausnummer}, {$adresse->cPLZ} {$adresse->cOrt}, {$adresse->angezeigtesLand}</small>
															</span>
														{/block}
													</label>
												{/block}
												{block name='ship-address-choose-address-item-modal-toggle'}
													<a href="" class="btn btn-blank btn-sm" data-toggle="modal" data-target="#shipadress{$adresse@iteration}" aria-label="{lang key='view'}: {lang key='shippingAdress' section='checkout'}">
														<span class="img-ct icon">
															<svg>
															  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-info"></use>
															</svg>
														</span>		
													</a>
												{/block}
												{block name='ship-address-choose-address-item-edit'}
													<a class="btn btn-blank btn-sm" href="{get_static_route id='jtl.php' params=['editLieferadresse' => 1, 'editAddress' => {$adresse->kLieferadresse}, 'fromCheckout'=>1]}" aria-label="{lang key='modifyShippingAdress' section='checkout'}">
														<span class="img-ct icon">
															<svg>
															  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
															</svg>
														</span>		
													</a>
												{/block}
                							</div>
										{/block}
									{/block}
            					{/foreach}
								{block name='ship-address-new-address-item'}
									<div class="flx-ac item">
										<label class="flx-ac m0 stc-radio w100" for="delivery_new" data-toggle="collapse" data-target="#register_shipping_address:not(.show)">
											<span class="stc-input mr-xxs">
												<input class="radio-checkbox" type="radio" name="kLieferadresse" value="-1" id="delivery_new" {if $kLieferadresse == -1}checked{/if} required="required" aria-required="true">  
												<span class="stc-radio-btn"></span>
											</span>
											<span class="payship-content">
												{lang key="createNewShippingAdress" section="account data"}
											</span>
										</label>
									</div>
								{/block}
            				</div>
        				</div>
					{/block}
					</fieldset>
					{block name='ship-address-new-address-form'}
						<fieldset id="register_shipping_address" class="mt-sm panel checkout-register-shipping-address collapse collapse-non-validate {if $kLieferadresse == -1 && !isset($shippingAddressPresetID)} show{/if}" aria-expanded="{if $kLieferadresse == -1 && !isset($smarty.session.shippingAddressPresetID)}true{else}false{/if}">
							<legend class="h4 block">{lang key="createNewShippingAdress" section="account data"}</legend>
							{include file="checkout/customer_shipping_address.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
							{include file="checkout/customer_shipping_contact.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
						</fieldset>
					{/block}
    			{else}
					{block name='ship-address-new-address-form-single'}
						<fieldset class="panel">
							<legend class="h4 block">{lang key="createNewShippingAdress" section="account data"}</legend>
							{include file="checkout/customer_shipping_address.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
							{include file="checkout/customer_shipping_contact.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
						</fieldset>
					{/block}
    			{/if}
    		{/block}
		</div>
	{/block}
	{block name='ship-address-javascript'}
		{if isset($smarty.get.editLieferadresse) || $step === 'Lieferadresse'}
			{inline_script}
				{literal}
					<script type="text/javascript">
						$(window).on('load', function () {
							var $registerShippingAddress = $('#checkout_register_shipping_address');
							if ($registerShippingAddress.prop('checked')) {
								$registerShippingAddress.click();
							}
							$.evo.extended().smoothScrollToAnchor('#checkout_register_shipping_address');
						});
					</script>
				{/literal}
			{/inline_script}
		{/if}
		{inline_script}
			{literal}
				<script type="text/javascript">
					$(document).ready(function () {
						var $shippingForm = $('#register_shipping_address');
						var $shippingRadios = $('input[name="kLieferadresse"]');
						var $shippingCheckbox = $('#checkout_register_shipping_address');
						var $shippingFieldsets = $('#select_shipping_address fieldset');
						var formShouldStayOpen = false;
						
						// Funktion um disabled Fieldsets zu reaktivieren
						function enableShippingFieldsets() {
							$shippingFieldsets.each(function() {
								var $fieldset = $(this);
								if ($fieldset.prop('disabled')) {
									$fieldset.prop('disabled', false);
									// Reaktiviere auch alle Radio-Buttons im Fieldset
									$fieldset.find('input[name="kLieferadresse"]').prop('disabled', false);
								}
							});
						}
						
						// Funktion um disabled Felder im Adressformular zu reaktivieren
						function enableAddressFormFields() {
							$shippingForm.find('input, select, textarea').each(function() {
								var $field = $(this);
								if ($field.prop('disabled') && !$field.hasClass('keep-disabled')) {
									$field.prop('disabled', false);
								}
							});
						}
						
						// Funktion um korrekte Lieferadresse basierend auf Formulardaten zu finden
						function findMatchingAddress() {
							// Hole die aktuellen Werte aus dem "neue Adresse" Formular
							var formData = {
								vorname: $('#register-shipping_address-firstName').val(),
								nachname: $('#register-shipping_address-lastName').val(),
								strasse: $('#register-shipping_address-street').val(),
								hausnummer: $('#register-shipping_address-streetnumber').val(),
								plz: $('#register-shipping_address-postcode').val(),
								ort: $('#register-shipping_address-city').val()
							};
							
							// Überprüfe, ob die Formulardaten mit einer bestehenden Adresse übereinstimmen
							var $matchingAddress = null;
							$shippingRadios.each(function() {
								var $radio = $(this);
								var value = $radio.val();
								
								// Überspringe "neue Adresse" Optionen
								if (value === '-1' || $radio.is('[data-jtlpack]') || $radio.is('[data-type="jtlpack"]')) {
									return;
								}
								
								// Hole die Adressdaten aus dem Label-Text
								var $label = $radio.closest('.item').find('.payship-content');
								if ($label.length > 0) {
									var labelText = $label.text().trim();
									var hasName = formData.vorname && formData.nachname && 
												 labelText.includes(formData.vorname) && labelText.includes(formData.nachname);
									var hasStreet = formData.strasse && labelText.includes(formData.strasse);
									var hasPlz = formData.plz && labelText.includes(formData.plz);
									var hasOrt = formData.ort && labelText.includes(formData.ort);
									
									// Wenn mindestens 3 der 4 wichtigsten Felder übereinstimmen
									var matches = (hasName ? 1 : 0) + (hasStreet ? 1 : 0) + (hasPlz ? 1 : 0) + (hasOrt ? 1 : 0);
									if (matches >= 3) {
										$matchingAddress = $radio;
										return false; // break loop
									}
								}
							});
							
							return $matchingAddress;
						}
						
						// Funktion um den korrekten Adress-State zu reparieren
						function fixAddressState() {
							// Prüfe, ob "neue Adresse" ausgewählt ist, aber Formulardaten vorhanden sind
							var $newAddressRadio = $('#delivery_new');
							var isNewAddressSelected = $newAddressRadio.prop('checked');
							
							if (isNewAddressSelected) {
								// Überprüfe, ob es sich um vorausgefüllte Daten einer bestehenden Adresse handelt
								var $matchingAddress = findMatchingAddress();
								
								if ($matchingAddress && $matchingAddress.length > 0) {
									// Wähle die passende bestehende Adresse aus
									console.log('Repariere Adress-State: Wähle bestehende Adresse aus');
									$matchingAddress.prop('checked', true).trigger('change');
									
									// Leere das Formular, da es jetzt eine bestehende Adresse ist
									setTimeout(function() {
										$shippingForm.find('input[type="text"], input[type="email"], textarea').val('');
										$shippingForm.find('select').prop('selectedIndex', 0);
									}, 100);
								} else {
									// Es ist wirklich eine neue Adresse - reaktiviere die Felder
									enableAddressFormFields();
								}
							}
						}
						
						// Überwache Änderungen am DOM (falls Fieldsets oder Felder nachträglich disabled werden)
						var observer = new MutationObserver(function(mutations) {
							mutations.forEach(function(mutation) {
								if (mutation.type === 'attributes' && mutation.attributeName === 'disabled') {
									enableShippingFieldsets();
									enableAddressFormFields();
								}
							});
						});
						
						// Starte die Überwachung für alle Fieldsets
						$shippingFieldsets.each(function() {
							observer.observe(this, { 
								attributes: true, 
								attributeFilter: ['disabled'] 
							});
						});
						
						// Überwache auch das Adressformular
						if ($shippingForm.length > 0) {
							observer.observe($shippingForm[0], { 
								attributes: true, 
								attributeFilter: ['disabled'],
								subtree: true
							});
						}
						
						// Reaktiviere Fieldsets beim Laden der Seite
						enableShippingFieldsets();
						
						// Repariere den Adress-State beim Laden
						setTimeout(function() {
							fixAddressState();
						}, 200);
						
						// Funktion um die erste verfügbare Lieferadresse auszuwählen
						function selectFirstShippingAddress() {
							// Stelle sicher, dass Fieldsets aktiviert sind
							enableShippingFieldsets();
							
							// Aktualisiere die Radio-Button-Referenz für den Fall, dass neue hinzugekommen sind
							$shippingRadios = $('input[name="kLieferadresse"]');
							
							// Finde die erste Lieferadresse (nicht "neue Adresse" Optionen)
							var $firstAddress = $shippingRadios.filter(function() {
								var $this = $(this);
								var value = $this.val();
								var isNewAddressOption = value === '-1' || 
														$this.is('[data-jtlpack]') || 
														$this.is('[data-type="jtlpack"]') ||
														$this.attr('id') === 'delivery_new' ||
														$this.attr('id') === 'packstation' ||
														$this.attr('id') === 'postfiliale';
								return !isNewAddressOption && value && value !== '' && !$this.prop('disabled');
							}).first();
							
							if ($firstAddress.length > 0) {
								$firstAddress.prop('checked', true).trigger('change');
							}
						}
						
						// Überwache Checkbox-Änderungen für "Lieferadresse entspricht Rechnungsadresse"
						$shippingCheckbox.on('change', function() {
							var isChecked = $(this).prop('checked');
							
							// Wenn Checkbox deaktiviert wird (Lieferadresse ≠ Rechnungsadresse)
							if (!isChecked) {
								// Kurze Verzögerung, damit das Collapse-Event vollständig abgeschlossen ist
								setTimeout(function() {
									// Repariere erst den State, dann wähle die erste Adresse
									fixAddressState();
									setTimeout(function() {
										selectFirstShippingAddress();
									}, 100);
								}, 100);
							}
						});
						
						// Überwache Radio-Button-Änderungen
						$shippingRadios.on('change', function() {
							var selectedValue = $(this).val();
							var selectedElement = $(this);
							
							// Prüfe ob es sich um eine "neue Adresse"-Option handelt
							// (value="-1" oder spezielle data-Attribute für Packstation/Postfiliale)
							var isNewAddressOption = selectedValue === '-1' || 
													selectedElement.is('[data-jtlpack]') || 
													selectedElement.is('[data-type="jtlpack"]') ||
													selectedElement.attr('id') === 'delivery_new' ||
													selectedElement.attr('id') === 'packstation' ||
													selectedElement.attr('id') === 'postfiliale';
													
							if (isNewAddressOption) {
								// Formular sollte geöffnet bleiben oder geöffnet werden
								formShouldStayOpen = true;
								if (!$shippingForm.hasClass('show') && !$shippingForm.hasClass('in')) {
									$shippingForm.addClass('show in').attr('aria-expanded', 'true').show();
								}
							} else {
								// Bestehende Adresse ausgewählt - Formular kann geschlossen werden
								formShouldStayOpen = false;
								if ($shippingForm.hasClass('show') || $shippingForm.hasClass('in')) {
									$shippingForm.removeClass('show in').attr('aria-expanded', 'false').hide();
								}
							}
						});
						
						// Verhindere automatisches Schließen des Formulars durch Bootstrap
						$(document).on('hide.bs.collapse', function (e) {
							if ($(e.target).attr('id') === 'register_shipping_address' && formShouldStayOpen) {
								e.preventDefault();
								e.stopImmediatePropagation();
								return false;
							}
						});
						
						// Stelle sicher, dass das Formular korrekt initialisiert wird
						var $checkedRadio = $shippingRadios.filter(':checked');
						if ($checkedRadio.length > 0) {
							$checkedRadio.trigger('change');
						}
					});
				</script>
			{/literal}
		{/inline_script}
	{/block}
{/block}