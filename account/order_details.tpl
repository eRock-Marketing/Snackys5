{block name='account-order-details'}
	{block name='account-order-details-js'}
		<script type="text/javascript">
			if (top.location !== self.location) {ldelim}
				top.location = self.location.href;
			{rdelim}
		</script>
	{/block}
	{block name='account-order-details-headline'}
    	<h1 class="h2 mb-sm">
			{lang key="orderCompletedPre" section="checkout"}: {$Bestellung->cBestellNr}
		</h1>
	{/block}
    {block name="order-details-order-info"}
        <div class="card">
            <div class="card-body">
                <span class="icon-wt"><strong>{lang key="orderDate" section="login"}:</strong> {$Bestellung->dErstelldatum_de} </span><strong>Status:</strong> {$Bestellung->Status}
            </div>
        </div>
    {/block}
    <hr class="invisible">
    {block name='order-details-basket'}
		{block name='order-details-basket-headline'}
        	<h2 class="h3">{lang key='basket'}</h2>
		{/block}
		{block name='order-details-basket-items'}
        	{include file='account/order_item.tpl' tplscope='confirmation'}
		{/block}
		{block name='order-details-basket-downloads'}
			{include file='account/downloads.tpl'}
		{/block}
		{block name='order-details-basket-uploads'}
        	{include file='account/uploads.tpl'}
		{/block}
    {/block}
{/block}