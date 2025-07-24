{block name='snippets-categories-mobile'}
    {strip}
    {include file="snippets/zonen.tpl" id="before_mobilemenu_content" title="before_mobilemenu_content"}
    {block name='snippets-categories-mega-assigns'}
        {if !isset($i)}
            {assign var=i value=0}
        {/if}
        {if !isset($activeId)}
            {if $NaviFilter->hasCategory()}
                {$activeId = $NaviFilter->getCategory()->getValue()}
            {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($Artikel)}
                {$activeId = $Artikel->gibKategorie()}
            {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($smarty.session.LetzteKategorie)}
                {$activeId = $smarty.session.LetzteKategorie}
            {else}
                {$activeId = 0}
            {/if}
        {/if}
        {assign var=max_subsub_items value=5}
    {/block}
    
    {block name="mobilemenu-homelink"}
        {if $snackyConfig.megaHome == 0}
            {include file="snippets/zonen.tpl" id="before_mobilemenu_homelink" title="before_mobilemenu_homelink"}
            <li class="is-lth{if $nSeitenTyp == 18} active{/if}">
                <a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="home-icon mm-mainlink">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 26.25"><path d="M3.75 26.25h9.37v-7.5h3.76v7.5h9.37V15H30L15 0 0 15h3.75z"/></svg>
                </a>
            </li>
            {else if $snackyConfig.megaHome == 1}
            <li class="is-lth{if $nSeitenTyp == 18} active{/if}">
                <a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="mm-mainlink">
                    {lang key="linkHome" section="custom"}
                </a>
            </li>
        {/if}
    {/block}
    
    {block name="mobilemenu-pages-before"}
        {include file="snippets/zonen.tpl" id="before_mobilemenu_pages_before" title="before_mobilemenu_pages_before"}
        {if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
            {include file='snippets/linkgroup_recursive_mobile.tpl' linkgroupIdentifier='megamenu_start' dropdownSupport=true tplscope='megamenu_start' limit={$snackyConfig.mmenu_subcats}}
        {/if}
    {/block}
    
    {block name="megamenu-categories"}
        {include file="snippets/zonen.tpl" id="before_mobilemenu_categories" title="before_mobilemenu_categories"}
        {if isset($snackyConfig.show_categories) && $snackyConfig.show_categories !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
            {include file='snippets/categories_recursive_mobile.tpl' i=0 categoryId=0 limit={$snackyConfig.mmenu_subcats} caret='right'}
        {/if}
    {/block}{* /megamenu-categories*}

    {block name="megamenu-pages"}
        {include file="snippets/zonen.tpl" id="before_mobilemenu_pages" title="before_mobilemenu_pages"}
        {if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
            {include file='snippets/linkgroup_recursive_mobile.tpl' linkgroupIdentifier='megamenu' dropdownSupport=true tplscope='megamenu' limit={$snackyConfig.mmenu_subcats}}
        {/if}
    {/block}

    {block name="megamenu-manufacturers"}
        {if isset($snackyConfig.show_manufacturers) && $snackyConfig.show_manufacturers !== 'N' 
            && ($Einstellungen.global.global_sichtbarkeit != 3
                || isset($smarty.session.Kunde->kKunde)
                && $smarty.session.Kunde->kKunde != 0)}
            {include file="snippets/zonen.tpl" id="before_mobilemenu_manufacturers" title="before_mobilemenu_manufacturers"}
            {get_manufacturers assign='manufacturers'}
            {if !empty($manufacturers)}
                <li class="dropdown-style mgm-fw{if $NaviFilter->hasManufacturer() || $nSeitenTyp == PAGE_HERSTELLER} active{/if}">
                    {assign var='linkKeyHersteller' value=\JTL\Shop::Container()->getLinkService()->getSpecialPageID(LINKTYP_HERSTELLER, false)|default:0}
                    {assign var='linkSEOHersteller' value=\JTL\Shop::Container()->getLinkService()->getLinkByID($linkKeyHersteller)|default:null}
                    {if $linkSEOHersteller !== null && !empty($linkSEOHersteller->getName())}
                        <a href="{$linkSEOHersteller->getURL()}" class="mm-mainlink">
                            {$linkSEOHersteller->getName()}
                            <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
                        </a>
                    {else}
                        <span class="mm-mainlink">
                            {lang key="manufacturers"}
                            <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
                        </span>
                    {/if}
                    <ul class="dropdown-menu keepopen">
                        {if isset($linkSEOHersteller) && $snackyConfig.mmenu_link_clickable == 'N'}
                            <li class="title{if $NaviFilter->hasManufacturer() || $nSeitenTyp == PAGE_HERSTELLER} active{/if}">
                                <a href="{$linkSEOHersteller->getURL()}" class="mm-mainlink">
                                    {lang key="showAll" section="global"}
                                </a>
                            </li>
                        {/if}
                        {foreach name=hersteller from=$manufacturers item=hst}
                            <li class="title{if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller == $hst->kHersteller} active{/if}"><a href="{$hst->cURLFull}" class="dropdown-link defaultlink"><span class="notextov">{$hst->cName}</span></a></li>
                        {/foreach}
                    </ul>
                </li>
            {/if}
        {/if}
    {/block}
    
    {if $snackyConfig.mmenu_show_shopnav == '0'}
        {block name="mobilemenu-additional"}
            {include file="snippets/zonen.tpl" id="before_mobilemenu_additional" title="before_mobilemenu_additional"}
            <li class="visible-xs">
                <hr class="invisible">
            </li>
            {block name="mobilemenu-additional-login"}
                {include file="snippets/zonen.tpl" id="before_mobilemenu_additional_login" title="before_mobilemenu_additional_login"}
                <li class="dropdown-style visible-xs{if $nSeitenTyp == 4} active{/if}">
                    <a href="{get_static_route id='jtl.php'}" title="{if empty($smarty.session.Kunde->kKunde)}{lang key='login'}{else}{lang key='hello'}{/if}" class="home-icon">
                        <span class="dpflex-a-center">
                            <span class="img-ct icon icon-wt op1">
                                <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-user"></use>
                                </svg>
                            </span>
                            <span class="visible-xs text">
                                {if empty($smarty.session.Kunde->kKunde)}
                                {lang key="login"}
                                {else}
                                {lang key='myAccount'}
                                {/if}
                            </span>
                        </span>
                    </a>
                </li>
            {/block}
            {if isset($smarty.session.Wunschliste->kWunschliste) && $smarty.session.Wunschliste->CWunschlistePos_arr|count > 0}
                {block name="mobilemenu-additional-wishlist"}
                    {include file="snippets/zonen.tpl" id="before_mobilemenu_additional_wishlist" title="before_mobilemenu_additional_wishlist"}
                    <li class="dropdown-style visible-xs{if $nSeitenTyp == 16} active{/if}">
                        <a href="{get_static_route id='wunschliste.php'}" title="{lang key="goToWishlist" sektion="global"}" class="home-icon">
                            <span class="dpflex-a-center">
                                <span class="img-ct icon icon-wt op1">
                                    <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-heart"></use>
                                    </svg>
                                </span>
                                <span class="visible-xs text">
                                    {lang key="wishlist"}
                                </span>
                            </span>
                        </a>
                    </li>
                {/block}
            {/if}
            {if isset($smarty.session.Vergleichsliste) && $smarty.session.Vergleichsliste->oArtikel_arr|count > 1}
                {block name="mobilemenu-additional-comparelist"}
                    {include file="snippets/zonen.tpl" id="before_mobilemenu_additional_comparelist" title="before_mobilemenu_additional_comparelist"}
                    <li class="dropdown-style visible-xs">
                        <a href="{get_static_route id='vergleichsliste.php'}" title="{lang key="compare" sektion="global"}"{if $Einstellungen.vergleichsliste.vergleichsliste_target === 'blank'} target="_blank"{/if} class="popup home-icon">
                            <span class="dpflex-a-center">
                                <span class="img-ct icon icon-wt op1">
                                    <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-compare"></use>
                                    </svg>
                                </span>
                                <span class="visible-xs text">
                                    {lang key="compare" sektion="global"}
                                </span>
                            </span>
                        </a>
                    </li>
                {/block}
            {/if}
            {block name="mobilemenu-additional-basket"}
                {include file="snippets/zonen.tpl" id="before_mobilemenu_additional_basket" title="before_mobilemenu_additional_basket"}
                <li class="dropdown-style visible-xs{if $nSeitenTyp == 3} active{/if}">
                    <a href="{get_static_route id='warenkorb.php'}" title="{lang key='basket'}" class="home-icon">
                        <span class="dpflex-a-center">
                            <span class="img-ct icon icon-wt op1">
                                <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
                                </svg>
                            </span>
                            <span class="visible-xs text">{lang key='basket'}</span>
                        </span>
                    </a>
                </li>
            {/block}
        {/block}
    {/if}
    {if $snackyConfig.languageMobileNav == 'Y'}
        {block name="mobilemenu-language-currency"}
            {block name="mobilemenu-language"}
                {if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
                    {include file="snippets/language_dropdown.tpl" isMobileMenu=true}
                {/if}
            {/block}
            {block name="mobilemenu-currency"}
                {if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
                    <li class="dropdown-style visible-xs">
                        <a href="#" class="dropdown-toggle mm-mainlink" title="{lang key='selectCurrency'}">
                            {$smarty.session.Waehrung->getName()} {include file='snippets/mobile-menu-arrow.tpl'}
                        </a>
                        <ul class="dropdown-menu">
                        {foreach from=$smarty.session.Waehrungen item=oWaehrung}
                            <li>
                                <a href="{$oWaehrung->getURL()}" rel="nofollow">{$oWaehrung->getName()}</a>
                            </li>
                        {/foreach}
                        </ul>
                    </li>
                {/if}
            {/block}
        {/block}
    {/if}
    {include file="snippets/zonen.tpl" id="after_mobilemenu_content" title="after_mobilemenu_content"}
{/strip}
{/block}