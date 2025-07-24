{block name='snippets-filter-characteristic'}
    {$is_dropdown = ($Merkmal->cTyp === 'SELECTBOX')}
    {$collapseInit = false}
    <ul class="nav nav-list blanklist{if $Merkmal->getData('cTyp') === 'BILD'} dpflex-wrap img-ftr{/if}">
    {foreach $Merkmal->getOptions() as $attributeValue}
        {$attributeImageURL = null}
        {if ($Merkmal->getData('cTyp') === 'BILD' || $Merkmal->getData('cTyp') === 'BILD-TEXT')}
            {$attributeImageURL = $attributeValue->getImage(\JTL\Media\Image::SIZE_XS)}
            {if $attributeImageURL|strpos:$smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN !== false
                || $attributeImageURL|strpos:$smarty.const.BILD_KEIN_MERKMALWERTBILD_VORHANDEN !== false}
                {$attributeImageURL = null}
            {/if}
        {/if}
        {if $is_dropdown}
            {block name='snippets-filter-characteristics-dropdown'}
            <li class="nav-it">
                {dropdownitem
                    class="{if $attributeValue->isActive()}active{/if} filter-item dpflex-a-center"
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
                        <span class="ctr">{$attributeValue->getCount()}</span>
                {/dropdownitem}
            </li>
            {/block}
        {else}
            {block name='snippets-filter-characteristics-nav'}
                {if {$Merkmal->getData('cTyp')} === 'TEXT'}
                    {block name='snippets-filter-characteristics-nav-text'}
                        <li class="nav-it">
                        {link
                            class="{if $attributeValue->isActive()}active{/if} filter-item dpflex-a-center"
                            href="{if !empty($attributeValue->getURL())}{$attributeValue->getURL()}{else}#{/if}"
                            title="{$attributeValue->getValue()|escape:'html'}"
                        }
                                {if !empty($attributeImageURL)}
                                    {image lazy=true webp=true
                                        src=$attributeImageURL
                                        alt=$attributeValue->getValue()|escape:'html'
                                        class="vmiddle"
                                    }
                                {/if}
                                <span class="word-break">{$attributeValue->getValue()|escape:'html'}</span>
                                <span class="ctr">{$attributeValue->getCount()}</span>
                        {/link}
                        </li>
                    {/block}
                {elseif $Merkmal->getData('cTyp') === 'BILD' && $attributeImageURL !== null}
                    {block name='snippets-filter-characteristics-nav-image'}
                        <li class="nav-it">
                        {link href="{if !empty($attributeValue->getURL())}{$attributeValue->getURL()}{else}#{/if}"
                            title="{$attributeValue->getValue()|escape:'html'}: {$attributeValue->getCount()}"
                            data=["toggle"=>"tooltip", "placement"=>"top", "boundary"=>"window"]
                            class="{if $attributeValue->isActive()}active{/if} filter-item"
                        }
                            <span class="img-ct icon">
                            {image lazy=true  webp=true
                                src=$attributeImageURL
                                alt=$attributeValue->getValue()|escape:'html'
                                title="{$attributeValue->getValue()|escape:'html'}: {$attributeValue->getCount()}"
                                class="vmiddle filter-img"
                            }
                            </span>
                        {/link}
                        </li>
                    {/block}
                {else}
                    {block name='snippets-filter-characteristics-nav-else'}
                        <li class="nav-it">
                            {link href="{if !empty($attributeValue->getURL())}{$attributeValue->getURL()}{else}#{/if}"
                                title="{$attributeValue->getValue()|escape:'html'}: {$attributeValue->getCount()}"
                                class="{if $attributeValue->isActive()}active{/if} filter-item dpflex-a-center"
                            }
                            {if !empty($attributeImageURL)}
                                <span class="img-ct mr-xxs icon ic-md">
                                {image lazy=true webp=true
                                    src=$attributeImageURL
                                    alt=$attributeValue->getValue()|escape:'html'
                                    title="{$attributeValue->getValue()|escape:'html'}: {$attributeValue->getCount()}"
                                    class="vmiddle filter-img"
                                }
                                </span>
                            {/if}
                            <span class="word-break">
                                {$attributeValue->getValue()|escape:'html'}
                            </span>
                            <span class="ctr">{$attributeValue->getCount()}</span>
                            {/link}
                        </li>
                    {/block}
                {/if}
            {/block}
        {/if}
    {/foreach}
    </ul>
{/block}
