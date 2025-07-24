{block name='register-index'}
{if !isset($viewportImages)}{assign var="viewportImages" value=0}{/if}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    {if $step === 'formular'}
        {if isset($checkout) && $checkout == 1}
            {include file='checkout/inc_steps.tpl'}
            {if !empty($smarty.session.Kunde->kKunde)}
                {lang key="changeBillingAddress" section="account data" assign="panel_heading"}
            {else}
                {lang key="createNewAccount" section="account data" assign="panel_heading"}
            {/if}
        {/if}
    
        {include file="snippets/extension.tpl"}
        {if !empty($fehlendeAngaben)}
            <div class="alert alert-danger">{lang key='mandatoryFieldNotification' section='errorMessages'}</div>
        {/if}
        {if isset($fehlendeAngaben.email_vorhanden) && $fehlendeAngaben.email_vorhanden == 1}
            <div class="alert alert-danger">{lang key="emailAlreadyExists" section="account data"}</div>
        {/if}
        {if isset($fehlendeAngaben.formular_zeit) && $fehlendeAngaben.formular_zeit == 1}
            <div class="alert alert-danger">{lang key="formToFast" section="account data"}</div>
        {/if}
        <div id="new_customer" class="row">
			<div class="col-12">
				{if !isset($checkout) && empty($smarty.session.Kunde->kKunde)}
					{include file="snippets/zonen.tpl" id="opc_before_heading"}
					<h1 class="mb-sm">{lang key="createNewAccount" section="account data"}</h1>
				{/if}
				<div class="panel-wrap" id="panel-register-form">
					{include file="snippets/zonen.tpl" id="opc_before_form"}
					{include file='register/form.tpl'}
				</div>
			</div>
		</div>
                        
    
    {elseif $step === 'formular eingegangen'}
		{include file="snippets/zonen.tpl" id="opc_before_heading"}
        <h1>{lang key="accountCreated" section="global"}</h1>
			{include file="snippets/zonen.tpl" id="opc_after_heading"}
        <p>{lang key="activateAccountDesc" section="global"}</p>
    {/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}