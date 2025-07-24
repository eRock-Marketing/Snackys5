{block name='basket-cart-dropdown-checkout'}
	{assign var="step3_active" value=($bestellschritt[5] == 1)}
	{if $step3_active}
	{else}
		{block name='checkout-cart-headline'}
			<span class="text-center h3 block">{lang key="basket" section="global"}</span>
		{/block}
		{if $smarty.session.Warenkorb->PositionenArr|@count > 0}
			{block name='checkout-cart-items'}
				<form id="cart-form-xs" method="post" action="{get_static_route id='warenkorb.php'}">
					{$jtl_token}
					<input type="hidden" name="wka" value="1" />
					{foreach name="positionen" from=$smarty.session.Warenkorb->PositionenArr item=oPosition}
						{block name='checkout-cart-item'}
							{if !$oPosition->istKonfigKind()}
								{if $oPosition->nPosTyp == C_WARENKORBPOS_TYP_ARTIKEL}
									{block name='checkout-cart-item-article'}
										<div class="sc-item dropdown">
											{block name='checkout-cart-item-article-content'}
												<div class="flx-ac">
													{block name='checkout-cart-item-article-image'}
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
													{/block}
													{block name='checkout-cart-item-article-name'}
														<div class="cols-name{if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen != 'Y'} noimg{/if}">
															{$oPosition->nAnzahl|replace_delim}{if $oPosition->Artikel->cEinheit} {$oPosition->Artikel->cEinheit}{else}&times;{/if}
															<a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:"html"}">
																{$oPosition->cName|trans}
															</a>
														</div>
													{/block}
													{block name='checkout-cart-item-article-price'}
														<div class="cols-price">
															{if $oPosition->istKonfigVater()}
																<strong>{$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
															{else}
																<strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
															{/if}
														</div>
													{/block}
													{block name='checkout-cart-item-article-infobutton'}
														<button class="editpos" type="button" data-toggle="collapse" data-target="#edit_{$oPosition@iteration}">
															<span class="img-ct icon icon">
																<svg>
																  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-info"></use>
																</svg>
															</span>
														</button>
													{/block}
												</div>
											{/block}
											{block name='checkout-cart-item-article-infos'}
												<div class="edit-item" id="edit_{$oPosition@iteration}">
													<ul class="list-unstyled text-muted small blanklist m0 w100">
														{block name='checkout-cart-item-article-artnr'}
															<li class="sku"><strong>{lang key="productNo" section="global"}:</strong> {$oPosition->Artikel->cArtNr}</li>
														{/block}
														{block name='checkout-cart-item-article-mhd'}
															{if isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
																<li title="{lang key='productMHDTool' section='global'}" class="best-before">
																	<strong>{lang key="productMHD" section="global"}:</strong> {$oPosition->Artikel->dMHD_de}
																</li>
															{/if}
														{/block}
														{block name='checkout-cart-item-article-baseprice'}
															{if $oPosition->Artikel->cLocalizedVPE && $oPosition->Artikel->cVPE !== 'N'}
																<li class="baseprice">
																	<strong>{lang key="basePrice" section="global"}:</strong> {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}
																</li>
															{/if}
														{/block}
														{block name='checkout-cart-item-article-variations'}
															{if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
																{foreach name=variationen from=$oPosition->WarenkorbPosEigenschaftArr item=Variation}
																	<li class="variation">
																		<strong>{$Variation->cEigenschaftName|trans}:</strong> {$Variation->cEigenschaftWertName|trans}
																	</li>
																{/foreach}
															{/if}
														{/block}
														{block name='checkout-cart-item-article-delivery'}
															{if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans}
																<li class="delivery-status">
																	<strong>{lang key="deliveryStatus" section="global"}:</strong> {$oPosition->cLieferstatus|trans}
																</li>
															{/if}
														{/block}
														{block name='checkout-cart-item-article-notice'}
															{if !empty($oPosition->cHinweis)}
																<li class="text-info notice">{$oPosition->cHinweis}</li>
															{/if}
														{/block}
														{block name='checkout-cart-item-article-manufacturer'}
															{if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
																 <li class="manufacturer">
																	<strong>{lang key="manufacturer" section="productDetails"}:</strong>
																	<span class="values">
																	   {$oPosition->Artikel->cHersteller}
																	</span>
																 </li>
															{/if}
														{/block}
														{block name='checkout-cart-item-article-characteristic'}
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
														{/block}
														{block name='checkout-cart-item-article-attributes'}
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
														{/block}
														{block name='checkout-cart-item-article-shortdesc'}                                    
															{if !isset($isCheckout)}
																{if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
																	<li class="shortdesc hidden-xs hidden-sm hidden-md">{$oPosition->Artikel->cKurzBeschreibung}</li>
																{/if}
															{/if}
														{/block}
														{block name='checkout-cart-item-article-weight'}
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
														{/block}
													</ul>
												</div>
											{/block}
										</div>
									{/block}
								{else}
									{block name='checkout-cart-item-other'}
										<div class="flx-ac sc-item">
											{block name='checkout-cart-item-other-image'}
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
											{/block}
											{block name='checkout-cart-item-other-name'}
												<div class="cols-name" colspan="2">
													{$oPosition->nAnzahl|replace_delim}&times;&nbsp;{$oPosition->cName|trans|escape:"htmlall"}
												</div>
											{/block}
											{block name='checkout-cart-item-other-price'}
												<div class="cols-price">
													<strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
												</div>
											{/block}
											{block name='checkout-cart-item-other-placeholder'}
												<button class="editpos invisible">
													<span class="img-ct icon icon">
														<svg>
														  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-info"></use>
														</svg>
													</span>
												</button>
											{/block}
										</div>
									{/block}
								{/if}
							{/if}
						{/block}
					{/foreach}
				</form>
			{/block}
			{block name='checkout-cart-sum'}
				<div class="sc-sum">
					{block name='checkout-cart-sum-netto'}
						{if $NettoPreise}
							<div class="text-muted total total-net flx-jb cols-sums">
								<div colspan="3">
                            		{if empty($smarty.session.Versandart)}
                                		{lang key='subtotal' section='account data'}
                            		{else}
                                		{lang key='totalSum'}
                            		{/if} ({lang key='net' section='global'}):
								</div>
								<div class="text-nowrap text-right">
									<span>{$WarensummeLocalized[$NettoPreise]}</span>
								</div>
							</div>
						{/if}
					{/block}
					{block name='checkout-cart-sum-steuerpos'}
						{if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && isset($Steuerpositionen) && $Steuerpositionen|@count > 0}
							{foreach $Steuerpositionen as $Steuerposition}
								<div class="text-muted tax flx-jb cols-sums">
									<div colspan="3">{$Steuerposition->cName}</div>
									<div class="text-nowrap text-right">{$Steuerposition->cPreisLocalized}</div>
								</div>
							{/foreach}
						{/if}
					{/block}
					{block name='checkout-cart-sum-total'}
						<div class="total flx-jb sum-tt cols-sums">
							<div colspan="3">
                        		{if empty($smarty.session.Versandart)}
                            		{lang key='subtotal' section='account data'}
                        		{else}
                            		{lang key='totalSum'}
                        		{/if}:
							</div>
							<div class="text-nowrap text-right total">
								<strong>{$WarensummeLocalized[0]}</strong>
							</div>
						</div>
					{/block}
					{block name='checkout-cart-sum-shipping'}
                		{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                			{if isset($FavourableShipping)}
                    			{if $NettoPreise}
                        			{$shippingCosts = "`$FavourableShipping->cPriceLocalized[$NettoPreise]` {lang key='plus' section='basket'} {lang key='vat' section='productDetails'}"}
                    			{else}
                        			{$shippingCosts = $FavourableShipping->cPriceLocalized[$NettoPreise]}
                    			{/if}
								<div class="card mt-xxs mb-xxs text-muted shipping-costs flx-jb cols-sums">
									<div class="panel small">
										{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL():$shippingCosts:$FavourableShipping->country->getName() key='shippingInformationSpecific' section='basket'}
									</div>
								</div>
								<tr class="">
									<td colspan="4"><small></small></td>
								</tr>
                			{elseif empty($FavourableShipping) && empty($smarty.session.Versandart)}
								<div class="card mt-xxs mb-xxs text-muted shipping-costs flx-jb cols-sums">
									<div class="panel small">
										{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() key='shippingInformation' section='basket'}
									</div>
								</div>
							{/if}
						{/if}
					{/block}
				</div>
			{/block}
    	{else}
			{block name='checkout-cart-empty'}
        		<a href="{get_static_route id='warenkorb.php'}" title="{lang section='checkout' key='emptybasket'}">{lang section='checkout' key='emptybasket'}</a>
			{/block}
    	{/if}
    {/if}
{/block}