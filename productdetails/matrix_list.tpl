{block name='productdetails-matrix-list'}
    {if $Artikel->nIstVater == 1 && $Artikel->oVariationKombiKinderAssoc_arr|count > 0}
        {block name='productdetails-index-childs'}
            {foreach $Artikel->oVariationKombiKinderAssoc_arr as $child}
                {if $Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_lagerbeachten !== 'Y' ||
                ($Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_lagerbeachten === 'Y' && $child->inWarenkorbLegbar == 1)}
                    <div class="flx-ac mtrx-l card-body flx-w{if $snackyConfig.css_maxProductWidth <= 500} mtrx-xs{/if}">
                        {block name='productdetails-matrix-list-image'}
                            <div class="col-img">
                                <div class="img-ct">
                                    {include file='snippets/image.tpl' item=$child srcSize='xs'}
                                </div>
                            </div>
                        {/block}
                        {block name='productdetails-matrix-list-product-info'}
                            <div class="col-prd">
                                {block name='productdetails-matrix-list-title'}
                                    {link href=$child->cURLFull class="no-tdc"}{$child->cName}{/link}
                                {/block}
                                {block name='productdetails-matrix-list-include-price'}
                                    {include file='productdetails/price.tpl' Artikel=$child tplscope='matrix'}
                                {/block}
                                {if $child->nErscheinendesProdukt}
                                    {block name='productdetails-matrix-list-coming-soon'}
                                        <div class="small text-muted">
                                            {lang key='productAvailableFrom'}: {$child->Erscheinungsdatum_de}
                                            {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $child->inWarenkorbLegbar == 1}
                                                ({lang key='preorderPossible'})
                                            {/if}
                                        </div>
                                    {/block}
                                {/if}                                    
                                {block name='productdetails-matrix-list-include-stock'}
                                    {if $child@first}
                                        {include file='productdetails/stock.tpl' Artikel=$child tplscope='matrix'}
                                    {else}
                                        {include file='productdetails/stock.tpl' Artikel=$child tplscope='matrix' modal="none"}
                                    {/if}
                                {/block}
                            </div>
                        {/block}
                        {block name='productdetails-matrix-list-var-box-count'}
                            <div class="col-qty">
                                {if $child->inWarenkorbLegbar == 1 && !$child->bHasKonfig && ($child->nVariationAnzahl == $child->nVariationOhneFreifeldAnzahl)}
                                    {inputgroup class="choose_quantity{if isset($smarty.session.variBoxAnzahl_arr[$child->kArtikel]->bError) && $smarty.session.variBoxAnzahl_arr[$child->kArtikel]->bError} has-error{/if}{if $child->cEinheit} has-unit{/if}{if $snackyConfig.quantityButtons != '1'} no-qty{/if}"}
                                        {block name='matrix-quantity-minus'}
                                            {if $snackyConfig.quantityButtons == '1'}
                                                <div class="btn-group qty-btns w100 m0">
                                                    <button class="btn btn-blank qty-sub btn-sm" aria-label="{lang key='quantity' section='global'}: {lang key='less'}" type="button">
                                                        <span class="img-ct icon">
                                                            <svg>
                                                            <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-minus"></use>
                                                            </svg>
                                                        </span>
                                                    </button>
                                            {/if}
                                        {/block}
                                        {input placeholder="0"
                                            name="variBoxAnzahl[{$child->kArtikel}]"
                                            type="{if $snackyConfig.quantityButtons == '1'}number{else}text{/if}"
                                            min="0"
                                            value="{if isset($smarty.session.variBoxAnzahl_arr[$child->kArtikel]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$child->kArtikel]->fAnzahl|replace_delim}{/if}"
                                            class="quantity text-center{if $snackyConfig.quantityButtons == '1'} qty-inp{/if}" 
                                            aria=["label"=>"{lang key='quantity'} {$child->cName}"]}
										{block name='matrix-quantity-plus'}
                                            {if $snackyConfig.quantityButtons == '1'}
                                                        <button class="btn btn-blank qty-add btn-sm" aria-label="{lang key='quantity' section='global'}: {lang key='more'}" type="button">
                                                            <span class="img-ct icon">
                                                                <svg>
                                                                <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-plus"></use>
                                                                </svg>
                                                            </span>
                                                        </button>
                                                    </div>
                                            {/if}
                                        {/block}
                                        {if $child->cEinheit}
                                            <div class="unit small text-muted">
                                                {$child->cEinheit}
                                            </div>
                                        {/if}
                                    {/inputgroup}
                                {/if}
                            </div>
                        {/block}
                    </div>
                {/if}
                <hr>
            {/foreach}
        {/block}
        {block name='productdetails-matrix-list-submit'}
            {input type="hidden" name="variBox" value="1"}
            {input type="hidden" name="varimatrix" value="1"}
            <div class="card-body">
                {button name="inWarenkorb"
                    type="submit"
                    value="1"
                    variant="primary"
                    class="btn-lg btn-block"
                    }
                        {lang key='addToCart'}
                {/button}
            </div>
        {/block}
    {/if}
{/block}
