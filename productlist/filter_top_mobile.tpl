{block name='productlist-filter-top-mobile'}
    {block name='filter-top-mobile-toggle'}
        {if $show_filters}
            <div id="ftr-tg" class="mb-{if $NaviFilter->getFilterCount() > 0}xs{else}sm{/if}">
                <div class="btn w100 flx-jb">
                    <div class="flx-ac">
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
    {/block}
    {block name='filter-top-mobile-active-filters'}
        {include file="productlist/active_filters.tpl"}
    {/block}
{/block}