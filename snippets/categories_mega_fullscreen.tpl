{block name='snippets-categories-mega-fullscreen'}
{strip}
{assign var=max_subsub_items value=5}
{if $snackyConfig.megaHome == 0}
<li class="is-lth{if $nSeitenTyp == 18} active{/if}">
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="home-icon">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 26.25"><path d="M3.75 26.25h9.37v-7.5h3.76v7.5h9.37V15H30L15 0 0 15h3.75z"/></svg>
	</a>
</li>
{else if $snackyConfig.megaHome == 1}
<li class="is-lth{if $nSeitenTyp == 18} active{/if}">
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}">
		{lang key="linkHome" section="custom"}
	</a>
</li>
{/if}
{if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
    {include file='snippets/linkgroup_list_fullscreen.tpl' linkgroupIdentifier='megamenu_start' dropdownSupport=true tplscope='megamenu_start'}
{/if}

{block name="megamenu-categories"}
{if isset($snackyConfig.show_categories) && $snackyConfig.show_categories !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
    {assign var='show_subcategories' value=false}
    {if isset($snackyConfig.show_subcategories) && $snackyConfig.show_subcategories !== 'N'}
        {assign var='show_subcategories' value=true}
    {/if}

    {get_category_array categoryId=0 assign='categories'}
    {if !empty($categories)}
        {if !isset($activeId)}
            {if $NaviFilter->hasCategory()}
                {$activeId = $NaviFilter->getCategory()->getValue()}
            {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($Artikel)}
                {assign var='activeId' value=$Artikel->gibKategorie()}
            {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($smarty.session.LetzteKategorie)}
                {$activeId = $smarty.session.LetzteKategorie}
            {else}
                {$activeId = 0}
            {/if}
        {/if}
        {if !isset($activeParents) && ($nSeitenTyp == 1 || $nSeitenTyp == 2)}
            {get_category_parents categoryId=$activeId assign='activeParents'}
        {/if}
        {foreach name='categories' from=$categories item='category'}
            {assign var='isDropdown' value=false}
            {if isset($category->hasChildren()) && $category->hasChildren()}
                {assign var='isDropdown' value=true}
            {/if}
            <li class="{if $isDropdown}mgm-fw{/if}{if $category->getID() == $activeId || (isset($activeParents[0]) && $activeParents[0]->getID() == $category->getID())} active{/if}">
                <a href="{$category->getURL()}">
                    {$category->getShortName()}
                    {if $isDropdown}<span class="ar ar-r"></span><span class="fa-caret-down visible-xs"></span>{/if}
                </a>
                {if $isDropdown}
                    <ul class="mm-fullscreen">
                        <li>
								<a class="category-title block" href="{$category->getURL()}">
									{$category->cName}
								</a>
                                    {assign var=hasInfoColumn value=false}
                                    {if isset($snackyConfig.show_maincategory_info) && $snackyConfig.show_maincategory_info !== 'N' && ($category->cBildURL !== 'gfx/keinBild.gif' || !empty($category->cBeschreibung))}
                                        {assign var=hasInfoColumn value=true}
                                        <div class="visible-lg mega-info-lg top15 pr hiden-xs">
                                                {if $category->cBildURL !== 'gfx/keinBild.gif' && !$isMobile}
                                                    <a class="img-ct{if $snackyConfig.imageratioCategory == '43'}  rt4x3{/if}" href="{$category->getURL()}">
													{include file='snippets/image.tpl'
																		class='img-responsive'
																		item=$category
																		square=false
																		srcSize='sm'}
                                                    </a>
                                                    <div class="clearall top15"></div>
                                                {/if}
                                                {if $category->cBildURL !== 'gfx/keinBild.gif'}<div class="description text-muted">{/if}{$category->getDescription()}{if $category->cBildURL !== 'gfx/keinBild.gif'}</div>{/if}
                                        </div>
                                    {/if}
                                        <div class="row row-eq-height row-eq-img-height {if $hasInfoColumn} hasInfoColumn{/if} subcat-list">
                                            {if $category->hasChildren()}
                                                {if !empty($category->getChildren())}
                                                    {assign var=sub_categories value=$category->getChildren()}
                                                {else}
                                                    {get_category_array categoryId=$category->getID() assign='sub_categories'}
                                                {/if}
                                                {foreach name='sub_categories' from=$sub_categories item='sub'}
                                                    <div class="col-12 col-sm-6 col-md-4 col-lg-3 category-wrapper top15{if $sub->getID() == $activeId || (isset($activeParents[1]) && $activeParents[1]->getID() == $sub->getID())} active{/if}">
                                                            {if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N' && !$isMobile}
                                                                    <a class="img text-center pr block hidden-xs" href="{$sub->getURL()}">
                                                                        <span class="img-ct{if $snackyConfig.imageratioCategory == '43'}  rt4x3{/if}">
																			{include file='snippets/image.tpl'
																								class='image'
																								item=$sub
																								square=false
																								srcSize='sm'}
                                                                        </span>
                                                                    </a>
                                                            {/if}
                                                                    <a class="h5 title caption{if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N'} text-center{/if}" href="{$sub->getURL()}">
                                                                            {$sub->getShortName()}
																		{if $show_subcategories && $sub->hasChildren()}
																		<span class="fa-caret-down visible-xs"></span>
																		{/if}
                                                                    </a>
                                                            {if $show_subcategories && $sub->hasChildren()}
                                                                {if !empty($sub->getChildren())}
                                                                    {assign var=subsub_categories value=$sub->getChildren()}
                                                                {else}
                                                                    {get_category_array categoryId=$sub->getID() assign='subsub_categories'}
                                                                {/if}
                                                                <hr class="hr-sm hidden-xs">
                                                                <ul class="list-unstyled small subsub">
                                                                    {foreach name='subsub_categories' from=$subsub_categories item='subsub'}
                                                                        {if $smarty.foreach.subsub_categories.iteration <= $max_subsub_items}
                                                                            <li{if $subsub->getID() == $activeId || (isset($activeParents[2]) && $activeParents[2]->getID() == $subsub->getID())} class="active"{/if}>
                                                                                <a href="{$subsub->getURL()}">
                                                                                    {$subsub->getShortName()}
                                                                                </a>
                                                                            </li>
                                                                        {else}
                                                                            <li class="more"><a href="{$sub->getURL()}">{lang key="more" section="global"} <span class="remaining">({math equation='total - max' total=$subsub_categories|count max=$max_subsub_items})</span></a></li>
                                                                            {break}
                                                                        {/if}
                                                                    {/foreach}
                                                                </ul>
                                                            {/if}
                                                    </div>
                                                {/foreach}
                                            {/if}
                                        </div>{* /row *}
                                    {* /mega-categories *}
                                {* /row *}
                            {* /mgm-c *}
                        </li>
                    </ul>
                {/if}
            </li>
        {/foreach}
    {/if}
{/if}
{/block}{* /megamenu-categories*}

{block name="megamenu-pages"}
{if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
    {include file='snippets/linkgroup_list_fullscreen.tpl' linkgroupIdentifier='megamenu' dropdownSupport=true tplscope='megamenu'}
{/if}
{/block}{* megamenu-pages *}

{block name="megamenu-manufacturers"}
{if isset($snackyConfig.show_manufacturers) && $snackyConfig.show_manufacturers !== 'N' 
    && ($Einstellungen.global.global_sichtbarkeit != 3
        || isset($smarty.session.Kunde->kKunde)
        && $smarty.session.Kunde->kKunde != 0)}
    {get_manufacturers assign='manufacturers'}
    {if !empty($manufacturers)}
        <li class="mgm-fw mm-manu{if $NaviFilter->hasManufacturer() || $nSeitenTyp == PAGE_HERSTELLER} active{/if}">
            {assign var='linkKeyHersteller' value=\JTL\Shop::Container()->getLinkService()->getSpecialPageID(LINKTYP_HERSTELLER, false)|default:0}
            {assign var='linkSEOHersteller' value=\JTL\Shop::Container()->getLinkService()->getLinkByID($linkKeyHersteller)|default:null}
            {if $linkSEOHersteller !== null && !empty($linkSEOHersteller->getName())}
                <a href="{$linkSEOHersteller->getURL()}">
                    {$linkSEOHersteller->getName()}
                    <span class="caret"></span>
                </a>
            {else}
                <a class="no-link">
                    {lang key="manufacturers"}
                    <span class="ar ar-r"></span><span class="fa-caret-down visible-xs"></span>
                </a>
            {/if}
            <ul class="mm-fullscreen">
                <li>
                        <div class="category-title manufacturer">
                            {if isset($linkSEOHersteller)}
                                <a href="{$linkSEOHersteller->getURL()}">{$linkSEOHersteller->getName()}</a>
                            {else}
                                <span>{lang key="manufacturers" section="global"}</span>
                            {/if}
                        </div>
						<div class="row row-eq-height row-eq-img-height hasInfoColumn subcat-list">
							{foreach name=hersteller from=$manufacturers item=hst}
								<div class="col-12 col-sm-6 col-md-4 col-lg-3 category-wrapper manufacturer top15{if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller == $hst->kHersteller} active{/if}">
										{if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N' && !$isMobile}
												<a class="img text-center pr block hidden-xs" href="{$hst->cURLFull}"><span class="img-ct{if $snackyConfig.imageratioCategory == '43'}  rt4x3{/if}">
													{include file='snippets/image.tpl'
														class='submenu-headline-image'
														item=$hst
														square=false
														srcSize='sm'}
												</span></a>
										{/if}
											<a class="title h5 caption{if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N'} text-center{/if}" href="{$hst->cURLFull}"><span>{$hst->cName}</span></a>
								</div>
							{/foreach}
						</div>{* /row *}
                </li>
            </ul>
        </li>
    {/if}
{/if}
{/block}{* megamenu-manufacturers *}


{block name="megamenu-global-characteristics"}
{*
{if isset($snackyConfig.show_global_characteristics) && $snackyConfig.show_global_characteristics !== 'N'}
    {get_global_characteristics assign='characteristics'}
    {if !empty($characteristics)}

    {/if}
{/if}
*}
{/block}{* megamenu-global-characteristics *}
{/strip}
{/block}