{block name='snippets-filter-review'}
    <ul class="{if isset($class)}{$class}{else}nav nav-list{/if}">
        {foreach $Suchergebnisse->Bewertung as $oBewertung}
            {if $NaviFilter->hasRatingFilter() && $NaviFilter->getRatingFilter()->getValue() == $oBewertung->nStern}
                <li>
                    <a rel="nofollow" href="{$NaviFilter->URL->getRatings()}" class="active">
                        <span class="badge pull-right">{$oBewertung->nAnzahl}</span>
                        <span class="value">
                            {include file='productdetails/rating.tpl' stars=$oBewertung->nStern}
                            {if $NaviFilter->getRatingFilter()->getValue() < 5}
                                <em>({lang key='from' section='productDetails'} {$oBewertung->nStern}
                                    {if $oBewertung->nStern > 1}
                                        {lang key='starPlural'}
                                    {else}
                                        {lang key='starSingular'}
                                    {/if})
                                </em>
                            {/if}
                        </span>
                    </a>
                </li>
            {elseif $oBewertung->nAnzahl >= 1 && $oBewertung->nStern > 0}
                <li>
                    <a rel="nofollow" href="{$oBewertung->cURL}">
                        <span class="badge pull-right">{$oBewertung->nAnzahl}</span>
                        <span class="value">
                            {include file='productdetails/rating.tpl' stars=$oBewertung->nStern}
                            {if $oBewertung->nStern < 5}
                                <em>
                                    ({lang key='from' section='productDetails'} {$oBewertung->nStern}
                                    {if $oBewertung->nStern > 1}
                                        {lang key='starPlural'}
                                    {else}
                                        {lang key='starSingular'}
                                    {/if})
                                </em>
                            {/if}
                        </span>
                    </a>
                </li>
            {elseif $oBewertung->nAnzahl >= 1 && $oBewertung->nStern > 0}
                <li>
                    <a rel="nofollow" href="{$oBewertung->cURL}">
                        <span class="badge pull-right">{$oBewertung->nAnzahl}</span>
                        <span class="value">
                            {include file='productdetails/rating.tpl' stars=$oBewertung->nStern}
                            {if $oBewertung->nStern < 5}
                                <em>
                                    ({lang key='from' section='productDetails'} {$oBewertung->nStern}
                                    {if $oBewertung->nStern > 1}
                                        {lang key='starPlural'}
                                    {else}
                                        {lang key='starSingular'}
                                    {/if})
                                </em>
                            {/if}
                        </span>
                    </a>
                </li>
            {/if}
        {/foreach}
    </ul>
{/block}