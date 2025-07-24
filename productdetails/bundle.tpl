{block name='productdetails-bundle'}
	{if !empty($Products)}
    	<hr class="invisible">
    	<form action="{if !empty($ProductMain->cURLFull)}{$ProductMain->cURLFull}{else}{$ShopURL}/{/if}" method="post" id="form_bundles" class="jtl-validate mb-lg">
			{$jtl_token}
			{block name='bundle-defines'}
				<input type="hidden" name="a" value="{$ProductMain->kArtikel}" />
				<input type="hidden" name="addproductbundle" value="1" />
				<input type="hidden" name="aBundle" value="{$ProductKey}" />
			{/block}
			{block name='bundle-panel'}
        		<div class="panel-default panel-slider">
            		{block name="productdetails-bundle-main"}
						{block name='bundle-panel-heading'}
            				<div class="panel-heading">
								<div class="panel-title flx-ac flx-jb mb-xs">
									{block name='bundle-panel-heading-headline'}
                    					<span class="h2 m0 block">{lang key="buyProductBundle" section="productDetails"}</span>
									{/block}
									{block name='bundle-panel-heading-desktop-navigation'}
                    					<div class="right">
                        					{if !$isMobile}
                            					<div class="ar-ct btn-group{if $Products|@count > $snackyConfig.css_listElmXl} show-xl{/if}{if $Products|@count > $snackyConfig.css_listElmLg} show-lg{/if}{if $Products|@count > $snackyConfig.css_listElmMd} show-md{/if}{if $Products|@count > $snackyConfig.css_listElmSm} show-sm{/if}{if $Products|@count > $snackyConfig.css_listElmXs} show-xs{/if}">
													<span class="sl-ar sl-pr btn inactive">
														<span class="ar ar-l"></span>
													</span>
													<span class="sl-ar sl-nx btn">
														<span class="ar ar-r"></span>
													</span>
                            					</div>
                        					{/if}
                    					</div>
									{/block}
								</div>
            				</div>
						{/block}
						{block name='bundle-panel-body'}
							<div class="panel-body">
								{block name='bundle-panel-body-mobile-navigation'}
                					{if $isMobile}
                						<div class="row ar-ct-m">
                    						<div class="col-12 ar-ct{if $Products|@count > $snackyConfig.css_listElmXl} show-xl{/if}{if $Products|@count > $snackyConfig.css_listElmLg} show-lg{/if}{if $Products|@count > $snackyConfig.css_listElmMd} show-md{/if}{if $Products|@count > $snackyConfig.css_listElmSm} show-sm{/if}{if $Products|@count > $snackyConfig.css_listElmXs} show-xs{/if}">
												<span class="sl-ar sl-pr btn inactive">
													<span class="ar ar-l"></span>
												</span>
												<span class="sl-ar sl-nx btn">
													<span class="ar ar-r"></span>
												</span>
                    						</div>
                						</div>
									{/if}
								{/block}
								{block name='bundle-panel-body-products'}
									<div class="row p-sl no-scrollbar flx-nw{if isset($isBox)} sidebar{/if}">
										{foreach $Products as $bundleProduct}
											{block name='bundle-panel-body-product'}
												<div class="col-lg-2 p-w">
													<div class="p-c">
														{block name='bundle-panel-body-product-image'}
															<a class="img-w block" href="{$bundleProduct->cURLFull}">
																<span class="img-ct">
																	{include file='snippets/image.tpl' item=$bundleProduct square=false}
																</span>
															</a>
														{/block}
														{block name='bundle-panel-body-product-caption'}
															<div class="caption">
																{block name='bundle-panel-body-product-caption-name'}
																	<span class="title word-break h4 m0">
																		{foreach from=$ProductMain->oStueckliste_arr item=bundleProduct2}
                                    										{if $bundleProduct2->kArtikel == $bundleProduct->kArtikel}
																				<span class="article-bundle-info">
																					<span class="bundle-amount">{$bundleProduct2->fAnzahl_stueckliste}</span> <span class="bundle-times">x</span>
																				</span>
																				{break}
                                    										{/if}
                                										{/foreach}
                                										<a href="{$bundleProduct->cURLFull}">{$bundleProduct->cName}</a>
																	</span>
																{/block}
																{block name='bundle-panel-body-product-caption-price'}
																	<div class="price_wrapper">
																		<strong class="price text-nowrap"><span>{$bundleProduct->Preise->cVKLocalized[0]}</span> *</strong>
																	</div>
																{/block}
															</div>
														{/block}
													</div>
												</div>
											{/block}
										{/foreach}
									</div>
								{/block}
							</div>
						{/block}
						{block name='bundle-panel-footer'}
							{if JTL\Session\Frontend::getCustomerGroup()->mayViewPrices()}
								<div class="flx-ac panel mt-xs">
									{block name='bundle-panel-footer-price'}
										<div class="bundle-price h4">
											<span class="price-sum">{lang key="priceForAll" section="productDetails"}:
												<strong class="price price-sm">{$ProduktBundle->cPriceLocalized[$NettoPreise]} *</strong>
											</span>
											{if $ProduktBundle->fPriceDiff > 0}
												<br />
												<span class="label label-warning">{lang key="youSave" section="productDetails"}: <span class="color-brand">{$ProduktBundle->cPriceDiffLocalized[$NettoPreise]}</span></span>
											{/if}
											{if $ProductMain->cLocalizedVPE}
												<b class="label">{lang key="basePrice" section="global"}: </b>
												<span class="value">{$ProductMain->cLocalizedVPE[$NettoPreise]}</span>
											{/if}
										</div>
									{/block}
									{block name='bundle-panel-footer-submit'}
										<button name="inWarenkorb" type="submit" value="{lang key="addAllToCart" section="global"}" class="submit btn btn-primary btn-lg">{lang key="addAllToCart" section="global"}</button>
									{/block}
								</div>
							{/if}
						{/block}
					{/block}
				</div>
			{/block}
    	</form>
	{/if}
{/block}