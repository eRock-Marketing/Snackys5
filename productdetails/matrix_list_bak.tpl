{block name='productdetails-matrix-list'}
{if $Artikel->nIstVater == 1 && $Artikel->oVariationKombiKinderAssoc_arr|count > 0}
    <div class="table-responsive">
        <table class="table table-striped variation-matrix">
            <tbody>
            {foreach $Artikel->oVariationKombiKinderAssoc_arr as $child}
                {if $Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_lagerbeachten !== 'Y' ||
                ($Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_lagerbeachten === 'Y' && $child->inWarenkorbLegbar == 1)}
                    <tr class="row">
                        <td class="hidden-xs col-sm-1">
                            <img class="img-responsive" src="{$child->Bilder[0]->cURLMini}" alt="{$child->Bilder[0]->cAltAttribut}">
                        </td>
                        <td class="col-6">
                            <div >
                                <a href="{$child->cSeo}"><span itemprop="name">{$child->cName}</span></a>
                            </div>
                            <div class="small">
                                {if $child->nErscheinendesProdukt}
                                    {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                    {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $child->inWarenkorbLegbar == 1}
                                        ({lang key='preorderPossible'})
                                    {/if}
                                {/if}
                                {include file='productdetails/stock.tpl' Artikel=$child tplscope='matrix'}
                            </div>
                        </td>
                        <td class="col-4 col-sm-3">
                            {if $child->inWarenkorbLegbar == 1 && !$child->bHasKonfig && ($child->nVariationAnzahl == $child->nVariationOhneFreifeldAnzahl)}
                                <div class="input-group input-group-sm pull-right{if isset($smarty.session.variBoxAnzahl_arr[$child->kArtikel]->bError) && $smarty.session.variBoxAnzahl_arr[$child->kArtikel]->bError} has-error{/if}">
                                    {if $child->cEinheit}
                                        <span class="input-group-addon unit hidden-xs">{$child->cEinheit}: </span>
                                    {/if}
                                    <input
                                        size="3" placeholder="0"
                                        class="form-control text-right"
                                        name="variBoxAnzahl[{$child->kArtikel}]"
                                        type="text"
                                        value="{if isset($smarty.session.variBoxAnzahl_arr[$child->kArtikel]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$child->kArtikel]->fAnzahl|replace_delim}{/if}">
                                </div>
                            {/if}
                        </td>
                        <td class="hidden-xs col-sm-1 text-center">
                            <span class="text-muted">&times;</span>
                        </td>
                        <td class="col-2 col-sm-3 text-right">
                            {include file='productdetails/price.tpl' Artikel=$child tplscope='matrix'}
                        </td>
                    </tr>
                {/if}
            {/foreach}
            </tbody>
        </table>
    </div>
    <input type="hidden" name="variBox" value="1" />
    <input type="hidden" name="varimatrix" value="1" />
    <button name="inWarenkorb" type="submit" value="{lang key='addToCart'}" class="submit btn btn-primary pull-right">{lang key='addToCart'}</button>
{/if}
{/block}
