{block name='account-password'}
	{block name="header"}
		{include file='layout/header.tpl'}
	{/block}
	{block name="content"}
		{block name='account-password-extension'}
    		{include file="snippets/extension.tpl"}
		{/block}
		{block name='account-password-outer'}
    		<div id="newpw">
				{if $step !== 'confirm'}
        			{block name="password-reset-form"}
						{block name="password-reset-form-headline"}
            				<h1 class="h2 mb-sm">{lang key="forgotPassword" section="global"}</h1>
						{/block}
						{block name="password-reset-error-msg"}
							{if !empty($cFehler)}
								<div class="alert alert-danger">{$cFehler}</div>
							{/if}
						{/block}
            			{block name="password-reset-form-body"}
            				<form id="passwort_vergessen" action="{get_static_route id='pass.php'}{if $bExclusive === true}?exclusive_content=1{/if}" method="post" class="panel jtl-validate">
                				{$jtl_token}
								{block name="password-reset-form-legend"}
                					<legend>{lang key="createNewPassword" section="forgot password"}</legend>
								{/block}
								{block name="password-reset-form-alert"}
                					{$alertList->displayAlertByKey('forgotPasswordDesc')}
								{/block}
								<fieldset>
									{block name="password-reset-form-mail"}
										<div class="form-group float-label-control required">
											<label for="email" class="control-label">{lang key="emailadress" section="global"}</label>
											<input
											type="email"
											name="email"
											id="email"
											class="form-control"
											placeholder="{lang key="emailadress" section="global"}*"
											{if $presetEmail !== ''}value="{$presetEmail}"{/if}
											required
											/>
										</div>
									{/block}
									{block name="password-reset-form-captcha"}
										{if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true)
										&& ($Einstellungen.kunden.forgot_password_captcha|default:'N')}
											<div class="form-group float-label-control{if isset($fehlendeAngaben.captcha) && $fehlendeAngaben.captcha !== false} has-error{/if}">
												{captchaMarkup getBody=true}
											</div>
											<hr>
										{/if}
									{/block}
									{block name="password-reset-form-submit"}
										<div class="form-group">
											{if $bExclusive === true}
											  <input type="hidden" name="exclusive_content" value="1" />
											{/if}
											<input type="hidden" name="passwort_vergessen" value="1" />
											<input type="submit" class="btn btn-primary btn-block submit submit_once" value="{lang key="createNewPassword" section="forgot password"}" />
										</div>
									{/block}
								</fieldset>
            				</form>
            			{/block}
        			{/block}
    			{else}
        			{block name="password-reset-confirm"}
						{block name="password-reset-confirm-headline"}
        					<h1 class="h2 mb-sm">
								{block name="password-reset-confirm-title"}
									{lang key="createNewPassword" section="forgot password"}
								{/block}
							</h1>
						{/block}
						{block name="password-reset-confirm-error-msg"}
							{if !empty($cFehler)}
								<div class="alert alert-danger">{$cFehler}</div>
							{/if}
						{/block}
						{block name="password-reset-confirm-body"}
							<form id="passwort_vergessen" action="{get_static_route id='pass.php'}{if $bExclusive === true}?exclusive_content=1{/if}" method="post" class="panel jtl-validate">
								{$jtl_token}
								<fieldset>
									{block name="password-reset-password"}
										<div class="form-group required">
											<label for="pw_new" class="control-label">{lang key='password' section='account data'}</label>
											<input type="password" name="pw_new" id="pw_new" class="form-control" placeholder="{lang key='password' section='account data'}*" required>
										</div>
									{/block}
									{block name="password-reset-passwort-rpt"}
										<div class="form-group required">
											<label for="pw_new_confirm" class="control-label">{lang key='passwordRepeat' section='account data'}</label>
											<input type="password" name="pw_new_confirm" id="pw_new_confirm" class="form-control" placeholder="{lang key='passwordRepeat' section='account data'}*" required>
										</div>
									{/block}
									{block name="password-reset-submit"}
										<div class="form-group">
											{if $bExclusive === true}
												<input type="hidden" name="exclusive_content" value="1">
											{/if}
											<input type="hidden" name="fpwh" value="{$fpwh}">
											<input type="submit" class="btn btn-primary btn-block submit submit_once" value="{lang key="confirmNewPassword" section="forgot password"}">
										</div>
									{/block}
								</fieldset>
							</form>
						{/block}
        			{/block}
    			{/if}
        	</div>
		{/block}
	{/block}
	{block name="footer"}
		{include file='layout/footer.tpl'}
	{/block}
{/block}