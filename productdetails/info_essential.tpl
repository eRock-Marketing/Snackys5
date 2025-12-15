{block name="productdetails-info-essential-left"}
    <div class="{if $snackyConfig.positionArticleInfos == 1}small mt-xs{else}col-12 col-sm-12 col-md-8 col-lg-6{/if}">
        {block name="productdetails-info-essential"}
            <ul class="blanklist nav nav-sm">
                {block name="productdetails-info-artnr-wrapper"}
                    {if isset($Artikel->cArtNr)}
                        <li class="product-sku nav-it">
                            <strong>{lang key="sortProductno"}:</strong> <span>{$Artikel->cArtNr}</span>
                        </li>
                    {/if}
                {/block}                                
                {block name="productdetails-info-mhd-wrapper"}
                    {if $Einstellungen.artikeldetails.show_shelf_life_expiration_date === 'Y' && isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                        <li title="{lang key='productMHDTool'}" class="best-before nav-it">
                            <strong>{lang key="productMHD"}:</strong> <span>{$Artikel->dMHD_de}</span>                                        
                        </li>
                    {/if}
                {/block}                                
                {block name="productdetails-info-barcode-wrapper"}
                    {if !empty($Artikel->cBarcode) && ($Einstellungen.artikeldetails.gtin_display === 'details' || $Einstellungen.artikeldetails.gtin_display === 'always')}
                        <li class="nav-it">
                            <strong>{lang key='ean'}: </strong><span>{$Artikel->cBarcode}</span>
                        </li>
                    {/if}
                {/block}                                
                {block name="productdetails-info-han"}
                    {if !empty($Artikel->cHAN) && ($Einstellungen.artikeldetails.han_display === 'details' || $Einstellungen.artikeldetails.han_display === 'always')}
                        <li class="nav-it">
                            <strong>{lang key='han'}: </strong><span>{$Artikel->cHAN}</span>
                        </li>
                    {/if}
                {/block}                                
                {block name="productdetails-info-isbn-wrapper"}
                    {if !empty($Artikel->cISBN) && ($Einstellungen.artikeldetails.isbn_display === 'D' || $Einstellungen.artikeldetails.isbn_display === 'DL')}
                        <li class="nav-it">
                            <strong>{lang key='isbn'}: </strong><span>{$Artikel->cISBN}</span>
                        </li>
                    {/if}
                {/block}
                {block name="productdetails-info-category-wrapper"}
                    {assign var=i_kat value=($Brotnavi|count)-2}
                    {if $Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y' && isset($Brotnavi[$i_kat])}
                        <li class="product-category word-break nav-it">
                            <strong>{lang key="category" section="global"}: </strong><a href="{$Brotnavi[$i_kat]->getURLFull()}" {if !empty($smarty.get.quickView)}target="_blank"{/if}>{$Brotnavi[$i_kat]->getName()}</a>
                        </li>
                    {/if}
                {/block}                                
                {block name="productdetails-info-gefahrgut-wrapper"}
                    {if !empty($Artikel->cUNNummer) && !empty($Artikel->cGefahrnr) && ($Einstellungen.artikeldetails.adr_hazard_display === 'D' || $Einstellungen.artikeldetails.adr_hazard_display === 'DL')}
                        <li class="nav-it">
                            <strong>{lang key='adrHazardSign'}: </strong>
                            <div class="adr-table text-center">
                                <strong class="block first">{$Artikel->cGefahrnr}</strong>
                                <strong class="block">{$Artikel->cUNNummer}</strong>
                            </div>
                        </li>
                    {/if}
                {/block} 
                {block name="productdetails-info-manufacturer-wrapper"}
                    {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller) && $snackyConfig.positionManufacturer == 1}
                        <li class="nav-it flx-ac">                            
				            {include file='productdetails/manufacturer.tpl'}
                        </li>
                    {/if}
                {/block}
            </ul>
        {/block}
    </div>
{/block}