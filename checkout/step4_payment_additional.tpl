{block name='checkout-step4-payment-additional'}
	<form id="form_payment_extra" class="form payment_extra" method="post" action="{get_static_route id='bestellvorgang.php'}">
		{block name='step4-additional-payment'}
			<div id="order-additional-payment" class="bottom15 form-group">
				{$jtl_token}
				{include file=$Zahlungsart->cZusatzschrittTemplate}
				<input type="hidden" name="zahlungsartwahl" value="1" />
				<input type="hidden" name="zahlungsartzusatzschritt" value="1" />
				<input type="hidden" name="Zahlungsart" value="{$Zahlungsart->kZahlungsart}" />
			</div>
		{/block}
		{block name='step4-submit'}
			<div class="text-right">
				<button type="submit" value="{lang key="continueOrder" section="account data"}" class="submit btn btn-lg submit_once btn-primary">{lang key="continueOrder" section="account data"}</button>
			</div>
		{/block}
	</form>
{/block}