{block name='productdetails-basket'}
{if ($Artikel->inWarenkorbLegbar == 1 || $Artikel->nErscheinendesProdukt == 1) || $Artikel->Variationen}
    <div id="add-to-cart" class="hidden-print product-buy{if $Artikel->nErscheinendesProdukt} coming_soon{/if}">

        {block name="add-to-cart"}
            {if $Artikel->nErscheinendesProdukt}
                <div class="{if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y'}alert alert-warning coming_soon{else}alert alert-info {/if} text-center">
                    {lang key="productAvailableFrom" section="global"}: <strong>{$Artikel->Erscheinungsdatum_de}</strong>
                    {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar == 1}
                        ({lang key="preorderPossible" section="global"})
                    {/if}
                </div>
            {/if}
            {if $Artikel->inWarenkorbLegbar == 1 && !$Artikel->oKonfig_arr}
                {if !$showMatrix}
                    {block name="basket-form-inline"}
                        <div id="quantity-grp" class="dpflex{if $snackyConfig.quantityButtons == '1'}-wrap{/if} w100 choose_quantity{if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix} disabled mb-xxs{/if}">
                            {if $snackyConfig.quantityButtons == '1'}
                            <div class="btn-group qty-btns w100 m0">
                                <div class="btn btn-blank qty-sub">
                                    <span class="img-ct icon">
                                        <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-minus"></use>
                                        </svg>
                                    </span>
                                </div>
                            {/if}
                                
                            <input type="{if $Artikel->cTeilbar === 'Y' && $Artikel->fAbnahmeintervall == 0}text{else}number{/if}"
                               min="{if $Artikel->fMindestbestellmenge}{$Artikel->fMindestbestellmenge}{else if $Artikel->cTeilbar != 'Y'}1{/if}"
                               max="{$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''}"
                               {if $Artikel->cTeilbar != 'Y'}
                                   step="{if $Artikel->fAbnahmeintervall > 0}{$Artikel->fAbnahmeintervall}{else}1{/if}"
                                {/if}
                                   id="quantity" class="quantity form-control{if $snackyConfig.quantityButtons == '1'} text-center{else} text-right{/if}" name="anzahl"
                                   aria-label="{lang key='quantity'}"
                                   value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}1{/if}" />
                            {if $Artikel->cEinheit}
                                <span class="input-group-addon unit">{$Artikel->cEinheit}</span>
                            {/if}
                            {if $snackyConfig.quantityButtons == '1'}
                                <div class="btn btn-blank qty-add">
                                    <span class="img-ct icon">
                                        <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-plus"></use>
                                        </svg>
                                    </span>
                                </div>
                            </div>
                            <hr class="hr-xs invisible w100">
                            {/if}
                            <button aria-label="{lang key='addToCart'}" name="inWarenkorb" type="submit" value="{lang key='addToCart'}" class="sn-addBasket submit btn btn-primary btn-lg btn-block{if isset($wkWeiterleiten)} wkWeiterleiten{/if}"{if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix} disabled{/if}
                                data-track-type="click" data-track-event="add_to_cart" data-track-p-value="{$Artikel->Preise->fVKNetto}" data-track-p-currency="{$smarty.session.Waehrung->cISO}" data-track-p-items='[{ldelim}"id":"{$Artikel->cArtNr}","category":"{$cate|htmlspecialchars}","name":"{$Artikel->cName|htmlspecialchars}","price":"{$Artikel->Preise->fVKNetto}","quantity":"selectorval:#quantity"{rdelim}]'
                            >
                                <span class="">{lang key='addToCart'}</span>
                            </button>
                        </div>
                    {/block}
                {/if}
                {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix}
                    <div class="small">
                        <p class="alert alert-info choose-variations">{lang key="chooseVariations" section="messages"}</p>
                    </div>
               {/if}
            {/if}
        {if $Artikel->inWarenkorbLegbar == 1
            && ($Artikel->fMindestbestellmenge > 1
                || ($Artikel->fMindestbestellmenge > 0 && $Artikel->cTeilbar === 'Y')
                || ($Artikel->fAbnahmeintervall > 0 && $Einstellungen.artikeldetails.artikeldetails_artikelintervall_anzeigen === 'Y')
                || $Artikel->cTeilbar === 'Y'
                || (!empty($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE])
                    && $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE] > 0))}
                <div class="purchase-info small mt-xxs">
                    <div class="alert alert-info" role="alert">
                    {assign var="units" value=$Artikel->cEinheit}
                    {if empty($Artikel->cEinheit) || $Artikel->cEinheit|@count_characters == 0}
                        <span class="block">{lang key="units" section="productDetails" assign="units"}</span>
                    {/if}

                    {if $Artikel->fMindestbestellmenge > 1 || ($Artikel->fMindestbestellmenge > 0 && $Artikel->cTeilbar === 'Y')}
                        {lang key="minimumPurchase" section="productDetails" assign="minimumPurchase"}
                        <span class="block">{$minimumPurchase|replace:"%d":$Artikel->fMindestbestellmenge|replace:"%s":$units}</span>
                    {/if}

                    {if $Artikel->fAbnahmeintervall > 0 && $Einstellungen.artikeldetails.artikeldetails_artikelintervall_anzeigen === 'Y'}
                        {lang key="takeHeedOfInterval" section="productDetails" assign="takeHeedOfInterval"}
                        <span class="block">{$takeHeedOfInterval|replace:"%d":$Artikel->fAbnahmeintervall|replace:"%s":$units}</span>
                    {/if}

                    {if $Artikel->cTeilbar === 'Y'}
                        <span class="block">{lang key="integralQuantities" section="productDetails"}</span>
                    {/if}

                    {if !empty($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]) && $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE] > 0}
                        {lang key="maximalPurchase" section="productDetails" assign="maximalPurchase"}
                        <span class="block">{$maximalPurchase|replace:"%d":$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE]|replace:"%s":$units}</span>
                    {/if}
                    </div>
                </div>
            {/if}
        {/block}
    </div>
{/if}
{/block}