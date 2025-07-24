{block name='productdetails-price'}
{if $smarty.session.Kundengruppe->mayViewPrices()}
    <div class="price_wrapper{if $tplscope === 'detail'} mb-xxs{/if}">
    {block name="price-wrapper"}
    {if $Artikel->getOption('nShowOnlyOnSEORequest', 0) === 1}
        <span class="price_label price_out_of_stock">{lang key='productOutOfStock' section='productDetails'}</span>
    {elseif $Artikel->Preise->fVKNetto == 0 && $Artikel->bHasKonfig}
        <span class="price_label price_as_configured">{lang key='priceAsConfigured' section='productDetails'}</span> <strong class="price"></strong>
    {elseif $Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
        <span class="price_label price_on_application small">{lang key="priceOnApplication" section="global"}</span>
    {else}
		<div class="price-row">
        {block name='price-label'}
            {if ($tplscope !== 'detail' && $Artikel->Preise->oPriceRange->isRange() && $Artikel->Preise->oPriceRange->rangeWidth() > $Einstellungen.artikeluebersicht.articleoverview_pricerange_width)
                || ($tplscope === 'detail' && ($Artikel->nVariationsAufpreisVorhanden == 1 || $Artikel->bHasKonfig) && $Artikel->kVaterArtikel == 0)}
                <span class="price_label pricestarting">{lang key='priceStarting'} </span>
			{elseif $Artikel->Preise->rabatt>0 &&  $snackyConfig.oldPricePlace !== '1'}
				<span class="price_label nowonly">{lang key='nowOnly'} </span>
			{/if}
		{/block}
		<strong class="price text-nowrap{if isset($Artikel->Preise->Sonderpreis_aktiv) && $Artikel->Preise->Sonderpreis_aktiv} special-price{/if}">
            {block name="snackys-del-price"}
                {if $Artikel->Preise->Sonderpreis_aktiv && $Einstellungen.artikeldetails.artikeldetails_sonderpreisanzeige == 2 && $snackyConfig.oldPricePlace == '1'}
                    <del class="old-price">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                {elseif !$Artikel->Preise->Sonderpreis_aktiv && $Artikel->Preise->rabatt > 0}
                    {if ($Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 3 || $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 4) && $snackyConfig.oldPricePlace == '1'}
                    <del class="old-price">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                    {/if}
                {/if}
            {/block}
			{block name='price-range'}
                <span{if $Artikel->Preise->oPriceRange->isRange() && $tplscope !== 'box'} itemprop="priceSpecification" itemscope itemtype="http://schema.org/UnitPriceSpecification"{/if} {if $tplscope === 'matrix'} class="no-wrap" {/if}>
                {if $tplscope !== 'detail' && $Artikel->Preise->oPriceRange->isRange()}
                    {if $Artikel->Preise->oPriceRange->rangeWidth() <= $Einstellungen.artikeluebersicht.articleoverview_pricerange_width}
                        {assign var=rangePrices value=$Artikel->Preise->oPriceRange->getLocalizedArray($NettoPreise)}
                        <span class="first-range-price">{$rangePrices[0]} - </span><span class="second-range-price">{$rangePrices[1]} {if $tplscope !== 'detail'} <span class="footnote-reference">*</span>{/if}</span>
                    {else}
                        {$Artikel->Preise->oPriceRange->getMinLocalized($NettoPreise)} <span class="footnote-reference">*</span>
                    {/if}
                {else}
                    {if $Artikel->Preise->oPriceRange->isRange() && ($Artikel->nVariationsAufpreisVorhanden == 1 || $Artikel->bHasKonfig) && $Artikel->kVaterArtikel == 0}{$Artikel->Preise->oPriceRange->getMinLocalized($NettoPreise)}{else}{$Artikel->Preise->cVKLocalized[$NettoPreise]}{/if}
                {/if}
                {if $Artikel->Preise->oPriceRange->isRange() && $tplscope !== 'box'}
                    <meta itemprop="priceCurrency" content="{$smarty.session.Waehrung->getName()}">
                    <meta itemprop="minPrice" content="{$Artikel->Preise->oPriceRange->minBruttoPrice}">
                    <meta itemprop="maxPrice" content="{$Artikel->Preise->oPriceRange->maxBruttoPrice}">
                {/if}
                {if $tplscope !== 'detail' && !$Artikel->Preise->oPriceRange->isRange()}<span class="footnote-reference">*</span>{/if}
                </span>
			{/block}
			{block name='price-snippets'}
				{if $tplscope !== 'box'}
					<meta itemprop="price" content="{if $Artikel->Preise->oPriceRange->isRange()}{$Artikel->Preise->oPriceRange->minBruttoPrice}{else}{$Artikel->Preise->fVKBrutto}{/if}">
					<meta itemprop="priceCurrency" content="{$smarty.session.Waehrung->getName()}">
					{if $Artikel->Preise->Sonderpreis_aktiv && $Artikel->dSonderpreisStart_en !== null && $Artikel->dSonderpreisEnde_en !== null}
						<meta itemprop="validFrom" content="{$Artikel->dSonderpreisStart_en}">
						<meta itemprop="validThrough" content="{$Artikel->dSonderpreisEnde_en}">
						<meta itemprop="priceValidUntil" content="{$Artikel->dSonderpreisEnde_en}">
					{/if}
				{/if}
			{/block}
		</strong>
		</div>
        {if $tplscope === 'detail'}
            <div class="price-note small">
                {if $Artikel->cEinheit && ($Artikel->fMindestbestellmenge > 1 || $Artikel->fAbnahmeintervall > 1)}
                    <span class="price_label per_unit"> {lang key="vpePer"} 1 {$Artikel->cEinheit}</span>
                {/if}
                
                {* Grundpreis *}
                {if !empty($Artikel->cLocalizedVPE)}
                    {block name='detail-base-price'}
                        <div class="base-price" itemprop="priceSpecification" itemscope itemtype="http://schema.org/UnitPriceSpecification">
                            <meta itemprop="price" content="{if $Artikel->Preise->oPriceRange->isRange()}{($Artikel->Preise->oPriceRange->minBruttoPrice/$Artikel->fVPEWert)|string_format:"%.2f"}{else}{($Artikel->Preise->fVKBrutto/$Artikel->fVPEWert)|string_format:"%.2f"}{/if}">
                            <meta itemprop="priceCurrency" content="{$smarty.session.Waehrung->getName()}">
                            <span class="value" itemprop="referenceQuantity" itemscope itemtype="http://schema.org/QuantitativeValue">
                                {$Artikel->cLocalizedVPE[$NettoPreise]}
                                <meta itemprop="value" content="{$Artikel->fGrundpreisMenge}">
                                <meta itemprop="unitText" content="{$Artikel->cVPEEinheit|regex_replace:"/[\d ]/":""}">
                            </span>
                        </div>
                    {/block}
                {/if}
                
                {block name="detail-vat-info"}
                    <span class="vat_info text-muted block">
                        {include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}
                    </span>
                {/block}
                
                {if $Artikel->Preise->Sonderpreis_aktiv && $Einstellungen.artikeldetails.artikeldetails_sonderpreisanzeige == 2 && $snackyConfig.oldPricePlace !== '1'}
                    <div class="instead_of old_price">{lang key="oldPrice" section="global"}:
                        <del class="value">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                    </div>
                {elseif !$Artikel->Preise->Sonderpreis_aktiv && $Artikel->Preise->rabatt > 0}
                    {if ($Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 3 || $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 4) && $snackyConfig.oldPricePlace !== '1'}
                        <div class="old_price">{lang key="oldPrice"}:
                            <del class="value text-nowrap">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                        </div>
                    {/if}
                    {if $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 2 || $Einstellungen.artikeldetails.artikeldetails_rabattanzeige == 4}
                        <div class="discount">{lang key="discount"}:
                            <span class="value text-nowrap">{$Artikel->Preise->rabatt}%</span>
                        </div>
                    {/if}
                {/if}

                {if $Einstellungen.artikeldetails.artikeldetails_uvp_anzeigen === 'Y' && $Artikel->fUVP > 0}
					{* if $snackyConfig.oldPricePlace !== '1' *}
						<div class="suggested-price">
							<abbr title="{lang key="suggestedPrice" section="productDetails"}">{lang key="suggestedPrice" section="productDetails"}</abbr>:
							<span class="value text-nowrap">{$Artikel->cUVPLocalized}</span>
						</div>
					{* /if *}
                    {* Preisersparnis zur UVP anzeigen? *}
                    {if isset($Artikel->SieSparenX) && $Artikel->SieSparenX->anzeigen == 1 && $Artikel->SieSparenX->nProzent > 0 && !$NettoPreise && $Artikel->taxData['tax'] > 0}
                        <div class="yousave">({lang key="youSave" section="productDetails"}
                            <span class="percent">{$Artikel->SieSparenX->nProzent}%</span>, {lang key="thatIs" section="productDetails"}
                            <span class="value text-nowrap">{$Artikel->SieSparenX->cLocalizedSparbetrag}</span>)
                        </div>
                    {/if}
                {/if}
            </div>{* /price-note *}
        {else}{* scope productlist *}
            <div class="price-note">
                {* Grundpreis *}
                {if !empty($Artikel->cLocalizedVPE) && !$Artikel->Preise->oPriceRange->isRange()}
                    {block name='productdetails-price-list-base-price'}
                        <div class="base_price" itemprop="priceSpecification" itemscope itemtype="http://schema.org/UnitPriceSpecification">
                            <meta itemprop="price" content="{($Artikel->Preise->fVKBrutto/$Artikel->fVPEWert)|string_format:"%.2f"}">
                            <meta itemprop="priceCurrency" content="{$smarty.session.Waehrung->getName()}">
                            <span class="value" itemprop="referenceQuantity" itemscope itemtype="http://schema.org/QuantitativeValue">
                                    {$Artikel->cLocalizedVPE[$NettoPreise]}
                                    <meta itemprop="value" content="{$Artikel->fGrundpreisMenge}">
                                    <meta itemprop="unitText" content="{$Artikel->cVPEEinheit|regex_replace:"/[\d ]/":""}">
                                </span>
                        </div>
                    {/block}
                {/if}
                
                {if $Artikel->Preise->Sonderpreis_aktiv && isset($Einstellungen.artikeluebersicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_sonderpreisanzeige == 2}
					{if $snackyConfig.oldPricePlace !== '1'}
                    <div class="instead-of old-price">
                        <small class="text-muted">
                            {lang key="oldPrice"}: 
                            <del class="value">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                        </small>
                    </div>
					{/if}
                {elseif !$Artikel->Preise->Sonderpreis_aktiv && $Artikel->Preise->rabatt > 0 && isset($Einstellungen.artikeluebersicht)}
                    {if ($Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 3 || $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 4) && $snackyConfig.oldPricePlace !== '1'}
                        <div class="old-price">
                            <small class="text-muted">
                                {lang key="oldPrice"}: 
                                <del class="value text-nowrap">{$Artikel->Preise->alterVKLocalized[$NettoPreise]}</del>
                            </small>
                        </div>
                    {/if}
                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 2 || isset($Einstellungen.artikeluebersicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_rabattanzeige == 4}
                        <div class="discount">
                            <small class="text-muted">
                                {lang key="discount"}: 
                                <span class="value text-nowrap">{$Artikel->Preise->rabatt}%</span>
                            </small>
                        </div>
                    {/if}
                {/if}
            </div>{* /price-note *}
        {/if}
    {/if}
    {/block}
    </div>{* /price_wrapper *}
{else}
    {block name="price-invisible"}
        <span class="price_label price_invisible">{lang key="priceHidden"}</span>
    {/block}
{/if}
{/block}