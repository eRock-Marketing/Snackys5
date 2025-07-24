{block name='basket-index'}
{if !isset($viewportImages)}{assign var="viewportImages" value=0}{/if}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
	{include file="snippets/zonen.tpl" id="opc_before_heading"}
{include file="snippets/extension.tpl"}
<div class="row {if ($Warenkorb->PositionenArr|@count > 0)}dpflex-j-between{else}dpflex-j-center{/if}">
    <div class="{if ($Warenkorb->PositionenArr|@count > 0)}col-12 col-md-7 col-lg-8{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-9{/if}{else}col-12 col-md-8 col-lg-6{/if}">
    <h1 class="mb-spacer mb-small{if ($Warenkorb->PositionenArr|@count == 0)} text-center{/if}">{lang key="basket" section="global"} {if ($Warenkorb->PositionenArr|@count > 0)}<span class="text-muted">({$WarenkorbArtikelPositionenanzahl} {lang key="product" section="global"})</span>{/if}</h1>
    {include file="snippets/zonen.tpl" id="opc_after_heading"}
    
    {block name='basket-index-notice-shipping'}
        {if !empty($WarenkorbVersandkostenfreiHinweis) && $Warenkorb->PositionenArr|@count > 0}
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
    
    {if ($Warenkorb->PositionenArr|@count > 0)}
        {block name="basket"}
            <div class="basket_wrapper">
                <div class="basket-well mb-sm">
                    {block name="basket-items"}
						{include file="snippets/zonen.tpl" id="before_basket" title="opc_before_basket"}
                        <form id="cart-form" method="post" action="{get_static_route id='warenkorb.php'}">
                            {$jtl_token}
                            <input type="hidden" name="wka" value="1" />
                            {include file='checkout/inc_order_items.tpl' tplscope='cart'}
                        </form>
                    {/block}
                </div>
    
                {if !empty($xselling->Kauf) && count($xselling->Kauf->Artikel) > 0 && !$isMobile}
                    {block name="basket-xsell"}
                      <div class="basket-xsell">
                       <hr class="invisible">
                       {lang key='basketCustomerWhoBoughtXBoughtAlsoY' section='global' assign='panelTitle'}
                       {include file='snippets/product_slider.tpl' productlist=$xselling->Kauf->Artikel title=$panelTitle}
                      </div>
                    {/block}
                {/if}
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
    </div>
    {if ($Warenkorb->PositionenArr|@count > 0)}
    <div class="col-12 col-md-5 col-lg-4{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-3{/if} right-boxes mt-xs">
		{block name='basket-index-include-uploads'}
			{if !empty($oUploadSchema_arr)}
				<div id="fileupload-wrapper" class="panel mb-spacer mb-small small">
					{include file='snippets/uploads.tpl' tplscope='basket'}
				</div>
			{/if}
		{/block}
			
        <div class="cart-sum panel mb-spacer mb-small">
            {assign var="showCoupon" value=false}
            {if $Einstellungen.kaufabwicklung.warenkorb_kupon_anzeigen === 'Y' && $KuponMoeglich == 1}
                {block name="basket-coupon-outer"}
                    {assign var="showCoupon" value=true}
                    <div class="panel-heading">
                        <h2 class="h5 m0 panel-title">{lang key="useCoupon" section="checkout"}</h2>
                    </div>
                    <div class="apply-coupon panel-body mb-spacer mb-xs">
                        <form class="form-inline jtl-validate" id="basket-coupon-form" method="post" action="{get_static_route id='warenkorb.php'}">
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
            {/if}
            <div class="panel-body">
                {block name="basket-prices"}
                    {if $NettoPreise}
                        <div class="total-net dpflex-j-between">
                            <span class="price_label"><strong>{lang key="totalSum" section="global"} ({lang key="net" section="global"}):</strong></span>
                            <strong class="price total-sum">{$WarensummeLocalized[$NettoPreise]}</strong>
                        </div>
                    {/if}
                    {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|@count > 0}
                        {foreach name=steuerpositionen from=$Steuerpositionen item=Steuerposition}
                            <div class="tax dpflex-j-between">
                                {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                                    <td class="hidden-xs"></td>
                                {/if}
                                <span class="tax_label">{$Steuerposition->cName}:</span>
                                <span class="tax_label">{$Steuerposition->cPreisLocalized}</span>
                            </div>
                        {/foreach}
                    {/if}
                    {if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
                         <div class="customer-credit dpflex-j-between">
                             <span>{lang key="useCredit" section="account data"}</span>
                              <span>{$smarty.session.Bestellung->GutscheinLocalized}</span>
                         </div>
                    {/if}
                    <div class="total info dpflex-j-between mb-spacer mb-xs text-lg">
                        <span class="price_label"><strong>{lang key="totalSum" section="global"}:</strong></span>
                        <strong class="price total-sum">{$WarensummeLocalized[0]}</strong>
                    </div>
                {/block}
                {block name="basket-checkout-btn"}
                    <a href="{get_static_route id='bestellvorgang.php'}?wk=1" class="submit btn btn-primary btn-block btn-lg" id="cart-checkout-btn">{lang key='nextStepCheckout' section='checkout'}</a>
                {/block}
            </div>
            {block name="basket-add-pays"}
                <div class="add-pays">
                    <div class="paypal"></div>
                    <div class="amazon"></div>
                </div>
                <div class="payplan"></div>
            {/block}
        </div>
        {if $oArtikelGeschenk_arr|@count > 0}
            {block name="basket-freegift"}
                <div id="freegift" class="panel mb-spacer mb-small">
                    <div class="panel-heading">
                        <h2 class="panel-title h4">{block name="basket-freegift-title"}{lang key='freeGiftFromOrderValueBasket'}{/block}</h2>
                    </div>
                    <div class="panel-body">
                        {block name="basket-freegift-body"}
                            <form method="post" name="freegift" action="{get_static_route id='warenkorb.php'}">
                                {$jtl_token}
                                    {foreach $oArtikelGeschenk_arr as $oArtikelGeschenk}
									<div class="row mb-spacer mb-xs">
										<label class="thumbnail dpflex-a-center dpflex-nowrap w100" for="gift{$oArtikelGeschenk->kArtikel}" role="button">
											<div class="col-1">
												<input name="gratisgeschenk" type="radio" value="{$oArtikelGeschenk->kArtikel}" id="gift{$oArtikelGeschenk->kArtikel}" />
											</div>
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
											<div class="caption col-8 col-sm-9 col-md-8">
												<p class="m0">{$oArtikelGeschenk->cName}</p>
												<p class="small text-muted m0">{lang key='freeGiftFrom1'} {$oArtikelGeschenk->cBestellwert} {lang key='freeGiftFrom2'}</p>
											</div>
										</label>
									</div>
                                    {/foreach}
                                <div class="">
                                    <input type="hidden" name="gratis_geschenk" value="1" />
                                    <input name="gratishinzufuegen" type="submit" value="{lang key='addToCart'}" class="submit btn btn-block" />
                                </div>
                            </form>
                        {/block}
                    </div>
                </div>
            {/block}
        {/if}

        
        {if $Einstellungen.kaufabwicklung.warenkorb_versandermittlung_anzeigen === 'Y'}
            {block name="basket-shipping-estimate-form"}
                <div class="basket-shipping-estimate-form">
                    {include file="snippets/zonen.tpl" id="opc_before_shipping_calculator"}
                    <form id="basket-shipping-estimate-form" method="post" action="{get_static_route id='warenkorb.php'}">
                        {$jtl_token}
                        {include file='snippets/shipping_calculator.tpl' checkout=true tplscope="cart"}
                    </form>
                </div>
            {/block}
        {/if}
    </div>
    {/if}
    </div>
        
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

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}