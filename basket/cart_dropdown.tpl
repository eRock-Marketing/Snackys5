{block name='basket-cart-dropdown'}
	{include file="snippets/zonen.tpl" id="before_sidebasket" title="before_sidebasket"}
	{block name='basket-cart-dropdown-assign-tpl'}
		{if empty($parentTemplateDir)}
			{* Workaround for IO Request *}
			{assign var="parentTemplateDir" value="templates/Snackys/"}
		{/if}
	{/block}
	{block name='sidebasket-headline'}
		<div class="text-center h3 mb-sm">{lang key="basket" section="global"}</div>
		{include file="snippets/zonen.tpl" id="after_sidebasket_headline" title="after_sidebasket_headline"}
	{/block}
	{block name='sidebasket-added-notice'}
		{if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
			{if isset($zuletztInWarenkorbGelegterArtikel)}
				{assign var=pushedArtikel value=$zuletztInWarenkorbGelegterArtikel}
			{else}
				{assign var=pushedArtikel value=$Artikel}
			{/if}
			<div class="alert alert-success">{$pushedArtikel->cName} {lang key="productAddedToCart" section="global"}</div>
		{/if}
	{/block}
	{$cartPositions = JTL\Session\Frontend::getCart()->PositionenArr}
	{block name='basket-cart-dropdown-max-cart-positions'}
		{$maxCartPositions = 15}
	{/block}
	{if $cartPositions|count > 0}
		{block name='sidebasket-filled'}
			{if !empty($WarenkorbVersandkostenfreiHinweis)}
				{block name='sidebasket-versandfrei-hinweis'}
					<div class="alert alert-info">
						{$WarenkorbVersandkostenfreiHinweis|truncate:120:"..."}
						<a class="popup" href="{if !empty($oSpezialseiten_arr) && isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}{else}#{/if}" data-toggle="tooltip"  data-placement="bottom" title="{lang section="login" key="shippingInfo"}"></a>
					</div>
					{include file="snippets/zonen.tpl" id="after_sidebasket_versandfrei" title="after_sidebasket_versandfrei"}
				{/block}
			{/if}
			{block name='sidebasket-items'}
				<form id="cart-form-xs" method="post" action="{get_static_route id='warenkorb.php'}">
					{if isset($jtl_token)}
						{$jtl_token}
					{/if}
					<input type="hidden" name="wka" value="1" />
					{foreach $cartPositions as $oPosition name=positionen}
						{block name='sidebasket-items-item'}
							{if !$oPosition->istKonfigKind()}
								{if $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL || $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_GRATISGESCHENK}
									{block name='sidebasket-items-warenkorbartikel'}
										<div class="sc-item dropdown">
											<div class="flx-ac">
												{block name='sidebasket-items-warenkorbartikel-image'}
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
												{block name='sidebasket-items-warenkorbartikel-name'}
													<div class="cols-name">
														{$oPosition->nAnzahl|replace_delim}{if $oPosition->Artikel->cEinheit} {$oPosition->Artikel->cEinheit}{else}&times;{/if}
														<a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:"html"}">
															{$oPosition->cName|trans}
														</a>
													</div>
												{/block}
												{block name='sidebasket-items-warenkorbartikel-price'}
													<div class="cols-price">
														{if $oPosition->istKonfigVater()}
															<strong>{$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
														{else}
															<strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
														{/if}
													</div>
												{/block}
												{block name='sidebasket-items-warenkorbartikel-editbutton'}
													{if $snackyConfig.editSidebasket == 2}
														<button class="editpos" type="button" data-toggle="collapse" data-target="#edit_{$oPosition@iteration}_wrap">
															<span class="img-ct icon icon">
																<svg>
																	<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
																</svg>
															</span>
														</button>
													{/if}
												{/block}
											</div>
											{block name='sidebasket-items-warenkorbartikel-edit'}
												{if $snackyConfig.editSidebasket == 2}
													<div class="collapse" id="edit_{$oPosition@iteration}_wrap">
														<div class="edit-item show" id="edit_{$oPosition@iteration}">
															{block name='sidebasket-items-warenkorbartikel-edit-quantity'}
																{if $oPosition->istKonfigVater()}
																	{block name='sidebasket-items-warenkorbartikel-edit-quantity-confi'}
																		<div class="qty-wrapper modify">
																			<a class="btn btn-default configurepos btn-xs" href="index.php?a={$oPosition->kArtikel}&ek={$smarty.foreach.positionen.index}">
																				{lang key="configure" section="global"}
																			</a>
																		</div>
																	{/block}
																{else}
																	{block name='sidebasket-items-warenkorbartikel-edit-quantity-amount'}
																		<div class="form-inline flx-je">
																			<div class="input-group" role="group">
																				<input name="anzahl[{$smarty.foreach.positionen.index}]" class="btn-group form-control quantity text-right" size="3" value="{$oPosition->nAnzahl}" />
																				<button type="submit" class="btn btn-default btn-xs" title="{lang key='refresh' section='checkout'}">
																					<span class="img-ct icon">
																						<svg>
																							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-refresh"></use>
																						</svg>
																					</span>
																				</button>
																			</div>
																		</div>
																	{/block}
																{/if}
																{block name='sidebasket-items-warenkorbartikel-edit-delete'}
																	<button type="submit" class="droppos btn btn-xs flx-ac btn-flex btn-danger" name="dropPos" value="{$smarty.foreach.positionen.index}" title="{lang key="delete" section="global"}">
																		<span class="img-ct icon op1">
																			<svg class="icon-darkmode">
																				<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
																			</svg>
																		</span>
																	</button>
																{/block}
															{/block}
														</div>
													</div>
												{/if}
											{/block}
										</div>
									{/block}
								{else}
									{block name='sidebasket-items-nichtwarenkorbartikel'}
										<div class="flx-ac sc-item">
											{block name='sidebasket-items-nichtwarenkorbartikel-image'}
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
											{block name='sidebasket-items-nichtwarenkorbartikel-name'}
												<div class="cols-name" colspan="2">
													{$oPosition->nAnzahl|replace_delim}&times;&nbsp;{$oPosition->cName|trans|escape:"htmlall"}
												</div>
											{/block}
											{block name='sidebasket-items-nichtwarenkorbartikel-price'}
												<div class="cols-price">
													<strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
												</div>
											{/block}
											{block name='sidebasket-items-nichtwarenkorbartikel-edit'}
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
				{include file="snippets/zonen.tpl" id="after_sidebasket_items" title="after_sidebasket_items"}
			{/block}
			{block name='sidebaket-price'}
				<div class="sc-sum">
					{block name='sidebaket-price-netto'}
						{if $NettoPreise}
							<div class="text-muted total total-net flx-jb cols-sums">
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
					{/block}
					{block name='sidebaket-price-tax'}
						{if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && isset($Steuerpositionen) && $Steuerpositionen|count > 0}
							{foreach $Steuerpositionen as $Steuerposition}
								<div class="text-muted tax flx-jb cols-sums">
									<div colspan="3">{$Steuerposition->cName}</div>
									<div class="text-nowrap text-right">{$Steuerposition->cPreisLocalized}</div>
								</div>
							{/foreach}
						{/if}
					{/block}
					{block name='sidebaket-price-sum'}
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
					{block name='sidebaket-price-shipping'}
						{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
							{if isset($FavourableShipping)}
								{if $NettoPreise}
									{$shippingCosts = "`$FavourableShipping->cPriceLocalized[$NettoPreise]` {lang key='plus' section='basket'} {lang key='vat' section='productDetails'}"}
								{else}
									{$shippingCosts = $FavourableShipping->cPriceLocalized[$NettoPreise]}
								{/if}
								<hr class="invisible hr-xs">
								<div class="card small text-muted shipping-costs flx-jb cols-sums">
									<div class="panel w100">
										{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL():$shippingCosts:$FavourableShipping->country->getName() key='shippingInformationSpecific' section='basket'}
									</div>
								</div>
							{elseif empty($FavourableShipping) && empty($smarty.session.Versandart)}
								<hr class="invisible hr-xs">
								<div class="card small text-muted shipping-costs flx-jb cols-sums">
									<div class="panel w100">
										{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() key='shippingInformation' section='basket'}
									</div>
								</div>
							{/if}
						{/if}
					{/block}
				</div>
				{include file="snippets/zonen.tpl" id="after_sidebasket_prices" title="after_sidebasket_prices"}
			{/block}
		{/block}
	{else}
		{block name="empty-sidebasket"}
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
			<p class="text-center text-muted">{lang section='checkout' key='emptybasket'}</p>
		{/block}
	{/if}
	{block name='sidebasket-buybuttons'}
		<div class="fixed-btn-group{if $snackyConfig.shopBButton == 1} one-button{/if}">
			{block name='sidebasket-buybuttons-to-basket'}
				<a href="{get_static_route id='warenkorb.php'}" class="btn btn-block{if $snackyConfig.shopBButton == 1} btn-primary btn-lg{/if}" title="{lang key='gotoBasket'}"> {lang key='gotoBasket'}</a>
			{/block}
			{block name='sidebasket-buybuttons-to-checkout'}
				{if $snackyConfig.shopBButton == 0}
					<a href="{get_static_route id='bestellvorgang.php'}" class="btn btn-primary btn-block btn-lg">{lang key="checkout" section="basketpreview"}</a>
				{/if}
			{/block}
		</div>
	{/block}
	{block name='sidebasket-addbuybuttons'}
		<div class="add-pays cart-dropdown-buttons">
			<div class="paypal"></div>
			<div class="amazon"></div>
		</div>
		<div class="payplan"></div>
		{include file="snippets/zonen.tpl" id="after_sidebasket_buybuttons" title="after_sidebasket_buybuttons"}
	{/block}
	{block name='sidebasket-legallinks'}
		{getLink nLinkart=12 cAssign="linkdatenschutz"}
		{getLink nLinkart=27 cAssign="linkimpressum"}
		{if $linkimpressum || $linkdatenschutz}
			<div class="text-center small mt-xs">
				{if $linkdatenschutz}
					<a href="{$linkdatenschutz->getURL()}" rel="nofollow">
						{if !empty($linkdatenschutz->getTitle())}
							{$linkdatenschutz->getTitle()}
						{else}
							{$linkdatenschutz->getName()}
						{/if}
					</a>
				{/if}
				{if $linkimpressum && $linkdatenschutz} • {/if}
				{if $linkimpressum}
					<a href="{$linkimpressum->getURL()}" rel="nofollow">
						{if !empty($linkimpressum->getTitle())}
							{$linkimpressum->getTitle()}
						{else}
							{$linkimpressum->getName()}
						{/if}
					</a>
				{/if}
			</div>
		{/if}
	{/block}
	{include file="snippets/zonen.tpl" id="after_sidebasket" title="after_sidebasket"}
{/block}