{block name='account-change-password'}
	{block name='account-change-password-headline'}
		<h1 class="h2">{lang key="changePassword" section="login"}</h1>
	{/block}

	{block name="change-password-form"}
		{block name="change-password-form-text"}
			<p>{lang key='changePasswordDesc' section='login'}</p>
		{/block}
		<form id="password" action="{get_static_route id='jtl.php'}" method="post" class="jtl-validate">
			{$jtl_token}
			{block name="change-password-form-currentpass"}
				<div class="form-group required">
					<label for="currentPassword" class="control-label">{lang key="currentPassword" section="login"}</label>
					<input type="password" name="altesPasswort" id="currentPassword" class="form-control" required>
				</div>
			{/block}
			{block name="change-password-form-newpass"}
				<div class="form-group required">
					<label for="newPassword" class="control-label">{lang key="newPassword" section="login"}</label>
					<input type="password" name="neuesPasswort1" id="newPassword" class="form-control" required autocomplete="new-password" maxlength="255">
				</div>
			{/block}
			{block name="change-password-form-newpassrpt"}
				<div class="form-group required">
					<label for="newPasswordRpt" class="control-label">{lang key="newPasswordRpt" section="login"}</label>
					<input type="password" name="neuesPasswort2" id="newPasswordRpt" class="form-control" required>
				</div>
			{/block}
			{block name="change-password-form-submit"}
				<div class="form-group">
					<hr class="invisible hr-sm">
					<input type="hidden" name="pass_aendern" value="1">
					<input type="submit" value="{lang key="changePassword" section="login"}" class="submit btn btn-primary btn-block btn-lg">
				</div>
			{/block}
		</form>
	{/block}
{/block}