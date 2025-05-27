{block name='snippets-filter-characteristic'}
    {$is_dropdown = ($Merkmal->cTyp === 'SELECTBOX')}
    {$collapseInit = false}
    {$showFilterCount = $Einstellungen.navigationsfilter.merkmalfilter_trefferanzahl_anzeigen !== 'N'
        && !($Einstellungen.navigationsfilter.merkmalfilter_trefferanzahl_anzeigen === 'E' && $Merkmal->getData('isMultiSelect'))}
    {*<div class="filter-search-wrapper">
    {block name='snippets-filter-characteristic-include-search-in-items'}
        {include file='snippets/filter/search_in_items.tpl' itemCount=count($Merkmal->getOptions()) name=$Merkmal->getName()}
    {/block}*}
    <ul class="nav nav-list blanklist{if $Merkmal->getData('cTyp') === 'BILD'} flx-w img-ftr{/if}">
    {foreach $Merkmal->getOptions() as $attributeValue}
        {$attributeImageURL = null}
        {if ($Merkmal->getData('cTyp') === 'BILD' || $Merkmal->getData('cTyp') === 'BILD-TEXT')}
            {$attributeImageURL = $attributeValue->getImage(\JTL\Media\Image::SIZE_XS)}
            {if strpos($attributeImageURL, $smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN) !== false
                || strpos($attributeImageURL, $smarty.const.BILD_KEIN_MERKMALWERTBILD_VORHANDEN) !== false}
                {$attributeImageURL = null}
            {/if}
        {/if}
        {if $is_dropdown}
            {block name='snippets-filter-characteristics-dropdown'}
            <li class="nav-it">
                {dropdownitem
                    class="{if $attributeValue->isActive()}active{/if} filter-item flx-ac"
                    href="{if !empty($attributeValue->getURL())}{$attributeValue->getURL()}{else}#{/if}"
                    title="{if $Merkmal->getData('cTyp') === 'BILD'}{$attributeValue->getValue()|escape:'html'}{/if}"
                }
                        {if !empty($attributeImageURL)}
                            {image lazy=true webp=true
                                src=$attributeImageURL
                                alt=$attributeValue->getValue()|escape:'html'
                                class="vmiddle"
                            }
                        {/if}
                        <span class="word-break">{$attributeValue->getValue()|escape:'html'}</span>
                        {if $showFilterCount}
                            <span class="ctr">{$attributeValue->getCount()}</span>
                        {/if}
                {/dropdownitem}
            </li>
            {/block}
        {else}
            {block name='snippets-filter-characteristics-nav'}
                {if {$Merkmal->getData('cTyp')} === 'TEXT'}
                    {block name='snippets-filter-characteristics-nav-text'}
                        {if $attributeValue->getCount() > 0}
                        <li class="nav-it">
                        {link
                            class="{if $attributeValue->isActive()}active{/if} filter-item flx-ac"
                            href="{if !empty($attributeValue->getURL())}{$attributeValue->getURL()}{else}#{/if}"
                            title="{$attributeValue->getValue()|escape:'html'}"
							rel="nofollow"
                        }
                                {if !empty($attributeImageURL)}
                                    {image lazy=true webp=true
                                        src=$attributeImageURL
                                        alt=$attributeValue->getValue()|escape:'html'
                                        class="vmiddle"
                                    }
                                {/if}
                                <span class="word-break">{$attributeValue->getValue()|escape:'html'}</span>
                                {if $showFilterCount}
                                    <span class="ctr">{$attributeValue->getCount()}</span>
                                {/if}
                        {/link}
                        </li>
                        {/if}
                    {/block}
                {elseif $Merkmal->getData('cTyp') === 'BILD' && $attributeImageURL !== null}
                    {block name='snippets-filter-characteristics-nav-image'}                        
                        <li class="nav-it">
                        {link href="{if !empty($attributeValue->getURL())}{$attributeValue->getURL()}{else}#{/if}"
                            title="{$attributeValue->getValue()|escape:'html'}" 
                            class="{if $attributeValue->isActive()}active{/if} filter-item" 
                            rel="nofollow"
                        }
                            <span class="img-ct icon">
                            {image lazy=true  webp=true
                                src=$attributeImageURL
                                alt=$attributeValue->getValue()|escape:'html'
                                class="vmiddle filter-img"
                            }
                            </span>
                        {/link}
                        </li>
                    {/block}
                {else}
                    {block name='snippets-filter-characteristics-nav-else'}
                        {if $attributeValue->getCount() > 0}
                        <li class="nav-it">
                            {link href="{if !empty($attributeValue->getURL())}{$attributeValue->getURL()}{else}#{/if}"
                                class="{if $attributeValue->isActive()}active{/if} filter-item flx-ac" 
                                title="{$attributeValue->getValue()|escape:'html'}" 
                                rel="nofollow"
                            }
                            {if !empty($attributeImageURL)}
                                <span class="img-ct mr-xxs icon ic-md">
                                {image lazy=true webp=true
                                    src=$attributeImageURL
                                    alt=$attributeValue->getValue()|escape:'html'
                                    class="vmiddle filter-img"
                                }
                                </span>
                            {/if}
                            <span class="word-break">
                                {$attributeValue->getValue()|escape:'html'}
                            </span>
                            {if $showFilterCount}
                                <span class="ctr">{$attributeValue->getCount()}</span>
                            {/if}
                            {/link}
                        </li>
                        {/if}
                    {/block}
                {/if}
            {/block}
        {/if}
    {/foreach}
    </ul>
    {*</div>*}
{/block}
