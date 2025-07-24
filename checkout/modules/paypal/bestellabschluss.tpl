{block name='checkout-modules-paypal-bestellabschluss'}
    {block name='checkout-modules-paypal-bestellabschluss-script'}
        {inline_script}<script>
            $(document).ready(function () {
                $('#paypal_button').hide();
                $('#paypal_text').html('{lang key='redirect' section='global'}');
                $('#paypal_checkout').submit();
            });
        </script>{/inline_script}
    {/block}

    {block name='checkout-modules-paypal-bestellabschluss-content'}
        <div style="margin:10px 0;">
            {strip}
                <div>
                    {image src="{$ShopURL|replace:"http://":"//"}/gfx/PayPal/horizontal_solution_PP.gif" alt="PayPal Logo"}
                </div>
            {/strip}
            <div style="margin:10px 0;" id="paypal_text">
                <noscript>
                    {lang key='paypalDesc' section='checkout'}
                </noscript>
            </div>
            <div>
                {block name='checkout-modules-paypal-bestellabschluss-form'}
                    {form method="post" action=$url id="paypal_checkout"}
                        {foreach $fields as $value}
                            {input type="hidden" name=$name value=$value|escape:'html'}
                        {/foreach}
                        {input type="submit" value="{lang key='paypalBtn' section='checkout'}" id="paypal_button"}
                    {/form}
                {/block}
            </div>
        </div>
    {/block}
{/block}
