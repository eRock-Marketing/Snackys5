{block name='productdetails-basket'}
	{if ($Artikel->inWarenkorbLegbar == 1 || $Artikel->nErscheinendesProdukt == 1) || $Artikel->Variationen}
		{block name='basket-assigns'}
			{$interval = $Artikel->fAbnahmeintervall|default:0}
			{$mbm = $Artikel->fMindestbestellmenge|default:0}
		{/block}
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
													{JTL\Session\Frontend::getCurrency()->getName()}
												{/inputgrouptext}
											{/inputgroupappend}
										{/inputgroup}
									{/col}
									{input type="hidden" id="quantity" class="quantity" name="anzahl" value="1"}
								{/block}
                        	{else}
								{block name='basket-quantity'}
                            		<div id="quantity-grp" class="flx{if $snackyConfig.quantityButtons == '1'}-w{/if} w100 choose_quantity{if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix} disabled mb-xxs{/if}">
										{block name='basket-quantity-minus'}
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
										{/block}
										{block name='basket-quantity-defines'}
											{$step = 1}
											{if $Artikel->cTeilbar === 'Y' && $interval == 0}
												{$step = 'any'}
											{elseif $interval > 0}
												{$step = $interval}
											{/if}
											{$inputValue = 1}
											{if $interval > 0 || $mbm > 1}
												{$inputValue = max($mbm,$interval)}
											{elseif isset($fAnzahl)}
												{$inputValue = $fAnzahl}
											{/if}
											{$pid = $Artikel->kVariKindArtikel|default:$Artikel->kArtikel}
											{if $mbm == 0 && $step != 'any'}
												{$mbm = $step}
											{/if}
										{/block}
										{block name='basket-quantity-input'}
											{input type="number"
												min=$mbm
												max=$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''
												required=($interval > 0)
												step=$step
												id="quantity" class="quantity" name="anzahl"
												aria=["label"=>"{lang key='quantity'}"]
												value=$inputValue
												data=[
													"decimals"=>{getDecimalLength quantity=$interval},
													"product-id"=>"{$pid}"
												]
											}
										{/block}
										{block name='basket-quantity-unit'}
											{if $Artikel->cEinheit}
												<span class="input-group-addon unit">{$Artikel->cEinheit}</span>
											{/if}
										{/block}
										{block name='basket-quantity-plus'}
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
										{/block}
								{/block}
							{/if}
							{block name='basket-submit'}
								<button aria-label="{lang key='addToCart'}" name="inWarenkorb" type="submit" value="{lang key='addToCart'}" class="sn-addBasket submit btn btn-primary btn-lg btn-block{if isset($wkWeiterleiten)} wkWeiterleiten{/if}"{if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix} disabled{/if}>
									<span class="">{lang key='addToCart'}</span>
								</button>
							{/block}
							{if isset($kEditKonfig)}
								<input type="hidden" name="kEditKonfig" value="{$kEditKonfig}"/>
							{/if}
							{if $snackyConfig.quantityButtons != '1'}
								</div>
							{/if}
                    	{/block}
                	{/if}
					{block name='basket-variation-notice'}
						{if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix}
							<div class="small">
								<p class="alert alert-info choose-variations">{lang key="chooseVariations" section="messages"}</p>
							</div>
					   {/if}
					{/block}
            	{/if}
				{block name='basket-purchase-infos'}
					{if $Artikel->inWarenkorbLegbar == 1
						&& ($mbm > 1
							|| ($interval > 0 &&
							$Einstellungen.artikeldetails.artikeldetails_artikelintervall_anzeigen === 'Y')
							|| $Artikel->cTeilbar === 'Y'
							|| $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:0 > 0)}
						<div class="purchase-info small mt-xxs">
							<div class="alert alert-info" role="alert">
								{block name='basket-purchase-infos-units'}
									{assign var="units" value=$Artikel->cEinheit}
									{if empty($Artikel->cEinheit) || $Artikel->cEinheit|strlen == 0}
										<span class="block">{lang key="units" section="productDetails" assign="units"}</span>
									{/if}
								{/block}
								{block name='basket-purchase-infos-minimum'}
									{if $mbm > 1 || ($mbm > 0 && $Artikel->cTeilbar === 'Y')}
										{lang key="minimumPurchase" section="productDetails" assign="minimumPurchase"}
										<span class="block">{$minimumPurchase|replace:"%d":$mbm|replace:"%s":$units}</span>
									{/if}
								{/block}
								{block name='basket-purchase-infos-intervall'}
									{if $interval > 0 && $Einstellungen.artikeldetails.artikeldetails_artikelintervall_anzeigen === 'Y'}
										{lang key="takeHeedOfInterval" section="productDetails" assign="takeHeedOfInterval"}
										<span class="block">{$takeHeedOfInterval|replace:"%d":$interval|replace:"%s":$units}</span>
									{/if}
								{/block}
								{block name='basket-purchase-infos-integral'}
									{if $Artikel->cTeilbar === 'Y'}
										<span class="block">{lang key="integralQuantities" section="productDetails"}</span>
									{/if}
								{/block}
								{block name='basket-purchase-infos-maximum'}
									{if !empty($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]) && $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE] > 0}
										{lang key="maximalPurchase" section="productDetails" assign="maximalPurchase"}
										<span class="block">{$maximalPurchase|replace:"%d":$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_MAXBESTELLMENGE]|replace:"%s":$units}</span>
									{/if}
								{/block}
							</div>
						</div>
					{/if}
				{/block}
			{/block}
		</div>
	{/if}
{/block}