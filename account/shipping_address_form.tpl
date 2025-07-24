{block name='account-shipping-address-form'}
	{block name='account-shipping-address-form-headline'}
		<h1>{lang key="myShippingAddresses"}</h1>
	{/block}
    {block name='account-shipping-address-form-form'}
		{if $Lieferadressen|count > 0 && !isset($smarty.get.editAddress)}
			{block name='account-shipping-address-form-new-shipaddress'}
				<a class="btn btn-primary" data-toggle="collapse" href="#newshipping" role="button" aria-expanded="false" aria-controls="newshipping">
					{lang key="createNewShippingAdress" section="account data"}	
				</a>
			{/block}
			<div class="collapse" id="newshipping">
		{/if}
		{form method="post" id='lieferadressen' action="{get_static_route params=['editLieferadresse' => 1]}" class="jtl-validate panel mt-sm"}
			{block name='account-shipping-address-form-headline'}
				{if $Lieferadressen|count == 0}
					<div class="h4 mt-xxs">{lang key="createNewShippingAdress" section="account data"}</div>
				{/if}
			{/block}
			{block name='account-shipping-address-form-include-customer-shipping-address'}
				{include file='checkout/customer_shipping_address.tpl' prefix="register" fehlendeAngaben=null}
			{/block}
			{block name='account-shipping-address-form-include-customer-shipping-contact'}
				{include file='checkout/customer_shipping_contact.tpl' prefix="register" fehlendeAngaben=null}
			{/block}
			{block name='account-shipping-address-form-form-submit'}
				<hr class="invisible hr-xs">
				{row class='btn-row'}
					{col md=12 xl=6 class="checkout-button-row-submit mb-3"}
						{input type="hidden" name="editLieferadresse" value="1"}
						{if isset($Lieferadresse->nIstStandardLieferadresse) && $Lieferadresse->nIstStandardLieferadresse === 1}
							{input type="hidden" name="isDefault" value=1}
						{/if}
						{if isset($Lieferadresse->kLieferadresse) && !isset($smarty.get.fromCheckout)}
							{input type="hidden" name="updateAddress" value=$Lieferadresse->kLieferadresse}
							{button type="submit" value="1" block=true variant="primary"}
								{lang key='updateAddress' section='account data'}
							{/button}
						{elseif !isset($Lieferadresse->kLieferadresse)}
							{input type="hidden" name="editAddress" value="neu"}
							{button type="submit" value="1" block=true variant="primary"}
								{lang key='saveAddress' section='account data'}
							{/button}
						{elseif isset($Lieferadresse->kLieferadresse) && isset($smarty.get.fromCheckout)}
							{input type="hidden" name="updateAddress" value=$Lieferadresse->kLieferadresse}
							{input type="hidden" name="backToCheckout" value="1"}
							{button type="submit" value="1" block=true variant="primary"}
								{lang key='updateAddressBackToCheckout' section='account data'}
							{/button}
						{/if}
					{/col}
                    {col md=12 xl=6 class="checkout-button-row-new-address"}
                        {if isset($Lieferadresse->kLieferadresse) && !isset($smarty.get.fromCheckout)}
                            {link type="button"  class="btn btn-primary btn-block" href="{get_static_route id='jtl.php' params=['editLieferadresse' => 1]}"}
                                {lang key='newShippingAddress' section='account data'}
                            {/link}
                        {/if}
                    {/col}
				{/row}
			{/block}
		{/form}
		{if $Lieferadressen|count > 0 && !isset($smarty.get.editAddress)}
			</div>
		{/if}
		{block name='account-shipping-address-form-form-address-wrapper'}
			{if !isset($smarty.get.fromCheckout) && $Lieferadressen|count > 0}
				<div class="card mt-sm sa-card">
					<div class="card-body">
						{foreach $Lieferadressen as $address}
							{block name='account-shipping-address-item'}
								{block name='account-shipping-address-item-modal'}
									<div class="modal modal-dialog" id="shipadress{$address@iteration}" tabindex="-1">
										<div class="modal-content">
											{block name='account-shipping-address-item-modal-header'}
												<div class="modal-header">
													<div class="modal-title h5">
														{lang key="shippingAdress" section="account data"}
													</div>
													<button type="button" class="close-btn" data-dismiss="modal" aria-label="Close">
													</button>
												</div>
											{/block}
											{block name='account-shipping-address-item-modal-body'}
												<div class="modal-body">
													{if $address->cFirma}{$address->cFirma}<br />{/if}
													<strong>{if $address->cTitel}{$address->cTitel}{/if} {$address->cVorname} {$address->cNachname}</strong><br />
													{$address->cStrasse} {$address->cHausnummer}<br />
													{$address->cPLZ} {$address->cOrt}<br />
													{include file='checkout/inc_delivery_address.tpl' Lieferadresse=$address hideMainInfo=true}
													{if $Einstellungen.kaufabwicklung.bestellvorgang_kaufabwicklungsmethode == 'N' && $address->nIstStandardLieferadresse !== 1}
														<hr class="invisible hr-sm">
														<a href="" class="btn btn-block">{lang key='setAsStandard' section='account data'}</a>
													{/if}
												</div>
											{/block}
										</div>
									</div>
								{/block}
								{block name='account-shipping-address-item-card'}
									<div class="flx flx-ac item">
										{block name='account-shipping-address-item-card-info'}
											<span class="w100">
												<strong class="block">{if $address->cTitel}{$address->cTitel}{/if} {$address->cVorname} {$address->cNachname}</strong>
												<small class="text-muted">{$address->cStrasse} {$address->cHausnummer}, {$address->cPLZ} {$address->cOrt}</small>
											</span>	
										{/block}
										{block name='account-shipping-address-item-card-popup'}
											<button class="btn btn-blank" data-toggle="modal" data-target="#shipadress{$address@iteration}">
												<span class="img-ct icon">
													<svg>
													  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-info"></use>
													</svg>
												</span>		
											</button>
										{/block}
										{block name='account-shipping-address-item-card-edit'}
											<a class="btn btn-blank" href="{get_static_route id='jtl.php'}?editLieferadresse=1&editAddress={$address->kLieferadresse}">
												<span class="img-ct icon">
													<svg>
													  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
													</svg>
												</span>		
											</a>
										{/block}
										{block name='account-shipping-address-item-card-delete'}
											<a class="btn btn-blank" href="{get_static_route id='jtl.php'}?editLieferadresse=1&deleteAddress={$address->kLieferadresse}">
												<span class="img-ct icon">
													<svg>
													  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
													</svg>
												</span>
											</a>
										{/block}
									</div>
								{/block}
							{/block}
						{/foreach}
					</div>
				</div>
			{/if}
		{/block}
    {/block}
{/block}