{block name='productlist-index'}
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
        && empty($AktuelleKategorie->categoryFunctionAttributes['darstellung']))}
{else}
    {assign var=show_filters value=(count($NaviFilter->getAvailableContentFilters()) > 0
    && ($Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab == 0
        || $NaviFilter->getSearchResults()->getProductCount() >= $Einstellungen.artikeluebersicht.suchfilter_anzeigen_ab))
    || $NaviFilter->getFilterCount() > 0 || (count($Suchergebnisse->getSortingOptions()) > 0 && $Suchergebnisse->getProductCount() >= 1)
     || !empty($boxes.left)}
{/if}
{block name="header"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/header.tpl'}
    {/if}
{/block}
{if !isset($smarty.get.sidebar)}
    {include file="productwizard/index.tpl"}
    {include file="snippets/zonen.tpl" id="opc_before_result_options"}
{/if}
{if !$isMobile && !isset($smarty.get.sidebar)}
    {include file="productlist/filter_top.tpl"}
{elseif !isset($smarty.get.sidebar)}
    {include file="productlist/filter_top_mobile.tpl"}
{/if}
{if !isset($smarty.get.sidebar)}
    {include file="snippets/zonen.tpl" id="opc_after_result_options"}
{/if}

{if !isset($smarty.get.sidebar)}
{block name="content"}
	{assign var="viewportImages" value=0 scope="global"}
	{foreach name=navi from=$Brotnavi item=oItem}
		{if $smarty.foreach.navi.total == $smarty.foreach.navi.iteration}
			{assign var=cate value=$oItem->getName()}
		{/if}
	{/foreach}

    {if $Suchergebnisse->getProducts()|@count <= 0 && isset($KategorieInhalt)}
        {if isset($KategorieInhalt->TopArtikel->elemente) && $KategorieInhalt->TopArtikel->elemente|@count > 0}
            {include file="snippets/zonen.tpl" id="opc_before_category_top"}
            {lang key="topOffer" section="global" assign='slidertitle'}
            {include file='snippets/product_slider.tpl' id='slider-top-products' productlist=$KategorieInhalt->TopArtikel->elemente title=$slidertitle}
            {assign var=viewportImages value=5}
            <div class="mb-spacer mb-small"><hr class="hidden"></div>
        {/if}

        {if isset($KategorieInhalt->BestsellerArtikel->elemente) && $KategorieInhalt->BestsellerArtikel->elemente|@count > 0}
            {include file="snippets/zonen.tpl" id="opc_before_category_bestseller"}
            {lang key="bestsellers" section="global" assign='slidertitle'}
            {include file='snippets/product_slider.tpl' id='slider-bestseller-products' productlist=$KategorieInhalt->BestsellerArtikel->elemente title=$slidertitle}
            {assign var=viewportImages value=5}
            <div class="mb-spacer mb-small"><hr class="hidden"></div>
        {/if}
    {/if}

    <div id="result-wrapper" data-wrapper="true">

        {* Endless Scrolling Stuff *}
		{if isset($smarty.post.isAjax)}
			{if $smarty.post.paging=='prev'}
				<span class="hidden" id="endless-url">{if $Suchergebnisse->getPages()->getCurrentPage() > 1}{$oNaviSeite_arr.zurueck->cURL}{else}false{/if}</span>
			{else}
				<span class="hidden" id="endless-url">{if $Suchergebnisse->getPages()->getCurrentPage() < $Suchergebnisse->getPages()->getMaxPage()}{$oNaviSeite_arr.vor->cURL}{else}false{/if}</span>
			{/if}
		{/if}
    
        {assign var='style' value='gallery'}

        {if !$bExclusive && !empty($boxes.left)}
            {assign var='grid' value='col-6 col-lg-4'}
        {else}
            {assign var='grid' value='col-6 col-md-4'}
        {/if}
        {*Prio: -> Funktionsattribut -> Benutzereingabe -> Standarddarstellung*}
        {if (!empty($AktuelleKategorie->categoryFunctionAttributes['darstellung'])
            && $AktuelleKategorie->categoryFunctionAttributes['darstellung'] == 1)
            || (empty($AktuelleKategorie->categoryFunctionAttributes['darstellung'])
                && ((!empty($oErweiterteDarstellung->nDarstellung) && $oErweiterteDarstellung->nDarstellung == 1)
                    || (empty($oErweiterteDarstellung->nDarstellung)
                        && isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht)
                        && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht == 1))
        )}
            {assign var='style' value='list'}
            {assign var='grid' value='col-12'}
        {/if}
        {if !empty($Suchergebnisse->getError())}
            <p class="alert alert-danger">{$Suchergebnisse->getError()}</p>
        {/if}
        
        {* Bestseller *}
        {if isset($oBestseller_arr) && $oBestseller_arr|@count > 0}
            {block name="productlist-bestseller"}
				{include file="snippets/zonen.tpl" id="opc_before_bestseller"}
				{lang key='bestseller' section='global' assign='slidertitle'}
				{include file='snippets/product_slider.tpl' id='slider-top-products' productlist=$oBestseller_arr title=$slidertitle}  
                <div class="mb-md"><hr></div>
            {/block}
        {/if}
        
                    
        {block name="top-top-scroller"}
        {if $Suchergebnisse->getProducts()|@count >= 20}
                <a href="#top" id="nfity-scroll" class="dpflex-a-c dpflex-j-c">
                    <span class="ar ar-u"></span>
                </a>
        {/if}
        {/block}
		
        {block name="productlist-results"}
			{if $Suchergebnisse->getProducts()|@count > 0}
				{include file="snippets/zonen.tpl" id="opc_before_products"}
				<div class="row row-multi mb-spacer {$style}" id="p-l">
					{if $Suchergebnisse->getPages()->getCurrentPage() > 1 && !isset($smarty.post.isAjax) && ($snackyConfig.useEndlessScrolling == 'Y' || $snackyConfig.useEndlessScrolling == 'B')}
						<div class="el-sc endless-scrolling text-center block w100 form-group"><button id="view-prev" class="btn" data-url="{$oNaviSeite_arr.zurueck->getURL()}">{lang key="loadPrev" section="custom"}</button></div>
					{/if}
					<span class="pagination-url" data-url="{$smarty.server.REQUEST_URI}"></span>
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
					{if $Suchergebnisse->getPages()->getCurrentPage() < $Suchergebnisse->getPages()->getMaxPage() && !isset($smarty.post.isAjax) && ($snackyConfig.useEndlessScrolling == 'Y' || $snackyConfig.useEndlessScrolling == 'B') && (!isset($bAjaxRequest) || !$bAjaxRequest)}
						{if $snackyConfig.useEndlessScrolling == 'B'}
							{assign var="anzMore" value=$Suchergebnisse->getProductCount()-$Suchergebnisse->getOffsetEnd()}
							<div class="el-sc endless-scrolling text-center dpflex-a-center dpflex-j-center w100"><button id="view-next-click" class="btn btn-xs" data-url="{$oNaviSeite_arr.vor->getURL()}">{lang key="loadNext" section="custom" printf=$anzMore}</button></div>
						{else}
							<div class="el-sc endless-scrolling text-center dpflex-a-center dpflex-j-center w100"><button id="view-next" class="btn btn-xs" data-url="{$oNaviSeite_arr.vor->getURL()}"></button></div>
						{/if}
					{/if}
					
					
				</div>
			{/if}
        {/block}
        
        {block name="productlist-include-footer"}
			{if !isset($hasFilters)}{assign var="hasFilters" value=false}{/if}
			{include file='productlist/footer.tpl' hasFilters=$hasFilters}
        {/block}
    </div>
{/block}
{else}
	{include file="layout/sidebar.tpl"}
{/if}

{block name="footer"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/footer.tpl'}
    {/if}
{/block}
{/block}