{if $NaviFilter->getFilterCount() > 0}
    {if !$isMobile}
        <hr>
    {/if}
    <div class="active-filters{if $isMobile} mb-sm{/if}">
            {foreach $NaviFilter->getActiveFilters() as $activeFilter}
                {assign var=activeFilterValue value=$activeFilter->getValue()}
                {assign var=activeValues value=$activeFilter->getActiveValues()}
                {if $activeFilterValue !== null}
                    {if $activeValues|is_array}
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
                    {else}
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
                    {/if}
                {/if}
            {/foreach}
            {if $NaviFilter->getURL()->getUnsetAll() !== null}
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
            {/if}
    </div>
{/if}