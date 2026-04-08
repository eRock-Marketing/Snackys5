{block name='snippets-withdrawal-form'}
    {form method="post"
          action=""
          class="withdrawal-form jtl-validate"
          addhoneypot=true
          slide=true}
        {input type="hidden" name="withdrawal" value="1"}
        {if !empty($withdrawalErrors)}
            {alert variant="danger" dismissible=true}
                {lang key='fillOut'}
            {/alert}
        {/if}

        {row}
            {col cols=12 md=6}
                {formgroup label="{lang key='name'}"
                           label-for="withdrawal_name"
                           class="{if isset($withdrawalErrors.name)}has-error{/if}"}
                    {if isset($withdrawalErrors.name)}
                        <div class="form-error-msg" aria-live="assertive" role="alert">
                            <i class="fas fa-exclamation-triangle"></i> {lang key='fillOut'}
                        </div>
                    {/if}
                    {input type="text"
                           id="withdrawal_name"
                           name="withdrawal_name"
                           required=true
                           placeholder=" "
                           value=$withdrawalValues.name|default:''}
                {/formgroup}
            {/col}
            {col cols=12 md=6}
                {formgroup label="{lang key='yourOrderId' section='checkout'}"
                           label-for="withdrawal_order"
                           description="{if isset($Kunde) && $Kunde->kKunde > 0}<a href=\"{get_static_route id='jtl.php'}?bestellungen=1\" target=\"_blank\">{lang key='orderOverview' section='account data'}</a>{/if}"}
                    {input type="text"
                           id="withdrawal_order"
                           name="withdrawal_order"
                           required=true
                           placeholder=" "
                           value=$withdrawalValues.orderNumber|default:''}
                {/formgroup}
            {/col}
        {/row}

        {row}
            {col cols=12 md=6}
                {formgroup label="{lang key='email' section='account data'}"
                           label-for="withdrawal_email"
                           class="{if isset($withdrawalErrors.email)}has-error{/if}"}
                    {if isset($withdrawalErrors.email)}
                        <div class="form-error-msg" aria-live="assertive" role="alert">
                            <i class="fas fa-exclamation-triangle"></i> {lang key='invalidEmail'}
                        </div>
                    {/if}
                    {input type="email"
                           id="withdrawal_email"
                           name="withdrawal_email"
                           required=true
                           placeholder=" "
                           value=$withdrawalValues.email|default:''}
                {/formgroup}
            {/col}
        {/row}

        {row}
            {col cols=12}
                {formgroup label="{lang key='comment' section='productDetails'}" label-for="withdrawal_comment"}
                    {textarea id="withdrawal_comment"
                        name="withdrawal_comment"
                        rows="5"
                        placeholder=" "}{$withdrawalValues.comment|default:''}{/textarea}
                {/formgroup}
            {/col}
        {/row}

        {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true)
            && isset($Einstellungen.kunden.widerruf_abfragen_captcha) && $Einstellungen.kunden.widerruf_abfragen_captcha !== 'N'
            && JTL\Session\Frontend::getCustomer()->getID() === 0}
            {block name='withdrawal-form-captcha'}
                {row}
                    {col cols=12 md=6}
                        {formgroup class="simple-captcha-wrapper {if isset($withdrawalErrors.captcha) && $withdrawalErrors.captcha != false} has-error{/if}"}
                            {captchaMarkup getBody=true}
                        {/formgroup}
                    {/col}
                {/row}
            {/block}
        {/if}

        {row}
            {col cols=12 md=4 class='ml-auto-util'}
                {button type='submit' variant='primary' class='btn-block'}
                    {lang key='sendWithdrawal' section='global'}
                {/button}
            {/col}
        {/row}
    {/form}
{/block}
