{block name='snippets-filter-pricerange'}
<ul class="{if isset($class)}{$class}{else}nav nav-list blanklist{/if}">
    {if $NaviFilter->hasPriceRangeFilter()}
        {if $NaviFilter->getPriceRangeFilter()->getOffsetStart() >= 0 && $NaviFilter->getPriceRangeFilter()->getOffsetEnd() > 0}
            <li>
                <a href="{$NaviFilter->URL->getPriceRanges()}" rel="nofollow" class="active">
                    <span class="value">
                        {$NaviFilter->getPriceRangeFilter()->getOffsetStartLocalized()} - {$NaviFilter->getPriceRangeFilter()->getOffsetEndLocalized()}
                    </span>
                </a>
            </li>
        {/if}
    {else}
        {foreach $Suchergebnisse->Preisspanne as $oPreisspannenfilter}
            <li>
			{* $oPreisspannenfilter|print_r *}
                <a href="{$oPreisspannenfilter->cURL}" rel="nofollow">
                    <span class="badge">{$oPreisspannenfilter->nAnzahlArtikel}</span>
                    <span class="value">
                        {$oPreisspannenfilter->getOffsetStartLocalized()}  - {$oPreisspannenfilter->getOffsetEndLocalized()}
                    </span>
                </a>
            </li>
        {/foreach}
    {/if}
</ul>
{/block}