{block name='checkout-inc-order-items'}
	{block name='order-items-presets'}
		<input type="submit" name="fake" class="hidden">
		{if !isset($tplscope)}
			{assign var=tplscope value=""}
		{/if}
	{/block}
	{block name='order-items-checkout-headline'}
		{if $tplscope !== 'cart'}
			<span class="text-center h2 block">{lang key="basket" section="global"}</span>
			{if JTL\Session\Frontend::getCart()->PositionenArr|count > 0}
			{else}
				<div class="alert alert-info">{lang key="emptybasket" section="checkout"}</div>
			{/if}
		{/if}
	{/block}
	{block name='order-items-notices'}
		{if !empty($hinweis)}
    		{if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
				{if isset($zuletztInWarenkorbGelegterArtikel)}
        			{assign var=pushedArtikel value=$zuletztInWarenkorbGelegterArtikel}
    			{else}
        			{assign var=pushedArtikel value=$Artikel}
    			{/if}
        		<div class="alert alert-success">{$pushedArtikel->cName} {lang key="productAddedToCart" section="global"}</div>
    		{/if}
		{/if}
	{/block}
	{block name='order-items'} 
		{foreach JTL\Session\Frontend::getCart()->PositionenArr as $oPosition name=positionen}
			{if ($oPosition->nPosTyp == '3' || $oPosition->nPosTyp == '2') && $tplscope == 'cart'}
				{continue}
			{/if}
			{block name='order-items-item'}
    			{if !$oPosition->istKonfigKind()}
        			<div class="type-{$oPosition->nPosTyp} c-it{if isset($isSidebar)} sb-it{/if}{if isset($isCheckout)} sb-it{/if}">
            			<div class="row">
							{block name='order-items-image'}
                				{if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                    				<div class="img-col col-3 col-sm-2 col-md-2">
                        				{if !empty($oPosition->Artikel->cVorschaubildURL)}
                        					<a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}" class="img-ct w100">
												{if isset($nSeitenTyp) && $nSeitenTyp == 37}
													{include file='snippets/image.tpl'
														fluid=false
														item=$oPosition->Artikel
														square=false
														lazy=false
														class='img-responsive-width'}
												{else}
													{include file='snippets/image.tpl'
														fluid=false
														item=$oPosition->Artikel
														square=false
														class='img-responsive-width'}
												{/if}
                        					</a>
										{/if}
                    				</div>
								{/if}
							{/block}
							{block name='order-items-item-details'}
                				<div class="inf-col{if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'} col-9 col-sm-10 col-md-10{else} col-12{/if}">
                    				<div class="row first">
										{block name='order-items-item-infos'}
                        					<div class="col-8 col-md-8 col-lg-9">
                             					{if $oPosition->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL || $oPosition->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
													{block name='order-items-item-name'}
                                						<a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}" class="block">
															<strong class="title">{$oPosition->cName|trans}</strong>
														</a>
													{/block}
													{block name='order-items-item-infos-list'}
                                						{if !isset($isSidebar)}
                                							<ul class="list-unstyled text-muted small info-ul blanklist">
																{block name='order-items-item-infos-sku'}
                                    								<li class="sku">
																		<strong>{lang key="productNo" section="global"}:</strong> {$oPosition->Artikel->cArtNr}
																	</li>
																{/block}
																{block name='order-items-item-infos-mhd'}
																	{if isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
																		<li title="{lang key='productMHDTool' section='global'}" class="best-before">
																			<strong>{lang key="productMHD" section="global"}:</strong> {$oPosition->Artikel->dMHD_de}
																		</li>
																	{/if}
																{/block}
																{block name='order-items-item-infos-baseprice'}
																	{if $oPosition->Artikel->cLocalizedVPE && $oPosition->Artikel->cVPE !== 'N' && $oPosition->nPosTyp !== $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
																		<li class="baseprice">
																			<strong>{lang key="basePrice" section="global"}:</strong> {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}
																		</li>
																	{/if}
																{/block}
																{block name='order-items-item-infos-variations'}
																	{if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
																		{foreach name=variationen from=$oPosition->WarenkorbPosEigenschaftArr item=Variation}
																			<li class="variation">
																				<strong>{$Variation->cEigenschaftName|trans}:</strong> {$Variation->cEigenschaftWertName|trans}
																			</li>
																		{/foreach}
																	{/if}
																{/block}
																{block name='order-items-item-infos-delivery'}
																	{if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans}
																		<li class="delivery-status">
																			<strong>{lang key="deliveryStatus" section="global"}:</strong> {$oPosition->cLieferstatus|trans}
																		</li>
																	{/if}
																{/block}
																{block name='order-items-item-infos-notices'}
																	{if !empty($oPosition->cHinweis)}
																		<li class="text-info notice">{$oPosition->cHinweis}</li>
																	{/if}
																{/block}
																{block name='order-items-item-infos-manufacturer'}
																	{if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
																		 <li class="manufacturer">
																			<strong>{lang key="manufacturer" section="productDetails"}</strong>:
																			<span class="values">
																			   {$oPosition->Artikel->cHersteller}
																			</span>
																		 </li>
																	{/if}
																{/block}
																{block name='order-items-item-infos-characteristics'}
																	{if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr)}
																		{foreach $oPosition->Artikel->oMerkmale_arr as $characteristic}
																			<li class="characteristic">
																				<strong>{$characteristic->getName()}</strong>:
																				<span class="values">
																					{foreach $characteristic->getCharacteristicValues() as $characteristicValue}
																						{if !$characteristicValue@first}, {/if}
																						{$characteristicValue->getValue()}
																					{/foreach}
																				</span>
																			</li>
																		{/foreach}
																	{/if}
																{/block}
																{block name='order-items-item-infos-attributes'}
																	{if $Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute)}
																		{foreach $oPosition->Artikel->Attribute as $oAttribute_arr}
																			<li class="attribute">
																				<strong>{$oAttribute_arr->cName}</strong>:
																				<span class="values">
																					{$oAttribute_arr->cWert}
																				</span>
																			</li>
																		{/foreach}
																	{/if}
																{/block}
																{block name='order-items-item-infos-weight'}
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
																{block name='order-items-item-infos-shortdesc'}                                    
																	{if !isset($isCheckout)}
																		{if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
																			<li class="shortdescription hidden-xs hidden-sm hidden-md w100">{$oPosition->Artikel->cKurzBeschreibung|strip_tags}</li>
																		{/if}
																	{/if}
																{/block}
															</ul>
                                						{/if}
													{/block}
                            					{else}
													{block name='order-items-item-name-specialpos'}
                                						<strong>{$oPosition->cName|trans}{if isset($oPosition->discountForArticle)}{$oPosition->discountForArticle|trans}{/if}</strong>
													{/block}
													{block name='order-items-item-affix-specialpos'}
														{if isset($oPosition->cArticleNameAffix)}
															{if is_array($oPosition->cArticleNameAffix)}
																<ul class="small text-muted blanklist">
																	{foreach $oPosition->cArticleNameAffix as $cArticleNameAffix}
																		<li>{$cArticleNameAffix|trans}</li>
																	{/foreach}
																</ul>
															{else}
																<ul class="small text-muted blanklist">
																	<li>{$oPosition->cArticleNameAffix|trans}</li>
																</ul>
															{/if}
														{/if}
													{/block}
													{block name='order-items-item-notice-specialpos'}
														{if !empty($oPosition->cHinweis)}
															<small class="text-info notice">{$oPosition->cHinweis}</small>
														{/if}
													{/block}
                            					{/if}
												{block name='order-items-item-config'}
													{if $oPosition->istKonfigVater() && !isset($isSidebar)}
														{block name='order-items-item-config-items'}
															<ul class="config-items text-muted small blanklist">
																{foreach JTL\Session\Frontend::getCart()->PositionenArr as $KonfigPos}
																	{if $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
																		&& !$KonfigPos->isIgnoreMultiplier()}
																		<li>
																			<span class="qty">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
																			{$KonfigPos->cName|trans} &raquo;
																			<span class="price_value">
																				{$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
																				{lang key="pricePerUnit" section="checkout"}
																			</span>
																		</li>
																	{/if}
																{/foreach}
															</ul>
														{/block}
														{block name='order-items-item-config-unique'}
															<ul class="config-items text-muted small blanklist">
																<strong>{lang key="one-off" section="checkout"}</strong>
																{foreach JTL\Session\Frontend::getCart()->PositionenArr as $KonfigPos}
																	{if $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
																		&& $KonfigPos->isIgnoreMultiplier()}
																		<li>
																			<span class="qty">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
																			{$KonfigPos->cName|trans} &raquo;
																			<span class="price_value">
																				{$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
																				{lang key="pricePerUnit" section="checkout"}
																			</span>
																		</li>
																	{/if}
																{/foreach}
															</ul>
														{/block}
													{/if}
												{/block}
												{block name='order-items-item-partlist'}
													{if $Einstellungen.kaufabwicklung.bestellvorgang_partlist === 'Y' && !empty($oPosition->Artikel->kStueckliste) && !empty($oPosition->Artikel->oStueckliste_arr)}
														<ul class="partlist-items text-muted small blanklist">
															{foreach $oPosition->Artikel->oStueckliste_arr as $partListItem}
																<li>
																	<span class="qty">{$partListItem->fAnzahl_stueckliste}x</span>
																	{$partListItem->cName|trans}
																</li>
															{/foreach}
														</ul>
													{/if}
												{/block}
                        					</div>
										{/block}
										{block name='order-items-item-price-quantity'}
                        					<div class="col-4 col-md-4 col-lg-3 text-right">
												{block name='order-items-item-price'}
                            						<div class="price-block mt-xs mb-xs">
														{block name='order-items-item-price-singleprice'}
															{if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
																{if $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL && (!$oPosition->istKonfigVater() || !isset($oPosition->oKonfig_arr) || $oPosition->oKonfig_arr|count === 0)}
																	<span class="single-price small block nowrap">
																		{lang key="pricePerUnit" section="checkout"}: {$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}{if $tplscope != 'confirmation'} <span class="footnote-reference">*</span>{/if}
																	</span>
																{/if}
															{/if}
														{/block}
														{block name='order-items-item-price-price'}
															<strong class="price block nowrap">
																{if $oPosition->istKonfigVater()}
																	{$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}{if $tplscope != 'confirmation'} <span class="footnote-reference">*</span>{/if}
																{else}
																	{$oPosition->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}{if $tplscope != 'confirmation'} <span class="footnote-reference">*</span>{/if}
																{/if}
															</strong>
														{/block}
													  </div>
												{/block}
												{block name='order-items-item-quantity'}
											  		{if $tplscope === 'cart'}
														{block name='order-items-item-quantity-changeable'}
															{if $oPosition->nPosTyp == 1}
																{if $oPosition->istKonfigVater()}
																	{block name='order-items-item-quantity-confi'}
																		<div class="qty-wrapper modify">
																			<input name="anzahl[{$smarty.foreach.positionen.index}]" type="hidden" class="form-control" value="{$oPosition->nAnzahl}" />
																			<div id="cartitem-dropdown-menu{$smarty.foreach.positionen.index}" class="">
																				<div class="panel-body text-center">
																					<div class="form-inline flx-je flx-ac">
																						<span class="btn-group">
																							<input name="anzahl[{$smarty.foreach.positionen.index}]" id="quantity{$smarty.foreach.positionen.index}" class="form-control quantity small form-control text-right" size="3" value="{$oPosition->nAnzahl}" readonly />
																							<a class="btn btn-default btn-sm configurepos" href="{get_static_route id='index.php'}?a={$oPosition->kArtikel}&ek={$oPosition@index}">
																								<span class="img-ct icon">
																									<svg>
																										<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
																									</svg>
																								</span>
																							</a>
																						</span>
																					</div>
																				</div>
																			</div>
																		</div>
																	{/block}
																{else}
																	{block name='order-items-item-quantity-product'}
                                            							<div class="qty-wrapper modify">                    
                                                							<div id="cartitem-dropdown-menu{$smarty.foreach.positionen.index}" class="">
                                                    							<div class="panel-body text-center">
                                                        							<div class="form-inline flx-je">
                                                            							<div id="quantity-grp{$smarty.foreach.positionen.index}" class="choose_quantity input-group">
																							<input name="anzahl[{$smarty.foreach.positionen.index}]" id="quantity{$smarty.foreach.positionen.index}" 
																							class="form-control quantity small form-control text-right" 
																							size="3"
																							min="{if $oPosition->Artikel->fMindestbestellmenge}{$oPosition->Artikel->fMindestbestellmenge}{else}0{/if}"
																							max="{$oPosition->Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''}"
																							{if $oPosition->Artikel->fAbnahmeintervall > 0}
																								step="{$oPosition->Artikel->fAbnahmeintervall}"
																							{/if}
																							value="{$oPosition->nAnzahl}"
																							/>
                                                                							<span class="input-group-btn">
                                                                    							<button type="submit" class="btn btn-default btn-sm pr" title="{lang key='refresh' section='checkout'}">
                                                                        							<span class="img-ct icon">
																										<svg>
																			  								<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-refresh"></use>
																										</svg>
                                                                        							</span>
                                                                    							</button>
                                                                							</span>
                                                            							</div>
                                                        							</div>
                                                    							</div>
                                                							</div>
                                            							</div>
																	{/block}
                                        						{/if}
															{elseif $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
																{block name='order-items-item-quantity-gift'}
                                    								<input name="anzahl[{$smarty.foreach.positionen.index}]" type="hidden" value="1" />
																{/block}
															{/if}
														{/block}
													{else}
														{block name='order-items-item-quantity-not-changeable'}
															{if $oPosition->nPosTyp != '3' && $oPosition->nPosTyp != '2'}
																<span class="qty">
																	<span class="badge">{$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}</span>
																</span>
															{/if}
														{/block}
                            						{/if}  
												{/block}
												{block name='order-items-item-delete'}
                            						{if $tplscope === 'cart' && $oPosition->nPosTyp == 1}
                                						<button type="submit" class="droppos text-muted pr flx-ac btn-flex" name="dropPos" value="{$smarty.foreach.positionen.index}" title="{lang key="delete" section="global"}">
                                    						<span class="img-ct icon">
                                        						<svg>
                                          							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
                                        						</svg>
                                    						</span>
                                						</button>
                            						{/if}
												{/block}
                        					</div>
										{/block}
									</div>
                				</div>
							{/block}
						</div>
					</div>
				{/if}
			{/block}
		{/foreach}
	{/block}
{/block}