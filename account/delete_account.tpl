{block name='account-delete-account'}
	{block name='account-delete-account-headline'}
		<h1 class="h2">{lang key="deleteAccount" section="login"}</h1>
	{/block}
	{block name='account-delete-account-text'}
		<p class="text-danger">{lang key='reallyDeleteAccount' section='login'}</p>
	{/block}
	{block name='account-delete-account-form'}
		<form id="delete_account" action="{get_static_route id='jtl.php'}" method="post">
			{$jtl_token}
			<div class="form-group">
			<label for="delete-account-password">{lang key='currentPassword' section='login'}</label>
			<input id="delete-account-password" name="delete-account-password" type="password" placeholder="{lang key='currentPassword' section='login'}" autocomplete="off" required=true />
			</div>
			<input type="hidden" name="del_acc" value="1" />
			<input type="submit" class="submit btn btn-danger" value="{lang key="deleteAccount" section="login"}" />
		</form>
	{/block}
{/block}