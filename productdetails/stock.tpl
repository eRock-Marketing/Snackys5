{block name='productdetails-stock'}
    {block name='stock-assigns'}
        {assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
    {/block}
    {block name='stock-wrapper'}
        <div class="delivery-status small">
            {block name='delivery-status'}
                {block name='stock-status'}
                    {if !isset($shippingTime)}
                        {if $Artikel->inWarenkorbLegbar === $smarty.const.INWKNICHTLEGBAR_UNVERKAEUFLICH}
                            {block name='stock-status-unsaleable'}
                                <span class="status icon-wt">{lang key='productUnsaleable' section='productDetails'}</span>
                            {/block}
                        {elseif !$Artikel->nErscheinendesProdukt}
                            {block name='stock-status-include'}
                                {include file='snippets/stock_status.tpl' currentProduct=$Artikel}
                            {/block}
                        {else}
                            {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && $Artikel->fLagerbestand > 0}
                                {block name='stock-status-storageinfo'}
                                    <span class="status status-{$Artikel->Lageranzeige->nStatus} icon-wt">{$Artikel->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                {/block}
                            {elseif $anzeige === 'ampel' && $Artikel->fLagerbestand > 0}
                                {block name='stock-status-ampel'}
                                    <span class="status status-{$Artikel->Lageranzeige->nStatus} icon-wt">{$Artikel->Lageranzeige->AmpelText}</span>
                                {/block}
                            {/if}
                        {/if}
                        {block name='stock-delivery-status'}
                            {if isset($Artikel->cLieferstatus) && ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'Y' ||
                            ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'L' && $Artikel->fLagerbestand == 0 && $Artikel->cLagerBeachten === 'Y') ||
                            ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'A' && ($Artikel->fLagerbestand > 0 || $Artikel->cLagerKleinerNull === 'Y' || $Artikel->cLagerBeachten !== 'Y')))}
                                <span class="delivery-status icon-wt"><strong>{lang key='deliveryStatus'}</strong>: {$Artikel->cLieferstatus}</span>
                            {/if}
                        {/block}
                    {/if}
                {/block}
                {block name='stock-delivery'}
                    {if !isset($availability)}
                        {if $Artikel->cEstimatedDelivery}
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
                                            {getDeliveryDate calculateDays=$snackyConfig.daysForDeliverCalculation days=$Artikel->nMinDeliveryDays saturday=$snackyConfig.deliveryDateSaturday state=$snackyConfig.deliveryDateState endTime=$snackyConfig.deliveryDateFinishTime format=$snackyConfig.deliveryDateFormat}
                                            {if $Artikel->nMinDeliveryDays < $Artikel->nMaxDeliveryDays}
                                                - {getDeliveryDate calculateDays=$snackyConfig.daysForDeliverCalculation days=$Artikel->nMaxDeliveryDays saturday=$snackyConfig.deliveryDateSaturday state=$snackyConfig.deliveryDateState endTime=$snackyConfig.deliveryDateFinishTime format=$snackyConfig.deliveryDateFormat}
                                            {/if}
                                            <span class="estimated-delivery-info">{lang key='shippingInfoIcon' section='productDetails' printf=$selectedCountry->getISO()}</span>
                                        {/block}
                                    {else}
                                        {block name='productdetails-stock-snackys-deliverytime'}
                                            {if !isset($availability) && !isset($shippingTime)}<strong>{lang key='shippingTime'}: </strong>{/if}
                                            <span class="a{$Artikel->Lageranzeige->nStatus} text-nowrap">
                                                {$Artikel->cEstimatedDelivery}
                                                <span class="estimated-delivery-info">{lang key='shippingInfoIcon' section='productDetails' printf=$selectedCountry->getISO()}</span>
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
                    {/if}
                {/block}
            {/block}
        </div>
    {/block}
{/block}
