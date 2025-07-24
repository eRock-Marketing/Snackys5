{block name='productdetails-basket'}
{if ($Artikel->inWarenkorbLegbar == 1 || $Artikel->nErscheinendesProdukt == 1) || $Artikel->Variationen}
    <div id="add-to-cart" class="hidden-print product-buy{if $Artikel->nErscheinendesProdukt} coming_soon{/if}">

        {block name="add-to-cart"}
            {if $Artikel->inWarenkorbLegbar == 1 && !$Artikel->oKonfig_arr}
                {if !$showMatrix}
                    {block name="basket-form-inline"}
                        {if $Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX])}
                            {block name='productdetails-basket-voucher-flex'}
                                {col cols=12 sm=6}
                                    {inputgroup class="form-counter"}
                                        {input type="number"
                                            step=".01"
                                            value="{if isset($voucherPrice)}{$voucherPrice}{/if}"
                                            name="{$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX}Value"
                                            required=true
                                            placeholder="{lang key='voucherFlexPlaceholder' section='productDetails' printf=$smarty.session.Waehrung->getName()}"}
                                        {inputgroupappend}
                                            {inputgrouptext class="form-control"}
                                                {$smarty.session.Waehrung->getName()}
                                            {/inputgrouptext}
                                        {/inputgroupappend}
                                    {/inputgroup}
                                {/col}
                                {if isset($kEditKonfig)}
                                    <input type="hidden" name="kEditKonfig" value="{$kEditKonfig}"/>
                                {/if}
                                {input type="hidden" id="quantity" class="quantity" name="anzahl" value="1"}
                            {/block}
                        {else}
                            <div id="quantity-grp" class="dpflex{if $snackyConfig.quantityButtons == '1'}-wrap{/if} w100 choose_quantity{if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix} disabled mb-xxs{/if}">
                                {if $snackyConfig.quantityButtons == '1'}
                                <div class="btn-group qty-btns w100 m0">
                                    <div class="btn btn-blank qty-sub">
                                        <span class="img-ct icon">
                                            <svg>
                                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-minus"></use>
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
                                       value="{if $Artikel->fAbnahmeintervall > 0 || $Artikel->fMindestbestellmenge > 1}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}1{/if}" />
                                {if $Artikel->cEinheit}
                                    <span class="input-group-addon unit">{$Artikel->cEinheit}</span>
                                {/if}
                                {if $snackyConfig.quantityButtons == '1'}
                                    <div class="btn btn-blank qty-add">
                                        <span class="img-ct icon">
                                            <svg>
                                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-plus"></use>
                                            </svg>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        <hr class="hr-xs invisible w100">
                        {/if}
                        {/if}
                        <button aria-label="{lang key='addToCart'}" name="inWarenkorb" type="submit" value="{lang key='addToCart'}" class="sn-addBasket submit btn btn-primary btn-lg btn-block{if isset($wkWeiterleiten)} wkWeiterleiten{/if}"{if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix} disabled{/if}>
                            <span class="">{lang key='addToCart'}</span>
                        </button>
                        {if $snackyConfig.quantityButtons != '1'}
                        </div>
                        {/if}
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