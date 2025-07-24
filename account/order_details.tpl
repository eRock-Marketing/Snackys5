{block name='account-order-details'}
    <script type="text/javascript">
        if (top.location !== self.location) {ldelim}
            top.location = self.location.href;
        {rdelim}
    </script>

    <h1 class="h2 mb-spacer mb-small">{lang key="orderCompletedPre" section="checkout"}: {$Bestellung->cBestellNr}</h1>
    {block name="order-details-order-info"}
        <div class="card">
            <div class="card-body">
                <span class="icon-wt"><strong>{lang key="orderDate" section="login"}:</strong> {$Bestellung->dErstelldatum_de} </span><strong>Status:</strong> {$Bestellung->Status}
            </div>
        </div>
    {/block}
    <hr class="invisible">
    {block name='order-details-basket'}
        <h2 class="h3">{lang key='basket'}</h2>
        {include file='account/order_item.tpl' tplscope='confirmation'}
        {include file='account/downloads.tpl'}
        {include file='account/uploads.tpl'}
    {/block}
{/block}