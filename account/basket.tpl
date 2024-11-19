{block name='account-order-item-wrapper'}
    {block name='oder-items-tablehead'}
        <div class="row bskt flx-nw">
            <div class="col-prd">{lang key='product'}</div>
            <div class="col-qnt col-nbr">{lang key='quantity'}</div>
            {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                <div class="col-prc prc-sgl col-nbr">{lang key='pricePerUnit' section='checkout'}</div>
            {/if}
            <div class="col-prc col-nbr">{lang key='price'}</div>
        </div>
    {/block}
    {block name='oder-items-foreach'}
        {foreach $Bestellung->Positionen as $oPosition name=positionen}
            {if !(is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem > 0)}
                <div class="row bskt flx-nw itms flx-ac tp-{$oPosition->nPosTyp}{if $oPosition->nPosTyp == '3' || $oPosition->nPosTyp == '2' || $oPosition->nPosTyp == '5'} total{/if}">
                    {block name='oder-items-product'}
                        <div class="col-prd flx-ac">
                            {block name='oder-items-product-image'}
                                {if !empty($oPosition->Artikel->cVorschaubildURL)}
                                    <a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}" class="img-ct">
                                        {if isset($nSeitenTyp) && $nSeitenTyp == 37}
                                            {include file='snippets/image.tpl'
                                                fluid=false
                                                item=$oPosition->Artikel
                                                square=false
                                                lazy=false
                                                class='img-responsive-width'
                                                alt=$oPosition->cName|trans|escape:'html'}
                                        {else}
                                            {include file='snippets/image.tpl'
                                                fluid=false
                                                item=$oPosition->Artikel
                                                square=false
                                                class='img-responsive-width'
                                                alt=$oPosition->cName|trans|escape:'html'}
                                        {/if}
                                    </a>
                                {else}
                                    <span class="spacer"></span>
                                {/if}
                            {/block}
                            {block name='oder-items-product-data'}
                                <div class="prd">
                                    {if $oPosition->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL || $oPosition->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
                                        {block name='oder-items-product-data-name'}
                                            <a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}" class="prd-itm">{$oPosition->cName|trans}</a>
                                        {/block}
                                        {block name='oder-items-product-data-list'}
                                            {assign "hasmore" 0}
                                            {if ($Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr))
                                                || ($Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans)
                                                || !empty($oPosition->cHinweis)
                                                || ($oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N")
                                                || ($Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr))
                                                || ($Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute))
                                                || (isset($oPosition->Artikel->cGewicht) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->Artikel->fGewicht > 0)
                                                || ($Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0)
                                            }
                                                {assign "hasmore" 1}
                                            {/if}
                                            <ul class="blanklist small">
                                                {block name='order-items-item-infos-sku'}
                                                    <li class="sku">
                                                        {lang key="productNo" section="global"}: {$oPosition->Artikel->cArtNr}
                                                    </li>
                                                {/block}
                                                {block name='order-items-item-infos-mhd'}
                                                    {if $Einstellungen.artikeldetails.show_shelf_life_expiration_date === 'Y' && isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
                                                        <li title="{lang key='productMHDTool' section='global'}" class="best-before">
                                                            {lang key="productMHD" section="global"}: {$oPosition->Artikel->dMHD_de}
                                                        </li>
                                                    {/if}
                                                {/block}
                                                {block name='order-items-item-infos-baseprice'}
                                                    {if $oPosition->Artikel->cLocalizedVPE && $oPosition->Artikel->cVPE !== 'N' && $oPosition->nPosTyp !== $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
                                                        <li class="baseprice">
                                                            {lang key="basePrice" section="global"}: {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}
                                                        </li>
                                                    {/if}
                                                {/block}
                                            </ul>
                                            {if $hasmore == 1}
                                                <a class="defaultlink small" data-toggle="collapse" href="#moreinfo{$smarty.foreach.positionen.index}" role="button" aria-expanded="false" aria-controls="#moreinfo{$smarty.foreach.positionen.index}">
                                                    {lang key='showMore'} 
                                                </a>
                                            {/if}
                                            {if is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem === 0}
                                                <a href="#" class="defaultlink small" data-toggle="modal" data-target="#konfi{$smarty.foreach.positionen.index}">
                                                    {lang key='listOfItems'} 
                                                </a>
                                                <div class="modal modal-dialog konf-mod" tabindex="-1" id="konfi{$smarty.foreach.positionen.index}">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <span class="modal-title block h5">
                                                                {$oPosition->cName|trans}
                                                            </span>
                                                            <button type="button" class="close-btn" data-dismiss="modal" aria-label="Close">
                                                            </button>
                                                        </div>
                                                        <div class="modal-body small">
                                                            {block name='order-items-item-config-items'}
                                                                {foreach $Bestellung->Positionen as $KonfigPos}
                                                                    {if $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0}
                                                                        <div class="cnf-it flx-ac bskt itms">
                                                                            <span class="img-ct">
                                                                                {if isset($nSeitenTyp) && $nSeitenTyp == 37}
                                                                                    {include file='snippets/image.tpl'
                                                                                        fluid=false
                                                                                        item=$KonfigPos->Artikel
                                                                                        square=false
                                                                                        lazy=false
                                                                                        class='img-responsive-width'}
                                                                                {else}
                                                                                    {include file='snippets/image.tpl'
                                                                                        fluid=false
                                                                                        item=$KonfigPos->Artikel
                                                                                        square=false
                                                                                        class='img-responsive-width'}
                                                                                {/if}
                                                                            </span>
                                                                            <span class="prd">
                                                                                <span class="qty">{if !(is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem === 0)}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
                                                                                {$KonfigPos->cName|trans}
                                                                            </span>
                                                                            <span class="prcv">
                                                                                {if substr($KonfigPos->cEinzelpreisLocalized[$NettoPreise], 0, 1) !== '-'}+{/if}{$KonfigPos->cEinzelpreisLocalized[$NettoPreise]}
                                                                                <small>{lang key='pricePerUnit' section='checkout'}</small>
                                                                            </span>
                                                                        </div>
                                                                    {/if}
                                                                {/foreach}
                                                            {/block}
                                                        </div>
                                                    </div>
                                                </div>
                                            {/if}
                                        {/block}
                                    {else}
                                        <span class="prd-itm">{$oPosition->cName|trans}{if isset($oPosition->discountForArticle)}{$oPosition->discountForArticle|trans}{/if}</span>
                                        {block name='order-items-item-affix-specialpos'}
                                            {if isset($oPosition->cArticleNameAffix)}
                                                {if is_array($oPosition->cArticleNameAffix)}
                                                    <ul class="blanklist small">
                                                        {foreach $oPosition->cArticleNameAffix as $cArticleNameAffix}
                                                            <li>{$cArticleNameAffix|trans}</li>
                                                        {/foreach}
                                                    </ul>
                                                {else}
                                                    <ul class="blanklist small">
                                                        <li>{$oPosition->cArticleNameAffix|trans}</li>
                                                    </ul>
                                                {/if}
                                            {/if}
                                        {/block}
                                        {block name='order-items-item-notice-specialpos'}
                                            {if !empty($oPosition->cHinweis)}
                                                <small class="block text-muted">{$oPosition->cHinweis}</small>
                                            {/if}
                                        {/block}
                                    {/if}
                                </div>
                            {/block}
                        </div>
                    {/block}
                    {block name='oder-items-quantity'}
                        <div class="col-qnt col-nbr">
                            {block name='order-items-item-quantity'}
                                {if $oPosition->nPosTyp != '3' && $oPosition->nPosTyp != '2' && $oPosition->nPosTyp != '5'}
                                    <span class="hidden">{lang key='quantity'}:</span> {$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}
                                {/if}
                            {/block}
                        </div>
                    {/block}
                    {block name='oder-items-price-single'}
                        {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                            <div class="col-prc prc-sgl col-nbr">
                                {if $oPosition->nPosTyp == 1}
                                    {if !(is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem === 0)}
                                        {$oPosition->cEinzelpreisLocalized[$NettoPreise]}
                                    {else}
                                        {$oPosition->cKonfigeinzelpreisLocalized[$NettoPreise]}
                                    {/if}
                                {/if}
                            </div>
                        {/if}
                    {/block}
                    {block name='oder-items-price'}
                        <div class="col-prc col-nbr">
                            {if is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem === 0}
                                {$oPosition->cKonfigpreisLocalized[$NettoPreise]}
                            {else}
                                {$oPosition->cGesamtpreisLocalized[$NettoPreise]}
                            {/if}
                        </div>
                    {/block}
                </div>
                {block name='oder-items-item-moreinfo'}
                    {if $hasmore == 1}
                        <div class="collapse small" id="moreinfo{$smarty.foreach.positionen.index}">
                            <div class="inside">
                                <table class="m0">
                                    {block name='order-items-item-infos-variations'}
                                        {if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
                                            {foreach name=variationen from=$oPosition->WarenkorbPosEigenschaftArr item=Variation}
                                                <tr class="variation">
                                                    <td>{$Variation->cEigenschaftName|trans}:</td> 
                                                    <td>{$Variation->cEigenschaftWertName|trans}</td>
                                                </tr>
                                            {/foreach}
                                        {/if}
                                    {/block}
                                    {block name='order-items-item-infos-delivery'}
                                        {if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans}
                                            <tr class="delivery-status">
                                                <td>{lang key="deliveryStatus" section="global"}:</td> 
                                                <td>{$oPosition->cLieferstatus|trans}</td>
                                            </tr>
                                        {/if}
                                    {/block}
                                    {block name='order-items-item-infos-notices'}
                                        {if !empty($oPosition->cHinweis)}
                                            <tr class="text-info notice">
                                                <td colspan="2">{$oPosition->cHinweis}</td>
                                            </tr>
                                        {/if}
                                    {/block}
                                    {block name='order-items-item-infos-manufacturer'}
                                        {if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
                                                <tr class="manufacturer">
                                                <td>{lang key="manufacturer" section="productDetails"}:</td>
                                                <td class="values">
                                                    {$oPosition->Artikel->cHersteller}
                                                </td>
                                            </tr>
                                        {/if}
                                    {/block}
                                    {block name='order-items-item-infos-characteristics'}
                                        {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr)}
                                            {foreach $oPosition->Artikel->oMerkmale_arr as $characteristic}
                                                <tr class="characteristic">
                                                    <td>{$characteristic->getName()|escape:'html'}:</td>
                                                    <td class="values">
                                                        {foreach $characteristic->getCharacteristicValues() as $characteristicValue}
                                                            {if !$characteristicValue@first}, {/if}
                                                            {$characteristicValue->getValue()}
                                                        {/foreach}
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        {/if}
                                    {/block}
                                    {block name='order-items-item-infos-attributes'}
                                        {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute)}
                                            {foreach $oPosition->Artikel->Attribute as $oAttribute_arr}
                                                <tr class="attribute">
                                                    <td>{$oAttribute_arr->cName}:</td>
                                                    <td class="values">
                                                        {$oAttribute_arr->cWert}
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        {/if}
                                    {/block}
                                    {block name='order-items-item-infos-shortdesc'}                                    
                                        {if !isset($isCheckout)}
                                            {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
                                                <tr class="shortdescription hidden-xs hidden-sm hidden-md w100">
                                                    <td colspan="2">{$oPosition->Artikel->cKurzBeschreibung|strip_tags}</td>
                                                </tr>
                                            {/if}
                                        {/if}
                                    {/block}
                                </table>
                            </div>
                        </div>
                    {/if}
                {/block}
            {/if}
        {/foreach}
    {/block}
    {block name='oder-items-total'}
        {if $NettoPreise}
            {block name='account-order-items-total-price-net'}
                <div class="row bskt flx-nw itms flx-ac total">
                    <div class="col-prd flx-ac">
                        {lang key='totalSum'} ({lang key='net'}):
                    </div>
                    <div class="col-prc col-nbr">
                        {$Bestellung->WarensummeLocalized[1]}
                    </div>
                </div>
            {/block}
        {/if}
        {if $Bestellung->GuthabenNutzen == 1}
            {block name='account-order-items-total-customer-credit'}
                <div class="row bskt flx-nw itms flx-ac total">
                    <div class="col-prd flx-ac">
                        {lang key='useCredit' section='account data'}
                    </div>
                    <div class="col-prc col-nbr">
                        {$Bestellung->GutscheinLocalized}
                    </div>
                </div>
            {/block}
        {/if}
        {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N'}
            {block name='account-order-items-total-tax'}
                {foreach $Bestellung->Steuerpositionen as $taxPosition}
                    <div class="row bskt flx-nw itms flx-ac total">
                        <div class="col-prd flx-ac">
                            <span class="spacer"></span>
                            <div class="prd">
                                {$taxPosition->cName}:
                            </div>
                        </div>
                        <div class="col-prc col-nbr">
                            {$taxPosition->cPreisLocalized}
                        </div>
                    </div>
                {/foreach}
            {/block}
        {/if}
        {block name='account-order-items-total-total'}
            <div class="row bskt flx-nw itms flx-ac total">
                <div class="col-prd flx-ac">
                    <span class="spacer"></span>
                    <div class="prd">
                        {lang key='totalSum'} {if $NettoPreise}{lang key='gross' section='global'}{/if}:
                    </div>
                </div>
                <div class="col-prc col-nbr">
                    {$Bestellung->WarensummeLocalized[0]}
                </div>
            </div>
        {/block}
        {if !empty($Bestellung->OrderAttributes)}
            {block name='account-order-items-total-order-attributes'}
                {foreach $Bestellung->OrderAttributes as $attribute}
                    {if $attribute->cName === 'Finanzierungskosten'}
                        <div class="row bskt flx-nw itms flx-ac total">
                            {block name='account-order-items-finance-costs'}
                                <div class="col-prd flx-ac">
                                    <span class="spacer"></span>
                                    <div class="prd">
                                        {lang key='financeCosts' section='order'}
                                    </div>
                                </div>
                            {/block}
                            {block name='account-order-items-finance-costs-value'}
                                <div class="col-prc col-nbr">
                                    {$attribute->cValue}
                                </div>
                            {/block}
                        </div>
                    {/if}
                {/foreach}
            {/block}
        {/if}
    {/block}
{/block}