{block name='snippets-wishlist'}
    {get_static_route id='wunschliste.php' assign='wishlistURL'}
    {block name="header"}
        {include file='layout/header.tpl'}
    {/block}
    {block name="content"}
        <div id="account" class="row">
            <div class="col-12 col-md-4 col-lg-3 al-wp">
                {include file="snippets/zonen.tpl" id="opc_before_menu"}
                <div class="panel mb-sm" id="account-list">
                    <div class="panel-heading">
                        <span class="panel-title h4 block">{lang key="myAccount"}</span>
                    </div>
                    <ul class="blanklist panel-body nav">
                        {block name="my-account-menu-list"}
                            {block name="my-account-menu-meinkonto"}
                            <li class="nav-it">
                                <a href="{get_static_route id='jtl.php'}" class="defaultlink flx-ac flx-jb{if $step === 'mein Konto'} active{/if}">
                                    {lang key="accountOverview" section="account data"}
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
                                {lang key="orders" section="account data"}
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
                                {lang key="billingAdress" section="account data"}
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
                                {lang key="myShippingAddresses" section="account data"}
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
                                    <strong>
                                        {lang key="wishlists" section="account data"}
                                    </strong>
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
                    <div class="panel-footer">
                         <a href="{get_static_route id='jtl.php' secure=true}?logout=1" title="{lang key='logOut'}" class="btn btn-block">{lang key='logOut'}</a>
                    </div>
                </div>
                {include file="snippets/zonen.tpl" id="opc_after_menu"}
                {block name="account-wishlist"}
                    <div class="panel wishlists">
                        <div class="h4 panel-title">
                            {block name="account-wishlist-title"}
                                {lang key="myWishlists"}
                            {/block}
                        </div>
                        {block name="account-wishlist-body"}
                            {if !empty($oWunschliste_arr[0]->kWunschliste)}
                                {foreach name=wunschlisten from=$oWunschliste_arr item=Wunschliste}
                                    <div class="flx-ac item">
                                        <div class="w100">
                                            <a href="{$wishlistURL}?wl={$Wunschliste->getID()}">
                                                <strong class="block">{$Wunschliste->getName()}</strong>
                                            </a>
                                            <span class="block text-muted small">{lang key="products"}: {$Wunschliste->productCount}</span>
                                        </div>
                                        <div class="text-right">
                                            <form method="post" action="{get_static_route id='jtl.php'}?wllist=1">
                                                <input type="hidden" name="wl" value="{$Wunschliste->getID()}"/>
                                                {$jtl_token}
                                                <span class="btn-group btn-group-sm">
                                                    <button class="btn-blank btn-sm btn flx-ac" name="wls" value="{$Wunschliste->getID()}" title="{lang key="wishlistStandard" section="login"}">
                                                        <span class="img-ct icon {if $Wunschliste->isDefault() !== true}inactive{else}active{/if}">
                                                            <svg>
                                                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-circle"></use>
                                                            </svg>
                                                        </span>
                                                    </button>
                                                    {if $Wunschliste->isPublic()}
                                                        <button type="submit" class="btn-blank btn-sm btn flx-ac" name="wlAction" value="setPrivate" title="{lang key='wishlistPrivat' section='login'}">
                                                            <span class="img-ct icon">
                                                                <svg>
                                                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-hide"></use>
                                                                </svg>
                                                            </span>
                                                        </button>
                                                    {/if}
                                                    {if !$Wunschliste->isPublic()}
                                                        <button type="submit" class="btn-blank btn-sm btn flx-ac" name="wlAction" value="setPublic" title="{lang key='wishlistNotPrivat' section='login'}">
                                                            <span class="img-ct icon">
                                                                <svg>
                                                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-show"></use>
                                                                </svg>
                                                            </span>
                                                        </button>
                                                    {/if}
                                                    <button type="submit" class="btn-blank btn-sm btn flx-ac" name="wllo" value="{$Wunschliste->getID()}" title="{lang key='wishlisteDelete' section='login'}">
                                                        <span class="img-ct icon">
                                                            <svg>
                                                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
                                                            </svg>
                                                        </span>
                                                    </button>
                                                </span>
                                            </form>
                                        </div>
                                    </div>
                                {/foreach}
                            {/if}
                            <form method="post" action="{$wishlistURL}" class="form form-inline">
                                <input type="hidden" name="kWunschliste" value="{$CWunschliste->getID()}"/>
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
                    <form method="post" action="{$wishlistURL}{if $CWunschliste->isDefault() !== true}?wl={$CWunschliste->getID()}{/if}" name="Wunschliste" class="wl-wp basket_wrapper{if $hasItems === true} top15{/if}">
                        {$jtl_token}
                        {block name="wishlist"}
                            <div class="flx-jb flx-ac mb-sm">
                                <h1 class="h2 m0">{$CWunschliste->getName()} {if $isCurrenctCustomer === false && $CWunschliste->getCustomer() !== null}<span class="block h4 m0 text-muted">{lang key="from" section="product rating" alt_section="login,productDetails,productOverview,global,"} {$CWunschliste->oKunde->cVorname}</span>{/if}</h1>
                                {if !isset($bAjaxRequest) || !$bAjaxRequest}
                                    <button type="submit" title="{lang key="wishlistUpdate" section="login"}" class="btn" name="action" value="update">
                                        <span class="-xs">{lang key="saveConfiguration" section="productDetails"}</span>
                                    </button>
                                {/if}
                            </div>
                            {include file='snippets/extension.tpl'}
                            <input type="hidden" name="wla" value="1"/>
                            <input type="hidden" name="kWunschliste" value="{$CWunschliste->getID()}"/>
                            {if $CWunschliste->isPublic() && !empty($cURLID)}
                                <input type="hidden" name="wlid" value="{$cURLID}" />
                            {/if}
                            {if !empty($wlsearch)}
                                <input type="hidden" name="wlsearch" value="1"/>
                                <input type="hidden" name="cSuche" value="{$wlsearch}"/>
                            {/if}
                            {if !empty($CWunschliste->getItems())}
                                <div class="row row-multi mb-xs">
                                    {foreach name=wunschlistepos from=$CWunschliste->getItems() item=CWunschlistePos}
                                        <div class="col-6 col-sm-4 col-md-6 col-lg-4{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-3{/if} wl-it">
                                            <div class="p-c">
                                                <div class="img-w">
                                                    <span class="img-ct">
                                                        <a href="{$CWunschlistePos->getProduct()->getURL()}">
                                                            {include file='snippets/image.tpl'
                                                                fluid=false
                                                                item=$CWunschlistePos->getProduct()
                                                                squareClass='first-wrapper'
                                                                srcSize='sm'
                                                                class="img-responsive"}
                                                        </a>
                                                    </span>
                                                </div>
                                                <div class="caption mb-xxs">
                                                    <a href="{$CWunschlistePos->getProduct()->getURL()}" class="h5 title">{$CWunschlistePos->getProductName()}</a>
                                                    {if $CWunschlistePos->getProduct()->getOption('nShowOnlyOnSEORequest', 0) === 1}
                                                        <p>{lang key='productOutOfStock' section='productDetails'}</p>
                                                    {elseif $CWunschlistePos->getProduct()->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
                                                        <p>{lang key='priceOnApplication' section='global'}</p>
                                                    {else}
                                                        {include file="productdetails/price.tpl" Artikel=$CWunschlistePos->getProduct() tplscope="wishlist"}
                                                    {/if}
                                                    {foreach name=eigenschaft from=$CWunschlistePos->getProperties() item=CWunschlistePosEigenschaft}
                                                        {if $CWunschlistePosEigenschaft->getFreeTextValue()}
                                                            <p>
                                                            <b>{$CWunschlistePosEigenschaft->getPropertyName()}:</b>
                                                            {$CWunschlistePosEigenschaft->getFreeTextValue()}{if $CWunschlistePos->getProperties()|@count > 1 && !$smarty.foreach.eigenschaft.last}</p>{/if}
                                                        {else}
                                                            <p>
                                                            <b>{$CWunschlistePosEigenschaft->getPropertyName()}:</b>
                                                            {$CWunschlistePosEigenschaft->cEigenschaftWertName}{if $CWunschlistePos->getProperties()|@count > 1 && !$smarty.foreach.eigenschaft.last}</p>{/if}
                                                        {/if}
                                                    {/foreach}
                                                </div>
                                                <textarea{if $isCurrenctCustomer !== true} readonly="readonly"{/if} class="form-control mb-xxs small" rows="4" name="Kommentar_{$CWunschlistePos->getID()}" placeholder="{lang key="yourNote"}">{$CWunschlistePos->cKommentar}</textarea>
                                                {if $CWunschlistePos->getProduct()->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === "N"}
                                                    <button name="remove" value="{$CWunschlistePos->getID()}"
                                                       class="close-btn"
                                                       title="{lang key="wishlistremoveItem" section="login"}">
                                                    </button>
                                                {else}
                                                    <div class="w100 btn-group">
                                                        <input{if $isCurrenctCustomer !== true} readonly="readonly"{/if}
                                                            type="{if $CWunschlistePos->getProduct()->cTeilbar === 'Y' && $CWunschlistePos->getProduct()->fAbnahmeintervall == 0}text{else}number{/if}"
                                                            name="Anzahl_{$CWunschlistePos->getID()}"
                                                            class="wunschliste_anzahl form-control text-right" type="text"
                                                            size="1"
                                                            min="{if $CWunschlistePos->getProduct()->fMindestbestellmenge}{$CWunschlistePos->getProduct()->fMindestbestellmenge}{else}0{/if}"
                                                            max="{$CWunschlistePos->getProduct()->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''}"
                                                            {if $CWunschlistePos->getProduct()->fAbnahmeintervall > 0}
                                                                step="{$CWunschlistePos->getProduct()->fAbnahmeintervall}"
                                                            {/if}
                                                            value="{$CWunschlistePos->fAnzahl}">
                                                        {if $CWunschlistePos->getProduct()->cEinheit}<span class="add btn btn-xs">{$CWunschlistePos->getProduct()->cEinheit}</span>{/if}
                                                        {if $CWunschlistePos->getProduct()->bHasKonfig}
                                                            <a href="{$CWunschlistePos->getProduct()->getURL()}" class="btn"
                                                               title="{lang key="product" section="global"}">
                                                                <span class="img-ct icon">
                                                                    <svg>
                                                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
                                                                    </svg>
                                                                </span>
                                                            </a>
                                                        {else}
                                                            <button name="addToCart" value="{$CWunschlistePos->getID()}"
                                                                class="btn btn-primary"
                                                                title="{lang key='wishlistaddToCart' section='login'}">
                                                                <span class="img-ct icon">
                                                                    <svg class="icon-darkmode">
                                                                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
                                                                    </svg>
                                                                </span>
                                                            </button>
                                                        {/if}
                                                    </div>
                                                    {if $isCurrenctCustomer === true}
                                                        <button name="remove" value="{$CWunschlistePos->getID()}"
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
                                        <div class="btn-group wl-ac flx-je">
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
                                        <a href="{$wishlistURL}" title="{lang key='goToWishlist'}" class="btn btn-primary btn-block">{lang key="goToWishlist"}</a>
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
                                    action="{$wishlistURL}{if $CWunschliste->isDefault() !== true}?wl={$CWunschliste->getID()}{/if}"
                                    name="Wunschliste"
                                }
                                    {block name='snippets-wishlist-form-content-rename'}
                                        {block name='snippets-wishlist-form-content-rename-inputs-hidden'}
                                            {input type="hidden" name="wla" value="1"}
                                            {input type="hidden" name="kWunschliste" value=$CWunschliste->getID()}
                                            {input type="hidden" name="action" value="update"}
                                        {/block}
                                        {block name='snippets-wishlist-form-content-rename-submit'}
                                            <div class="input-group form-group">
                                                {input id="wishlist-name" type="text" placeholder="name" name="WunschlisteName" value=$CWunschliste->getName()}
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
                            {if $CWunschliste->isPublic()}
                                <div class="mt-sm">
                                    <div class="h5 m0">{lang key="wishlistViaEmail" section="login"}</div>
                                    <form method="post" action="{$wishlistURL}">
                                        {$jtl_token}
                                        <input type="hidden" name="kWunschliste" value="{$CWunschliste->getID()}"/>
                                        <div class="form-group input-group">
                                            <input type="text" name="wishlist-url" readonly="readonly"
                                                   value="{$wishlistURL}?wlid={$CWunschliste->getURL()}"
                                                   class="form-control">
                                            <span class="input-group-btn pr">
                                                {if $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
                                                    <button type="submit" name="action" value="sendViaMail"
                                                            {if !$hasItems} disabled="disabled"{/if}
                                                            class="btn btn-default"
                                                            title="{lang key='wishlistViaEmail' section='login'}">
                                                       {lang key="wishlistSend" section="login"}
                                                   </button>
                                                {/if}
                                            </span>
                                        </div>
                                    </form>
                                </div>
                            {else}
                                <div class="alert alert-info">
                                    {lang key="wishlistNoticePrivate" section="login"}
                                </div>
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