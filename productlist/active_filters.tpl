{block name='er-active-filters'}
    {if $NaviFilter->getFilterCount() > 0}
        {if !$isMobile}
            <hr>
        {/if}
        {block name='er-active-filters-wrapper'}
            <div class="active-filters{if $isMobile} mb-sm{/if}">
                {foreach $NaviFilter->getActiveFilters() as $activeFilter}
                    {block name='er-active-filters-assigns'}
                        {assign var=activeFilterValue value=$activeFilter->getValue()}
                        {assign var=activeValues value=$activeFilter->getActiveValues()}
                    {/block}
                    {if $activeFilterValue !== null}
                        {block name='er-active-filters-items'}
                            {if $activeValues|is_array}
                                {block name='er-active-filters-items-array'}
                                    {foreach $activeValues as $filterOption}
                                        {strip}
                                            <a href="{$activeFilter->getUnsetFilterURL($filterOption->getValue())}" rel="nofollow" title="Filter {lang key='delete'}" class="btn btn-sm filter-type-{$activeFilter->getNiceName()}">
                                                <div class="img-ct icon mr-xxs">
                                                    <svg>
                                                    <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
                                                    </svg>
                                                </div>
                                                {$filterOption->getFrontendName()}
                                            </a>
                                        {/strip}
                                    {/foreach}
                                {/block}
                            {else}
                                {block name='er-active-filters-items-single'}
                                    {strip}
                                        <a href="{$activeFilter->getUnsetFilterURL($activeFilter->getValue())}" rel="nofollow" title="Filter {lang key='delete'}" class="btn btn-sm filter-type-{$activeFilter->getNiceName()}">
                                            <div class="img-ct icon mr-xxs">
                                                <svg>
                                                <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
                                                </svg>
                                            </div>
                                            {$activeValues->getFrontendName()}  
                                        </a>
                                    {/strip}
                                {/block}
                            {/if}
                        {/block}
                    {/if}
                {/foreach}
                {if $NaviFilter->getURL()->getUnsetAll() !== null}
                    {block name='er-active-filters-delete-all'}
                        {strip}
                            <a href="{$NaviFilter->getURL()->getUnsetAll()}" title="{lang key='removeFilters'}" class="btn btn-sm">
                                <div class="img-ct icon mr-xxs">
                                    <svg>
                                    <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
                                    </svg>
                                </div>
                                {lang key='removeFilters'}
                            </a>
                        {/strip}
                    {/block}
                {/if}
            </div>
        {/block}
    {/if}
{/block}