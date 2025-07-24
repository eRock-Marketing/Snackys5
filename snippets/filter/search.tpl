{block name='snippets-filter-search'}
    {$limit = $Einstellungen.template.productlist.filter_max_options}
    {$collapseInit = false}
    <ul class="nav nav-list blanklist">
    {foreach $NaviFilter->searchFilterCompat->getOptions() as $searchFilter}
        {block name='snippets-filter-search-navitem'}
            <li>
                <a rel="nofollow" href="{$searchFilter->getURL()}" class="filter-item {if $searchFilter->isActive()}active{/if}" aria-label="{lang key='filterBy'}: {$searchFilter->getName()|escape:'html'}">
                    <span class="value">{$searchFilter->getName()}</span>
                    {badge variant="outline-secondary"}{$searchFilter->getCount()} <span class="sr-only">{lang key='products'} {lang key='found'}</span>{/badge}
                </a>
            </li>
        {/block}
    {/foreach}
    </ul>
{/block}
