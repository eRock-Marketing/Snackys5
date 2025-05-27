{block name='register-form-customer-login'}
    {block name='login-mail'}
        <div class="form-group float-label-control required">
            <label for="email" class="control-label">{lang key="email" section="account data"}</label>
            <input type="text" name="email" id="login_email" class="form-control" placeholder="{lang key="email" section="account data"}" required />
        </div>
    {/block}
    {block name='login-password'}
        <div class="form-group float-label-control required">
            <label for="password" class="control-label">{lang key="password" section="account data"}</label>
            <input type="password" name="passwort" id="login_password" class="form-control" placeholder="{lang key="password" section="account data"}" required />
            <a class="small" href="{get_static_route id='pass.php'}"> {lang key="forgotPassword" section="global"}</a>
        </div>
    {/block}
    {block name='login-captcha'}
        {if isset($showLoginCaptcha) && $showLoginCaptcha}
            <div class="form-group text-center float-label-control">
                {captchaMarkup getBody=true}
            </div>
        {/if}
    {/block}
    {block name='login-submit-wrapper'}
        <div class="form-group">
            <input type="hidden" name="login" value="1" />
            <input type="hidden" name="wk" value="{if isset($one_step_wk)}{$one_step_wk}{else}0{/if}" />
            {if !empty($oRedirect->cURL)}
                {foreach $oRedirect->oParameter_arr as $oParameter}
                    <input type="hidden" name="{$oParameter->Name}" value="{$oParameter->Wert}" />
                {/foreach}
                <input type="hidden" name="r" value="{$oRedirect->nRedirect}" />
                <input type="hidden" name="cURL" value="{$oRedirect->cURL}" />
            {/if}
            {block name='login-submit-button'}
                <input type="submit" value="{lang key="login" section="checkout"}" class="btn btn-primary {if !isset($withSidebar) || $withSidebar === 0}btn-block{/if} btn-lg submit" />
            {/block}
        </div>
    {/block}
{/block}