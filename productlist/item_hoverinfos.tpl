{block name="item-hoverinfos"}
    <div class="exp">
        {block name="form-expandable"}
            {if $hasOnlyListableVariations > 0 && !$Artikel->bHasKonfig && $Artikel->kEigenschaftKombi === 0}
                <div class="basket-variations">
                    {assign var="singleVariation" value=true}
                    {include file="productdetails/variation.tpl" simple=$Artikel->isSimpleVariation showMatrix=false smallView=true ohneFreifeld=($hasOnlyListableVariations === 2)}
                </div>
            {/if}
            <div>
                {block name="productlist-add-basket"}
                    {if ($Artikel->inWarenkorbLegbar === 1 || ($Artikel->nErscheinendesProdukt === 1 && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y')) &&
                    (($Artikel->nIstVater === 0 && $Artikel->Variationen|@count === 0) || $hasOnlyListableVariations === 1) && !$Artikel->bHasKonfig}
                        <div class="quantity-wrapper form-group top7">
                            {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
                                <div class="alert alert-info choose-variations">{lang key="chooseVariations" section="messages"}</div>
                            {else}
                                <div class="quantity-wrapper form-group top7">
                                    {if $snackyConfig.quantityButtons == 1}
                                        <div class="btn-group qty-btns w100 m0">
                                            {block name="productlist-add-basket-minus"}
                                                <div class="btn btn-blank qty-sub">
                                                    <span class="img-ct icon">
                                                        <svg>
                                                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-minus"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                            {/block}
                                    {else}
                                        <div class="input-group input-group-sm">
                                    {/if}
                                    {block name="productlist-add-basket-input"}
                                        <input type="{if $Artikel->cTeilbar === 'Y' && $Artikel->fAbnahmeintervall == 0}text{else}number{/if}"
                                            min="{if $Artikel->fMindestbestellmenge}{$Artikel->fMindestbestellmenge}{else}0{/if}"
                                            max="{$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''}"
                                            {if $Artikel->fAbnahmeintervall > 0}step="{$Artikel->fAbnahmeintervall}"{/if}
                                            size="2"
                                            id="quantity{$Artikel->kArtikel}"
                                            class="quantity form-control{if $snackyConfig.quantityButtons == 1} text-center {else} text-right{/if}"
                                            name="anzahl"
                                            autocomplete="off"
                                            value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}1{/if}">
                                    {/block}
                                    {if $snackyConfig.quantityButtons == 1}
                                            {block name="productlist-add-basket-plus"}
                                                <div class="btn btn-blank qty-add">
                                                    <span class="img-ct icon">
                                                        <svg>
                                                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-plus"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                            {/block}
                                        </div>
                                        <hr class="hr-xxs invisible">
                                        <button type="submit" class="btn btn-primary btn-block" id="submit{$Artikel->kArtikel}" title="{lang key="addToCart"}">
                                            {lang key="addToCart"}
                                        </button>
                                    {else}
                                            <span class="input-group-btn">
                                                <button type="submit" class="btn btn-primary" id="submit{$Artikel->kArtikel}" title="{lang key="addToCart"}">
                                                    <span class="img-ct icon ic-w">
                                                        <svg>
                                                            <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
                                                        </svg>
                                                    </span>
                                                </button>
                                            </span>
                                        </div>
                                    {/if}
                                </div>
                            {/if}
                        </div>
                    {else}
                        {block name="productlist-add-basket-details-link"}
                            <div class="top7 form-group">
                                <a class="btn btn-default btn-md btn-block" role="button" href="{$Artikel->cURLFull}">{lang key="details"}</a>
                            </div>
                        {/block}
                    {/if}
                {/block}
            </div>
            {block name="form-expandable-declarations"}
                {if $Artikel->kArtikelVariKombi > 0}
                    <input type="hidden" name="aK" value="{$Artikel->kArtikelVariKombi}" />
                {/if} 	
                {if isset($Artikel->kVariKindArtikel)}
                    <input type="hidden" name="VariKindArtikel" value="{$Artikel->kVariKindArtikel}" />
                {/if}
                <input type="hidden" name="a" value="{$Artikel->kArtikel}" />
                <input type="hidden" name="wke" value="1" />
                <input type="hidden" name="overview" value="1" />
                <input type="hidden" name="Sortierung" value="{if !empty($Suchergebnisse->Sortierung)}{$Suchergebnisse->Sortierung}{/if}" />			
                {if $Suchergebnisse->getPages()->getCurrentPage() > 1}
                    <input type="hidden" name="seite" value="{$Suchergebnisse->getPages()->getCurrentPage()}" />
                {/if}
                {if $NaviFilter->hasCategory()}
                    <input type="hidden" name="k" value="{$NaviFilter->getCategory()->getValue()}" />
                {/if}
                {if $NaviFilter->hasManufacturer()}
                    <input type="hidden" name="h" value="{$NaviFilter->getManufacturer()->getValue()}" />
                {/if}
                {if $NaviFilter->hasSearchQuery()}
                    <input type="hidden" name="l" value="{$NaviFilter->getSearchQuery()->getValue()}" />
                {/if}
                {if $NaviFilter->hasCharacteristicValue()}
                    <input type="hidden" name="m" value="{$NaviFilter->getCharacteristicValue()->getValue()}" />
                {/if}
                {if $NaviFilter->hasCategoryFilter()}
                    {assign var=cfv value=$NaviFilter->getCategoryFilter()->getValue()}
                    {if is_array($cfv)}
                        {foreach $cfv as $val}
                            <input type="hidden" name="hf" value="{$val}" />
                        {/foreach}
                    {else}
                        <input type="hidden" name="kf" value="{$cfv}" />
                    {/if}
                {/if}
                {if $NaviFilter->hasManufacturerFilter()}
                    {assign var=mfv value=$NaviFilter->getManufacturerFilter()->getValue()}
                    {if is_array($mfv)}
                        {foreach $mfv as $val}
                            <input type="hidden" name="hf" value="{$val}" />
                        {/foreach}
                    {else}
                        <input type="hidden" name="hf" value="{$mfv}" />
                    {/if}
                {/if}
                {foreach $NaviFilter->getCharacteristicFilter() as $filter}
                    <input type="hidden" name="mf{$filter@iteration}" value="{$filter->getValue()}" />
                {/foreach}
            {/block}
        {/block}
    </div>
{/block}