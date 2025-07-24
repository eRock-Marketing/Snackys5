{block name='account-index'}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
{include file="snippets/extension.tpl"}
	
    {if (isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1)}
	<div class="modal-dialog modal-lg">
		<div class="modal-content">   
			<div class="modal-header"><h4 class="modal-title">{lang key="basket" section="global"}</h4></div> 
			<section class="tmp-modal-content">
				<div class="modal-body">
					{lang key="basket2PersMerge" section="login"}<div class="answer"><a href="{get_static_route id='bestellvorgang.php'}?basket2Pers=1&token={$smarty.session.jtl_token}">{lang key="yes" section="global"}</a><a href="javascript:void();" class="x">{lang key="no" section="global"}</a></div>
				</div>
			</section>
		</div>
	</div>
    {/if}
    
    {if !isset($showLoginPanel)}
        {$showLoginPanel = true}
    {/if}
    {if $step === 'login' || (isset($editRechnungsadresse) && $editRechnungsadresse)}
        {$showLoginPanel = false}
    {/if}
	
    {include file="snippets/zonen.tpl" id="opc_before_account"}
    <div id="account" class="row">
        
        {if $showLoginPanel}
            <div class="col-12 col-md-4 col-lg-3 al-wp">
				{include file="snippets/zonen.tpl" id="opc_before_menu"}
                <div class="panel{if $step === 'bestellung'} mb-spacer mb-small{/if}" id="account-list">
                    <div class="panel-heading">
                        <span class="panel-title h4 block">{lang key="myAccount"}</span>
                    </div>
                    <ul class="blanklist panel-body nav">
                        <li class="nav-it">
                            <a href="{get_static_route id='jtl.php'}" class="defaultlink dpflex-a-center dpflex-j-between{if $step === 'mein Konto'} active{/if}">
                            {if $step === 'mein Konto'}<strong>{/if}
                                {lang key="accountOverview" section="account data"}
                            {if $step === 'mein Konto'}</strong>{/if}
                                <span class="img-ct icon icon-wt ic-md">
                                    <svg>
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-user"></use>
                                    </svg>
                                </span>
                            </a>
                        </li>
                        <li class="nav-it">
                            <a href="{get_static_route id='jtl.php' params=['bestellungen' => 1]}" class="defaultlink dpflex-a-center dpflex-j-between{if $step === 'bestellung' || $step === 'bestellungen'} active{/if}">
                            {if $step === 'bestellung' || $step === 'bestellungen'}<strong>{/if}
                            {lang key="orders" section="account data"}
                            {if $step === 'bestellung' || $step === 'bestellungen'}</strong>{/if}
                                <span class="img-ct icon icon-wt ic-md">
                                    <svg>
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
                                    </svg>
                                </span>
                            </a>
                        </li>
                        <li class="nav-it">
                            <a href="{get_static_route id='jtl.php' params=['editRechnungsadresse' => 1]}" class="defaultlink dpflex-a-center dpflex-j-between{if $step === 'rechnungsdaten'} active{/if}">
                            {if $step === 'rechnungsdaten'}<strong>{/if}
                            {lang key="addresses" section="account data"}
                            {if $step === 'rechnungsdaten'}</strong>{/if}
                                <span class="img-ct icon icon-wt ic-md">
                                    <svg>
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-house"></use>
                                    </svg>
                                </span>
                            </a>
                        </li>
                        {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
                            <li class="nav-it">
                                <a href="{get_static_route id='jtl.php' params=['wllist' => 1]}" class="defaultlink dpflex-a-center dpflex-j-between{if $step|substr:0:11 === 'wunschliste'} active{/if}">
                                {if $step|substr:0:11 === 'wunschliste'}<strong>{/if}
                                {lang key="wishlists" section="account data"}
                                {if $step|substr:0:11 === 'wunschliste'}</strong>{/if}
                                <span class="img-ct icon icon-wt ic-md">
                                    <svg>
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-heart"></use>
                                    </svg>
                                </span>
                                </a>
                            </li>
                        {/if}	
                        {if $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y' && !empty($smarty.session.Vergleichsliste->oArtikel_arr) && $smarty.session.Vergleichsliste->oArtikel_arr|count > 0}
                            <li class="nav-it">
                                <a href="{get_static_route id='vergleichsliste.php'}" class="dpflex-a-center dpflex-j-between nav-it defaultlink">
                                    {lang key="compare" sektion="global"}
                                    <span class="img-ct icon icon icon-wt ic-md">
                                        <svg>
                                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-compare"></use>
                                        </svg>
                                    </span>
                                </a>
                            </li>
                        {/if}
                        <li class="nav-it">
                            <a href="{get_static_route id='jtl.php' params=['bewertungen' => 1]}" class="defaultlink dpflex-a-center dpflex-j-between{if $step === 'bewertungen'} active{/if}">
                                {if $step === 'bewertungen'}<strong>{/if}
                                {lang key='allRatings'}
                                {if $step === 'bewertungen'}</strong>{/if}
                                <span class="img-ct icon icon-wt ic-md">
                                    <svg>
                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-reviews"></use>
                                    </svg>
                                </span>
                            </a>
                        </li>
                    </ul>
                    <div class="panel-footer">
			             <a href="{get_static_route id='jtl.php' secure=true}?logout=1" title="{lang key='logOut'}" class="btn btn-block">{lang key='logOut'}</a>
                    </div>
                </div>
				{include file="snippets/zonen.tpl" id="opc_after_menu"}
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
    
        <div class="col-12{if $showLoginPanel} col-md-8 col-lg-9{/if}">
            {if $showLoginPanel}
                {include file="snippets/zonen.tpl" id="opc_before_account_page"}
            {/if}
            {if $step === 'login'}
                {include file='account/login.tpl'}
            {elseif $step === 'mein Konto'}
                {include file='account/my_account.tpl'}
            {elseif $step === 'rechnungsdaten'}
                {include file='account/address_form.tpl'}
            {elseif $step === 'passwort aendern'}
                {include file='account/change_password.tpl'}
            {elseif $step === 'bestellung'}
                <div id="order-details">
                    {include file='account/order_details.tpl'}
                </div>
            {elseif $step === 'bestellungen'}
                {include file='account/orders.tpl'}
            {elseif $step === 'account loeschen'}
                {include file='account/delete_account.tpl'}
            {elseif $step === 'wunschliste'}
                {include file='account/wishlists.tpl'}
            {elseif $step === 'kunden_werben_kunden'}
                {include file='account/customers_recruiting.tpl'}
            {elseif $step === 'bewertungen'}
                {include file='account/feedback.tpl'}
            {/if}
            {if $showLoginPanel}
                {include file="snippets/zonen.tpl" id="opc_after_account_page"}
            {/if}
        </div>
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}