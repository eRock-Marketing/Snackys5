{block name='account-index'}
	{if !isset($viewportImages)}
		{assign var="viewportImages" value=0}
	{/if}
	{block name="header"}
		{include file='layout/header.tpl'}
	{/block}
	{block name="content"}
		{block name='account-index-extension'}
			{include file="snippets/extension.tpl"}
		{/block}
		{block name='account-index-wkmerge'}
			{if (isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1)}
				<div class="modal-dialog modal-lg">
					<div class="modal-content">   
						<div class="modal-header"><h4 class="modal-title">{lang key="basket" section="global"}</h4></div> 
						<section class="tmp-modal-content">
							<div class="modal-body">
								{lang key="basket2PersMerge" section="login"}
								<div class="answer">
									<a href="{get_static_route id='bestellvorgang.php'}?basket2Pers=1&token={$smarty.session.jtl_token}">
										{lang key="yes" section="global"}
									</a>
									<a href="{get_static_route id='jtl.php'}?updatePersCart=1&token={$smarty.session.jtl_token}" class="x">
										{lang key="no" section="global"}
									</a>
								</div>
							</div>
						</section>
					</div>
				</div>
			{/if}
		{/block}
    	{block name='account-index-loginpanel'}
			{if !isset($showLoginPanel)}
				{$showLoginPanel = true}
			{/if}
			{if $step === 'login' || (isset($editRechnungsadresse) && $editRechnungsadresse)}
				{$showLoginPanel = false}
			{/if}
		{/block}
		{include file="snippets/zonen.tpl" id="opc_before_account"}
		{block name='account-index-account'}
    		<div id="account" class="row">
        		{block name="my-account-menu-outer"}
					{if $showLoginPanel}
						<div class="col-12 col-md-4 col-lg-3 al-wp">
							{include file="snippets/zonen.tpl" id="opc_before_menu"}
							{block name="my-account-menu-wrapper"}
                				<div class="panel{if $step === 'bestellung'} mb-sm{/if}" id="account-list">
                    				<div class="panel-heading">
										<div class="panel-title h4">{lang key="myAccount"}</div>
									</div>
									<hr class="invisible hr-sm">
                    				<ul class="blanklist panel-body nav">
                        				{block name="my-account-menu-list"}
											{block name="my-account-menu-meinkonto"}
												<li class="nav-it">
													<a href="{get_static_route id='jtl.php'}" class="defaultlink flx-ac flx-jb{if $step === 'mein Konto'} active{/if}">
													{if $step === 'mein Konto'}<strong>{/if}
														{lang key="accountOverview" section="account data"}
													{if $step === 'mein Konto'}</strong>{/if}
														<span class="img-ct icon icon-wt ic-md">
															<svg>
															  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-user"></use>
															</svg>
														</span>
													</a>
												</li>
											{/block}
											{block name="my-account-menu-bestellungen"}
												<li class="nav-it">
													<a href="{get_static_route id='jtl.php' params=['bestellungen' => 1]}" class="defaultlink flx-ac flx-jb{if $step === 'bestellung' || $step === 'bestellungen'} active{/if}">
													{if $step === 'bestellung' || $step === 'bestellungen'}<strong>{/if}
													{lang key="orders" section="account data"}
													{if $step === 'bestellung' || $step === 'bestellungen'}</strong>{/if}
														<span class="img-ct icon icon-wt ic-md">
															<svg>
															  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
															</svg>
														</span>
													</a>
												</li>
											{/block}
											{block name="my-account-menu-rechnungsadresse"}
												<li class="nav-it">
													<a href="{get_static_route id='jtl.php' params=['editRechnungsadresse' => 1]}" class="defaultlink flx-ac flx-jb{if $step === 'rechnungsdaten'} active{/if}">
													{if $step === 'rechnungsdaten'}<strong>{/if}
													{lang key="billingAdress" section="account data"}
													{if $step === 'rechnungsdaten'}</strong>{/if}
														<span class="img-ct icon icon-wt ic-md">
															<svg>
															  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-house"></use>
															</svg>
														</span>
													</a>
												</li>
											{/block}
											{block name="my-account-menu-lieferadresse"}
												<li class="nav-it">
													<a href="{get_static_route id='jtl.php' params=['editLieferadresse' => 1]}" class="defaultlink flx-ac flx-jb{if $step === 'rechnungsdaten'} active{/if}">
													{if $step === 'lieferadressen'}<strong>{/if}
													{lang key="myShippingAddresses" section="account data"}
													{if $step === 'lieferadressen'}</strong>{/if}
														<span class="img-ct icon icon-wt ic-md">
															<svg>
															  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-house"></use>
															</svg>
														</span>
													</a>
												</li>
											{/block}
											{block name="my-account-menu-wunschliste"}
												{if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
													<li class="nav-it">
														<a href="{get_static_route id='jtl.php' params=['wllist' => 1]}" class="defaultlink flx-ac flx-jb{if $step|substr:0:11 === 'wunschliste'} active{/if}">
														{if $step|substr:0:11 === 'wunschliste'}<strong>{/if}
														{lang key="wishlists" section="account data"}
														{if $step|substr:0:11 === 'wunschliste'}</strong>{/if}
														<span class="img-ct icon icon-wt ic-md">
															<svg>
															  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-heart"></use>
															</svg>
														</span>
														</a>
													</li>
												{/if}	
											{/block}
											{block name="my-account-menu-vergleichsliste"}
												{if $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y' && !empty($smarty.session.Vergleichsliste->oArtikel_arr) && $smarty.session.Vergleichsliste->oArtikel_arr|count > 0}
													<li class="nav-it">
														<a href="{get_static_route id='vergleichsliste.php'}" class="flx-ac flx-jb nav-it defaultlink">
															{lang key="compare" sektion="global"}
															<span class="img-ct icon icon icon-wt ic-md">
																<svg>
																  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-compare"></use>
																</svg>
															</span>
														</a>
													</li>
												{/if}
											{/block}                            
											{block name="my-account-menu-bewertungen"}
												{if $Einstellungen.bewertung.bewertung_anzeigen === 'Y'}
													<li class="nav-it">
														<a href="{get_static_route id='jtl.php' params=['bewertungen' => 1]}" class="defaultlink flx-ac flx-jb{if $step === 'bewertungen'} active{/if}">
															{if $step === 'bewertungen'}<strong>{/if}
															{lang key='allRatings'}
															{if $step === 'bewertungen'}</strong>{/if}
															<span class="img-ct icon icon-wt ic-md">
																<svg>
																  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-reviews"></use>
																</svg>
															</span>
														</a>
													</li>
												{/if}
											{/block}
										{/block}
									</ul>
									{block name="my-account-menu-logout"}
										<hr class="invisible hr-sm">
										<div class="panel-footer">
											 <a href="{get_static_route id='jtl.php' secure=true}?logout=1" title="{lang key='logOut'}" class="btn btn-block">{lang key='logOut'}</a>
										</div>
									{/block}
                				</div>
								{include file="snippets/zonen.tpl" id="opc_after_menu"}
                			{/block}
							{if $step === 'bestellung'}
								{block name="order-details-infos"}
									<div class="panel small">
										<div class="panel-heading h5">{lang key="order"}</div>
										{include file='account/order_details_info.tpl'}
									</div>
								{/block}
							{/if}
            			</div>
        			{/if}
        		{/block}
				{block name="my-account-content-wrapper"}
        			<div class="col-12{if $showLoginPanel} col-md-8 col-lg-9{/if}">
						{if $showLoginPanel}
							{include file="snippets/zonen.tpl" id="opc_before_account_page"}
						{/if}
						{if $step === 'login'}
							{block name='account-index-include-login'}
								{include file='account/login.tpl'}
							{/block}
						{elseif $step === 'mein Konto'}
							{block name='account-index-include-myaccount'}
								{include file='account/my_account.tpl'}
							{/block}
						{elseif $step === 'rechnungsdaten'}
							{block name='account-index-include-adressform'}
								{include file='account/address_form.tpl'}
							{/block}
						{elseif $step === 'lieferadressen'}
							{block name='account-index-include-shippingaddress-form'}
								{include file='account/shipping_address_form.tpl'}
							{/block}
						{elseif $step === 'passwort aendern'}
							{block name='account-index-include-changepass'}
								{include file='account/change_password.tpl'}
							{/block}
						{elseif $step === 'bestellung'}
							{block name='account-index-include-orderdetails'}
								<div id="order-details">
									{include file='account/order_details.tpl'}
								</div>
							{/block}
						{elseif $step === 'bestellungen'}
							{block name='account-index-include-orders'}
								{include file='account/orders.tpl'}
							{/block}
						{elseif $step === 'account loeschen'}
							{block name='account-index-include-deleteaccount'}
								{include file='account/delete_account.tpl'}
							{/block}
						{elseif $step === 'wunschliste'}
							{block name='account-index-include-wishlist'}
								{include file='account/wishlists.tpl'}
							{/block}
						{elseif $step === 'kunden_werben_kunden'}
							{block name='account-index-include-customerrecruiting'}
								{include file='account/customers_recruiting.tpl'}
							{/block}
						{elseif $step === 'bewertungen'}
							{block name='account-index-include-feedback'}
								{include file='account/feedback.tpl'}
							{/block}
						{/if}
						{if $showLoginPanel}
							{include file="snippets/zonen.tpl" id="opc_after_account_page"}
						{/if}
					</div>
				{/block}
    		</div>
		{/block}
	{/block}
	{block name="footer"}
		{include file='layout/footer.tpl'}
	{/block}
{/block}