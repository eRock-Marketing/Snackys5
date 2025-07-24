{block name='checkout-order-completed'}
	{block name="header"}
		{include file='layout/header.tpl'}
	{/block}
	{block name="content"}
		{block name="content-extension"}
			{include file="snippets/extension.tpl"}
		{/block}
		<div class="order-completed">
			{block name='order-paymentmodules'}
        		{include file='checkout/inc_paymentmodules.tpl' showBasket='order-item'}
			{/block}
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