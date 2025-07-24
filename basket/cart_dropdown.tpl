{block name='basket-cart-dropdown'}
    {include file="snippets/zonen.tpl" id="before_sidebasket" title="before_sidebasket"}
    {if empty($parentTemplateDir)}
        {* Workaround for IO Request *}
        {assign var="parentTemplateDir" value="templates/Snackys/"}
    {/if}
    {block name='sidebasket-headline'}
        <span class="text-center h3 block mb-spacer mb-small">{lang key="basket" section="global"}</span>
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
    {if $smarty.session.Warenkorb->PositionenArr|@count > 0}
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
                   {if isset($jtl_token)}{$jtl_token}{/if}
                       <input type="hidden" name="wka" value="1" />
                        {foreach name="positionen" from=$smarty.session.Warenkorb->PositionenArr item=oPosition}
                            {if !$oPosition->istKonfigKind()}
                                {if $oPosition->nPosTyp == C_WARENKORBPOS_TYP_ARTIKEL}
                                   {block name='sidebasket-items-warenkorbartikel'}
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
                                                {$oPosition->nAnzahl|replace_delim}{if $oPosition->Artikel->cEinheit} {$oPosition->Artikel->cEinheit}{else}&times;{/if}
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
                                            <button class="editpos" type="button" data-toggle="collapse" data-target="#edit_{$oPosition@iteration}">
                                                <span class="img-ct icon icon">
                                                    <svg>
                                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
                                                    </svg>
                                                </span>
                                            </button>
                                            {/if}
                                            </div>
                                            {if $snackyConfig.editSidebasket == 2}
                                            <div class="edit-item" id="edit_{$oPosition@iteration}">
                                                {if $oPosition->istKonfigVater()}
                                                    <div class="qty-wrapper modify">
                                                        <a class="btn btn-default configurepos btn-xs"
                                                            href="index.php?a={$oPosition->kArtikel}&ek={$smarty.foreach.positionen.index}">
                                                            {lang key="configure" section="global"}
                                                        </a>
                                                    </div>
                                                {else}
                                                    <div class="form-inline dpflex-j-end">
                                                        <div class="input-group" role="group">
                                                            <input name="anzahl[{$smarty.foreach.positionen.index}]" class="btn-group form-control quantity text-right" size="3" value="{$oPosition->nAnzahl}" />
                                                            {* if $oPosition->Artikel->cEinheit}
                                                                <span class="btn-group unit input-group-addon hidden-xs">{$oPosition->Artikel->cEinheit}</span>
                                                            {/if *}
                                                                <button type="submit" class="btn btn-default btn-xs" title="{lang key='refresh' section='checkout'}">
                                                                    <span class="img-ct icon">
                                                                        <svg>
                                                                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-refresh"></use>
                                                                        </svg>
                                                                                </span>
                                                                </button>
                                                        </div>
                                                    </div>
                                                {/if}
                                                <button type="submit" class="droppos btn btn-xs dpflex-a-center btn-flex btn-danger" name="dropPos" value="{$smarty.foreach.positionen.index}" title="{lang key="delete" section="global"}">
                                                    <span class="img-ct icon op1">
                                                        <svg class="icon-darkmode">
                                                            <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
                                                        </svg>
                                                    </span>
                                                </button>
                                            </div>
                                            {/if}
                                        </div>
                                    {/block}
                                {else}
                                   {block name='sidebasket-items-nichtwarenkorbartikel'}
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
                                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-info"></use>
                                                    </svg>
                                                </span>
                                            </button>
                                        </div>
                                    {/block}
                                {/if}
                            {/if}
                        {/foreach}
                    </form>
                    {include file="snippets/zonen.tpl" id="after_sidebasket_items" title="after_sidebasket_items"}
                {/block}
                {block name='sidebaket-price'}
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
                                <div class="panel w100">
                                    {lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL():$shippingCosts:$FavourableShipping->country->getName() key='shippingInformationSpecific' section='basket'}
                                </div>
                            </div>
                        {elseif empty($FavourableShipping) && empty($smarty.session.Versandart)}
                            <hr class="invisible hr-xs">
                            <div class="card small text-muted shipping-costs dpflex-j-between cols-sums">
                                <div class="panel w100">
                                    {lang|sprintf:$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() key='shippingInformation' section='basket'}
                                </div>
                            </div>
                        {/if}
                    {/if}
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
            <a href="{get_static_route id='warenkorb.php'}" class="btn btn-block{if $snackyConfig.shopBButton == 1} btn-primary btn-lg{/if}" title="{lang key='gotoBasket'}"> {lang key='gotoBasket'}</a>
            {if $snackyConfig.shopBButton == 0}
            <a href="{get_static_route id='bestellvorgang.php'}" class="btn btn-primary btn-block btn-lg">{lang key="checkout" section="basketpreview"}</a>
            {/if}
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