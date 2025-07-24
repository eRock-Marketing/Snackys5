{block name='snippets-wishlist'}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
<div id="account" class="row">
    <div class="col-12 col-md-4 col-lg-3 al-wp">
        {include file="snippets/zonen.tpl" id="opc_before_menu"}
        <div class="panel mb-spacer mb-small" id="account-list">
            <div class="panel-heading">
                <span class="panel-title h4 block">{lang key="myAccount"}</span>
            </div>
            <ul class="blanklist panel-body nav">
                <li class="nav-it">
                    <a href="{get_static_route id='jtl.php'}" class="defaultlink dpflex-a-center dpflex-j-between{if $step === 'mein Konto'} active{/if}">
                        {lang key="accountOverview" section="account data"}
                        <span class="img-ct icon icon-wt ic-md">
                            <svg>
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-user"></use>
                            </svg>
                        </span>
                    </a>
                </li>
                <li class="nav-it">
                    <a href="{get_static_route id='jtl.php' params=['bestellungen' => 1]}" class="defaultlink dpflex-a-center dpflex-j-between{if $step === 'bestellung' || $step === 'bestellungen'} active{/if}">
                    {lang key="orders" section="account data"}
                        <span class="img-ct icon icon-wt ic-md">
                            <svg>
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
                            </svg>
                        </span>
                    </a>
                </li>
                <li class="nav-it">
                    <a href="{get_static_route id='jtl.php' params=['editRechnungsadresse' => 1]}" class="defaultlink dpflex-a-center dpflex-j-between{if $step === 'rechnungsdaten'} active{/if}">
                    {lang key="addresses" section="account data"}
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
                        <strong>{lang key="wishlists" section="account data"}</strong>
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
                        {lang key='allRatings'}
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
        {block name="account-wishlist"}
                        <div class="panel wishlists">
                        <div class="h4 panel-title">{block name="account-wishlist-title"}{lang key="myWishlists"}{/block}</div>
                        {block name="account-wishlist-body"}
                            {if !empty($oWunschliste_arr[0]->kWunschliste)}
                                    {foreach name=wunschlisten from=$oWunschliste_arr item=Wunschliste}
                                        <div class="dpflex-a-center item">
                                            <div class="w100">
                                                <a href="{get_static_route id='wunschliste.php'}?wl={$Wunschliste->kWunschliste}"><strong class="block">{$Wunschliste->cName}</strong></a>
                                                <span class="block text-muted small">{lang key="products"}: {$Wunschliste->productCount}</span>
                                            </div>
                                            <td class="text-right">
                                                <form method="post" action="{get_static_route id='jtl.php'}?wllist=1">
                                                    <input type="hidden" name="wl" value="{$Wunschliste->kWunschliste}"/>
                                                    {$jtl_token}
                                                    <span class="btn-group btn-group-sm">
                                                        <button class="btn-blank btn-sm btn dpflex-a-center" name="wls" value="{$Wunschliste->kWunschliste}" title="{lang key="wishlistStandard" section="login"}">
                                                            <span class="img-ct icon {if $Wunschliste->nStandard != 1}inactive{else}active{/if}">
                                                                <svg>
                                                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-circle"></use>
                                                                </svg>
                                                            </span>
                                                        </button>
                                                        {if $Wunschliste->nOeffentlich == 1}
                                                            <button type="submit" class="btn-blank btn-sm btn dpflex-a-center" name="wlAction" value="setPrivate" title="{lang key="wishlistPrivat" section="login"}">
                                                                <span class="img-ct icon">
                                                                    <svg>
                                                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-hide"></use>
                                                                    </svg>
                                                                </span>
                                                            </button>
                                                        {/if}
                                                        {if $Wunschliste->nOeffentlich == 0}
                                                            <button type="submit" class="btn-blank btn-sm btn dpflex-a-center" name="wlAction" value="setPublic" title="{lang key="wishlistNotPrivat" section="login"}">
                                                                <span class="img-ct icon">
                                                                    <svg>
                                                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-show"></use>
                                                                    </svg>
                                                                </span>
                                                            </button>
                                                        {/if}
                                                        <button type="submit" class="btn-blank btn-sm btn dpflex-a-center" name="wllo" value="{$Wunschliste->kWunschliste}" title="{lang key='wishlisteDelete' section='login'}">
                                                            <span class="img-ct icon">
                                                                <svg>
                                                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
                                                                </svg>
                                                            </span>
                                                        </button>
                                                    </span>
                                                </form>
                                            </td>
                                        </div>
                                    {/foreach}
                            {/if}
                            <form method="post" action="{get_static_route id='wunschliste.php'}" class="form form-inline">
                                <input type="hidden" name="kWunschliste" value="{$CWunschliste->kWunschliste}"/>
                                {$jtl_token}
                                <div class="input-group">
                                    <input name="cWunschlisteName" type="text" class="form-control input-sm" placeholder="{lang key="wishlistAddNew" section="login"}" size="25" />
                                    <span class="input-group-btn">
                                        <button type="submit" class="btn btn-default btn-sm" name="action" value="createNew">{lang key="wishlistSaveNew" section="login"}</button>
                                    </span>
                                </div>
                            </form>
                        {/block}
                        </div>
                    {/block}
    </div>
    <div class="col-12 col-md-8 col-lg-9">
        {if $step === 'wunschliste versenden' && $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
            {include file='account/wishlist_email_form.tpl'}
        {else}
            <form method="post" action="{get_static_route id='wunschliste.php'}{if $CWunschliste->nStandard != 1}?wl={$CWunschliste->kWunschliste}{/if}" name="Wunschliste" class="wl-wp basket_wrapper{if $hasItems === true} top15{/if}">
                {$jtl_token}
                {block name="wishlist"}
                <div class="dpflex-j-between dpflex-a-c mb-sm">
                    <h1 class="h2 m0">{$CWunschliste->cName} {if $isCurrenctCustomer === false && isset($CWunschliste->oKunde->cVorname)}<span class="block h4 m0 text-muted">{lang key="from" section="product rating" alt_section="login,productDetails,productOverview,global,"} {$CWunschliste->oKunde->cVorname}</span>{/if}</h1>
                    {if !isset($bAjaxRequest) || !$bAjaxRequest}
                    <button type="submit" title="{lang key="wishlistUpdate" section="login"}" class="btn" name="action" value="update">
                        <span class="-xs">{lang key="saveConfiguration" section="productDetails"}</span>
                    </button>
                    {/if}
                </div>
                    {include file='snippets/extension.tpl'}
                    <input type="hidden" name="wla" value="1"/>
                    <input type="hidden" name="kWunschliste" value="{$CWunschliste->kWunschliste}"/>
                    {if $CWunschliste->nOeffentlich == 1 && !empty($cURLID)}
                        <input type="hidden" name="wlid" value="{$cURLID}" />
                    {/if}
                    {if !empty($wlsearch)}
                        <input type="hidden" name="wlsearch" value="1"/>
                        <input type="hidden" name="cSuche" value="{$wlsearch}"/>
                    {/if}
                    {if !empty($CWunschliste->CWunschlistePos_arr)}
                        <div class="row row-multi mb-spacer mb-xs">
                            {foreach name=wunschlistepos from=$CWunschliste->CWunschlistePos_arr item=CWunschlistePos}
                                <div class="col-6 col-sm-4 col-md-6 col-lg-4{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-3{/if} wl-it">
                                    <div class="p-c">
                                        <div class="img-w">
                                            <span class="img-ct">
                                                <a href="{$CWunschlistePos->Artikel->cURLFull}">
                                                    {include file='snippets/image.tpl'
                                                        fluid=false
                                                        item=$CWunschlistePos->Artikel
                                                        squareClass='first-wrapper'
                                                        srcSize='sm'
                                                        class="img-responsive"}
                                                </a>
                                            </span>
                                        </div>
                                        <div class="caption mb-xxs">
                                            <a href="{$CWunschlistePos->Artikel->cURL}" class="h5 title">{$CWunschlistePos->cArtikelName}</a>
                                            {if $CWunschlistePos->Artikel->getOption('nShowOnlyOnSEORequest', 0) === 1}
                                                <p>{lang key='productOutOfStock' section='productDetails'}</p>
                                            {elseif $CWunschlistePos->Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
                                                <p>{lang key='priceOnApplication' section='global'}</p>
                                            {else}
                                                {include file="productdetails/price.tpl" Artikel=$CWunschlistePos->Artikel tplscope="wishlist"}
                                            {/if}
                                            {foreach name=eigenschaft from=$CWunschlistePos->CWunschlistePosEigenschaft_arr item=CWunschlistePosEigenschaft}
                                                {if $CWunschlistePosEigenschaft->cFreifeldWert}
                                                    <p>
                                                    <b>{$CWunschlistePosEigenschaft->cEigenschaftName}:</b>
                                                    {$CWunschlistePosEigenschaft->cFreifeldWert}{if $CWunschlistePos->CWunschlistePosEigenschaft_arr|@count > 1 && !$smarty.foreach.eigenschaft.last}</p>{/if}
                                                {else}
                                                    <p>
                                                    <b>{$CWunschlistePosEigenschaft->cEigenschaftName}:</b>
                                                    {$CWunschlistePosEigenschaft->cEigenschaftWertName}{if $CWunschlistePos->CWunschlistePosEigenschaft_arr|@count > 1 && !$smarty.foreach.eigenschaft.last}</p>{/if}
                                                {/if}
                                            {/foreach}
                                        </div>
                                        <textarea{if $isCurrenctCustomer !== true} readonly="readonly"{/if} class="form-control mb-xxs small" rows="4" name="Kommentar_{$CWunschlistePos->kWunschlistePos}" placeholder="{lang key="yourNote"}">{$CWunschlistePos->cKommentar}</textarea>

                                    {if $CWunschlistePos->Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === "N"}
                                        
                                                    <button name="remove" value="{$CWunschlistePos->kWunschlistePos}"
                                                       class="close-btn"
                                                       title="{lang key="wishlistremoveItem" section="login"}">
                                                    </button>
                                    {else}
                                        <div class="w100 btn-group">
                                        <input{if $isCurrenctCustomer !== true} readonly="readonly"{/if}
                                                    type="{if $CWunschlistePos->Artikel->cTeilbar === 'Y' && $CWunschlistePos->Artikel->fAbnahmeintervall == 0}text{else}number{/if}"
                                                    name="Anzahl_{$CWunschlistePos->kWunschlistePos}"
                                                    class="wunschliste_anzahl form-control text-right" type="text"
                                                    size="1"
                                                    min="{if $CWunschlistePos->Artikel->fMindestbestellmenge}{$CWunschlistePos->Artikel->fMindestbestellmenge}{else}0{/if}"
                                                    max="{$CWunschlistePos->Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''}"
                                                    {if $CWunschlistePos->Artikel->fAbnahmeintervall > 0}
                                                        step="{$CWunschlistePos->Artikel->fAbnahmeintervall}"
                                                    {/if}
                                                    value="{$CWunschlistePos->fAnzahl}">
                                                {if $CWunschlistePos->Artikel->cEinheit}<span class="add btn btn-xs">{$CWunschlistePos->Artikel->cEinheit}</span>{/if}
                                                {if $CWunschlistePos->Artikel->bHasKonfig}
                                                    <a href="{$CWunschlistePos->Artikel->cURLFull}" class="btn"
                                                       title="{lang key="product" section="global"}">
                                                        <span class="img-ct icon">
                                                            <svg>
                                                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-edit"></use>
                                                            </svg>
                                                        </span>
                                                    </a>
                                                {else}
                                                    <button name="addToCart" value="{$CWunschlistePos->kWunschlistePos}"
                                                            class="btn btn-primary"
                                                            title="{lang key="wishlistaddToCart" section="login"}">
                                                        <span class="img-ct icon">
                                                            <svg class="icon-darkmode">
                                                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
                                                            </svg>
                                                        </span>
                                                    </button>
                                                {/if}
                                            </div>
                                                {if $isCurrenctCustomer === true}
                                                    <button name="remove" value="{$CWunschlistePos->kWunschlistePos}"
                                                       class="close-btn"
                                                       title="{lang key="wishlistremoveItem" section="login"}">
                                                    </button>
                                                {/if}
                                    {/if}
                                    </div>
                                </div>
                            {/foreach}
                       </div>
                        {block name="wishlist-actions-block"}
                        {if !isset($bAjaxRequest) || !$bAjaxRequest}
                        <div class="btn-group wl-ac dpflex-j-end">
                            {if $isCurrenctCustomer === true}
                                <button class="btn submit" name="action" value="addAllToCart">
                                    <span class="-xs">{lang key="wishlistAddAllToCart" section="login"}</span>
                                </button>
                                <button class="btn submit" name="action" value="removeAll">
                                    <span class="-xs">{lang key="wishlistDelAll" section="login"}</span>
                                </button>
                            {/if}
                        </div>
                            {else}
                            <a href="{get_static_route id='wunschliste.php'}" title="{lang key="goToWishlist"}" class="btn btn-primary btn-block">{lang key="goToWishlist"}</a>
                            {/if}
                        {/block}
                    {else}
                        <div class="alert alert-info">{lang key="noEntriesAvailable" section="global"}</div>
                    {/if}
                {/block}
            </form>
            {if $isCurrenctCustomer === true && (!isset($bAjaxRequest) || !$bAjaxRequest)}
                {block name='snippets-wishlist-form-rename'}
                    {block name='snippets-wishlist-form-rename-hr-top'}
                    {/block}
                    <div id="edit-wishlist-name" visible=false class="mb-xs mt-md">
                        <span class="h5 block m0">{lang key='rename'}</span>
                        {form
                            method="post"
                            action="{get_static_route id='wunschliste.php'}{if $CWunschliste->nStandard != 1}?wl={$CWunschliste->kWunschliste}{/if}"
                            name="Wunschliste"
                        }
                        {block name='snippets-wishlist-form-content-rename'}
                            {block name='snippets-wishlist-form-content-rename-inputs-hidden'}
                                {input type="hidden" name="wla" value="1"}
                                {input type="hidden" name="kWunschliste" value=$CWunschliste->kWunschliste}
                                {input type="hidden" name="action" value="update"}
                            {/block}
                            {block name='snippets-wishlist-form-content-rename-submit'}
                                <div class="input-group form-group">
                                    {input id="wishlist-name" type="text" placeholder="name" name="WunschlisteName" value=$CWunschliste->cName}
                                    <div class="input-group-btn">
                                        {input type="submit" value="{lang key="saveConfiguration" section="productDetails"}" class="btn btn-block"}
                                    </div>
                                </div>
                            {/block}
                        {/block}
                        {/form}
                    </div>  
                {/block}
                {block name="wishlist-body"}
                    {if $CWunschliste->nOeffentlich == 1}
                        <div class="mt-sm">
                            <div class="h5 m0">{lang key="wishlistViaEmail" section="login"}</div>
                            <form method="post" action="{get_static_route id='wunschliste.php'}">
                                {$jtl_token}
                                <input type="hidden" name="kWunschliste" value="{$CWunschliste->kWunschliste}"/>
                                <div class="form-group input-group">
                                    <input type="text" name="wishlist-url" readonly="readonly"
                                           value="{get_static_route id='wunschliste.php'}?wlid={$CWunschliste->cURLID}"
                                           class="form-control">
                                    <span class="input-group-btn pr">
                                        {if $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
                                            <button type="submit" name="action" value="sendViaMail"
                                                    {if !$hasItems} disabled="disabled"{/if}
                                                    class="btn btn-default"
                                                    title="{lang key="wishlistViaEmail" section="login"}">
                                               {lang key="wishlistSend" section="login"}
                                           </button>
                                        {/if}
                                    </span>
                                </div>
                            </form>
                        </div>
                    {else}
                        <div class="alert alert-info">
                        {lang key="wishlistNoticePrivate" section="login"}&nbsp;</div>
                    {/if}
                {/block}
            {/if}
        {/if}
        </div>
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}