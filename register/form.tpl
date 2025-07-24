{block name='register-form'}
    <form method="post" action="{get_static_route id='registrieren.php'}" class="jtl-validate">
        {$jtl_token}
        {block name='register-form-include-customer-account'}
            {include file='register/form/customer_account.tpl'}
        {/block}
        <hr>
        {block name='register-form-include-shipping-address'}
            {if isset($checkout) && $checkout === 1}}
                {include file='checkout/inc_shipping_address.tpl'}
            {/if}
        {/block}
        <input type="hidden" name="checkout" value="{if isset($checkout)}{$checkout}{/if}">
        <input type="hidden" name="form" value="1">
        <input type="hidden" name="editRechnungsadresse" value="{$editRechnungsadresse}">
        {include file="snippets/zonen.tpl" id="opc_before_submit"}
        {block name='register-form-mandatory-notice'}
            <p class="small text-muted">(* = {lang key='mandatoryFields'})</p>
        {/block}
        {block name='register-form-privacy-notice'}
            <p class="privacy text-muted">
                <a href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}{/if}" class="popup small tdu">
                    {lang key='privacyNotice'}
                </a>
            </p>
        {/block}
        {block name='register-form-submit'}
            <input type="submit" class="btn btn-primary btn-lg submit submit_once" value="{lang key="sendCustomerData" section="account data"}">
        {/block}
    </form>
{/block}