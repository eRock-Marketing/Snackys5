{block name='account-address-form'}
	<h1 class="h2 mb-sm">{lang key="editBillingAdress" section="account data"}</h1>
	<form id="rechnungsdaten" action="{get_static_route id='jtl.php' params=['editRechnungsadresse' => 1]}" method="post" class="panel-wrap jtl-validate">
		<div id="panel-address-form">
			{$jtl_token}
			{include file='checkout/inc_billing_address_form.tpl'}
			<input type="hidden" name="editRechnungsadresse" value="1" />
			<input type="hidden" name="edit" value="1" />
			<hr class="invisible hr-sm">
			<div class="form-group">
				<hr class="hr-sm invisible">
				<input type="submit" class="btn btn-primary submit btn-block btn-lg" value="{lang key="editBillingAdress" section="account data"}" />
			</div>
		</div>
	</form>
{/block}