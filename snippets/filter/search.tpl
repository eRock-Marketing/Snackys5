{block name='snippets-filter-search'}
    {$limit = $Einstellungen.template.productlist.filter_max_options}
    {$collapseInit = false}
    <ul class="nav nav-list blanklist">
    {foreach $NaviFilter->searchFilterCompat->getOptions() as $searchFilter}
        {block name='snippets-filter-search-navitem'}
            <li>
            {link nofollow=true
                href=$searchFilter->getURL()
                class="filter-item {if $searchFilter->isActive()}active{/if}"}
                    <span class="value">{$searchFilter->getName()}</span>
                    {badge variant="outline-secondary"}{$searchFilter->getCount()}{/badge}
            {/link}
            </li>
        {/block}
    {/foreach}
    </ul>
{/block}
