{block name='snippets-filter-search-in-items'}
    {if (int)$Einstellungen.template.productlist.filter_search_count < $itemCount}
        {inputgroup size="sm"}
            {block name='snippets-filter-search-in-items-icon'}
                {inputgroupaddon prepend=true is-text=true}
                    <span class="fa fa-search"></span>
                {/inputgroupaddon}
            {/block}
            {block name='snippets-filter-search-in-items-input'}
                {input class="filter-search" placeholder={lang key='filterSearchPlaceholder' section='productOverview' printf=$name}}
            {/block}
            {block name='snippets-filter-search-in-items-clear'}
                <span class="form-clear d-none"><i class="fas fa-times"></i></span>
            {/block}
        {/inputgroup}
    {/if}
{/block}