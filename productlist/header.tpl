{block name='productlist-header'}
    {block name='header-assigns'}
        {assign var=ismobile value=false}
        {if $isMobile && !$isTablet}
            {assign var=ismobile value=true}
        {/if}
    {/block}
    {block name='productlist-header-navinfo'}    
        {if (!isset($oNavigationsinfo)
            || (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory()))
            || $oNavigationsinfo->getName()}
            {block name='productlist-header-navinfo-declarations'}
                {$showTitle = true}
                {$showImage = true}
                {$navData = null}
                {if $oNavigationsinfo->getCategory() !== null}
                    {$showTitle = in_array($Einstellungen['navigationsfilter']['kategorie_bild_anzeigen'], ['Y', 'BT'])}
                    {$showImage = in_array($Einstellungen['navigationsfilter']['kategorie_bild_anzeigen'], ['B', 'BT'])}
                    {$navData = $oNavigationsinfo->getCategory()}
                {elseif $oNavigationsinfo->getManufacturer() !== null}
                    {$showImage = in_array($Einstellungen['navigationsfilter']['hersteller_bild_anzeigen'], ['B', 'BT'])}
                    {$showTitle = in_array($Einstellungen['navigationsfilter']['hersteller_bild_anzeigen'], ['Y', 'BT'])}
                    {$navData = $oNavigationsinfo->getManufacturer()}
                {elseif $oNavigationsinfo->getCharacteristicValue() !== null}
                    {$showImage = in_array($Einstellungen['navigationsfilter']['merkmalwert_bild_anzeigen'], ['B', 'BT'])}
                    {$showTitle = in_array($Einstellungen['navigationsfilter']['merkmalwert_bild_anzeigen'], ['Y', 'BT'])}
                    {$navData = $oNavigationsinfo->getCharacteristicValue()}
                {/if}
                {include file="snippets/zonen.tpl" id="opc_before_heading"}
                {if isset($AktuelleKategorie) && isset($AktuelleKategorie->getCategoryAttributes())}
                    {assign var="catAttributes" value=$AktuelleKategorie->getCategoryAttributes()}
                    {if isset($catAttributes.seo_name->cWert)}
                        {assign var="catSeoName" value=$catAttributes.seo_name->cWert}
                    {/if}
                {/if}
            {/block}
            {block name='productlist-header-navinfo-headline'}
                {if !isset($oNavigationsinfo)
                || (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory())}
                    <h1 class="title mb-small">{$Suchergebnisse->getSearchTermWrite()}</h1>
                {elseif $oNavigationsinfo->getCategory() && isset($catSeoName) && $showTitle}
                    <h1 class="title mb-small">{$catSeoName}</h1>
                {elseif $oNavigationsinfo->getName() && $showTitle}
                    <h1 class="title mb-small">{$oNavigationsinfo->getName()}</h1>
                {/if}
                {include file="snippets/zonen.tpl" id="opc_after_heading"}
            {/block}
            {block name='productlist-header-navinfo-description'}
	            {if $oNavigationsinfo->getName()}
		            <div class="desc text-lg clearfix mb-sm{if $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild.gif' === false && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild_kl.gif' === false && $showImage} row{/if}">
			            {if $oNavigationsinfo->getImageURL() && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild.gif' === false && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild_kl.gif' === false && $showImage}
			                <div class="col-6 col-sm-3 col-md-4 col-lg-2 product-border">
                                {block name='productlist-header-navinfo-description-image'}
			                        <div class="img-ct{if $snackyConfig.imageratioCategory == '43'} rt4x3{/if}">
                                        {image src=$oNavigationsinfo->getImageURL()
                                            webp=true
                                            lazy=true
                                            sizes="{if !$bExclusive && $boxes.left !== null && !empty(trim(strip_tags($boxes.left))) && $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp}(min-width: 992px) 67vw, (min-width: 1300px) 75vw, 100vw{/if} "
                                            alt="{if $oNavigationsinfo->getCategory() !== null && !empty($navData->getImageAlt())}{$navData->getImageAlt()}{else}{$navData->getDescription()|default:''|strip_tags|truncate:50}{/if}"
                                            class="img-responsive"}
                                    </div>
                                {/block}
			                </div>
			                <div class="col-12 col-sm-9 col-md-8 col-lg-10">
                        {/if}
                        {if $Einstellungen.navigationsfilter.kategorie_beschreibung_anzeigen === 'Y'
                        && $oNavigationsinfo->getCategory() !== null
                        && $oNavigationsinfo->getCategory()->getDescription()|strlen > 0}
                            <div class="item_desc custom_content">{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->getCategory()->getDescription()|optimize}{else}{$oNavigationsinfo->getCategory()->getDescription()}{/if}</div>
                        {/if}
                        {if $Einstellungen.navigationsfilter.hersteller_beschreibung_anzeigen === 'Y'
                        && $oNavigationsinfo->getManufacturer() !== null
                        && $oNavigationsinfo->getManufacturer()->getDescription()|strlen > 0}
                            <div class="item_desc custom_content">{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->getManufacturer()->getDescription()|optimize}{else}{$oNavigationsinfo->getManufacturer()->getDescription()}{/if}</div>
                        {/if}
                        {if $Einstellungen.navigationsfilter.merkmalwert_beschreibung_anzeigen === 'Y'
                        && $oNavigationsinfo->getCharacteristicValue() !== null
                        && $oNavigationsinfo->getCharacteristicValue()->getDescription()|strlen > 0}
                            <div class="item_desc custom_content">{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->getCharacteristicValue()->getDescription()|optimize}{else}{$oNavigationsinfo->getCharacteristicValue()->getDescription()}{/if}</div>
                        {/if}
                        {if $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild.gif' === false && $oNavigationsinfo->getImageURL()|strpos:'gfx/keinBild_kl.gif' === false &&  $showImage}
                            </div>
                        {/if}
		            </div>
	            {/if}
            {/block}
        {/if}
    {/block}
    {block name="productlist-subcategories"}
        {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'N' && $oUnterKategorien_arr|count > 0}
	        {include file="snippets/zonen.tpl" id="opc_before_subcategories"}
            <div class="row row-multi sc-w mb-sm">
                {foreach $oUnterKategorien_arr as $Unterkat}
                    <div class="col-6 col-sm-4 col-md-4 col-lg-3{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-2{/if}">
                        <div class="thumbnail">
                            {block name="productlist-subcategories-image"}
                                {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'Y'}
                                    <a href="{$Unterkat->getURL()}" class="block img-w">
                                        <div class="img-ct{if $snackyConfig.imageratioCategory == '43'}  rt4x3{/if}">
                                            {if $viewportImages < 4}
                                                {image fluid=true lazy=false webp=true
                                                    src=$Unterkat->getImage(\JTL\Media\Image::SIZE_MD)
                                                    alt=$Unterkat->getName()
                                                    srcset="
                                                        {$Unterkat->getImage(\JTL\Media\Image::SIZE_XS)}
                                                        {$Unterkat->getImageWidth(\JTL\Media\Image::SIZE_XS)}w,
                                                        {$Unterkat->getImage(\JTL\Media\Image::SIZE_SM)}
                                                        {$Unterkat->getImageWidth(\JTL\Media\Image::SIZE_SM)}w,
                                                        {$Unterkat->getImage(\JTL\Media\Image::SIZE_MD)}
                                                        {$Unterkat->getImageWidth(\JTL\Media\Image::SIZE_MD)}w"|strip
                                                    sizes="(min-width: 992px) 25vw, 33vw"
                                                }
                                                {assign var=viewportImages value=$viewportImages+1 scope="global"}
                                            {else}
                                                {image fluid=true lazy=true webp=true
                                                    src=$Unterkat->getImage(\JTL\Media\Image::SIZE_MD)
                                                    alt=$Unterkat->getName()
                                                    srcset="
                                                        {$Unterkat->getImage(\JTL\Media\Image::SIZE_XS)}
                                                        {$Unterkat->getImageWidth(\JTL\Media\Image::SIZE_XS)}w,
                                                        {$Unterkat->getImage(\JTL\Media\Image::SIZE_SM)}
                                                        {$Unterkat->getImageWidth(\JTL\Media\Image::SIZE_SM)}w,
                                                        {$Unterkat->getImage(\JTL\Media\Image::SIZE_MD)}
                                                        {$Unterkat->getImageWidth(\JTL\Media\Image::SIZE_MD)}w"|strip
                                                    sizes="(min-width: 992px) 25vw, 33vw"
                                                }
                                            {/if}
                                        </div>
                                    </a>
                                {/if}
                            {/block}
                            {block name="productlist-subcategories-name"}
                                {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'B'}
                                    <a href="{$Unterkat->getURL()}" class="h5 block title{if $Einstellungen.navigationsfilter.unterkategorien_lvl2_anzeigen === 'Y' && $Unterkat->hasChildren()} mb-xxs{else} m0{/if}">
                                        {$Unterkat->getName()}
                                    </a>
                                {/if}
                            {/block}
                            {block name="productlist-subcategories-description"}
                                {if $Einstellungen.navigationsfilter.unterkategorien_beschreibung_anzeigen === 'Y' && !empty($Unterkat->getDescription())}
                                    <p class="item_desc small text-muted">{$Unterkat->getDescription()|strip_tags|truncate:68}</p>
                                {/if}
                            {/block}
                            {block name="productlist-subcategories-subsubs"}
                                {if $Einstellungen.navigationsfilter.unterkategorien_lvl2_anzeigen === 'Y'}
                                    {if $Unterkat->hasChildren()}
                                        <ul class="blanklist mt-xs">
                                            {foreach $Unterkat->getChildren() as $UnterUnterKat}
                                                <li>
                                                    <a href="{$UnterUnterKat->getURL()}" title="{$UnterUnterKat->getName()}" class="defaultlink">{$UnterUnterKat->getName()}</a>
                                                </li>
                                            {/foreach}
                                        </ul>
                                    {/if}
                                {/if}
                            {/block}
                        </div>
                    </div>
                {/foreach}
            </div>
        {/if}
    {/block}
    {block name="productlist-header-extension"}
        {include file="snippets/extension.tpl"}
    {/block}
    {block name="productlist-search-noresults"}
        {if $Suchergebnisse->getSearchUnsuccessful() == true}
            {include file="snippets/zonen.tpl" id="opc_before_no_results"}
            <div class="alert alert-info">{lang key="noResults" section="productOverview"}</div>
            <form id="suche2" action="{$ShopURL}" method="get" class="form mb-sm">
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
    {/block}
{/block}