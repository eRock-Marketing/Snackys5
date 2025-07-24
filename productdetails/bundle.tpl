{block name='productdetails-bundle'}
{if !empty($Products)}
    <hr class="invisible">
    <form action="{if !empty($ProductMain->cURLFull)}{$ProductMain->cURLFull}{else}index.php{/if}" method="post" id="form_bundles" class="evo-validate">
        <div class="panel-default panel-slider">
            <input type="hidden" name="a" value="{$ProductMain->kArtikel}" />
            <input type="hidden" name="addproductbundle" value="1" />
            <input type="hidden" name="aBundle" value="{$ProductKey}" />
            {block name="productdetails-bundle-main"}{* for additional hidden inputs use block prepend *}
            <div class="panel-heading">
				<div class="panel-title dpflex-a-center dpflex-j-between mb-spacer mb-xs">
                    <span class="h2 m0 block">{lang key="buyProductBundle" section="productDetails"}</span>
                    {if $tplscope !== 'box'}
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
                    {/if}
				</div>
            </div>
			<div class="panel-body">
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
				<div class="row p-sl no-scrollbar dpflex-nowrap{if isset($isBox)} sidebar{/if}">
					{foreach $Products as $bundleProduct}
						<div class="col-lg-2 p-w">
							<div class="p-c">
								<a class="img-w block" href="{$bundleProduct->cURLFull}">
									<span class="img-ct">
										{include file='snippets/image.tpl' item=$bundleProduct square=false}
									</span>
								</a>
								<div class="caption">
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
									<div class="price_wrapper">
										<strong class="price text-nowrap"><span>{$bundleProduct->Preise->cVKLocalized[0]}</span> *</strong>
									</div>
								</div>
							</div>
						</div>
					{/foreach}
				</div>
			</div>
			{if $smarty.session.Kundengruppe->mayViewPrices()}
				<div class="dpflex-a-center panel mt-xs">
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
					<button name="inWarenkorb" type="submit" value="{lang key="addAllToCart" section="global"}" class="submit btn btn-primary btn-lg">{lang key="addAllToCart" section="global"}</button>
				</div>
			{/if}
            {/block}
        </div>
    </form>
{/if}
{/block}