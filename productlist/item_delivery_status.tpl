{block name='productlist-item-delivery-status'}
    <div class="delivery-status">
        {if !isset($showEstimated)}
            {assign var="showEstimated" value=false}
        {/if}
        {assign var=anzeige value=$Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandsanzeige}
        {if $Artikel->inWarenkorbLegbar === $smarty.const.INWKNICHTLEGBAR_UNVERKAEUFLICH}
            <div class="status">
                <small>{lang key='productUnsaleable' section='productDetails'}</small>
            </div>
        {elseif $Artikel->nErscheinendesProdukt}
            <div class="availablefrom">
                <small>{lang key="productAvailableFrom"}: {$Artikel->Erscheinungsdatum_de}</small>
            </div>
            {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar === 1}
                <div class="attr attr-preorder"><small class="value">{lang key="preorderPossible" section="global"}</small></div>
            {/if}
        {elseif $anzeige !== 'nichts'
            && $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen !== 'N'
            && $Artikel->getBackorderString() !== ''
            && ($Artikel->cLagerKleinerNull === 'N' || $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen === 'U')}
            <div class="signal_image status-1"><small>{$Artikel->getBackorderString()}</small></div>
        {elseif $anzeige !== 'nichts'
            && $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen !== 'N'
            && $Artikel->cLagerBeachten === 'Y'
            && $Artikel->fLagerbestand <= 0
            && $Artikel->fLieferantenlagerbestand > 0
            && $Artikel->fLieferzeit > 0
            && ($Artikel->cLagerKleinerNull === 'N' || $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen === 'U')}
            <div class="signal_image status-1"><small>{lang key='supplierStockNotice' printf=$Artikel->fLieferzeit}</small></div>
        {elseif $anzeige === 'verfuegbarkeit' || $anzeige === 'genau'}
            <div class="signal_image status-{$Artikel->Lageranzeige->nStatus} small">{$Artikel->Lageranzeige->cLagerhinweis[$anzeige]}</div>
        {elseif $anzeige === 'ampel'}
            <div class="signal_image status-{$Artikel->Lageranzeige->nStatus} small">{$Artikel->Lageranzeige->AmpelText}</div>
        {/if}
        {if $Artikel->cEstimatedDelivery && $showEstimated}
            {getCountry iso=$shippingCountry assign='selectedCountry'}
            <div class="{if $Artikel->bHasKonfig} mt-xs{else} mt-xxs{/if} small">
                <div class="estimated-delivery alert alert-info m0"
                    {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                    data-toggle="popover"
                    data-placement="top"
                    data-content="{if $selectedCountry !== null}{lang key='shippingInformation' section='productDetails' assign=silv}{sprintf($silv, $selectedCountry->getName(), $oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL(), $oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL())}{/if}"
                    {/if}>
                    {if $snackyConfig.deliveryDate == '1'}
                        {block name='productdetails-stock-snackys-deliverydate'}
                            <strong>{lang key="deliveryDate" section="custom"}:</strong>
                            <div>
                            {getDeliveryDate calculateDays=$snackyConfig.daysForDeliverCalculation days=$Artikel->nMinDeliveryDays saturday=$snackyConfig.deliveryDateSaturday state=$snackyConfig.deliveryDateState endTime=$snackyConfig.deliveryDateFinishTime format=$snackyConfig.deliveryDateFormat}
                            {if $Artikel->nMinDeliveryDays < $Artikel->nMaxDeliveryDays}
                                - {getDeliveryDate calculateDays=$snackyConfig.daysForDeliverCalculation days=$Artikel->nMaxDeliveryDays saturday=$snackyConfig.deliveryDateSaturday state=$snackyConfig.deliveryDateState endTime=$snackyConfig.deliveryDateFinishTime format=$snackyConfig.deliveryDateFormat}
                            {/if}
                            </div>
                            <div class="estimated-delivery-info">{lang key='shippingInfoIcon' section='productDetails' printf=$selectedCountry->getISO()}</div>
                        {/block}
                    {else}
                        {block name='productdetails-stock-snackys-deliverytime'}
                            {if !isset($availability) && !isset($shippingTime)}<strong>{lang key='shippingTime'}: </strong>{/if}
                            <span class="a{$Artikel->Lageranzeige->nStatus} text-nowrap">
                                {$Artikel->cEstimatedDelivery}
                                <div class="estimated-delivery-info">{lang key='shippingInfoIcon' section='productDetails' printf=$selectedCountry->getISO()}</div>
                            </span>
                        {/block}
                    {/if}
                    {block name="productdetails-shipfree-info"}
                        {if !empty($WarenkorbVersandkostenfreiHinweis) && $tplscope == 'detail'}
                        <div class="mt-xxs">
                            {$WarenkorbVersandkostenfreiHinweis|truncate:120:"..."}
                        </div>
                        {/if}
                    {/block}
                </div>
            </div>
        {/if}
    </div>
{/block}