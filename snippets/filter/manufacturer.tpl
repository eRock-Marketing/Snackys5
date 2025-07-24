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
            <a href="{if !empty($filterOption->getURL())}{$filterOption->getURL()}{else}#{/if}" title="{$filterOption->getName()}: {$filterOption->getCount()}" data=$tooltip class="filter-item dpflex-a-center {if $filterOption->isActive()}active{/if}">
                {if $Einstellungen.navigationsfilter.hersteller_anzeigen_als == 'B'}
                    {block name='snippets-filter-manufacturer-item-image'}
                    <span class="img-ct icon ic-lg icon-wt">
                        {image lazy=true webo=true src=$filterOption->getData('cBildpfadKlein') class="vmiddle filter-img"}
                    </span>
                    <span class="ctr">{$filterOption->getCount()}</span>
                    {/block}
                {elseif $Einstellungen.navigationsfilter.hersteller_anzeigen_als === 'BT'}
                    {block name='snippets-filter-manufacturer-item-image-text'}
                        <span class="dpflex-a-center">
                            <span class="img-ct icon ic-lg icon-wt">
                                {image lazy=true webp=true src=$filterOption->getData('cBildpfadKlein') class="vmiddle filter-img"}
                            </span>
                            <span class="word-break">{$filterOption->getName()}</span>
                        </span>
                        <span class="ctr">{$filterOption->getCount()}</span>
                    {/block}
                {elseif $Einstellungen.navigationsfilter.hersteller_anzeigen_als === 'T'}
                    {block name='snippets-filter-manufacturer-item-text'}
                        <i class="far fa-{if $filterIsActive === true}check-{/if}square snippets-filter-item-icon-right"></i>
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
