{block name='snackys-basket'}
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
        {block name='oder-items-tablehead'}
            <div class="row bskt flx-nw{if $tplscope != 'cart'} bs-chc{/if}">
                <div class="col-prd">{lang key='product'}</div>
                <div class="col-qnt col-nbr">{lang key='quantity'}</div>
				{if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                	<div class="col-prc prc-sgl col-nbr">{lang key='pricePerUnit' section='checkout'}</div>
				{/if}
                <div class="col-prc col-nbr">{lang key='price'}</div>
				{if $tplscope === 'cart'}
                	<div class="col-del"></div>
				{/if}
            </div>
        {/block}
		{block name='oder-items-foreach'}
			{foreach JTL\Session\Frontend::getCart()->PositionenArr as $oPosition name=positionen}
				{if ($oPosition->nPosTyp == '3' || $oPosition->nPosTyp == '2') && $tplscope == 'cart'}
					{continue}
				{/if}
				{if !$oPosition->istKonfigKind()}
					{block name='oder-items-item'}
						<div class="row bskt flx-nw itms flx-ac{if $tplscope != 'cart'} bs-chc{/if} tp-{$oPosition->nPosTyp}">
							{block name='oder-items-product'}
								<div class="col-prd flx-ac">
									{block name='oder-items-product-image'}
										{if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
											{if !empty($oPosition->Artikel->cVorschaubildURL)}
												<a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|transByISO|escape:'html'}">
													<span class="img-ct">
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
													</span>
												</a>
											{else}
												<span class="spacer"></span>
											{/if}
										{/if}
									{/block}
									{block name='oder-items-product-data'}
										<div class="prd">
											{if $oPosition->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL || $oPosition->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
												{block name='oder-items-product-data-name'}
													<a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|transByISO|escape:'html'}" class="prd-itm">{$oPosition->cName|transByISO}</a>
												{/block}
												{block name='oder-items-product-data-list'}
													{assign "hasmore" 0}
													{if ($Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr))
														|| ($Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|transByISO)
														|| !empty($oPosition->cHinweis)
														|| ($oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N")
														|| ($Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr))
														|| ($Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute))
														|| (isset($oPosition->getTotalConfigWeight()) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->getTotalConfigWeight() > 0)
														|| (isset($oPosition->Artikel->cGewicht) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->Artikel->fGewicht > 0)
														|| ($Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0)
													}
														{assign "hasmore" 1}
													{/if}
													<ul class="blanklist small">
														{block name='order-items-item-infos-sku'}
															<li class="sku">
																{lang key="productNo" section="global"}: {$oPosition->Artikel->cArtNr}
															</li>
														{/block}
														{block name='order-items-item-infos-mhd'}
															{if $Einstellungen.artikeldetails.show_shelf_life_expiration_date === 'Y' && isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
																<li title="{lang key='productMHDTool' section='global'}" class="best-before">
																	{lang key="productMHD" section="global"}: {$oPosition->Artikel->dMHD_de}
																</li>
															{/if}
														{/block}
														{block name='order-items-item-infos-baseprice'}
															{if $oPosition->Artikel->cLocalizedVPE && $oPosition->Artikel->cVPE !== 'N' && $oPosition->nPosTyp !== $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
																<li class="baseprice">
																	{lang key="basePrice" section="global"}: {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}
																</li>
															{/if}
														{/block}
													</ul>
													{if $hasmore == 1}
														<a class="defaultlink small" data-toggle="collapse" href="#moreinfo{$smarty.foreach.positionen.index}" role="button" aria-expanded="false" aria-controls="#moreinfo{$smarty.foreach.positionen.index}">
															{lang key='showMore'} 
														</a>
													{/if}
													{if $oPosition->istKonfigVater()}
														<a href="#" class="defaultlink small" data-toggle="modal" data-target="#konfi{$smarty.foreach.positionen.index}">
															{lang key='listOfItems'} 
														</a>
														<div class="modal modal-dialog konf-mod" tabindex="-1" id="konfi{$smarty.foreach.positionen.index}">
															<div class="modal-content">
																<div class="modal-header">
																	<span class="modal-title block h5">
																		{$oPosition->cName|transByISO}
																	</span>
																	<button type="button" class="close-btn" data-dismiss="modal" aria-label="Close">
																	</button>
																</div>
																<div class="modal-body small">
																	{block name='order-items-item-config-items'}
																		{$labeled=false}
																		{foreach JTL\Session\Frontend::getCart()->PositionenArr as $KonfigPos}
																			{block name='product-config-item'}
																				{if $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
																				&& !$KonfigPos->isIgnoreMultiplier()}
																					<div class="cnf-it flx-ac bskt itms">
																						<span class="img-ct">
																							{if isset($nSeitenTyp) && $nSeitenTyp == 37}
																								{include file='snippets/image.tpl'
																									fluid=false
																									item=$KonfigPos->Artikel
																									square=false
																									lazy=false
																									class='img-responsive-width'}
																							{else}
																								{include file='snippets/image.tpl'
																									fluid=false
																									item=$KonfigPos->Artikel
																									square=false
																									class='img-responsive-width'}
																							{/if}
																						</span>
																						<span class="prd">
																							<span class="qty">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}&times;</span>
																						 	{$KonfigPos->cName|transByISO}
																						</span>
																						<span class="prcv">
																							{$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
																							<small>{lang key='pricePerUnit' section='checkout'}</small>
																						</span>
																					</div>
																				{elseif $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
																				&& $KonfigPos->isIgnoreMultiplier()}
																					{if !$labeled}
																						<div class="cnf-it flx-ac bskt itms">
																							<strong>{lang key='one-off' section='checkout'}</strong>
																							{$labeled=true}
																						</div>
																					{/if}																					
																					<div class="cnf-it flx-ac bskt itms">
																						<span class="img-ct">
																							{if isset($nSeitenTyp) && $nSeitenTyp == 37}
																								{include file='snippets/image.tpl'
																									fluid=false
																									item=$KonfigPos->Artikel
																									square=false
																									lazy=false
																									class='img-responsive-width'}
																							{else}
																								{include file='snippets/image.tpl'
																									fluid=false
																									item=$KonfigPos->Artikel
																									square=false
																									class='img-responsive-width'}
																							{/if}
																						</span>		
																						<span class="prd">																				
																							<span class="qty">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}&times;</span>
																							{$KonfigPos->cName|transByISO}
																						 </span>
																						<span class="prcv">
																							{$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
																							<small>{lang key='pricePerUnit' section='checkout'}</small>
																						</span>
																					</div>
																				{/if}
																			{/block}
																		{/foreach}
																	{/block}
																</div>
															</div>
														</div>
													{/if}
													{block name='order-items-item-partlist'}
														{if $Einstellungen.kaufabwicklung.bestellvorgang_partlist === 'Y' && !empty($oPosition->Artikel->kStueckliste) && !empty($oPosition->Artikel->oStueckliste_arr)}
															<a href="#" class="defaultlink small" data-toggle="modal" data-target="#bundle{$smarty.foreach.positionen.index}">
																{lang key='listOfItems'} 
															</a>
															<div class="modal modal-dialog konf-mod" tabindex="-1" id="bundle{$smarty.foreach.positionen.index}">
																<div class="modal-content">
																	<div class="modal-header">
																		<span class="modal-title block h5">
																			{$oPosition->cName|transByISO}
																		</span>
																		<button type="button" class="close-btn" data-dismiss="modal" aria-label="Close">
																		</button>
																	</div>
																	<div class="modal-body small">
																		{foreach $oPosition->Artikel->oStueckliste_arr as $partListItem}																					
																			<div class="cnf-it flx-ac bskt itms">
																				<span class="img-ct">
																					{if isset($nSeitenTyp) && $nSeitenTyp == 37}
																						{include file='snippets/image.tpl'
																							fluid=false
																							item=$partListItem
																							square=false
																							lazy=false
																							class='img-responsive-width'}
																					{else}
																						{include file='snippets/image.tpl'
																							fluid=false
																							item=$partListItem
																							square=false
																							class='img-responsive-width'}
																					{/if}
																				</span>	
																				<span class="prd">																				
																					<span class="qty">{$partListItem->fAnzahl_stueckliste}&times;</span>
																					{$partListItem->cName|transByISO}
																				 </span>
																			</div>
																		{/foreach}
																	</div>
																</div>
															</div>
														{/if}
													{/block}
												{/block}
											{else}
												<span class="prd-itm">{$oPosition->cName|transByISO}{if isset($oPosition->discountForArticle)}{$oPosition->discountForArticle|transByISO}{/if}</span>
												{block name='order-items-item-affix-specialpos'}
													{if isset($oPosition->cArticleNameAffix)}
														{if is_array($oPosition->cArticleNameAffix)}
															<ul class="blanklist small">
																{foreach $oPosition->cArticleNameAffix as $cArticleNameAffix}
																	<li>{$cArticleNameAffix|transByISO}</li>
																{/foreach}
															</ul>
														{else}
															<ul class="blanklist small">
																<li>{$oPosition->cArticleNameAffix|transByISO}</li>
															</ul>
														{/if}
													{/if}
												{/block}
												{block name='order-items-item-notice-specialpos'}
													{if !empty($oPosition->cHinweis)}
														<small class="block text-muted">{$oPosition->cHinweis}</small>
													{/if}
												{/block}
											{/if}
										</div>
									{/block}
								</div>
							{/block}
							{block name='oder-items-quantity'}
								<div class="col-qnt col-nbr">
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
																			<span class="btn-group input-group">
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
																			<div id="quantity-grp{$smarty.foreach.positionen.index}" class="choose_quantity input-group w100">
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
												{if $oPosition->nPosTyp != '3' && $oPosition->nPosTyp != '2' && $oPosition->nPosTyp != '5'}
													<span class="qty">
														<span class="hidden">{lang key='quantity'}:</span> {$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}
													</span>
												{/if}
											{/block}
										{/if}  
									{/block}
								</div>
							{/block}
							{block name='oder-items-price-single'}
								{if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
									<div class="col-prc prc-sgl col-nbr">
										{if $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL && (!$oPosition->istKonfigVater() || !isset($oPosition->oKonfig_arr) || $oPosition->oKonfig_arr|count === 0)}
											{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
										{/if}
									</div>
								{/if}
							{/block}
							{block name='oder-items-price'}
								<div class="col-prc col-nbr">
									{if $oPosition->istKonfigVater()}
										{$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
									{else}
										{$oPosition->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
									{/if}
								</div>
							{/block}
							{block name='oder-items-delete'}
								{if $tplscope === 'cart'}
									<div class="col-del">
										{if $tplscope === 'cart' && $oPosition->nPosTyp == 1}
											<button type="submit" name="dropPos" value="{$smarty.foreach.positionen.index}" title="{lang key='delete' section='global'}" class="btn btn-blank">
												&times;
											</button>
										{/if}
									</div>
								{/if}
							{/block}
						</div>
					{/block}
					{block name='oder-items-item-moreinfo'}
						{if $hasmore == 1}
							<div class="collapse small" id="moreinfo{$smarty.foreach.positionen.index}">
								<div class="inside">
									<table class="m0">
										{block name='order-items-item-infos-variations'}
											{if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
												{foreach name=variationen from=$oPosition->WarenkorbPosEigenschaftArr item=Variation}
													<tr class="variation">
														<td>{$Variation->cEigenschaftName|transByISO}:</td> 
														<td>{$Variation->cEigenschaftWertName|transByISO}</td>
													</tr>
												{/foreach}
											{/if}
										{/block}
										{block name='order-items-item-infos-delivery'}
											{if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|transByISO}
												<tr class="delivery-status">
													<td>{lang key="deliveryStatus" section="global"}:</td> 
													<td>{$oPosition->cLieferstatus|transByISO}</td>
												</tr>
											{/if}
										{/block}
										{block name='order-items-item-infos-notices'}
											{if !empty($oPosition->cHinweis)}
												<tr class="text-info notice">
													<td colspan="2">{$oPosition->cHinweis}</td>
												</tr>
											{/if}
										{/block}
										{block name='order-items-item-infos-manufacturer'}
											{if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
													<tr class="manufacturer">
													<td>{lang key="manufacturer" section="productDetails"}:</td>
													<td class="values">
														{$oPosition->Artikel->cHersteller}
													</td>
												</tr>
											{/if}
										{/block}
										{block name='order-items-item-infos-characteristics'}
											{if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr)}
												{foreach $oPosition->Artikel->oMerkmale_arr as $characteristic}
													<tr class="characteristic">
														<td>{$characteristic->getName()|escape:'html'}:</td>
														<td class="values">
															{foreach $characteristic->getCharacteristicValues() as $characteristicValue}
																{if !$characteristicValue@first}, {/if}
																{$characteristicValue->getValue()}
															{/foreach}
														</td>
													</tr>
												{/foreach}
											{/if}
										{/block}
										{block name='order-items-item-infos-attributes'}
											{if $Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute)}
												{foreach $oPosition->Artikel->Attribute as $oAttribute_arr}
													<tr class="attribute">
														<td>{$oAttribute_arr->cName}:</td>
														<td class="values">
															{$oAttribute_arr->cWert}
														</td>
													</tr>
												{/foreach}
											{/if}
										{/block}
										{block name='order-items-item-infos-weight'}
											{if $oPosition->istKonfigVater()}
												{if isset($oPosition->getTotalConfigWeight()) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->getTotalConfigWeight() > 0}
													<tr class="weight">
														<td>{lang key="shippingWeight" section="global"}: </td>
														<td class="value">{$oPosition->getTotalConfigWeight()} {lang key="weightUnit" section="global"}</td>
													</tr>
												{/if}
											{else}
												{if isset($oPosition->Artikel->cGewicht) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->Artikel->fGewicht > 0}
													<tr class="weight">
														<td>{lang key="shippingWeight" section="global"}: </td>
														<td class="value">{$oPosition->Artikel->cGewicht} {lang key="weightUnit" section="global"}</td>
													</tr>
												{/if}
											{/if}
										{/block}
										{block name='order-items-item-infos-shortdesc'}                                    
											{if !isset($isCheckout)}
												{if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
													<tr class="shortdescription hidden-xs hidden-sm hidden-md w100">
														<td colspan="2">{$oPosition->Artikel->cKurzBeschreibung|strip_tags}</td>
													</tr>
												{/if}
											{/if}
										{/block}
									</table>
								</div>
							</div>
						{/if}
					{/block}
				{/if}
			{/foreach}
		{/block}
	{/block}
{/block}