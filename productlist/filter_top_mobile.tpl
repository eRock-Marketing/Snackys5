{block name='productlist-filter-top-mobile'}
    {if $show_filters}
    <div id="ftr-tg" class="mb-{if $NaviFilter->getFilterCount() > 0}xs{else}sm{/if}">
        <div class="btn w100 dpflex-j-b">
            <div class="dpflex-a-c">
                <div class="img-ct icon ic-md mr-xxs">
                    <svg>
                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-filter"></use>
                    </svg>
                </div>
                {lang key='filterAndSort'}
            </div>
            {if $Suchergebnisse->getProductCount() >= 1}{$Suchergebnisse->getProductCount()} {lang key='products'}{/if}
        </div>
    </div>
    {/if}
    {include file="productlist/active_filters.tpl"} 
{/block}