{block name='register-form'}
<form method="post" action="{get_static_route id='registrieren.php'}" class="evo-validate">
    {$jtl_token}
    {include file='register/form/customer_account.tpl'}
    <hr>
    {if isset($checkout) && $checkout === 1}}
        {include file='checkout/inc_shipping_address.tpl'}
    {/if}
    <input type="hidden" name="checkout" value="{if isset($checkout)}{$checkout}{/if}">
    <input type="hidden" name="form" value="1">
    <input type="hidden" name="editRechnungsadresse" value="{$editRechnungsadresse}">
	
	{include file="snippets/zonen.tpl" id="opc_before_submit"}
    <p class="privacy text-muted text-right">
        <a href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}{/if}" class="popup">
            {lang key='privacyNotice'}
        </a>
    </p>
    <input type="submit" class="btn btn-primary btn-lg submit submit_once" value="{lang key="sendCustomerData" section="account data"}">
</form>
{/block}