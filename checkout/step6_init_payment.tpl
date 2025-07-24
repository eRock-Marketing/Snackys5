{block name='checkout-step6-init-payment'}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    <div id="content">
        <div class="order_process">
            {include file='checkout/inc_paymentmodules.tpl' showBasket='inc-order-items'}
        </div>
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}