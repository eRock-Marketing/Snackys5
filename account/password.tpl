{block name='account-password'}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    {include file="snippets/extension.tpl"}
	
    <div id="newpw">

    {if $step === 'formular'}
        {block name="password-reset-form"}
            <h1 class="h2 mb-spacer mb-small">{lang key="forgotPassword" section="global"}</h1>    
            {if !empty($cFehler)}
                <div class="alert alert-danger">{$cFehler}</div>
            {/if}
            {block name="password-reset-form-body"}
            <form id="passwort_vergessen" action="{get_static_route id='pass.php'}{if $bExclusive === true}?exclusive_content=1{/if}" method="post" class="panel jtl-validate">
                {$jtl_token}
                <legend>{lang key="createNewPassword" section="forgot password"}</legend>
                {$alertList->displayAlertByKey('forgotPasswordDesc')}
                <fieldset>
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
                    <div class="form-group">
                        {if $bExclusive === true}
                          <input type="hidden" name="exclusive_content" value="1" />
                        {/if}
                        <input type="hidden" name="passwort_vergessen" value="1" />
                        <input type="submit" class="btn btn-primary btn-block submit submit_once" value="{lang key="createNewPassword" section="forgot password"}" />
                    </div>
                </fieldset>
            </form>
            {/block}
        {/block}
    {elseif $step === 'confirm'}
        {block name="password-reset-confirm"}
        <h1 class="h2 mb-spacer mb-small">{block name="password-reset-confirm-title"}{lang key="createNewPassword" section="forgot password"}{/block}</h1>    
        {if !empty($cFehler)}
            <div class="alert alert-danger">{$cFehler}</div>
        {/if}
            {block name="password-reset-confirm-body"}
            <form id="passwort_vergessen" action="{get_static_route id='pass.php'}{if $bExclusive === true}?exclusive_content=1{/if}" method="post" class="panel jtl-validate">
                {$jtl_token}
                <fieldset>
                    <div class="form-group required">
                        <label for="pw_new" class="control-label">{lang key='password' section='account data'}</label>
                        <input type="password" name="pw_new" id="pw_new" class="form-control" placeholder="{lang key='password' section='account data'}*" required>
                    </div>
                    <div class="form-group required">
                        <label for="pw_new_confirm" class="control-label">{lang key='passwordRepeat' section='account data'}</label>
                        <input type="password" name="pw_new_confirm" id="pw_new_confirm" class="form-control" placeholder="{lang key='passwordRepeat' section='account data'}*" required>
                    </div>
                    <div class="form-group">
                        {if $bExclusive === true}
                            <input type="hidden" name="exclusive_content" value="1">
                        {/if}
                        <input type="hidden" name="fpwh" value="{$fpwh}">
                        <input type="submit" class="btn btn-primary btn-block submit submit_once" value="{lang key="confirmNewPassword" section="forgot password"}">
                    </div>
                </fieldset>
            </form>
            {/block}
        {/block}
    {else}
        <h1 class="h2 mb-spacer mb-small">{block name="password-reset-confirm-title"}{lang key="createNewPassword" section="forgot password"}{/block}</h1> 
        <div class="alert alert-success">{lang key="newPasswortWasGenerated" section="forgot password"}</div>
    {/if}
        </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}