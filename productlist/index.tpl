{block name='productlist-index'}
    {block name='index-assigns'}
        {if !isset($viewportImages)}{assign var="viewportImages" value=0}{/if}
        {assign var=ismobile value=false}
        {if $isMobile && !$isTablet}
            {assign var=ismobile value=true}
        {/if}
        {assign var=contentFilters value=$NaviFilter->getAvailableContentFilters()}
        {if !$isMobile}
            {assign var=show_filters value=(count($NaviFilter->getAvailableContentFilters()) > 0
            && ($Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab == 0
                || $NaviFilter->getSearchResults()->getProductCount() >= $Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab))
            || $NaviFilter->getFilterCount() > 0 || (count($Suchergebnisse->getSortingOptions()) > 0 && $Suchergebnisse->getProductCount() >= 1)
            || (isset($oErweiterteDarstellung->nDarstellung) && $Suchergebnisse->getProductCount() >= 1
                && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung === 'Y'
                && empty($AktuelleKategorie->getCategoryFunctionAttribute('darstellung')))}
        {else}
            {assign var=show_filters value=(count($NaviFilter->getAvailableContentFilters()) > 0
            && ($Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab == 0
                || $NaviFilter->getSearchResults()->getProductCount() >= $Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab))
            || $NaviFilter->getFilterCount() > 0 || (count($Suchergebnisse->getSortingOptions()) > 0 && $Suchergebnisse->getProductCount() >= 1)
            || !empty($boxes.left)}
        {/if}
    {/block}
    {block name="header"}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/header.tpl'}
        {/if}
    {/block}
    {block name="productlist-index-main"}
        {if !isset($smarty.get.livesearch)}
            {if !isset($smarty.get.sidebar)}
                {block name='index-wizard'}
                    {include file="productwizard/index.tpl"}
                    {include file="snippets/zonen.tpl" id="opc_before_result_options"}
                {/block}
            {/if}
            {if !$isMobile && !isset($smarty.get.sidebar)}
                {block name='index-filtertop'}
                    {include file="productlist/filter_top.tpl"}
                {/block}
            {elseif !isset($smarty.get.sidebar)}
                {block name='index-filtertop-mobile'}
                    {include file="productlist/filter_top_mobile.tpl"}
                {/block}
            {/if}
            {if !isset($smarty.get.sidebar)}
                {include file="snippets/zonen.tpl" id="opc_after_result_options"}
            {/if}
        {/if}
        {if isset($smarty.get.livesearch)}
            {block name='index-livesearch'}
                <div id="km_snackys_search" data-url="{$ShopURL}">
                    {include file="snippets/livesearch.tpl"}
                </div>
            {/block}
        {elseif !isset($smarty.get.sidebar)}
            {block name="content"}
                {block name="content-assigns"}
                    {assign var="viewportImages" value=0 scope="global"}
                    {foreach name=navi from=$Brotnavi item=oItem}
                        {if $smarty.foreach.navi.total == $smarty.foreach.navi.iteration}
                            {assign var=cate value=$oItem->getName()}
                        {/if}
                    {/foreach}
                {/block}
                {block name="content-sliders"}
                    {if $Suchergebnisse->getProducts()|count < 1 && isset($KategorieInhalt)}
                        {block name="content-sliders-top-articles"}
                            {if isset($KategorieInhalt->TopArtikel->elemente) && $KategorieInhalt->TopArtikel->elemente|count > 0}
                                {include file="snippets/zonen.tpl" id="opc_before_category_top"}
                                {lang key="topOffer" section="global" assign='slidertitle'}
                                {include file='snippets/product_slider.tpl' id='slider-top-products' productlist=$KategorieInhalt->TopArtikel->elemente title=$slidertitle}
                                {assign var=viewportImages value=5}
                                <div class="mb-sm"><hr class="hidden"></div>
                            {/if}
                        {/block}
                        {block name="content-sliders-bestsellers"}
                            {if isset($KategorieInhalt->BestsellerArtikel->elemente) && $KategorieInhalt->BestsellerArtikel->elemente|count > 0}
                                {include file="snippets/zonen.tpl" id="opc_before_category_bestseller"}
                                {lang key="bestsellers" section="global" assign='slidertitle'}
                                {include file='snippets/product_slider.tpl' id='slider-bestseller-products' productlist=$KategorieInhalt->BestsellerArtikel->elemente title=$slidertitle}
                                {assign var=viewportImages value=5}
                                <div class="mb-sm"><hr class="hidden"></div>
                            {/if}
                        {/block}
                    {/if}
                {/block}
                {block name="content-result-wrapper"}
                    <div id="result-wrapper" data-wrapper="true">
                        {block name="content-endless-scrolling"}
                            {if isset($smarty.post.isAjax)}
                                {if $smarty.post.paging=='prev'}
                                    <span class="hidden" id="endless-url">{if $Suchergebnisse->getPages()->getCurrentPage() > 1}{$oNaviSeite_arr.zurueck->cURL}{else}false{/if}</span>
                                {else}
                                    <span class="hidden" id="endless-url">{if $Suchergebnisse->getPages()->getCurrentPage() < $Suchergebnisse->getPages()->getMaxPage()}{$oNaviSeite_arr.vor->cURL}{else}false{/if}</span>
                                {/if}
                            {/if}
                        {/block}
                        {block name="content-assigns"}
                            {assign var='style' value='gallery'}
                            {if !$bExclusive && !empty($boxes.left)}
                                {assign var='grid' value='col-6 col-lg-4'}
                            {else}
                                {assign var='grid' value='col-6 col-md-4'}
                            {/if}
                            {if (!empty($AktuelleKategorie->getCategoryFunctionAttribute('darstellung'))
                            && $AktuelleKategorie->getCategoryFunctionAttribute('darstellung') == 1)
                            || (empty($AktuelleKategorie->getCategoryFunctionAttribute('darstellung'))
                            && ((!empty($oErweiterteDarstellung->nDarstellung) && $oErweiterteDarstellung->nDarstellung == 1)
                            || (empty($oErweiterteDarstellung->nDarstellung)
                            && isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht)
                            && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht == 1))
                            )}
                                {assign var='style' value='list'}
                                {assign var='grid' value='col-12'}
                            {/if}
                        {/block}
                        {block name="content-errors"}
                            {if !empty($Suchergebnisse->getError())}
                                <p class="alert alert-danger">{$Suchergebnisse->getError()}</p>
                            {/if}
                        {/block}
                        {block name="content-bestsellers"}
                            {if isset($oBestseller_arr) && $oBestseller_arr|count > 0}
                                {block name="productlist-bestseller"}
                                    {include file="snippets/zonen.tpl" id="opc_before_bestseller"}
                                    {lang key='bestseller' section='global' assign='slidertitle'}
                                    {include file='snippets/product_slider.tpl' id='slider-top-products' productlist=$oBestseller_arr title=$slidertitle}
                                    <div class="mb-md"><hr></div>
                                {/block}
                            {/if}
                        {/block}
                        {block name="top-top-scroller"}
                            {if $Suchergebnisse->getProducts()|@count >= 20}
                                <a href="#top" id="nfity-scroll" class="flx-ac flx-jc">
                                    <span class="ar ar-u"></span>
                                </a>
                            {/if}
                        {/block}
                        {block name="productlist-results"}
                            {if $Suchergebnisse->getProducts()|count > 0}
                                {include file="snippets/zonen.tpl" id="opc_before_products"}
                                <div class="row row-multi mb-lg {if $style === 'list' && (!$isMobile || $isTablet)}list{else}{$style}{/if}" id="p-l">
                                    {block name="productlist-results-load-prev"}
                                        {if $Suchergebnisse->getPages()->getCurrentPage() > 1 && !isset($smarty.post.isAjax) && ($snackyConfig.useEndlessScrolling == 'Y' || $snackyConfig.useEndlessScrolling == 'B')}
                                            <div class="el-sc endless-scrolling text-center block w100 form-group"><button id="view-prev" class="btn" data-url="{$oNaviSeite_arr.zurueck->getURL()}">{lang key="loadPrev" section="custom"}</button></div>
                                        {/if}
                                    {/block}
                                    {block name="productlist-results-pagination-url"}
                                        <span class="pagination-url" data-url="{$smarty.server.REQUEST_URI}"></span>
                                    {/block}
                                    {block name="productlist-results-items"}
                                        {foreach name=artikel from=$Suchergebnisse->getProducts() item=Artikel}
                                            <div class="p-w col-12{if $snackyConfig.hover_productlist === 'Y' && !$ismobile && $style != 'list'} hv-e{/if}">
                                                {assign var="stopLazy" value=false}
                                                {if $snackyConfig.nolazyloadProductlist >= $smarty.foreach.artikel.iteration}
                                                    {assign var="stopLazy" value=true}
                                                {/if}
                                                {if $style === 'list' && (!$isMobile || $isTablet)}
                                                    {include file='productlist/item_list.tpl' tplscope=$style stopLazy=$stopLazy}
                                                {else}
                                                    {include file='productlist/item_box.tpl' tplscope=$style class='thumbnail' stopLazy=$stopLazy}
                                                {/if}
                                            </div>
                                            {include file="snippets/zonen.tpl" id="after_product_s{$Suchergebnisse->getPages()->getCurrentPage()}_{$smarty.foreach.artikel.iteration}" title="after_product_s{$Suchergebnisse->getPages()->getCurrentPage()}_{$smarty.foreach.artikel.iteration}"}
                                        {/foreach}
                                    {/block}
                                    {block name="productlist-results-load-next"}
                                        {if $Suchergebnisse->getPages()->getCurrentPage() < $Suchergebnisse->getPages()->getMaxPage() && !isset($smarty.post.isAjax) && ($snackyConfig.useEndlessScrolling == 'Y' || $snackyConfig.useEndlessScrolling == 'B') && (!isset($bAjaxRequest) || !$bAjaxRequest)}
                                            {if $snackyConfig.useEndlessScrolling == 'B'}
                                                {assign var="anzMore" value=$Suchergebnisse->getProductCount()-$Suchergebnisse->getOffsetEnd()}
                                                <div class="el-sc endless-scrolling text-center flx-ac flx-jc w100">
                                                    <button id="view-next-click" class="btn btn-xs" data-url="{$oNaviSeite_arr.vor->getURL()}">{lang key="loadNext" section="custom" printf=$anzMore}</button>
                                                </div>
                                            {else}
                                                <div class="el-sc endless-scrolling text-center flx-ac flx-jc w100">
                                                    <button id="view-next" class="btn btn-xs" data-url="{$oNaviSeite_arr.vor->getURL()}"></button>
                                                </div>
                                            {/if}
                                        {/if}
                                    {/block}
                                </div>
                            {/if}
                        {/block}
                        {block name="productlist-include-footer"}
                            {if !isset($hasFilters)}{assign var="hasFilters" value=false}{/if}
                            {include file='productlist/footer.tpl' hasFilters=$hasFilters}
                        {/block}
                    </div>
                {/block}
            {/block}
        {else}
            {block name="content-sidebar"}
                {include file="layout/sidebar.tpl"}
            {/block}
        {/if}
    {/block}
    {block name="footer"}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/footer.tpl'}
        {/if}
    {/block}
{/block}