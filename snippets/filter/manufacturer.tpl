{block name='snippets-filter-manufacturer'}
    {$collapseInit = false}
    <ul class="nav blanklist">
    {foreach $filter->getOptions() as $filterOption}
        <li class="nav-it">
        {assign var=filterIsActive value=$filterOption->isActive() || $NaviFilter->getFilterValue($filter->getClassName()) === $filterOption->getValue()}
        {block name='snippets-filter-manufacturer-item'}
            {if $Einstellungen.navigationsfilter.hersteller_anzeigen_als == 'B'}
                {$tooltip = ["toggle"=>"tooltip", "placement"=>"top", "boundary"=>"window"]}
            {else}
                {$tooltip = []}
            {/if}
            <a href="{if !empty($filterOption->getURL())}{$filterOption->getURL()}{else}#{/if}" title="{$filterOption->getName()}: {$filterOption->getCount()}" data=$tooltip class="filter-item flx-ac {if $filterOption->isActive()}active{/if}" rel="nofollow">
                {if $Einstellungen.navigationsfilter.hersteller_anzeigen_als == 'B'}
                    {block name='snippets-filter-manufacturer-item-image'}
                    <span class="img-ct icon ic-lg icon-wt">
                        {image lazy=true webp=true src=$filterOption->getData('cBildpfadKlein') alt=$filterOption->getName()|escape:'html' class="vmiddle filter-img"}
                    </span>
                    <span class="ctr">{$filterOption->getCount()}</span>
                    {/block}
                {elseif $Einstellungen.navigationsfilter.hersteller_anzeigen_als === 'BT'}
                    {block name='snippets-filter-manufacturer-item-image-text'}
                        <span class="flx-ac">
                            <span class="img-ct icon ic-lg icon-wt">
                                {image lazy=true webp=true src=$filterOption->getData('cBildpfadKlein') alt=$filterOption->getName()|escape:'html' class="vmiddle filter-img"}
                            </span>
                            <span class="word-break">{$filterOption->getName()}</span>
                        </span>
                        <span class="ctr">{$filterOption->getCount()}</span>
                    {/block}
                {elseif $Einstellungen.navigationsfilter.hersteller_anzeigen_als === 'T'}
                    {block name='snippets-filter-manufacturer-item-text'}
                        <span class="word-break">{$filterOption->getName()}</span>
                        <span class="ctr">{$filterOption->getCount()}</span>
                    {/block}
                {/if}
            </a>
        {/block}
        </li>
    {/foreach}
    </ul>
{/block}
