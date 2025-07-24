{block name='productlist-header'}
{assign var=ismobile value=false}
{if $isMobile && !$isTablet}
    {assign var=ismobile value=true}
{/if}
{block name='productlist-header-navinfo'}
{if (!isset($oNavigationsinfo)
    || (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory()))
	|| $oNavigationsinfo->getName()}
    {$showTitle = true}
    {$showImage = true}
    {$navData = null}
    {if $oNavigationsinfo->getCategory() !== null}
        {$showTitle = in_array($Einstellungen['navigationsfilter']['kategorie_bild_anzeigen'], ['Y', 'BT'])}
        {$showImage = in_array($Einstellungen['navigationsfilter']['kategorie_bild_anzeigen'], ['B', 'BT'])}
    {elseif $oNavigationsinfo->getManufacturer() !== null}
        {$showImage = in_array($Einstellungen['navigationsfilter']['hersteller_bild_anzeigen'], ['B', 'BT'])}
        {$showTitle = in_array($Einstellungen['navigationsfilter']['hersteller_bild_anzeigen'], ['Y', 'BT'])}
    {elseif $oNavigationsinfo->getCharacteristicValue() !== null}
        {$showImage = in_array($Einstellungen['navigationsfilter']['merkmalwert_bild_anzeigen'], ['B', 'BT'])}
        {$showTitle = in_array($Einstellungen['navigationsfilter']['merkmalwert_bild_anzeigen'], ['Y', 'BT'])}
    {/if}
    {include file="snippets/zonen.tpl" id="opc_before_heading"}
    
    {if !isset($oNavigationsinfo)
    || (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory())}
        <h1 class="title mb-small">{$Suchergebnisse->getSearchTermWrite()}</h1>
    {elseif $oNavigationsinfo->getCategory() && !empty($oNavigationsinfo->getCategory()->categoryAttributes) && isset($oNavigationsinfo->getCategory()->categoryAttributes.seo_name) && $showTitle}
        <h1 class="title mb-small">{$oNavigationsinfo->getCategory()->categoryAttributes.seo_name->cWert}</h1>
    {elseif $oNavigationsinfo->getName() && $showTitle}
        <h1 class="title mb-small">{$oNavigationsinfo->getName()}</h1>
    {/if}
    {include file="snippets/zonen.tpl" id="opc_after_heading"}
	{if $oNavigationsinfo->getName()}
		<div class="desc text-lg clearfix mb-spacer mb-small{if $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild.gif' === false && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild_kl.gif' === false && $showImage} row{/if}">
			{if $oNavigationsinfo->getImageURL() && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild.gif' === false && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild_kl.gif' === false && $showImage}
			<div class="col-6 col-sm-3 col-md-4 col-lg-2 product-border">
			  <div class="img-ct{if $snackyConfig.imageratioCategory == '43'} rt4x3{/if}">
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
			{if $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild.gif' === false && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild_kl.gif' === false &&  $showImage}
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
