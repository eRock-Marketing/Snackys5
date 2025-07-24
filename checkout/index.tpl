{block name='checkout-index'}
	{block name='checkout-index-assigns'}
		{if !isset($viewportImages)}
			{assign var="viewportImages" value=0}
		{/if}
	{/block}
	{block name="header"}
		{if !isset($bAjaxRequest) || !$bAjaxRequest}
			{include file='layout/header.tpl' smallversion=true}
		{/if}
	{/block}
	{block name="content"}   
		<div id="result-wrapper">
        	<div id="checkout">
				{block name="content-steps"}
            		{include file="checkout/inc_steps.tpl"}
				{/block}
            	{if $step === 'accountwahl'}
					{block name="content-login-or-register"}
                		{include file='checkout/step0_login_or_register.tpl'}
					{/block}
            	{elseif $step === 'edit_customer_address' || $step === 'Lieferadresse'}
					{block name="content-register-form"}
                		{include file='checkout/step1_edit_customer_address.tpl'}
					{/block}
            	{elseif $step === 'Versand' || $step === 'Zahlung'}
					{block name="content-shpping-payment"}
                		{include file='checkout/step3_shipping_options.tpl'}
					{/block}
            	{elseif $step === 'ZahlungZusatzschritt'}
					{block name="content-payment-extra"}
                		{include file='checkout/step4_payment_additional.tpl'}
					{/block}
            	{elseif $step === 'Bestaetigung'}
					{block name="content-confirmation"}
                		{include file='checkout/step5_confirmation.tpl'}
					{/block}
            	{/if}
				{block name="content-steps-next"}
					{include file="checkout/inc_steps_next.tpl"}
				{/block}
        	</div>
			{block name="content-javascript"}    
				<script type="text/javascript">
					if (top.location !== self.location) {ldelim}
						top.location = self.location.href;
					{rdelim}
				</script>
			{/block}
    	</div>
		{block name="content-parse-basket-modal"}
			{if (isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1)}
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">{lang key="basket" section="global"}</h4>
						</div>
						<section class="tmp-modal-content">
							<div class="modal-body">
								{lang key="basket2PersMerge" section="login"}
								<div class="answer">
									<a href="{get_static_route id='bestellvorgang.php'}?basket2Pers=1&token={$smarty.session.jtl_token}">{lang key="yes" section="global"}</a>
									<a href="{get_static_route id='bestellvorgang.php'}?updatePersCart=1&token={$smarty.session.jtl_token}" class="x">{lang key="no" section="global"}</a>
								</div>
							</div>
						</section>
					</div>
				</div>
    		{/if}
		{/block}
	{/block}
	{block name="footer"}
		{if !isset($bAjaxRequest) || !$bAjaxRequest}
			{include file='layout/footer.tpl' smallversion=true}
		{/if}
	{/block}
{/block}