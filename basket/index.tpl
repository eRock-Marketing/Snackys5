{block name='basket-index'}
	{block name='basket-viewport-assign'}
		{if !isset($viewportImages)}
			{assign var="viewportImages" value=0}
		{/if}
	{/block}
	{block name="header"}
		{include file='layout/header.tpl'}
	{/block}
	{block name="content"}
		{get_static_route id='warenkorb.php' assign='cartURL'}
		{include file="snippets/zonen.tpl" id="opc_before_heading"}
		{block name='basket-extension'}
			{include file="snippets/extension.tpl"}
		{/block}
		{block name="basket-content-wrapper"}
			<div class="row {if ($Warenkorb->PositionenArr|count > 0)}flx-jb{else}flx-jc{/if}">
				{block name="basket-content-left"}
    				<div class="{if ($Warenkorb->PositionenArr|count > 0)}col-12 col-md-7 col-lg-8{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-9{/if}{else}col-12 col-md-8 col-lg-6{/if}">
						{block name="basket-content-headline"}
    						<h1 class="mb-sm{if ($Warenkorb->PositionenArr|count == 0)} text-center{/if}">{lang key="basket" section="global"} {if ($Warenkorb->PositionenArr|count > 0)}<span class="text-muted">({count(JTL\Session\Frontend::getCart()->PositionenArr)} {lang key='products'})</span>{/if}</h1>
    						{include file="snippets/zonen.tpl" id="opc_after_heading"}
						{/block}
						{block name='basket-index-notice-shipping'}
        					{if !empty($WarenkorbVersandkostenfreiHinweis) && $Warenkorb->PositionenArr|count > 0}
            					<div class="alert alert-info">
                					{$WarenkorbVersandkostenfreiHinweis}
            					</div>
        					{/if}
    					{/block}
						{block name='basket-index-notice-weight'}
							{if $Einstellungen.kaufabwicklung.warenkorb_gesamtgewicht_anzeigen === 'Y'}
								<div class="alert alert-info">
									{lang key='cartTotalWeight' section='basket' printf=$WarenkorbGesamtgewicht}
								</div>
							{/if}
						{/block}
						{block name="basket-content-basket"}
    						{if ($Warenkorb->PositionenArr|count > 0)}
        						{block name="basket"}
            						<div class="basket_wrapper">
										{block name="basket-content-items-wrapper"}
                							<div class="basket-well mb-sm">
                    							{block name="basket-items"}
													{include file="snippets/zonen.tpl" id="before_basket" title="opc_before_basket"}
                        							<form id="cart-form" method="post" action="{$cartURL}">
                            							{$jtl_token}
                            							<input type="hidden" name="wka" value="1" />
                            							{include file='checkout/inc_order_items.tpl' tplscope='cart'}
                        							</form>
                    							{/block}
                							</div>
										{/block}
										{block name="basket-content-xsell-wrapper"}
                							{if !empty($xselling->Kauf) && count($xselling->Kauf->Artikel) > 0 && !$isMobile}
                    							{block name="basket-xsell"}
                      								<div class="basket-xsell">
                       									<hr class="invisible">
                       									{lang key='basketCustomerWhoBoughtXBoughtAlsoY' section='global' assign='panelTitle'}
														{include file='snippets/product_slider.tpl' productlist=$xselling->Kauf->Artikel title=$panelTitle}
                      								</div>
                    							{/block}
                							{/if}
										{/block}
            						</div>
        						{/block}
    						{else}
        						{block name="basket-empty"}
            						<div class="c-empt">
                						<span class="img-ct">
                    						<svg>
                      							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
                    						</svg>
                    						{if $snackyConfig.basketType == 0}
                    							<span class="h4 text-center">0</span>
                    						{/if}
                						</span>
									</div>							
            						<div class="alert alert-info text-center">{lang key="emptybasket" section="checkout"}</div>
            						<a href="{$ShopURL}" class="submit btn btn-primary btn-block btn-lg">{lang key="continueShopping" section="checkout"}</a>
        						{/block}
    						{/if}
						{/block}
					</div>
				{/block}
				{block name="basket-content-right"}
    				{if ($Warenkorb->PositionenArr|count > 0)}
    					<div class="col-12 col-md-5 col-lg-4{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-3{/if} right-boxes mt-xs">
							{block name='basket-index-include-uploads'}
								{if !empty($oUploadSchema_arr)}
									<div id="fileupload-wrapper" class="panel mb-sm small">
										{include file='snippets/uploads.tpl' tplscope='basket'}
									</div>
								{/if}
							{/block}
							{block name="basket-content-buybox"}			
        						<div class="cart-sum panel mb-sm">
            						{assign var="showCoupon" value=false}
            						{if $Einstellungen.kaufabwicklung.warenkorb_kupon_anzeigen === 'Y' && $KuponMoeglich == 1}
                						{block name="basket-coupon-outer"}
                    						{assign var="showCoupon" value=true}
											{block name="basket-coupon-headline"}
                    							<div class="panel-heading">
                        							<h2 class="h5 m0 panel-title">{lang key="useCoupon" section="checkout"}</h2>
                    							</div>
											{/block}
											{block name="basket-coupon-content"}
                    							<div class="apply-coupon panel-body mb-xs">
                        							<form class="form-inline jtl-validate" id="basket-coupon-form" method="post" action="{$cartURL}#basket-coupon-form">
                            							{$jtl_token}
                            							{block name="basket-coupon"}
                                							<div class="form-group m0 w100{if !empty($invalidCouponCode)} has-error{/if}">
                                    							<div class="input-group">
                                        							<input aria-label="{lang key='couponCode' section='account data'}" class="form-control" type="text" name="Kuponcode" id="couponCode" maxlength="32" placeholder="{lang key='couponCode' section='account data'}" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" required/>
                                        							<span class="input-group-btn">
                                            							<input class="btn btn-default" type="submit" value="&rsaquo;" />
                                        							</span>
                                    							</div>
															</div>
                            							{/block}
                        							</form>
												</div>
                							{/block}
										{/block}
									{/if}
									{block name="basket-prices-outer"}
            							<div class="panel-body">
                							{block name="basket-prices"}
												{block name="basket-prices-netto"}
                    								{if $NettoPreise}
                        								<div class="total-net flx-jb">
                            								<span class="price_label">
																<strong>{lang key="totalSum" section="global"} ({lang key="net" section="global"}):</strong>
															</span>
                            								<strong class="price total-sum">{$WarensummeLocalized[$NettoPreise]}</strong>
                        								</div>
													{/if}
												{/block}
												{block name="basket-prices-coupon"}
                    								{foreach $Warenkorb->PositionenArr as $Couponposition}
                        								{if $Couponposition->nPosTyp == '3' || $Couponposition->nPosTyp == '2'}
                        									<div class="coup flx-jb mb-xxs">
                            									<span class="coup_label">
                                									{$Couponposition->cName|trans}:
                            									</span>
                            									<span class="coup_label">
                                									{$Couponposition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                            									</span>
                        									</div>
                    									{/if}
                    								{/foreach}
												{/block}
												{block name="basket-prices-steuerpos"}
                    								{if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|count > 0}
                        								{foreach name=steuerpositionen from=$Steuerpositionen item=Steuerposition}
                            								<div class="tax flx-jb">
                                								<span class="tax_label">{$Steuerposition->cName}:</span>
                                								<span class="tax_label">{$Steuerposition->cPreisLocalized}</span>
                            								</div>
                        								{/foreach}
                    								{/if}
												{/block}
												{block name="basket-prices-guthaben"}
                    								{if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
                         								<div class="customer-credit flx-jb">
                             								<span>{lang key="useCredit" section="account data"}</span>
                             				 				<span>{$smarty.session.Bestellung->GutscheinLocalized}</span>
                         								</div>
                    								{/if}
												{/block}
												{block name="basket-prices-total"}
                    								<div class="total info flx-jb mb-xs text-lg">
                        								<span class="price_label">
															<strong>{lang key="totalSum" section="global"}:</strong>
														</span>
                        								<strong class="price total-sum">{$WarensummeLocalized[0]}</strong>
                    								</div>
												{/block}
                							{/block}
											{block name="basket-checkout-shipping-costs"}
												<div class="small mb-xs">
													{$favourableShippingString}
												</div>
											{/block}
                							{block name="basket-checkout-btn"}
                    							<a href="{get_static_route id='bestellvorgang.php'}?wk=1" class="submit btn btn-primary btn-block btn-lg" id="cart-checkout-btn">{lang key='nextStepCheckout' section='checkout'}</a>
                							{/block}
            							</div>
									{/block}
            						{block name="basket-add-pays"}
                						<div class="add-pays">
                    						<div class="paypal"></div>
											<div class="amazon"></div>
                						</div>
                						<div class="payplan"></div>
            						{/block}
        						</div>
							{/block}
							{block name="basket-freegift-outer"}
        						{if $oArtikelGeschenk_arr|count > 0}
            						{block name="basket-freegift"}
                						<div id="freegift" class="panel mb-sm">
											{block name="basket-freegift-headline"}
                    							<div class="panel-heading">
                        							<h2 class="panel-title h4">{block name="basket-freegift-title"}{lang key='freeGiftFromOrderValueBasket'}{/block}</h2>
                    							</div>
											{/block}
											{block name="basket-freegift-body-outer"}
                    							<div class="panel-body">
                        							{block name="basket-freegift-body"}
                            							<form method="post" name="freegift" action="{$cartURL}#freegift">
                                							{$jtl_token}
                                    						{foreach $oArtikelGeschenk_arr as $oArtikelGeschenk}
																{block name="basket-freegift-item"}
																	<div class="row mb-xs">
																		<label class="thumbnail flx-ac flx-nw w100" for="gift{$oArtikelGeschenk->kArtikel}" role="button">
																			{block name="basket-freegift-item-radio"}
																				<div class="col-1">
																					<input name="gratisgeschenk" type="radio" value="{$oArtikelGeschenk->kArtikel}" id="gift{$oArtikelGeschenk->kArtikel}" />
																				</div>
																			{/block}
																			{block name="basket-freegift-item-image"}
																				<div class="col-3 col-sm-2 col-md-3">
																					<div class="img-ct">
																						{include file='snippets/image.tpl'
																							fluid=false
																							item=$oArtikelGeschenk
																							square=false
																							srcSize='xs'
																							sizes='45px'
																							class='image'}
																					</div>
																				</div>
																			{/block}
																			{block name="basket-freegift-item-name"}
																				<div class="caption col-8 col-sm-9 col-md-8">
																					<p class="m0">{$oArtikelGeschenk->cName}</p>
																					<p class="small text-muted m0">{lang key='freeGiftFrom1'} {$oArtikelGeschenk->cBestellwert} {lang key='freeGiftFrom2'}</p>
																				</div>
																			{/block}
																		</label>
																	</div>
																{/block}
                                    						{/foreach}
															<div class="">
																<input type="hidden" name="gratis_geschenk" value="1" />
																<input name="gratishinzufuegen" type="submit" value="{lang key='addToCart'}" class="submit btn btn-block" />
															</div>
														</form>
													{/block}
                    							</div>
											{/block}
										</div>
            						{/block}
								{/if}
							{/block}
							{block name="basket-shipping-estimate-form-outer"}        
        						{if $Einstellungen.kaufabwicklung.warenkorb_versandermittlung_anzeigen === 'Y'}
            						{block name="basket-shipping-estimate-form"}
                						<div class="basket-shipping-estimate-form">
                    						{include file="snippets/zonen.tpl" id="opc_before_shipping_calculator"}
                    						<form id="basket-shipping-estimate-form" method="post" action="{$cartURL}#basket-shipping-estimate-form">
                        						{$jtl_token}
                        						{include file='snippets/shipping_calculator.tpl' checkout=true tplscope="cart"}
                    						</form>
										</div>
            						{/block}
        						{/if}
							{/block}
    					</div>
    				{/if}
				{/block}
			</div>
		{/block}
		{block name="basket-xsell-outer"}        
    		{if !empty($xselling->Kauf) && count($xselling->Kauf->Artikel) > 0 && $isMobile}
        		{block name="basket-xsell"}
          			<div class="basket-xsell-xs">
           				<hr class="invisible">
						{lang key='basketCustomerWhoBoughtXBoughtAlsoY' section='global' assign='panelTitle'}
						{include file='snippets/product_slider.tpl' productlist=$xselling->Kauf->Artikel title=$panelTitle}
          			</div>
        		{/block}
			{/if}
		{/block}
	{/block}
	{block name="footer"}
		{include file='layout/footer.tpl'}
	{/block}
{/block}