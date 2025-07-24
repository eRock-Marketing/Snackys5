{block name='account-login'}
	<div id="log">
		{block name='account-login-headline'}
			<h1 class="h2 mb-sm">
				{if !empty($oRedirect->cName)}
					{$oRedirect->cName}
				{else}
					{lang key="loginTitle" section="login"}
				{/if}
			</h1>
		{/block}
		{block name="login-form"}
			{include file="snippets/zonen.tpl" id="opc_before_login"}
			<form id="login_form" action="{get_static_route id='jtl.php'}" method="post" role="form" class="panel jtl-validate">
				{$jtl_token}
				<fieldset>
					{block name="login-form-headline"}
						<legend>{lang section="checkout" key="loginForRegisteredCustomers"}</legend>
					{/block}
					{block name="login-form-alerts"}
						{if empty($cHinweis)}
							<div class="alert alert-info">{lang key="loginDesc" section="login"} {if isset($oRedirect) && $oRedirect->cName}{lang key="redirectDesc1" section="global"} {$oRedirect->cName} {lang key="redirectDesc2" section="global"}.{/if}</div>
						{elseif !$alertNote}
							<div class="alert alert-info">{lang key='loginDesc' section='login'} {if isset($oRedirect) && $oRedirect->cName}{lang key='redirectDesc1'} {$oRedirect->cName} {lang key='redirectDesc2'}.{/if}</div>
						{/if}
					{/block}
					{block name="login-form-mail"}
						<div class="form-group required">
							<label for="email" class="control-label">{lang key="emailadress" section="global"}</label>
							<input type="email" name="email" id="email" class="form-control" placeholder="{lang key="emailadress" section="global"}*" required spellcheck="false" autocorrect="off"/>
						</div>
					{/block}
					{block name="login-form-password"}
						<div class="form-group required">
							<label for="password" class="control-label">{lang key="password" section="account data"}</label>
							<input type="password" name="passwort" id="password" class="form-control" placeholder="{lang key="password" section="account data"}" autocomplete="on" required/>
						</div>
					{/block}
					{block name="login-form-captcha"}
						{if isset($showLoginCaptcha) && $showLoginCaptcha}
							<div class="form-group text-center float-label-control">
								{captchaMarkup getBody=true}
							</div>
						{/if}
					{/block}
					{block name="login-form-submit"}
						<div class="form-group">
							<hr class="invisible hr-sm">
							<input type="hidden" name="login" value="1" />
							{if !empty($oRedirect->cURL)}
								{foreach $oRedirect->oParameter_arr as $oParameter}
									<input type="hidden" name="{$oParameter->Name}" value="{$oParameter->Wert}" />
								{/foreach}
								<input type="hidden" name="r" value="{$oRedirect->nRedirect}" />
								<input type="hidden" name="cURL" value="{$oRedirect->cURL}" />
							{/if}
							<input type="submit" value="{lang key="login" section="checkout"}" class="btn btn-primary btn-block submit"/>
						</div>
					{/block}
				</fieldset>
				{block name="login-form-forgotpass"}
					<small class="text-right block">
					   <a class="defaultlink" href="{get_static_route id='pass.php'}">{lang key="forgotPassword" section="global"}</a>
					</small>
				{/block}
			</form>
		{/block}
		{block name='account-login-spacer'}
			<hr class="invisible">
		{/block}
		{block name="register-block"}
			<div class="panel new-ct">
				{block name="register-block-heading"}
					<div class="pane-heading">
						<span class="block h4">{lang key="newHere" section="global"}</span>
					</div>
				{/block}
				{block name="register-block-content"}
					<div class="panel-body">
						<p>{lang key="createNewAccountDesc" section="checkout"}</p>
						<p><a class="register btn btn-block" href="{get_static_route id='registrieren.php'}"> {lang key="registerNow" section="global"}</a></p>
					</div>
				{/block}
			</div>
		{/block}
	</div>
{/block}