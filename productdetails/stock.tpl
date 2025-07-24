{block name='productdetails-stock'}
{assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
<div class="delivery-status small">
{block name='delivery-status'}
    {if !isset($shippingTime)}
        {if $Artikel->inWarenkorbLegbar === $smarty.const.INWKNICHTLEGBAR_UNVERKAEUFLICH}
            <span class="status icon-wt">{lang key='productUnsaleable' section='productDetails'}</span>
        {elseif !$Artikel->nErscheinendesProdukt}
            {include file='snippets/stock_status.tpl' currentProduct=$Artikel}
        {else}
            {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && $Artikel->fLagerbestand > 0}
                <span class="status status-{$Artikel->Lageranzeige->nStatus} icon-wt">{$Artikel->Lageranzeige->cLagerhinweis[$anzeige]}</span>
            {elseif $anzeige === 'ampel' && $Artikel->fLagerbestand > 0}
                <span class="status status-{$Artikel->Lageranzeige->nStatus} icon-wt">{$Artikel->Lageranzeige->AmpelText}</span>
            {/if}
        {/if}

        {* rich snippet availability *}
        {if $Artikel->cLagerBeachten === 'N' || $Artikel->fLagerbestand > 0 || $Artikel->cLagerKleinerNull === 'Y'}
            <link itemprop="availability" href="http://schema.org/InStock" />
        {elseif $Artikel->nErscheinendesProdukt && $Artikel->Erscheinungsdatum_de !== '00.00.0000' && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y'}
            <link itemprop="availability" href="http://schema.org/PreOrder" />
        {elseif $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull === 'N' && $Artikel->fLagerbestand <= 0}
            <link itemprop="availability" href="http://schema.org/OutOfStock" />
        {/if}

        {if isset($Artikel->cLieferstatus) && ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'Y' ||
        ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'L' && $Artikel->fLagerbestand == 0 && $Artikel->cLagerBeachten === 'Y') ||
        ($Einstellungen.artikeldetails.artikeldetails_lieferstatus_anzeigen === 'A' && ($Artikel->fLagerbestand > 0 || $Artikel->cLagerKleinerNull === 'Y' || $Artikel->cLagerBeachten !== 'Y')))}
            <span class="delivery-status icon-wt"><strong>{lang key='deliveryStatus'}</strong>: {$Artikel->cLieferstatus}</span>
        {/if}
    {/if}

    {if !isset($availability)}
        {if $Artikel->cEstimatedDelivery}
            <div class="{if $Artikel->bHasKonfig} mt-xs{else} mt-xxs{/if} small">
                <div class="estimated-delivery alert alert-info m0"
                    {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                    data-toggle="popover"
                    data-placement="top"
                    data-content="{if $Firma->country !== null}{lang|sprintf:$Firma->country->getName():$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL():$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() key='shippingInformation' section='productDetails'}{/if}"
                    {/if}>
                    {if $snackyConfig.deliveryDate == '1'}
                        <strong>{lang key="deliveryDate" section="custom"}:</strong>
                        {getDeliveryDate days=$Artikel->nMinDeliveryDays saturday=$snackyConfig.deliveryDateSaturday state=$snackyConfig.deliveryDateState endTime=$snackyConfig.deliveryDateFinishTime format=$snackyConfig.deliveryDateFormat}
                        {if $Artikel->nMinDeliveryDays < $Artikel->nMaxDeliveryDays}
                            - {getDeliveryDate days=$Artikel->nMaxDeliveryDays saturday=$snackyConfig.deliveryDateSaturday state=$snackyConfig.deliveryDateState endTime=$snackyConfig.deliveryDateFinishTime format=$snackyConfig.deliveryDateFormat}
                        {/if}
                    {else}
                        {if !isset($availability) && !isset($shippingTime)}<strong>{lang key='shippingTime'}: </strong>{/if}
                        <span class="a{$Artikel->Lageranzeige->nStatus} text-nowrap">
                                {$Artikel->cEstimatedDelivery}
                        </span>
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
</div>
{/block}
