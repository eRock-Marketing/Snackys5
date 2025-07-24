{block name='checkout-order-completed'}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}   

    {include file="snippets/extension.tpl"}
    
    <div class="order-completed">
        {include file='checkout/inc_paymentmodules.tpl'}
    
		{block name='order-completed'}
        {if isset($abschlussseite)}
            {include file='checkout/inc_order_completed.tpl'}
        {/if}
        {/block}
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}