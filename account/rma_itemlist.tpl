{block name='account-rma-itemlist'}
{if isset($rmaItems)}
    {cardheader}
    {block name='account-rma-itemlist-header'}
    <div class="d-flex justify-content-between align-items-center">
        <span class="h3 mb-0">
            {lang key='rma_products' section='rma'}
        </span>
        <span class="badge badge-secondary">{count($rmaItems)}</span>
    </div>
    {/block}
    {/cardheader}
    {block name='account-rma-itemlist-body'}
    <ul class="list-group list-compressed" id="rma-sticky-item-list">
        {foreach $rmaItems as $item}
            <li class="list-group-item justify-content-between lh-condensed">
                <div class="pr-2">
                    <h6 class="my-0 line-clamp line-clamp-2">{$item->name}</h6>
                    <small>{lang key='quantity'}: {$item->quantity}{$item->unit}</small>
                </div>
            </li>
        {/foreach}
    </ul>
    {/block}
{/if}
{/block}
