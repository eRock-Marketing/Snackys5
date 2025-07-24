{block name="sticky-basket-bar"}
    {if ($Artikel->inWarenkorbLegbar == 1 || $Artikel->nErscheinendesProdukt == 1) || $Artikel->Variationen}
        {if isset($Artikel->Bilder[0]->cAltAttribut)}
            {assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"quotes"}
        {else}
            {assign var="alt" value=$Artikel->cName}
        {/if}
        {$image = $Artikel->Bilder[0]}
        <div id="stck-bskt" class="flx-ac">
            <div class="left flx-ac">
                <div class="img-ct">
                    {image 
                        alt=$alt 
                        webp=true
                        src="{$image->cURLKlein}"
                        lazy=true
                    }
                </div>
                <div class="info flx-ac flx-jb">
                    <div class="title">
                        <strong>{$Artikel->cName}</strong>
                    </div>
                    <div class="text-right">
                        {if !($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX]))}
                            {include file="productdetails/price.tpl" Artikel=$Artikel tplscope="list"}
                        {/if}
                    </div>
                </div>
            </div>
            <div class="right">
                {if ($Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix) || $Artikel->bHasKonfig}
                    <a href="#content-wrapper" class="btn btn-primary btn-lg">
                        <span class="visible-xs">
                            <span class="img-ct icon">
                                <svg>
                                    <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-filter"></use>
                                </svg>
                            </span>
                        </span>
                        <span class="hidden-xs">{lang key='configure'}</span>
                    </a>
                {else}
                    <div class="btn btn-primary btn-lg" id="stck-bskt-add">
                        <span class="visible-xs">
                            <span class="img-ct icon">
                                <svg>
                                    <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
                                </svg>
                            </span>
                        </span>
                        <span class="hidden-xs">{lang key='addToCart'}</span>
                    </div>
                {/if}
            </div>
        </div> 
    {/if}
{/block}