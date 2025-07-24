{block name='snippets-language-dropdown'}
    {$languages = JTL\Session\Frontend::getLanguages()}
    {if $languages|count > 1}
        {if (isset($isFooter) && $isFooter) || (isset($isHeader) && $isHeader)}
        <div class="dropdown lng-dd{if isset($isFooter) && $isFooter} mb-xxs{/if}">
        {else}
        <li class="dropdown{if isset($isMobileMenu) && $isMobileMenu}-style visible-xs{/if} lng-dd">
        {/if}
            <a href="#" class="language-dropdown {if isset($isMobileMenu) && $isMobileMenu}mm-mainlink l-full{else}flx-ac{/if} {$dropdownClass|default:''}{if isset($isFooter) && $isFooter} btn btn-block btn-sm{/if}"{if !(isset($isMobileMenu) && $isMobileMenu)} data-toggle="dropdown"{/if} title="{lang key='selectLang'}">
                {foreach $languages as $language}
                    {if $language->getId() === JTL\Shop::getLanguageID()}
                        {block name='snippets-language-dropdown-text'}
                            <span class="img-ct icon {if isset($isHeader) && $isHeader}icon-xl{/if} rt4x3{if (isset($isFooter) && $isFooter) || (isset($isMobileMenu) && $isMobileMenu)} mr-xxs{/if}">
                                {if $language->getIso639()|lower == 'de' || $language->getIso639()|lower == 'en'}
                                    <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{$language->getIso639()|lower}"></use>
                                    </svg>
                                {else}
                                    {image alt=$language->getDisplayLanguage()
                                        lazy=true
                                        webp=true
                                        src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/lang-flags/{$language->getIso639()|lower}.png"
                                    }
                                {/if}
                            </span>
                            {if (isset($isFooter) && $isFooter) || (isset($isMobileMenu) && $isMobileMenu)}<span class="name">{$language->getDisplayLanguage()}</span>{/if}
                        {/block}
                    {/if}
                {/foreach}
                <span class="caret{if isset($isMobileMenu) && $isMobileMenu} hidden-xs{/if}"></span>{if isset($isMobileMenu) && $isMobileMenu}{include file='snippets/mobile-menu-arrow.tpl'}{/if}
            </a>
            <ul class="dropdown-menu">
            {foreach $languages as $language}
                {block name='snippets-language-dropdown-item'}
                    {if $language->getId() != JTL\Shop::getLanguageID()}
                    <li>
                        <a href="{$language->getUrl()}" class="link-lang flx-ac"  data-iso="{$language->getIso()}" rel="nofollow">
                            <span class="img-ct icon {if isset($isHeader) && $isHeader}ic-lg{/if} rt4x3 mr-xxs">
                                {if $language->getIso639()|lower == 'de' || $language->getIso639()|lower == 'en'}
                                    <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{$language->getIso639()|lower}"></use>
                                    </svg>
                                {else}
                                    {image alt=$language->getDisplayLanguage()
                                        lazy=true
                                        webp=true
                                        src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/lang-flags/{$language->getIso639()|lower}.png"
                                    }
                                {/if}
                            </span>
                            <span class="name">{$language->getDisplayLanguage()}</span>
                        </a>
                    </li>
                    {/if}
                {/block}
            {/foreach}
            </ul>
        {if (isset($isFooter) && $isFooter) || (isset($isHeader) && $isHeader)}
        </div>
        {else}
        </li>
        {/if}
    {/if}
{/block}
