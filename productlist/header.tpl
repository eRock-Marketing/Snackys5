{block name='productlist-header'}
{assign var=ismobile value=false}
{if $isMobile && !$isTablet}
    {assign var=ismobile value=true}
{/if}
{block name='productlist-header-navinfo'}
{if (!isset($oNavigationsinfo)
    || (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory()))
	|| $oNavigationsinfo->getName()}
    {include file="snippets/zonen.tpl" id="opc_before_heading"}
    
    <div class="title dpflex-a-center dpflex-j-between mb-spacer mb-small">
		{if !isset($oNavigationsinfo)
		|| (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory())}
			<h1 class="m0">{$Suchergebnisse->getSearchTermWrite()}</h1>
		{elseif $oNavigationsinfo->getCategory() && !empty($oNavigationsinfo->getCategory()->categoryAttributes) && isset($oNavigationsinfo->getCategory()->categoryAttributes.seo_name)}
			<h1>{$oNavigationsinfo->oKategorie->categoryAttributes.seo_name->cWert}</h1>
        {elseif $oNavigationsinfo->getName()}
			<h1 class="m0">{$oNavigationsinfo->getName()}</h1>
		{/if}
        {if count($Suchergebnisse->getProducts()) > 0 && !$ismobile}
            <div class="dpflex-a-c">
                {include file="productlist/improve_search.tpl"} 
                {has_boxes position='left' assign='hasLeftBox'}
                {if !$bExclusive && $hasLeftBox && !empty($boxes.left|strip_tags|trim) && $nSeitenTyp == $smarty.const.PAGE_ARTIKELLISTE}
                    {assign var="hasFilters" value="true"}	
                {else}
                    {assign var="hasFilters" value=false}	
                {/if}
                {if ($hasFilters) == true}
                <div class="visible-xs visible-sm ml-xs c-pt" id="ftr-tg">
                    <div class="img-ct icon ic-lg">
                        <svg class="">
                            <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-filter"></use>
                        </svg>
                    </div>
                </div>
                {/if}
            </div>
        {elseif count($Suchergebnisse->getProducts()) > 0}
            <div id="ftr-tg">
                <div class="img-ct icon ic-lg">
                    <svg class="">
                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-filter"></use>
                    </svg>
                </div>
            </div>
        {/if}
    </div>
	{if $oNavigationsinfo->getName()}
		<div class="desc text-lg clearfix mb-spacer mb-small{if $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild.gif' === false && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild_kl.gif' === false} row{/if}">
			{if $oNavigationsinfo->getImageURL() && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild.gif' === false && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild_kl.gif' === false}
			<div class="col-6 col-sm-3 col-md-4 col-lg-2 product-border">
			  <div class="img-ct{if $snackyConfig.imageratioCategory == '43'}  rt4x3{/if}">
				{image src=$oNavigationsinfo->getImageURL()
					webp=true
					lazy=true
					alt="{if $oNavigationsinfo->getCategory() !== null}{$oNavigationsinfo->getCategory()->cBeschreibung|strip_tags|truncate:40|escape:'html'}{elseif $oNavigationsinfo->getManufacturer() !== null}{$oNavigationsinfo->getManufacturer()->cBeschreibung|strip_tags|truncate:40|escape:'html'}{/if}"
					class="img-responsive"}
			  </div>
			</div>
			<div class="col-12 col-sm-9 col-md-8 col-lg-10">
			{/if}
			{if $Einstellungen.navigationsfilter.kategorie_beschreibung_anzeigen === 'Y'
            && $oNavigationsinfo->getCategory() !== null
            && $oNavigationsinfo->getCategory()->cBeschreibung|strlen > 0}
				<div class="item_desc custom_content">{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->getCategory()->cBeschreibung|optimize}{else}{$oNavigationsinfo->getCategory()->cBeschreibung}{/if}</div>
			{/if}
			{if $Einstellungen.navigationsfilter.hersteller_beschreibung_anzeigen === 'Y'
            && $oNavigationsinfo->getManufacturer() !== null
            && $oNavigationsinfo->getManufacturer()->cBeschreibung|strlen > 0}
				<div class="item_desc custom_content">{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->getManufacturer()->cBeschreibung|optimize}{else}{$oNavigationsinfo->getManufacturer()->cBeschreibung}{/if}</div>
			{/if}
			{if $Einstellungen.navigationsfilter.merkmalwert_beschreibung_anzeigen === 'Y'
            && $oNavigationsinfo->getCharacteristicValue() !== null
            && $oNavigationsinfo->getCharacteristicValue()->cBeschreibung|strlen > 0}
				<div class="item_desc custom_content">{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->getCharacteristicValue()->cBeschreibung|optimize}{else}{$oNavigationsinfo->getCharacteristicValue()->cBeschreibung}{/if}</div>
			{/if}
			{if $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild.gif' === false && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild_kl.gif' === false}
			</div>
			{/if}
		</div>
	{/if}
{/if}
{/block}

{block name="productlist-subcategories"}
{if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'N' && $oUnterKategorien_arr|@count > 0}
	{include file="snippets/zonen.tpl" id="opc_before_subcategories"}
    <div class="row row-multi sc-w mb-spacer mb-small">
        {foreach $oUnterKategorien_arr as $Unterkat}
            <div class="col-6 col-sm-4 col-md-4 col-lg-3{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-2{/if}">
                <div class="thumbnail">
                    {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'Y'}
                    <a href="{$Unterkat->getURL()}" class="block img-w">
                            <div class="img-ct{if $snackyConfig.imageratioCategory == '43'}  rt4x3{/if}">
							{if $viewportImages < 4}
								{image fluid=true lazy=false webp=true
									src=$Unterkat->getImage(\JTL\Media\Image::SIZE_MD)
									alt=$Unterkat->getName()}
								{assign var=viewportImages value=$viewportImages+1 scope="global"}
							{else}
								{image fluid=true lazy=true webp=true
									src=$Unterkat->getImage(\JTL\Media\Image::SIZE_MD)
									alt=$Unterkat->getName()}
							{/if}
                            </div>
                    </a>
                    {/if}
                    {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'B'}
                        <a href="{$Unterkat->getURL()}" class="h5 m0 title">
                            {$Unterkat->getName()}
                        </a>
                    {/if}
                    {if $Einstellungen.navigationsfilter.unterkategorien_beschreibung_anzeigen === 'Y' && !empty($Unterkat->getDescription())}
                        <p class="item_desc small text-muted">{$Unterkat->getDescription()|strip_tags|truncate:68}</p>
                    {/if}
                    {if $Einstellungen.navigationsfilter.unterkategorien_lvl2_anzeigen === 'Y'}
                         {if $Unterkat->hasChildren()}
                            <hr class="hr-sm">
                            <ul class="blanklist">
                                {foreach $Unterkat->getChildren() as $UnterUnterKat}
                                    <li>
                                        <a href="{$UnterUnterKat->getURL()}" title="{$UnterUnterKat->getName()}" class="defaultlink">{$UnterUnterKat->getName()}</a>
                                    </li>
                                {/foreach}
                            </ul>
                        {/if}
                    {/if}
                </div>
            </div>
        {/foreach}
    </div>
{/if}
{/block}

{block name="productlist-header-extension"}
    {include file="snippets/extension.tpl"}
{/block}

{if $Suchergebnisse->getSearchUnsuccessful() == true}
	{include file="snippets/zonen.tpl" id="opc_before_no_results"}
    <div class="alert alert-info">{lang key="noResults" section="productOverview"}</div>
    <form id="suche2" action="{$ShopURL}" method="get" class="form mb-spacer mb-small">
        <fieldset>
            <div class="form-group">
                <label for="searchkey">{lang key="searchText" section="global"}</label>
                <div class="btn-group">
                    <input type="search" class="form-control" name="suchausdruck" value="{if isset($Suchergebnisse->getSearchTerm())}{$Suchergebnisse->getSearchTerm()|escape:'htmlall'}{/if}" id="searchkey" minlength="{$Einstellungen.artikeluebersicht.suche_min_zeichen}" />
                    <input type="submit" value="{lang key="searchAgain" section="productOverview"}" class="submit btn btn-primary" />
                </div>
            </div>
        </fieldset>
    </form>
{/if}

{* if $Suchergebnisse->getProductCount() > 0}
    <div class="row list-pageinfo top10 visible-xs">
        <div class="col-6 col-sm-4 page-current">
             <strong>{lang key='page' section='productOverview'} {$Suchergebnisse->getPages()->getCurrentPage()}</strong> {lang key='of' section='productOverview'} {$Suchergebnisse->getPages()->getTotalPages()}
        </div>
        <div class="col-6 col-sm-8 page-total text-right">
            {lang key='products'} {$Suchergebnisse->getOffsetStart()} - {$Suchergebnisse->getOffsetEnd()} {lang key='of' section='productOverview'} {$Suchergebnisse->getProductCount()}
        </div>
    </div>
{/if *}
{/block}
