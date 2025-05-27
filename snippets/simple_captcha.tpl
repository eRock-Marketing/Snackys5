{block name='snippets-simple-captcha'}
<div class="form-group float-label-control">
    <input type="hidden" name="{$captchaToken}" value="{$captchaCode}">
    {if isset($bAnti_spam_failed) && $bAnti_spam_failed}
        <div class="form-error-msg text-danger"><i class="fa fa-warning"></i>
            {lang key='invalidToken' section='global'}
        </div>
    {/if}
</div>
{/block}
