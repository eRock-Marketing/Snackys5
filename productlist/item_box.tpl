{block name='productlist-item-box'}
{if $snackyConfig.variation_select_productlist === 'N' || $snackyConfig.hover_productlist !== 'Y'}
{assign var="hasOnlyListableVariations" value=0}
{else}
{hasOnlyListableVariations artikel=$Artikel maxVariationCount=$snackyConfig.variation_select_productlist maxWerteCount=$snackyConfig.variation_max_werte_productlist assign="hasOnlyListableVariations"}
{/if}
<div id="result-wrapper_buy_form_{$Artikel->kArtikel}" data-wrapper="true"
	class="p-c {if $snackyConfig.hover_productlist === 'Y' && !$isMobile} hv-e{/if}{if isset($listStyle) && $listStyle === 'gallery'} active{/if}{if isset($class)} {$class}{/if}">
    {block name="productlist-image"}
    <a class="img-w block" href="{$Artikel->cURLFull}">
        {if isset($Artikel->Bilder[0]->cAltAttribut)}
			{assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"html"}
        {else}
			{assign var="alt" value=$Artikel->cName}
        {/if}
        <div class="img-ct{if isset($Artikel->Bilder[1])} has-second{/if}">
            {$image = $Artikel->Bilder[0]}
			{image 
				alt=$alt 
				webp=true
				src="{$image->cURLKlein}"
				srcset="{$image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
						 {$image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
						 {$image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w"
				sizes="auto"
				data=["id"  => $imgcounter]
				class="{if !$isMobile && !empty($Artikel->Bilder[1])} first{/if}"
				lazy=!$stopLazy
			}

            {if isset($Artikel->Bilder[1]) && !$isMobile}
            <div class="second-img">
                {$image2 = $Artikel->Bilder[1]}

                {image alt=$alt fluid=true webp=true lazy=true
                    src="{$image2->cURLKlein}"
                    srcset="{$image2->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
                             {$image2->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
                             {$image2->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w"
                    sizes="auto"
                    data=["id"  => $imgcounter]
                    class="{if !$isMobile && !empty($Artikel->Bilder[1])} first{/if}"
                    fluid=true
                    lazy=true
                }
            </div>
            {/if}
        </div>
		{block name='searchspecial-overlay'}
			{if isset($Artikel->oSuchspecialBild)}
				{if isset($Artikel->oSuchspecialBild->cSuchspecial)}
					{assign var="cSpecialCheck" value=$Artikel->oSuchspecialBild->cSuchspecial|replace:'ü':''}
					{if $Artikel->oSuchspecialBild->cSuchspecial == 'Sonderangebote' && $snackyConfig.saleprozent == 'Y'}
						{assign var="rabatt" value=($Artikel->Preise->alterVKNetto-$Artikel->Preise->fVKNetto)/$Artikel->Preise->alterVKNetto*100}
						<span class="ov-t {$Artikel->oSuchspecialBild->cSuchspecial|lower|strip:''}">- {$rabatt|round:0}%</span>
					{elseif isset($oSuchspecial[$cSpecialCheck])}
						<span class="ov-t {$Artikel->oSuchspecialBild->cSuchspecial|lower|strip:''}">{$oSuchspecial[$cSpecialCheck]}</span>
					{*Workaround for damn ü !*}
					{elseif $Artikel->oSuchspecialBild->cSuchspecial|substr:0:4|lower == 'in k'}
						<span class="ov-t bald-verfuegbar">{$oSuchspecial['bald-verfuegbar']}</span>
					{else}
						<span class="ov-t {$Artikel->oSuchspecialBild->cSuchspecial|lower|strip:''}">#{$Artikel->oSuchspecialBild->cSuchspecial}</span>
					{/if}
				{/if}
			{/if}
		{/block}
    </a>
    {/block}
    {block name="productlist-image-caption"}
    <div class="caption">
        <a href="{$Artikel->cURLFull}" class="title block h4 m0" itemprop="name">{$Artikel->cKurzbezeichnung}</a>
        {if $Artikel->cName !== $Artikel->cKurzbezeichnung}
			<meta itemprop="alternateName" content="{$Artikel->cName}">
		{/if}
        <meta itemprop="url" content="{$Artikel->cURLFull}">
        {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}
            <a href="{$Artikel->cURLFull}#tab-votes" class="hidden-print block">
			{include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}
            </a>
        {/if}
        {include file="productdetails/price.tpl" Artikel=$Artikel tplscope=$tplscope}
    </div>{* /caption *}
    {/block}
    <form id="buy_form_{$Artikel->kArtikel}" action="{$ShopURL}/" method="post" class="form form-basket evo-validate" data-toggle="basket-add">
        {$jtl_token}
        {block name="productlist-delivery-status"}
        <div class="delivery-status">
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
			{* if $Artikel->cEstimatedDelivery}
				<div class="estimated_delivery hidden-xs small">{lang key="shippingTime"}: {$Artikel->cEstimatedDelivery}</div>
			{/if *}
        </div>
        {/block}
        {if $snackyConfig.hover_productlist === 'Y' && !$isMobile}
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
                (($Artikel->nIstVater === 0 && $Artikel->Variationen|@count === 0) || $hasOnlyListableVariations === 1) && !$Artikel->bHasKonfig
                }
                <div class="quantity-wrapper form-group top7">
                    {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
                    <div class="alert alert-info choose-variations">{lang key="chooseVariations" section="messages"}</div>
                    {else}
                    <div class="quantity-wrapper form-group top7">
                        {if $snackyConfig.quantityButtons == 1}
                        <div class="btn-group qty-btns w100 m0">
                            <div class="btn btn-blank qty-sub">
                                <span class="img-ct icon">
                                    <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-minus"></use>
                                    </svg>
                                </span>
                            </div>
                        {else}
                        <div class="input-group input-group-sm">
                        {/if}
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
                        {if $snackyConfig.quantityButtons == 1}
                            <div class="btn btn-blank qty-add">
                                <span class="img-ct icon">
                                    <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-plus"></use>
                                    </svg>
                                </span>
                            </div>
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
                                            <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
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
                <div class="top7 form-group">
                    <a class="btn btn-default btn-md btn-block" role="button" href="{$Artikel->cURLFull}">{lang key="details"}</a>
                </div>
                {/if}
                {/block}
            </div>

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
        </div>
        {elseif $snackyConfig.listShowCart != 1}
        <div class="exp{if $snackyConfig.listShowCart == 2} flo-bt {/if}{if $snackyConfig.listShowAmountCart == 1} hide-qty{else} show-qty{/if}">
            {block name="form-expandable"}
            {block name="productlist-add-basket"}
            {if ($Artikel->inWarenkorbLegbar === 1 || ($Artikel->nErscheinendesProdukt === 1 && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y')) &&
            (($Artikel->nIstVater === 0 && $Artikel->Variationen|@count === 0)) && !$Artikel->bHasKonfig}
            {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
            {else}
            {if $snackyConfig.listShowCart == 3 && $snackyConfig.listShowAmountCart == 2 && $snackyConfig.quantityButtons != 1}<div class="input-group input-group-sm small">{/if}
                {if $snackyConfig.quantityButtons == 1 && $snackyConfig.listShowCart == 3 && $snackyConfig.listShowAmountCart == 2}
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
					min="{if $Artikel->fMindestbestellmenge}{$Artikel->fMindestbestellmenge}{else}0{/if}"
					max="{$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''}"
					{if $Artikel->fAbnahmeintervall > 0}step="{$Artikel->fAbnahmeintervall}"{/if}
					size="2"
					id="quantity{$Artikel->kArtikel}"
					class="quantity form-control{if $snackyConfig.quantityButtons != 1} text-right{else} text-center{/if}"
					name="anzahl"
					autocomplete="off"
					value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}{$snackyConfig.listAmountCart}{/if}">                   
                {if $snackyConfig.quantityButtons == 1 && $snackyConfig.listShowCart == 3 && $snackyConfig.listShowAmountCart == 2}
                    <div class="btn btn-blank qty-add">
                        <span class="img-ct icon">
                            <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-plus"></use>
                            </svg>
                        </span>
                    </div>
                </div>
                <hr class="hr-xxs invisible">
                {/if}
                    <span class="input-group-btn">
                        <button type="submit" class="btn btn-primary sn-addBasket btn-block" id="submit{$Artikel->kArtikel}" title="{lang key="addToCart" section="global"}">
                            {if ($snackyConfig.listShowAmountCart == 2 && $snackyConfig.quantityButtons != 1) ||  $snackyConfig.listShowCart == 2}
                                <span class="img-ct icon ic-w mauto">
                                    <svg>
                                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
                                    </svg>
                                </span>
                            {else}
                            <span class="visible-xs">
                                <span class="img-ct icon ic-w mauto">
                                    <svg>
                                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
                                    </svg>
                                </span>
                            </span>
                            <span class="hidden-xs">{lang key="addToCart" section="global"}</span>
                            {/if}
                        </button>
                    </span>
                {if $snackyConfig.listShowCart == 3 && $snackyConfig.listShowAmountCart == 2 && $snackyConfig.quantityButtons != 1}</div>{/if}
            {/if}
            {elseif $snackyConfig.listShowCart == 3}
            <a href="{$Artikel->cURLFull}" class="btn btn-block">{lang key="details"}</a>
            {/if}
            {/block}

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
        </div>
        {/if}
    </form>
</div>
{/block}
