{block name='snippets-filter-active-filter'}
{if $NaviFilter->getFilterCount() > 0}
    {block name='snippets-filter-active-filter-content'}
        <div class="active-filters">
            {foreach $NaviFilter->getActiveFilters() as $activeFilter}
                {assign var=activeFilterValue value=$activeFilter->getValue()}
                {assign var=activeValues value=$activeFilter->getActiveValues()}
                {if $activeFilterValue !== null}
                    {if $activeValues|is_array}
                        {foreach $activeValues as $filterOption}
                            {block name='snippets-filter-active-filter-values'}
                                {link href=$activeFilter->getUnsetFilterURL($filterOption->getValue())
                                    rel="nofollow"
                                    title="{lang key='deleteFilter'}"
                                    class="btn btn-outline-secondary btn-sm filter-type-{$activeFilter->getNiceName()} snippets-filter-item js-filter-item"}
                                    {$filterOption->getFrontendName()}<span class="fa fa-times snippets-filter-item-icon-left"></span>
                                {/link}
                            {/block}
                        {/foreach}
                    {else}
                        {block name='snippets-filter-active-filter-value'}
                            {link href=$activeFilter->getUnsetFilterURL($activeFilter->getValue())
                                rel="nofollow"
                                title="{lang key='deleteFilter'}"
                                class="btn btn-outline-secondary btn-sm filter-type-{$activeFilter->getNiceName()} snippets-filter-item js-filter-item"}
                                {$activeValues->getFrontendName()}<span class="fa fa-times snippets-filter-item-icon-left"></span>
                            {/link}
                        {/block}
                    {/if}
                {/if}
            {/foreach}
            {if $NaviFilter->getURL()->getUnsetAll() !== null}
                {block name='snippets-filter-active-filter-remove'}
                    {link href=$NaviFilter->getURL()->getUnsetAll()
                        title="{lang key='removeFilters'}"
                        class='snippets-filter-item-all js-filter-item'}
                        {lang key='removeFilters'}
                    {/link}
                {/block}
            {/if}
        </div>
    {/block}
{/if}
{/block}
