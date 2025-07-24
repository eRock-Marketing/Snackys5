{block name='basket-cart-dropdown-checkout'}
{assign var="step3_active" value=($bestellschritt[5] == 1)}
{if $step3_active}
{else}
<span class="text-center h3 block">{lang key="basket" section="global"}</span>

    {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}

    {if isset($zuletztInWarenkorbGelegterArtikel)}
        {assign var=pushedArtikel value=$zuletztInWarenkorbGelegterArtikel}
    {else}
        {assign var=pushedArtikel value=$Artikel}
    {/if}
        <div class="alert alert-success">{$pushedArtikel->cName} {lang key="productAddedToCart" section="global"}</div>
    {/if}
	
    {if $smarty.session.Warenkorb->PositionenArr|@count > 0}
			<form id="cart-form-xs" method="post" action="{get_static_route id='warenkorb.php'}">
			{$jtl_token}
			<input type="hidden" name="wka" value="1" />
            {foreach name="positionen" from=$smarty.session.Warenkorb->PositionenArr item=oPosition}
                {if !$oPosition->istKonfigKind()}
                    {if $oPosition->nPosTyp == C_WARENKORBPOS_TYP_ARTIKEL}
            			<div class="sc-item dropdown">
							<div class="dpflex-a-center">
                            {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                            <div class="cols-img">
								<span class="img-ct">
									{include file='snippets/image.tpl'
										fluid=false
										item=$oPosition->Artikel
										square=false
										srcSize='xs'
										sizes='45px'
										class='img-sm'}
								</span>
                            </div>
                            {/if}
                            <div class="cols-name{if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen != 'Y'} noimg{/if}">
                                {$oPosition->nAnzahl|replace_delim}{if $oPosition->Artikel->cEinheit} {$oPosition->Artikel->cEinheit}{else}&times;{/if}
                                <a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:"html"}">
                                    {$oPosition->cName|trans}
                                </a>
                            </div>
                            <div class="cols-price">
                                {if $oPosition->istKonfigVater()}
                                    <strong>{$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
                                {else}
                                    <strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
                                {/if}
                            </div>
							<button class="editpos" type="button" data-toggle="collapse" data-target="#edit_{$oPosition@iteration}">
								<span class="img-ct icon icon">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-info"></use>
                                    </svg>
								</span>
							</button>
							</div>
							<div class="edit-item" id="edit_{$oPosition@iteration}">
								<ul class="list-unstyled text-muted small blanklist m0 w100">
                                    <li class="sku"><strong>{lang key="productNo" section="global"}:</strong> {$oPosition->Artikel->cArtNr}</li>
                                    {if isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
                                        <li title="{lang key='productMHDTool' section='global'}" class="best-before">
                                            <strong>{lang key="productMHD" section="global"}:</strong> {$oPosition->Artikel->dMHD_de}
                                        </li>
                                    {/if}
                                    {if $oPosition->Artikel->cLocalizedVPE && $oPosition->Artikel->cVPE !== 'N'}
                                        <li class="baseprice"><strong>{lang key="basePrice" section="global"}:</strong> {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}</li>
                                    {/if}
                                    {if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
                                        {foreach name=variationen from=$oPosition->WarenkorbPosEigenschaftArr item=Variation}
                                            <li class="variation">
                                                <strong>{$Variation->cEigenschaftName|trans}:</strong> {$Variation->cEigenschaftWertName|trans}
                                            </li>
                                        {/foreach}
                                    {/if}
                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans}
                                        <li class="delivery-status"><strong>{lang key="deliveryStatus" section="global"}:</strong> {$oPosition->cLieferstatus|trans}</li>
                                    {/if}
                                    {if !empty($oPosition->cHinweis)}
                                        <li class="text-info notice">{$oPosition->cHinweis}</li>
                                    {/if}

                                    {* Buttonloesung eindeutige Merkmale *}
                                    {if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
                                         <li class="manufacturer">
                                            <strong>{lang key="manufacturer" section="productDetails"}:</strong>
                                            <span class="values">
                                               {$oPosition->Artikel->cHersteller}
                                            </span>
                                         </li>
                                    {/if}

                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr)}
                                        {foreach from=$oPosition->Artikel->oMerkmale_arr item="oMerkmale_arr"}
                                            <li class="characteristic">
                                                <strong>{$oMerkmale_arr->cName}</strong>:
                                                <span class="values">
                                                    {foreach name="merkmalwerte" from=$oMerkmale_arr->oMerkmalWert_arr item="oWert"}
                                                        {if !$smarty.foreach.merkmalwerte.first}, {/if}
                                                        {$oWert->cWert}
                                                    {/foreach}
                                                </span>
                                            </li>
                                        {/foreach}
                                    {/if}

                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute)}
                                        {foreach from=$oPosition->Artikel->Attribute item="oAttribute_arr"}
                                            <li class="attribute">
                                                <strong>{$oAttribute_arr->cName}</strong>:
                                                <span class="values">
                                                    {$oAttribute_arr->cWert}
                                                </span>
                                            </li>
                                        {/foreach}
                                    {/if}
                                    
                                    {if !isset($isCheckout)}
                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
                                        <li class="shortdesc hidden-xs hidden-sm hidden-md">{$oPosition->Artikel->cKurzBeschreibung}</li>
                                    {/if}
                                    {/if}

                                    {if $oPosition->istKonfigVater()}
										{if isset($oPosition->getTotalConfigWeight()) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->getTotalConfigWeight() > 0}
											<li class="weight">
												<strong>{lang key="shippingWeight" section="global"}: </strong>
												<span class="value">{$oPosition->getTotalConfigWeight()} {lang key="weightUnit" section="global"}</span>
											</li>
										{/if}
									{else}
										{if isset($oPosition->Artikel->cGewicht) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->Artikel->fGewicht > 0}
											<li class="weight">
												<strong>{lang key="shippingWeight" section="global"}: </strong>
												<span class="value">{$oPosition->Artikel->cGewicht} {lang key="weightUnit" section="global"}</span>
											</li>
										{/if}
                                    {/if}
                                </ul>
							</div>
						</div>
                    {else}
            			<div class="dpflex-a-center sc-item">
							<div class="cols-img">
								<span class="img-ct">
									{include file='snippets/image.tpl'
										fluid=false
										item=$oPosition->Artikel
										square=false
										srcSize='xs'
										sizes='45px'
										class='img-sm'}
								</span>
							</div>
                            <div class="cols-name" colspan="2">
                                {$oPosition->nAnzahl|replace_delim}&times;&nbsp;{$oPosition->cName|trans|escape:"htmlall"}
                            </div>
                            <div class="cols-price">
                                <strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
                            </div>
							<button class="editpos invisible">
								<span class="img-ct icon icon">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-info"></use>
                                    </svg>
								</span>
							</button>
                        </div>
                    {/if}
                {/if}
            {/foreach}
			</form>
			<div class="sc-sum">
				{if $NettoPreise}
					<div class="text-muted total total-net dpflex-j-between cols-sums">
						<div colspan="3">
                            {if empty($smarty.session.Versandart)}
                                {lang key='subtotal' section='account data'}
                            {else}
                                {lang key='totalSum'}
                            {/if} ({lang key='net' section='global'}):
						</div>
						<div class="text-nowrap text-right"><span>{$WarensummeLocalized[$NettoPreise]}</span></div>
					</div>
				{/if}
				{if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && isset($Steuerpositionen) && $Steuerpositionen|@count > 0}
					{foreach $Steuerpositionen as $Steuerposition}
						<div class="text-muted tax dpflex-j-between cols-sums">
							<div colspan="3">{$Steuerposition->cName}</div>
							<div class="text-nowrap text-right">{$Steuerposition->cPreisLocalized}</div>
						</div>
					{/foreach}
				{/if}
				<div class="total dpflex-j-between sum-tt cols-sums">
					<div colspan="3">
                        {if empty($smarty.session.Versandart)}
                            {lang key='subtotal' section='account data'}
                        {else}
                            {lang key='totalSum'}
                        {/if}:
					</div>
					<div class="text-nowrap text-right total"><strong>{$WarensummeLocalized[0]}</strong></div>
				</div>
                {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                {if isset($FavourableShipping)}
                    {if $NettoPreise}
                        {$shippingCosts = "`$FavourableShipping->cPriceLocalized[$NettoPreise]` {lang key='plus' section='basket'} {lang key='vat' section='productDetails'}"}
                    {else}
                        {$shippingCosts = $FavourableShipping->cPriceLocalized[$NettoPreise]}
                    {/if}
						<div class="card mt-xxs mb-xxs text-muted shipping-costs dpflex-j-between cols-sums">
							<div class="panel small">
								{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL():$shippingCosts:$FavourableShipping->country->getName() key='shippingInformationSpecific' section='basket'}
							</div>
						</div>
                    <tr class="">
                        <td colspan="4"><small></small></td>
                    </tr>
                {elseif empty($FavourableShipping) && empty($smarty.session.Versandart)}
						<div class="card mt-xxs mb-xxs text-muted shipping-costs dpflex-j-between cols-sums">
							<div class="panel small">
								{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() key='shippingInformation' section='basket'}
							</div>
						</div>
				{/if}
				{/if}
			</div>
    {else}
        <a href="{get_static_route id='warenkorb.php'}" title="{lang section='checkout' key='emptybasket'}">{lang section='checkout' key='emptybasket'}</a>
    {/if}
    {/if}
{/block}