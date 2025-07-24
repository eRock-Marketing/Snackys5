{block name='basket-cart-dropdown'}
{if empty($parentTemplateDir)}
	{* Workaround for IO Request *}
	{assign var="parentTemplateDir" value="templates/Snackys/"}
{/if}
<span class="text-center h3 block mb-spacer mb-small">{lang key="basket" section="global"}</span>
    {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
        {if isset($zuletztInWarenkorbGelegterArtikel)}
            {assign var=pushedArtikel value=$zuletztInWarenkorbGelegterArtikel}
        {else}
            {assign var=pushedArtikel value=$Artikel}
        {/if}
        <div class="alert alert-success">{$pushedArtikel->cName} {lang key="productAddedToCart" section="global"}</div>
    {/if}
	
    {if $smarty.session.Warenkorb->PositionenArr|@count > 0}
        {if !empty($WarenkorbVersandkostenfreiHinweis)}
            <div class="alert alert-info">{$WarenkorbVersandkostenfreiHinweis|truncate:120:"..."}
                <a class="popup" href="{if !empty($oSpezialseiten_arr) && isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}{else}#{/if}" data-toggle="tooltip"  data-placement="bottom" title="{lang section="login" key="shippingInfo"}">
                </a>
            </div>
        {/if}
			<form id="cart-form-xs" method="post" action="{get_static_route id='warenkorb.php'}">
			{$jtl_token}
			<input type="hidden" name="wka" value="1" />
            {foreach name="positionen" from=$smarty.session.Warenkorb->PositionenArr item=oPosition}
                {if !$oPosition->istKonfigKind()}
                    {if $oPosition->nPosTyp == C_WARENKORBPOS_TYP_ARTIKEL}
            			<div class="sc-item dropdown">
							<div class="dpflex-a-center">
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
                            <div class="cols-name">
                                {$oPosition->nAnzahl|replace_delim}{if $oPosition->Artikel->cEinheit}{$oPosition->Artikel->cEinheit}{else}&times;{/if}
                                <a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:"html"}">
                                    {$oPosition->cName|trans}
                                </a>
                            </div>
                            <div class="cols-price">
                                {if $oPosition->istKonfigVater()}
                                    <strong>{$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
                                {else}
                                    <strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
                                {/if}
                            </div>
                            {if $snackyConfig.editSidebasket == 2}
							<button class="editpos" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<span class="img-ct icon icon">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-edit"></use>
                                    </svg>
								</span>
							</button>
                            {/if}
							</div>
                            {if $snackyConfig.editSidebasket == 2}
							<div class="edit-item">
								{if $oPosition->istKonfigVater()}
									<div class="qty-wrapper modify">
										<a class="btn btn-default configurepos btn-xs"
											href="index.php?a={$oPosition->kArtikel}&ek={$smarty.foreach.positionen.index}">
											{lang key="configure" section="global"}
										</a>
									</div>
								{else}
									<div class="form-inline dpflex-j-end">
										<div class="input-group" role="group" id="quantity-grp{$smarty.foreach.positionen.index}">
											<input name="anzahl[{$smarty.foreach.positionen.index}]" id="quantity{$smarty.foreach.positionen.index}" class="btn-group form-control quantity text-right" size="3" value="{$oPosition->nAnzahl}" />
											{* if $oPosition->Artikel->cEinheit}
												<span class="btn-group unit input-group-addon hidden-xs">{$oPosition->Artikel->cEinheit}</span>
											{/if *}
												<button type="submit" class="btn btn-default btn-xs" title="{lang key='refresh' section='checkout'}">
													<span class="img-ct icon">
														<svg>
														  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-refresh"></use>
														</svg>
																</span>
												</button>
										</div>
									</div>
								{/if}
								<button type="submit" class="droppos btn btn-xs dpflex-a-center btn-flex btn-danger" name="dropPos" value="{$smarty.foreach.positionen.index}" title="{lang key="delete" section="global"}">
									<span class="img-ct icon op1">
										<svg class="icon-darkmode">
											<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
                                        </svg>
									</span>
                            	</button>
							</div>
                            {/if}
						</div>
                    {else}
            			<div class="dpflex-a-center sc-item">
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
                            <div class="cols-name" colspan="2">
                                {$oPosition->nAnzahl|replace_delim}&times;&nbsp;{$oPosition->cName|trans|escape:"htmlall"}
                            </div>
                            <div class="cols-price">
                                <strong>{$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}</strong>
                            </div>
							<button class="editpos invisible">
								<span class="img-ct icon icon">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-info"></use>
                                    </svg>
								</span>
							</button>
                        </div>
                    {/if}
                {/if}
            {/foreach}
			</form>
			<div class="sc-sum">
				{if $NettoPreise}
					<div class="text-muted total total-net dpflex-j-between cols-sums">
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
				{if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && isset($Steuerpositionen) && $Steuerpositionen|@count > 0}
					{foreach $Steuerpositionen as $Steuerposition}
						<div class="text-muted tax dpflex-j-between cols-sums">
							<div colspan="3">{$Steuerposition->cName}</div>
							<div class="text-nowrap text-right">{$Steuerposition->cPreisLocalized}</div>
						</div>
					{/foreach}
				{/if}
				<div class="total dpflex-j-between sum-tt cols-sums">
					<div colspan="3">
                        {if empty($smarty.session.Versandart)}
                            {lang key='subtotal' section='account data'}
                        {else}
                            {lang key='totalSum'}
                        {/if}:
					</div>
					<div class="text-nowrap text-right total"><strong>{$WarensummeLocalized[0]}</strong></div>
				</div>
                {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                {if isset($FavourableShipping)}
                    {if $NettoPreise}
                        {$shippingCosts = "`$FavourableShipping->cPriceLocalized[$NettoPreise]` {lang key='plus' section='basket'} {lang key='vat' section='productDetails'}"}
                    {else}
                        {$shippingCosts = $FavourableShipping->cPriceLocalized[$NettoPreise]}
                    {/if}
                        <hr class="invisible hr-xs">
						<div class="card small text-muted shipping-costs dpflex-j-between cols-sums">
							<div class="panel">
								{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL():$shippingCosts:$FavourableShipping->country->getName() key='shippingInformationSpecific' section='basket'}
							</div>
						</div>
                {elseif empty($FavourableShipping) && empty($smarty.session.Versandart)}
                        <hr class="invisible hr-xs">
						<div class="card small text-muted shipping-costs dpflex-j-between cols-sums">
							<div class="panel">
								{lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() key='shippingInformation' section='basket'}
							</div>
						</div>
				{/if}
				{/if}
			</div>
    {else}
    {block name="empty-sidebasket"}
    <div class="c-empt">
        <span class="img-ct">
            <svg>
              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
            </svg>
            {if $snackyConfig.basketType == 0}
            <span class="h4 text-center">0</span>
            {/if}
        </span>
    </div>
    <p class="text-center text-muted">{lang section='checkout' key='emptybasket'}</p>
    {/block}
    {/if}
{/block}