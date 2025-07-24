{block name="account-orders"}
    <h1 class="h2 mb-spacer mb-small">{block name="account-orders-title"}{lang key="myOrders"}{/block}</h1>

    {if $Bestellungen|@count > 0}
        {block name="account-orders-body"}
            {assign var=bDownloads value=false}
            {foreach $Bestellungen as $order}
                {if isset($order->bDownload) && $order->bDownload > 0}
                    {assign var=bDownloads value=true}
                {/if}
            {/foreach}

            {include file='snippets/pagination.tpl' oPagination=$orderPagination cThisUrl='jtl.php' cParam_arr=['bestellungen'=>1] parts=['pagi', 'label']}
            <div class="card">
                <div class="card-body">
                    {foreach $orderPagination->getPageItems() as $order}
                    <a href="{$cCanonicalURL}?bestellung={$order->kBestellung}" class="dpflex-a-center item" title="{lang key='showOrder' section='login'}: {lang key='orderNo' section='login'} {$order->cBestellNr}">
                        <span class="w100">
                            <span class="row dpflex-a-center">
                                <span class="col-6">
                                    <strong class="block">{lang key="order"}: {$order->cBestellNr}</strong>
                                    <span class="block">{lang key="status"}: {$order->Status}</span>
                                </span>
                            <span class="text-muted small col-6">
                                <span class="block">{$order->dBestelldatum}</span> <span class="block">{$order->cBestellwertLocalized}</span></span>
                            </span>
                        </span>
                        <span class="img-ct icon icon-wt">
                            <svg>
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#ar-right"></use>
                            </svg>
                        </span>
                    </a>
                    {/foreach}
                </div>
            </div>
        {/block}
    {else}
        <div class="alert alert-info">{lang key='noEntriesAvailable'}</div>
    {/if}
{/block}
