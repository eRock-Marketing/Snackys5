{block name='register-index'}
    {block name='register-assigns'}
        {if !isset($viewportImages)}{assign var="viewportImages" value=0}{/if}
    {/block}
    {block name="header"}
        {include file='layout/header.tpl'}
    {/block}
    {block name="content"}
        {if $step === 'formular'}
            {if isset($checkout) && $checkout == 1}
                {block name='register-checkout-steps'}
                    {include file='checkout/inc_steps.tpl'}
                {/block}
                {block name='register-checkout-assigns'}
                    {if JTL\Session\Frontend::getCustomer()->getID() > 0}
                        {lang key="changeBillingAddress" section="account data" assign="panel_heading"}
                    {else}
                        {lang key="createNewAccount" section="account data" assign="panel_heading"}
                    {/if}
                {/block}
            {/if}
            {block name='register-extension'}
                {include file="snippets/extension.tpl"}
            {/block}
            {block name='register-alerts'}
                {if !empty($fehlendeAngaben)}
                    <div class="alert alert-danger">{lang key='mandatoryFieldNotification' section='errorMessages'}</div>
                {/if}
                {if isset($fehlendeAngaben.email_vorhanden) && $fehlendeAngaben.email_vorhanden == 1}
                    <div class="alert alert-danger">{lang key="emailAlreadyExists" section="account data"}</div>
                {/if}
                {if isset($fehlendeAngaben.formular_zeit) && $fehlendeAngaben.formular_zeit == 1}
                    <div class="alert alert-danger">{lang key="formToFast" section="account data"}</div>
                {/if}
            {/block}
            {block name='register-new-customer'}
                <div id="new_customer" class="row">
                    <div class="col-12">
                        {block name='register-new-customer-headline'}
                            {if !isset($checkout) && JTL\Session\Frontend::getCustomer()->getID() === 0}
                                {include file="snippets/zonen.tpl" id="opc_before_heading"}
                                <h1 class="mb-sm">{lang key="createNewAccount" section="account data"}</h1>
                            {/if}
                        {/block}
                        {block name='register-form'}
                            <div class="panel-wrap" id="panel-register-form">
                                {include file="snippets/zonen.tpl" id="opc_before_form"}
                                {include file='register/form.tpl'}
                            </div>
                        {/block}
                    </div>
                </div>
            {/block}     
        {elseif $step === 'formular eingegangen'}
            {block name='register-successfull'}
                {include file="snippets/zonen.tpl" id="opc_before_heading"}
                <h1>{lang key="accountCreated" section="global"}</h1>
                    {include file="snippets/zonen.tpl" id="opc_after_heading"}
                <p>{lang key="activateAccountDesc" section="global"}</p>
            {/block}
        {/if}
    {/block}
    {block name="footer"}
        {include file='layout/footer.tpl'}
    {/block}
{/block}