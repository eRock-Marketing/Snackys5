{block name='productlist-result-options'}
{assign var=ismobile value=false}
{if $isMobile && !$isTablet}
    {assign var=ismobile value=true}
{/if}
{assign var=contentFilters value=$NaviFilter->getAvailableContentFilters()}
{assign var=show_filters value=$Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab == 0
        || $NaviFilter->getSearchResults()->getProductCount() >= $Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab
        || $NaviFilter->getFilterCount() > 0}

        {block name="productlist-result-options-sort"}
        <div class="form-group dropdown filter-type-FilterItemSort ftr-sort">
            <a href="#" class="btn btn-default dropdown-toggle form-control{if $ismobile} btn-block{/if}" data-toggle="dropdown" role="button" aria-expanded="true">
                {lang key='sorting' section='productOverview'} <span class="caret"></span>
            </a>
            <ul class="dropdown-menu dropdown-menu-right">
                {foreach $Suchergebnisse->getSortingOptions() as $option}
                <li class="filter-item{if $option->isActive()} active{/if}">
                    <a rel="nofollow" href="{$option->getURL()}">{$option->getName()}</a>
                </li>
                {/foreach}
            </ul>
        </div>
        {/block}
{/block}