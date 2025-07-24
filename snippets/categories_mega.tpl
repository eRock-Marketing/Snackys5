{block name='snippets-categories-mega'}
{strip}
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
    {assign var=max_subsub_items value=$snackyConfig.megamenu_subcats}
{/block}
{block name='snippets-categories-mega-linkhome'}
{if $snackyConfig.megaHome == 0}
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
{block name='snippets-categories-mega-linkgroup-before'}
{if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
    {include file='snippets/linkgroup_list.tpl' linkgroupIdentifier='megamenu_start' dropdownSupport=true tplscope='megamenu_start'}
{/if}
{/block}
{block name="megamenu-categories"}
{if isset($snackyConfig.show_categories) && $snackyConfig.show_categories !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || JTL\Session\Frontend::getCustomer()->getID() > 0)}
    {assign var='show_subcategories' value=false}
    {if isset($snackyConfig.show_subcategories) && $snackyConfig.show_subcategories !== 'N'}
        {assign var='show_subcategories' value=true}
    {/if}

    {get_category_array categoryId=0 assign='categories'}
    {if !empty($categories)}
        {if !isset($activeParents) && ($nSeitenTyp == 1 || $nSeitenTyp == 2)}
            {get_category_parents categoryId=$activeId assign='activeParents'}
        {/if}

        {assign var="noImgUrl" value="{$ShopURL}/gfx/keinBild.gif"}
        {foreach name='categories' from=$categories item='category'}
            {assign var='isDropdown' value=false}
            {if isset($category->hasChildren()) && $category->hasChildren()}
                {assign var='isDropdown' value=true}
            {/if}

            {assign var="catFunctions" value=$category->getFunctionalAttributes()}
            <li class="{if $isDropdown}mgm-fw{/if}{if $category->getID() == $activeId || (isset($activeParent) && $activeParent->getID() === $category->getID())} active{/if}{if !empty($catFunctions["css_klasse"])} {$catFunctions["css_klasse"]}{/if}">
                <a href="{$category->getURL()}" class="mm-mainlink" title="{$category->getName()|escape:'html'}">
                    {$category->getShortName()}
                    {if $isDropdown}<span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}{/if}
                </a>
                {if $isDropdown}
                    <ul class="dropdown-menu keepopen">
                        <li class="mgm-c mw-container">
						    {include file="snippets/zonen.tpl" id="before_megamenu_content_{$category->getID()}" title="before_megamenu_content_{$category->getID()}"}
                                <div class="row flx-as">
                                    {assign var=hasInfoColumn value=false}
                                    {if isset($snackyConfig.show_maincategory_info) && $snackyConfig.show_maincategory_info !== 'N' && ($category->getImageUrl() !== $noImgUrl || !empty($category->getDescription()))}
                                        {assign var=hasInfoColumn value=true}
                                        <div class="col-md-4 col-lg-3 hidden-xs hidden-sm info-col">
											{if $category->getImageUrl() !== $noImgUrl && isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N'}
												<a href="{$category->getURL()}" class="block" title="{$category->getShortName()|escape:'html'}">
													<span class="img-ct{if $snackyConfig.imageratioCategory == '43'} rt4x3{/if}">
													{include file='snippets/image.tpl'
																		class='img-responsive'
																		item=$category
																		square=false
																		srcSize='sm'}
													</span>
												</a>
											{/if}
											<div class="description">
												<a class="h4 block m0" href="{$category->getURL()}" title="{$category->getShortName()|escape:'html'}">
													{$category->getShortName()}
												</a>
												<p>
													{$category->getDescription()|strip_tags|strip_tags|truncate:200}
												</p>
											</div>
                                        </div>
                                    {/if}
                                    <div class="col-12 col-sm-12{if $hasInfoColumn} col-md-8 col-lg-9{/if} mega-categories{if $hasInfoColumn} hasInfoColumn{/if} row row-multi">
                                            {if $category->hasChildren()}
                                                {if !empty($category->getChildren())}
                                                    {assign var=sub_categories value=$category->getChildren()}
                                                {else}
                                                    {get_category_array categoryId=$category->getID() assign='sub_categories'}
                                                {/if}
                                                {foreach name='sub_categories' from=$sub_categories item='sub'}
                                                    {assign var="catFunctions" value=$sub->getFunctionalAttributes()}
                                                    <div class="col-12 col-sm-3 col-lg-3{if $sub->getID() == $activeId || (isset($activeParents[1]) && $activeParents[1]->getID() == $sub->getID())} active{/if}{if !empty($catFunctions["css_klasse"])} {$catFunctions["css_klasse"]}{/if}">
                                                            {if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N'}
                                                                
															<a href="{$sub->getURL()}" class="hidden-xs block" title="{$sub->getShortName()|escape:'html'}">
																<span class="img-ct{if $snackyConfig.imageratioCategory == '43'}  rt4x3{/if}">
																	{include file='snippets/image.tpl'
																						class='image'
																						item=$sub
																						square=false
																						srcSize='sm'}
																</span>
															</a>
                                                            {/if}
															{if !empty($sub->getChildren())}
																{assign var=subsub_categories value=$sub->getChildren()}
															{else}
																{get_category_array categoryId=$sub->getID() assign='subsub_categories'}
															{/if}
															<a class="defaultlink h6 title block" href="{$sub->getURL()}" title="{$sub->getShortName()|escape:'html'}">
																{$sub->getShortName()}
																{if $show_subcategories && $sub->hasChildren() && count($subsub_categories)  > 0}
																{include file='snippets/mobile-menu-arrow.tpl'}
																{/if}
															</a>
                                                            {if $show_subcategories && $sub->hasChildren()}
																{if count($subsub_categories)  > 0} 
                                                                <ul class="blanklist small subsub">
                                                                    {foreach name='subsub_categories' from=$subsub_categories item='subsub'}
                                                                        {if $smarty.foreach.subsub_categories.iteration <= $max_subsub_items}
																			{assign var="subCatFunctions" value=$sub->getFunctionalAttributes()}
                                                                            <li class="{if $subsub->getID() == $activeId || (isset($activeParents[2]) && $activeParents[2]->getID() == $subsub->getID())} active{/if}{if !empty($subCatFunctions["css_klasse"])} {$subCatFunctions["css_klasse"]}{/if}">
                                                                                <a href="{$subsub->getURL()}" class="defaultlink" title="{$subsub->getShortName()|escape:'html'}">
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
                                                            {/if}
                                                    </div>
                                                {/foreach}
                                            {/if}
                                        {* /row *}
                                    </div>{* /mega-categories *}
                                </div>{* /row *}
                            {* /mgm-c *}
						    {include file="snippets/zonen.tpl" id="after_megamenu_content_{$category->getID()}" title="after_megamenu_content_{$category->getID()}"}
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
    {include file='snippets/linkgroup_list.tpl' linkgroupIdentifier='megamenu' dropdownSupport=true tplscope='megamenu'}
{/if}
{/block}{* megamenu-pages *}

{block name="megamenu-manufacturers"}
{if isset($snackyConfig.show_manufacturers) && $snackyConfig.show_manufacturers !== 'N' 
    && ($Einstellungen.global.global_sichtbarkeit != 3 || JTL\Session\Frontend::getCustomer()->getID() > 0)}
    {get_manufacturers assign='manufacturers'}
    {if !empty($manufacturers)}
        <li class="mgm-fw mm-manu{if $NaviFilter->hasManufacturer() || $nSeitenTyp == PAGE_HERSTELLER} active{/if}">
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
                <li class="mgm-c mw-container">
                    {include file="snippets/zonen.tpl" id="before_megamenu_content_manufacturers" title="before_megamenu_content_manufacturers"}
					<div class="row row-multi">
						{foreach name=hersteller from=$manufacturers item=hst}
							<div class="col-12 col-sm-3 col-md-3 col-lg-2{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-2{/if}{if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller == $hst->kHersteller} active{/if}">
								{if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N'}
									<a class="block hidden-xs img-w" href="{$hst->getURL()}">
										<span class="img-ct">
											{include file='snippets/image.tpl'
												class='submenu-headline-image'
												item=$hst
												square=false
												srcSize='sm'}
										</span>
									</a>
								{/if}
								<a class="defaultlink h6 title block" href="{$hst->getURL()}">
									<span>{$hst->getName()|escape:'html'}</span>
								</a>
							</div>
						{/foreach}
					</div>{* /row *}
                    {include file="snippets/zonen.tpl" id="after_megamenu_content_manufacturers" title="after_megamenu_content_manufacturers"}
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