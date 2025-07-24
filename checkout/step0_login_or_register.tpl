{block name='checkout-step0-login-or-register'}
	{block name='step0-notice-missing-information'}
		{if !empty($fehlendeAngaben) && !$alertNote}
			<div class="alert alert-danger">{lang key='mandatoryFieldNotification' section='errorMessages'}</div>
		{/if}
	{/block}
	{block name='step0-notice-email-exists'}
		{if isset($fehlendeAngaben.email_vorhanden) && $fehlendeAngaben.email_vorhanden == 1}
			<div class="alert alert-danger">{lang key="emailAlreadyExists" section="account data"}</div>
		{/if}
	{/block}
	{block name='step0-notice-timeout'}
		{if isset($fehlendeAngaben.formular_zeit) && $fehlendeAngaben.formular_zeit == 1}
			<div class="alert alert-danger">{lang key="formToFast" section="account data"}</div>
		{/if}
	{/block}
	{block name='step0-assign-sidebar'}
		{if isset($boxes.left) && !$bExclusive && !empty($boxes.left)}
			{assign var="withSidebar" value=1}
		{else}
			{assign var="withSidebar" value=0}
		{/if}
	{/block}
	{block name='step0-declare-active-tab'}
		{assign var="activeClass" value="none"}
		{assign var="loginClass" value=""}
		{assign var="regClass" value=""}
		{if $snackyConfig.checkoutPosTabs == '0'}
			{assign var="loginClass" value="first"}
			{assign var="activeClass" value="login"}
			{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
				{assign var="guestClass" value="last"}
			{else}
				{assign var="regClass" value="last"}
			{/if}
		{elseif $snackyConfig.checkoutPosTabs == '1'}
			{assign var="loginClass" value="first"}
			{assign var="activeClass" value="login"}
			{assign var="regClass" value="last"}
		{elseif $snackyConfig.checkoutPosTabs == '2'}
			{assign var="regClass" value="first"}
			{assign var="activeClass" value="reg"}
			{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
				{assign var="guestClass" value="last"}
			{else}
				{assign var="loginClass" value="last"}
			{/if}
		{elseif $snackyConfig.checkoutPosTabs == '3'}
			{assign var="regClass" value="first"}
			{assign var="activeClass" value="reg"}
			{assign var="loginClass" value="last"}
		{elseif $snackyConfig.checkoutPosTabs == '4'}
			{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
				{assign var="guestClass" value="first"}
				{assign var="activeClass" value="guest"}
			{else}
				{assign var="loginClass" value="first"}
				{assign var="activeClass" value="login"}
			{/if}
			{assign var="regClass" value="last"}
		{elseif $snackyConfig.checkoutPosTabs == '5'}
			{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
				{assign var="guestClass" value="first"}
				{assign var="activeClass" value="guest"}
			{else}
				{assign var="regClass" value="first"}
				{assign var="activeClass" value="reg"}
			{/if}
			{assign var="loginClass" value="last"}
		{/if}
		{if !empty($hinweis)}
			{assign var="activeClass" value="login"}
		{/if}
		{if !empty($fehlendeAngaben) && !$hinweis}
			{assign var="activeClass" value="reg"}
		{/if}
		{if isset($fehlendeAngaben.email_vorhanden) && $fehlendeAngaben.email_vorhanden == 1}
			{assign var="activeClass" value="reg"}
		{/if}
		{if isset($fehlendeAngaben.formular_zeit) && $fehlendeAngaben.formular_zeit == 1}
			{assign var="activeClass" value="reg"}
		{/if}
		{if $smarty.post.unreg_form == 1}
		{assign var="activeClass" value="guest"}
		{/if}
	{/block}
	{block name='step0-content'}
		<div id="register-customer" class="row">
			{block name='step0-choose-way'}
				<div class="col-12 mb-sm" id="choose-way">
					<div class="row m0">
						{block name='step0-choose-way-login'}
							<div class="col-4 step-box flx-ac flx-jc login {$loginClass}{if $activeClass == 'login'} active{/if}">
								<span class="img-ct">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-user-reg"></use>
									</svg>
								</span>
								<span>{lang key="COlogin" section="custom"}</span>
							</div>
						{/block}
						{block name='step0-choose-way-register'}
							<div class="col-4 step-box flx-ac flx-jc nouser reg {$regClass}{if $activeClass == 'reg'} active{/if}">
								<span class="img-ct">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-user-new"></use>
									</svg>
								</span>
								<span>{lang key="COreg" section="custom"}</span>
							</div>
						{/block}
						{block name='step0-choose-way-guest'}
							{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
								<div class="col-4 step-box flx-ac flx-jc nouser guest {$guestClass}{if $activeClass == 'guest'} active{/if}" id="checkout-guest-btn">
									<span class="img-ct">
										<svg>
										  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-user-guest"></use>
										</svg>
									</span>
									<span>{lang key="COguest" section="custom"}</span>
								</div>
							{/if}
						{/block}
					</div>
				</div>
			{/block}
			{block name='step0-existing-customer'}
				<div id="existing-customer" class="col-12{if $activeClass != 'login'} hidden{/if}">
					<form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form jtl-validate" id="order_register_or_login">
						{block name="checkout-login"}
							<div class="panel">
								{block name="checkout-login-body"}
									<fieldset>
										{$jtl_token}
										<legend>{block name="checkout-login-title"}{lang key="alreadyCustomer" section="global"}{/block}</legend>
										{include file="register/form/customer_login.tpl" withSidebar=$withSidebar}
									</fieldset>
								{/block}
								{block name="checkout-quick-checkout-placeholders"}
									<div class="add-pays w100 mt-xxs text-center">
										<div class="paypal"></div>
										<div class="amazon"></div>
									</div>
								{/block}
							</div>
						{/block}
					</form>
				</div>
			{/block}
			{block name='step0-new-customer'}
				<div id="customer" class="col-12{if $activeClass == 'login'} hidden{/if}">
					{include file="snippets/zonen.tpl" id="checkout-before-register" title="Checkout: Vor dem Registrieren-Formular"}
					<form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form jtl-validate" id="form-register">
						{block name="checkout-register"}
							<div class="panel-wrap">
								{block name="checkout-register-body"}
									{$jtl_token}
									{include file='register/form/customer_account.tpl' checkout=1 step="formular"}

									{include file='checkout/inc_shipping_address.tpl'}
								{/block}
							</div>
						{/block}
						{block name="checkout-register-privacy-notice"}
							<div>
								<p class="privacy text-muted text-right">
									<a href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}{/if}" class="popup">
										{lang key='privacyNotice'}
									</a>
								</p>
							</div>
						{/block}
						{block name="checkout-register-submit"}
							<div class="text-right">
								<input type="hidden" name="checkout" value="1">
								<input type="hidden" name="form" value="1">
								<input type="hidden" name="editRechnungsadresse" value="0">
								<input type="submit" class="btn btn-primary btn-lg submit submit_once" value="{lang key="sendCustomerData" section="account data"}">
							</div>
						{/block}
					</form>
				</div>
			{/block}
		</div>
	{/block}
{/block}