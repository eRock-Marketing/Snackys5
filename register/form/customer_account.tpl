{block name='register-form-customer-account'}
{block name='billing-address-form'}
	{include file='checkout/inc_billing_address_form.tpl'}
{/block}
{block name='content'}
	{if !$editRechnungsadresse}
		{if !$smarty.session.Warenkorb->hasDigitalProducts() && isset($checkout)
			&& $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
			<div class="form-group checkbox control-toggle">
				<input type="hidden" name="unreg_form" value="1">
				<label class="btn-block" for="checkout_create_account_unreg" data-toggle="collapse"
					data-target="#create_account_data">
					<input id="checkout_create_account_unreg" class="radio-checkbox" type="checkbox" name="unreg_form"
						value="0"  {if $unregForm !== 1 && !empty($fehlendeAngaben)}checked="checked"{elseif $activeClass == 'reg'}checked="checked"{/if} />
					<span class="control-label label-default">
						{lang key="createNewAccount" section="account data"}
					</span>
				</label>
			</div>
		{else}
			<input type="hidden" name="unreg_form" value="0">
		{/if}

		<div id="create_account_data" class="collapse in collapse-non-validate" aria-expanded="true"
					{if empty($checkout)
                        || $smarty.session.Warenkorb->hasDigitalProducts()
                        || $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'N'
                        || ($unregForm !== 1 && !empty($fehlendeAngaben))}
						
					{elseif isset($checkout) && $activeClass != 'reg'}
						style="display: none"
					{/if}>
            <hr class="invisible">
            <div class="panel">
                <div class="row">
                    <div class="col-md-6 col-12">
                        <div class="form-group float-label-control{if isset($fehlendeAngaben.pass_zu_kurz) || isset($fehlendeAngaben.pass_ungleich)} has-error{/if} required">
                            <label for="password" class="control-label">{lang key="password" section="account data"}</label>
                            <input type="password" name="pass" maxlength="20" id="password" class="form-control" placeholder="{lang key="password" section="account data"}" required autocomplete="off" aria-autocomplete="none">
                            {if isset($fehlendeAngaben.pass_zu_kurz)}
                                <div class="form-error-msg text-danger">
                                    {lang key='passwordTooShort' section='login' printf=$Einstellungen.kunden.kundenregistrierung_passwortlaenge}
                                </div>
                            {/if}
                        </div>
                    </div>
                    <div class="col-md-6 col-12">
                        <div class="form-group float-label-control{if isset($fehlendeAngaben.pass_ungleich)} has-error{/if} required">
                            <label for="password2" class="control-label">{lang key="passwordRepeat" section="account data"}</label>
                            <input type="password" name="pass2" maxlength="20" id="password2" class="form-control" placeholder="{lang key="passwordRepeat" section="account data"}" required data-must-equal-to="#create_account_data input[name='pass']" data-custom-message="{lang key="passwordsMustBeEqual" section="account data"}" autocomplete="off" aria-autocomplete="none">
                            {if isset($fehlendeAngaben.pass_ungleich)}
                                <div class="form-error-msg text-danger"> {lang key="passwordsMustBeEqual" section="account data"}</div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
		</div>
	{/if}
{/block}
{/block}