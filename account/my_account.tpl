{block name='account-my-account'}
<h1 class="mb-spacer mb-small">{lang key="hello"} {$smarty.session.Kunde->cVorname} {$smarty.session.Kunde->cNachname|entferneFehlerzeichen}</h1>
{if isset($smarty.get.reg)}
    <div class="alert alert-success">{lang key='accountCreated' section='global'}</div>
{/if}
{include file="snippets/zonen.tpl" id="after_account_page_headline" title="after_account_page_headline"}
<p>{lang key="myAccountDesc" section="login"}</p>

{block name="account-credit"}
<div class="alert alert-info credit-info">
    {lang key="yourMoneyOnAccount" section="login"}: {$Kunde->cGuthabenLocalized}
</div>
{/block}
<hr class="invisible">
{block name="my-orders-overview"}
<span class="h4 block">{lang key='myOrders'}</span>
<div class="card">
    <div class="card-body">
        {if count($Bestellungen) > 0}
            {block name='account-my-account-orders-body'}
                {foreach $Bestellungen as $order}
                {if $order@index === 5}{break}{/if}
                <a href="{$cCanonicalURL}?bestellung={$order->kBestellung}" class="dpflex-a-center item" title="{lang key='showOrder' section='login'}: {lang key='orderNo' section='login'} {$order->cBestellNr}">
                    <span class="w100">
                        <span class="row dpflex-a-center">
                            <span class="col-6">
                                <strong class="block">{lang key="order"}: {$order->cBestellNr}</strong>
                                <span class="block">{lang key="status"}: {$order->Status}</span>
                            </span>
                        <span class="text-muted small col-6">
                            <span class="block">{$order->dBestelldatum}</span> <span class="block">{$order->cBestellwertLocalized}</span></span>
                        </span>
                    </span>
                    <span class="img-ct icon icon-wt">
                        <svg>
                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#ar-right"></use>
                        </svg>
                    </span>
                </a>
                {/foreach}
                <a href="{$cCanonicalURL}?bestellungen=1" class="dpflex-a-center item" title="{lang key='showOrder' section='login'}: {lang key='orderNo' section='login'} {$order->cBestellNr}">
                    <strong class="w100">{lang key="showAll"}</strong>
                    <span class="img-ct icon icon-wt">
                        <svg>
                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#ar-right"></use>
                        </svg>
                    </span>
                </a>
            {/block}
        {else}
            {block name='account-my-account-orders-content-nodata'}
                {lang key='noOrdersYet' section='account data'}
            {/block}
        {/if}
    </div>
</div>
{/block}
<hr class="invisible">
{block name="my-personal-data"}
<span class="h4 block">{lang key="myPersonalData"}</span>
<div class="card">
    <div class="card-body">
        <a href="{$cCanonicalURL}?editRechnungsadresse=1" class="dpflex-a-center item">
            <span class="w100">
                <strong class="block">{lang key='billingAdress' section='account data'}</strong>
                <small class="text-muted">{$Kunde->cStrasse|entferneFehlerzeichen} {$Kunde->cHausnummer}, {$Kunde->cPLZ} {$Kunde->cOrt}, {$Kunde->cLand}</small>
            </span>
            <span class="img-ct icon icon-wt">
                <svg>
                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
                </svg>
            </span>
        </a>
        <a href="{$cCanonicalURL}?editRechnungsadresse=1" class="dpflex-a-center item">
            <span class="w100">
                <strong class="block">{lang key='contactInformation' section='account data'} {lang key='and'} {lang key='email' section='account data'}</strong>
                <small class="text-muted">{$Kunde->cMail}</small>
            </span>
            <span class="img-ct icon icon-wt">
                <svg>
                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
                </svg>
            </span>
        </a>
        <a class="dpflex-a-center item" href="{get_static_route id='jtl.php' params=['pass' => 1]}">
            <strong class="w100">{lang key="changePassword" section="login"}</strong>
            <span class="img-ct icon icon-wt">
                <svg>
                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
                </svg>
            </span>
        </a>
    </div>
</div>
{/block}
{block name="my-downloads"}
{include file='account/downloads.tpl'}
{/block}
<hr class="invisible hr-sm">
<div class="text-right">
    <a class="btn btn-danger" href="{get_static_route id='jtl.php' params=['del' => 1]}">
        {lang key="deleteAccount" section="login"}
    </a>
</div>
{/block}