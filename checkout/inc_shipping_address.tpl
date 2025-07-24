{block name='checkout-inc-shipping-address'}
{if isset($fehlendeAngaben.shippingAddress)}
    {assign var='fehlendeAngabenShipping' value=$fehlendeAngaben.shippingAddress}
{else}
    {assign var="fehlendeAngabenShipping" value=null}
{/if}
{assign var="showShippingAddress" value=(isset($Lieferadresse) || !empty($kLieferadresse) || isset($forceDeliveryAddress))}
<div class="form-group checkbox control-toggle{if isset($forceDeliveryAddress)} hidden{/if}" id="checkout_register_shipping_address_div">
    <input type="hidden" name="shipping_address" value="1">
    <label for="checkout_register_shipping_address" class="btn-block mt-sm{if isset($forceDeliveryAddress)} hidden{/if}" data-toggle="collapse" data-target="#select_shipping_address">
        <input id="checkout_register_shipping_address" class="radio-checkbox" type="checkbox" name="shipping_address" value="0"{if !$showShippingAddress} checked="checked"{/if} />
        <span class="control-label label-default">
            {lang key="shippingAdressEqualBillingAdress" section="account data"}
        </span>
    </label>
</div>
{block name="checkout-enter-shipping-address"}
<div id="select_shipping_address" class="mt-md{if $showShippingAddress || isset($smarty.get.editLieferadresse)}  collapse show{/if}"{if $showShippingAddress || isset($smarty.get.editLieferadresse)} style="display:block;"{/if}>
    {block name="checkout-enter-shipping-address-body"}
    {if !empty($smarty.session.Kunde->kKunde) && isset($Lieferadressen) && $Lieferadressen|count > 0}
        <div class="h4">{lang key="deviatingDeliveryAddress" section="account data"}</div>
        <div class="form-group">
            {foreach $Lieferadressen as $adresse}
                {if $adresse->kLieferadresse>0}
                    <div class="payship-option">
                        <label class="dpflex-a-center m0 stc-radio" for="delivery{$adresse->kLieferadresse}" data-toggle="collapse" data-target="#register_shipping_address.show">
                            <span class="stc-input">
                                <input class="radio-checkbox" type="radio" name="kLieferadresse" value="{$adresse->kLieferadresse}" id="delivery{$adresse->kLieferadresse}" {if $kLieferadresse == $adresse->kLieferadresse}checked{/if}>
                                <span class="stc-radio-btn"></span>
                            </span>
				            <span class="payship-content">
                                {if $adresse->cFirma}{$adresse->cFirma|entferneFehlerzeichen},{/if} {$adresse->cVorname} {$adresse->cNachname|entferneFehlerzeichen}, {$adresse->cStrasse|entferneFehlerzeichen} {$adresse->cHausnummer}, {$adresse->cPLZ} {$adresse->cOrt}, {$adresse->angezeigtesLand}
                            </span>
                        </label>
                    </div>
                {/if}
            {/foreach}
            <div class="payship-option">
                <label class="dpflex-a-center m0 stc-radio" for="delivery_new" data-toggle="collapse" data-target="#register_shipping_address:not(.show)">
                    <span class="stc-input">
                        <input class="radio-checkbox" type="radio" name="kLieferadresse" value="-1" id="delivery_new" {if $kLieferadresse == -1}checked{/if} required="required" aria-required="true">                                
                        <span class="stc-radio-btn"></span>
                    </span>
                    <span class="payship-content">
                        {lang key="createNewShippingAdress" section="account data"}
                    </span>
                </label>
            </div>
        </div>
        <fieldset id="register_shipping_address" class="collapse panel collapse-non-validate{if $kLieferadresse == -1} show{/if}" aria-expanded="{if $kLieferadresse == -1}true{else}false{/if}">
            <span class="h4 block">{lang key="createNewShippingAdress" section="account data"}</span>
            {include file="checkout/customer_shipping_address.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
            {include file="checkout/customer_shipping_contact.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
        </fieldset>
    {else}
        <fieldset class="panel">
            <span class="h4 block">{lang key="createNewShippingAdress" section="account data"}</span>
            {include file="checkout/customer_shipping_address.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
            {include file="checkout/customer_shipping_contact.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
        </fieldset>
    {/if}
    {/block}
</div>
{/block}
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