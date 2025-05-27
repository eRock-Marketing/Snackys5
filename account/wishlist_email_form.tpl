{block name='account-wishlist-email-form'}
	{if $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
		{block name="wishlist-email-form"}
			{block name='account-wishlist-email-form-headline'}
				<h1 class="h2">{lang key="wishlistViaEmail" section="login"}</h1>
			{/block}
			{block name="wishlist-email-form-body"}
				<form method="post" action="{get_static_route id='jtl.php'}" name="Wunschliste">
					{$jtl_token}
					<input type="hidden" name="wlvm" value="1" />
					<input type="hidden" name="wl" value="{$CWunschliste->kWunschliste}" />
					<input type="hidden" name="send" value="1" />
					{block name="wishlist-email-form-label"}
						<label for="wishlist-email">{lang key="wishlistEmails" section="login"}{if $Einstellungen.global.global_wunschliste_max_email > 0} | {lang key="wishlistEmailCount" section="login"}: {$Einstellungen.global.global_wunschliste_max_email}{/if}</label>
					{/block}
					{block name="wishlist-email-form-textarea"}
						<div class="form-group">
							<textarea id="wishlist-email" name="email" rows="5" class="form-control"></textarea>
						</div>
					{/block}
					{block name="wishlist-email-form-submit"}
						<div class="row">
							<div class="col-12">
								<input name="abschicken" type="submit" value="{lang key="wishlistSend" section="login"}" class="btn btn-primary">
							</div>
						</div>
					{/block}
				</form>
			{/block}
		{/block}
	{/if}
{/block}