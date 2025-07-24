{block name='checkout-inc-shipping-address'}
	{block name='ship-address-assigns'}
		{if isset($fehlendeAngaben.shippingAddress)}
			{assign var='fehlendeAngabenShipping' value=$fehlendeAngaben.shippingAddress}
		{else}
			{assign var="fehlendeAngabenShipping" value=null}
		{/if}
		{assign var="showShippingAddress" value=(isset($Lieferadresse) || !empty($kLieferadresse) || isset($forceDeliveryAddress))}
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
					{block name='ship-address-choose-headline'}
        				<div class="h4">{lang key="deviatingDeliveryAddress" section="account data"}</div>
					{/block}
					{block name='ship-address-choose-address'}
        				<div class="card mt-sm sa-card">
            				<div class="card-body">
            					{foreach $Lieferadressen as $adresse}
									{block name='ship-address-choose-address-item'}
                						{$checkAddress = (isset($shippingAddressPresetID) && ($shippingAddressPresetID == $adresse->kLieferadresse)) || (!isset($shippingAddressPresetID) && ($kLieferadresse == $adresse->kLieferadresse || ($kLieferadresse != -1 && $kLieferadresse != $adresse->kLieferadresse && $adresse->nIstStandardLieferadresse == 1)))}
										{block name='ship-address-choose-address-itemmodal'}
                							<div class="modal modal-dialog" id="shipadress{$adresse@iteration}" tabindex="-1">
                    							<div class="modal-content">
													{block name='ship-address-choose-address-item-modal-header'}
                        								<div class="modal-header">
                            								<div class="modal-title h5">
                                								{lang key="shippingAdress" section="account data"}
                            								</div>
                            								<button type="button" class="close-btn" data-dismiss="modal" aria-label="Close">
                            								</button>
                        								</div>
													{/block}
													{block name='ship-address-choose-address-item-modal-body'}
                        								<div class="modal-body">
															{if $adresse->cFirma}{$adresse->cFirma}<br />{/if}
															<strong>{if $adresse->cTitel}{$adresse->cTitel}{/if} {$adresse->cVorname} {$adresse->cNachname}</strong><br />
															{$adresse->cStrasse} {$adresse->cHausnummer}<br />
															{$adresse->cPLZ} {$adresse->cOrt}<br />
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
																<input class="radio-checkbox" type="radio" name="kLieferadresse" value="{$adresse->kLieferadresse}" id="delivery{$adresse->kLieferadresse}" {if $kLieferadresse == $adresse->kLieferadresse}checked{/if}>
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
													<a href="" class="btn btn-blank btn-sm" data-toggle="modal" data-target="#shipadress{$adresse@iteration}">
														<span class="img-ct icon">
															<svg>
															  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-info"></use>
															</svg>
														</span>		
													</a>
												{/block}
												{block name='ship-address-choose-address-item-edit'}
													<a class="btn btn-blank btn-sm" href="{get_static_route id='jtl.php' params=['editLieferadresse' => 1, 'editAddress' => {$adresse->kLieferadresse}, 'fromCheckout'=>1]}">
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
					{block name='ship-address-new-address-form'}
						<fieldset id="register_shipping_address" class="mt-sm panel checkout-register-shipping-address collapse collapse-non-validate {if $kLieferadresse == -1 && !isset($shippingAddressPresetID)} show{/if}" aria-expanded="{if $kLieferadresse == -1 && !isset($smarty.session.shippingAddressPresetID)}true{else}false{/if}">
							<span class="h4 block">{lang key="createNewShippingAdress" section="account data"}</span>
							{include file="checkout/customer_shipping_address.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
							{include file="checkout/customer_shipping_contact.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
						</fieldset>
					{/block}
    			{else}
					{block name='ship-address-new-address-form-single'}
						<fieldset class="panel">
							<span class="h4 block">{lang key="createNewShippingAdress" section="account data"}</span>
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
	{/block}
{/block}