{block name='layout-header'}
    {block name='doctype'}<!DOCTYPE html>{/block}
<html {block name='html-attributes'}lang="{$meta_language}" id="snackys-tpl"{/block}>
    {block name="head"}
        <head>
            {block name="layout-header-head"}
                {block name='head-base'}{/block}
                {snackys_content id="html_head_start" title="html_head_start"}
            {if $snackyConfig.pwa == 'Y'}<link rel="manifest" href="manifest.json">{/if}

            {block name="head-ressources-polyfill"}
                <script nomodule src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/snackys/intersectionObserver.js"></script>
                <script nomodule src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/snackys/iefix.js"></script>
                <script nomodule src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/snackys/classList.js"></script>
                <script nomodule src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/snackys/object-keys-polyfill.js"></script>
            {/block}

            {block name="head-resources-jquery"}
            <link rel="preload" href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/jquery36-lazysizes.min.js" as="script">
            {if !empty($snackyConfig.svgLogo)}
            <link rel="preload" href="{$snackyConfig.svgLogo}" as="image">
                {else}
            <link rel="preload" href="{$ShopLogoURL}" as="image">
            {/if}

                <script>
                    window.lazySizesConfig = window.lazySizesConfig || {};
                    window.lazySizesConfig.expand  = 50;
                </script>
                {if !empty($snackyConfig.gtag|trim)}
                    {include file="layout/tracking/tagmanager.tpl"}
                {/if}
                {if !empty($snackyConfig.matomo|trim)}
                    {include file="layout/tracking/matomo.tpl"}
                {/if}
                {if !empty($snackyConfig.bing_ads|trim)}
                    {include file="layout/tracking/bing.tpl"}
                {/if}
                {if !empty($snackyConfig.google_ads|trim) || !empty($snackyConfig.google_analytics_four|trim)}
                    {include file="layout/tracking/gtag.tpl"}
                {/if}

                <script src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/jquery36-lazysizes.min.js"></script>
            {if $Einstellungen.template.general.use_minify === 'N'}
            {if isset($cPluginJsHead_arr)}
            {foreach $cPluginJsHead_arr as $cJS}
                <script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
            {/foreach}
            {/if}
            {foreach $cJS_arr as $cJS}
                <script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
            {/foreach}
                {* Ab in Footer damit (damit auch die Ressourcen erst später angefragt werden!
                    {foreach $cPluginJsBody_arr as $cJS}
                        <script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
                    {/foreach}
                *}
                {else}
            {if "jtl3.js"|array_key_exists:$minifiedJS && "plugin_js_head"|array_key_exists:$minifiedJS}
                <script defer src="{$ShopURL}/asset/jtl3.js,plugin_js_head?v={$nTemplateVersion}"></script>
                {else if "jtl3.js"|array_key_exists:$minifiedJS}
                <script defer src="{$ShopURL}/{$minifiedJS["jtl3.js"]}"></script>
            {/if}
            {foreach $minifiedJS as $key => $item}
            {if $key != "plugin_js_body" && $key != "jtl3.js" && $key != "plugin_js_head"}
                <script defer src="{$ShopURL}/{$item}" data-text="true"></script>
            {/if}
            {/foreach}
            {/if}

            {if !empty($oUploadSchema_arr)}
                {getUploaderLang iso=$smarty.session.currentLanguage->cISO639|default:'' assign='uploaderLang'}
                <script defer src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/fileinput/fileinput.min.js"></script>
                <script defer src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/fileinput/themes/fas/theme.min.js"></script>
                <script defer src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/fileinput/locales/{$uploaderLang}.js"></script>
            {/if}

                {assign var="customJSPath" value=$currentTemplateDir|cat:'/js/custom.js'}
            {if file_exists($customJSPath)}
                <script src="{$ShopURL}/{$customJSPath}?v={$nTemplateVersion}" type="text/javascript" defer></script>
            {/if}

            {/block}
            {block name="head-meta"}
            <meta http-equiv="content-type" content="text/html; charset={$smarty.const.JTL_CHARSET}">
            <meta name="description" content={block name='head-meta-description'}"{$meta_description|truncate:1000:'':true}{/block}">
                {* Keywords are deprecated! no use for search engines!
                   {if !empty($meta_keywords)}
                        <meta name="keywords" content="{block name='head-meta-keywords'}{$meta_keywords|truncate:255:'':true}{/block}">
                    {/if}
                *}
            <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">

                {if $nSeitenTyp==2 && $NaviFilter->getFilterCount() > $snackyConfig.filterIndexing}
                    {assign var="bNoIndex" value=true}
                {elseif $nSeitenTyp==2 && $NaviFilter->getFilterCount() >0}
                    {assign var="bNoIndex" value=false}
                {/if}
            <meta name="robots" content="{if $robotsContent}{$robotsContent}{elseif $bNoIndex === true  || (isset($Link) && $Link->getNoFollow() === true)}noindex{else}index, follow{/if}">

            <meta property="og:type" content="website" />
            <meta property="og:site_name" content="{$meta_title}" />
            <meta property="og:title" content="{$meta_title}" />
            <meta property="og:description" content="{$meta_description|truncate:1000:"":true}" />
            <meta property="og:url" content="{$cCanonicalURL}"/>

            {if $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && !empty($Artikel->Bilder)}
            <meta property="og:image" content="{$Artikel->Bilder[0]->cURLGross}">
                {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE
                && $oNavigationsinfo->getImageURL() !== 'gfx/keinBild.gif'
                && $oNavigationsinfo->getImageURL() !== 'gfx/keinBild_kl.gif'
                }
            <meta property="og:image" content="{$oNavigationsinfo->getImageURL()}" />
                {elseif $nSeitenTyp === $smarty.const.PAGE_NEWSDETAIL && !empty($newsItem->getPreviewImage())}
            <meta property="og:image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}" />
                {else}
            <meta property="og:image" content="{$ShopLogoURL}" />
            {/if}
            {/block}

                <title>{block name="head-title"}{$meta_title}{/block}</title>

            {if isset($Suchergebnisse) && $Suchergebnisse->getPages()->getMaxPage() > 1 && $snackyConfig.prevnext == 'Y'}
            {block name='layout-header-prev-next'}
            {if $Suchergebnisse->getPages()->getCurrentPage() > 1}
            <link rel="prev" href="{$filterPagination->getPrev()->getURL()}">
            {/if}
            {if $Suchergebnisse->getPages()->getCurrentPage() < $Suchergebnisse->getPages()->getMaxPage()}
            <link rel="next" href="{$filterPagination->getNext()->getURL()}">
            {/if}
            {/block}
            {/if}

            {block name="canonical"}
                {if $snackyConfig.listingCanonicalToFirst == 'Y' && $nSeitenTyp == 2 && $filterPagination->getPrev()->getPageNumber() > 0}
                    {foreach $filterPagination->getPages() as $page}
                        {if $page->getPageNumber() == 1}
                            {assign var="cCanonicalURL" value=$page->getURL()|replace:"_s1":""}
                        {/if}
                    {/foreach}
                {/if}
            {if !empty($cCanonicalURL)}
            <link rel="canonical" href="{$cCanonicalURL}">
            {/if}
            {/block}

            {block name="head-icons"}
            <link type="image/x-icon" href="{$shopFaviconURL}" rel="icon">
            {/block}

                {php}
                    Shop::Smarty()->assign("cssArray", array());
                {/php}
            {block name="head-resources"}

            {block name="opc-dependencies"}
                {getActiveOPCItems cAssign="opcItems"}
            {if is_array($opcItems)}
            {if "Gallery\Gallery"|in_array:$opcItems ||
            "ProductStream\ProductStream"|in_array:$opcItems}
            <link rel="stylesheet" href="{$ShopURL}/templates/Snackys/themes/base/slick.css?v={$nTemplateVersion}" type="text/css">
                <script src="{$ShopURL}/templates/Snackys/js/slick.min.js?v={$nTemplateVersion}" type="text/javascript" defer></script>
            {/if}
            {if "Gallery\Gallery"|in_array:$opcItems}
            <link rel="stylesheet" href="{$ShopURL}/templates/Snackys/themes/base/slick-lightbox.css?v={$nTemplateVersion}" type="text/css">
                <script src="{$ShopURL}/templates/Snackys/js/slick-lightbox.min.js?v={$nTemplateVersion}" type="text/javascript" defer></script>
            {/if}
            {if "ImageSlider\ImageSlider"|in_array:$opcItems}
            <link rel="stylesheet" href="{$ShopURL}/templates/Snackys/themes/base/jquery-slider.css?v={$nTemplateVersion}" type="text/css">
                <script src="{$ShopURL}/templates/Snackys/js/jquery.nivo.slider.pack.js?v={$nTemplateVersion}" type="text/javascript" defer></script>
            {/if}
            {/if}
            {/block}

            {if $snackyConfig.fontawesome == 'Y' || ($opc->isEditMode() === false && $opc->isPreviewMode() === false && \JTL\Shop::isAdmin(true))}
            <link rel="preload" href="{$ShopURL}/templates/Snackys/themes/base/fontawesome.css?v={$nTemplateVersion}" as="style" onload="this.onload=null;this.rel='stylesheet'">
            {/if}
            {if $snackyConfig.full_bootstrap == 'Y'}
            <link rel="preload" href="{$ShopURL}/templates/Snackys/themes/base/css/bootstrap/bootstrap_full.css?v={$nTemplateVersion}" as="style" onload="this.onload=null;this.rel='stylesheet'">
                <noscript>
                    <link href="{$ShopURL}/templates/Snackys/themes/base/css/bootstrap/bootstrap_full.css?v={$nTemplateVersion}" rel="stylesheet">
                </noscript>
            {/if}

                {assign var='hasMobileSlider' value='false'}
                {if $snackyConfig.fullscreenElement == 1 && $isMobile}
                    {if isset($oSlider) && count($oSlider->getSlides()) > 0}
                        {assign var='hasMobileSlider' value='true'}
                    {/if}
                {/if}

                {block name="css-per-settings"}
{if $snackyConfig.headerType == 1 && $nSeitenTyp !== 11}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-navcenter.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/search-toggle.css'}

{elseif $snackyConfig.headerType == 2 && $nSeitenTyp !== 11}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-light.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-light-mmenu.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/search-toggle.css'}

{elseif $snackyConfig.headerType == 3 && $nSeitenTyp !== 11}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-light.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/search-toggle.css'}

{elseif $snackyConfig.headerType == 4 && $nSeitenTyp !== 11}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-light.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-fullscreen.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/search-toggle.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/megamenu-fullscreen.css'}
{elseif $snackyConfig.headerType == 4.5 && $nSeitenTyp !== 11}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-light.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-fullscreen.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/search-toggle.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/megamenu-fullscreen.css'}

{elseif $snackyConfig.headerType == 5 && $nSeitenTyp !== 11}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-fullscreen.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/search-toggle.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-navcenter.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-navcenter-fullscreen.css'}

{elseif $snackyConfig.headerType == 5.5 && $nSeitenTyp !== 11}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-fullscreen.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/search-toggle.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-navcenter.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-navcenter-fullscreen.css'}

{elseif $snackyConfig.headerType == 6 && $nSeitenTyp !== 11}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-light.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-fullscreen.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/search-toggle.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/megamenu-fullscreen.css'}

{elseif $snackyConfig.headerType == 7 && $nSeitenTyp !== 11}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-navcenter.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/layout-ultralight.css'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/search-toggle.css'}

{else}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header_default.css'}
{/if}
{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 5 || $Einstellungen.template.theme.theme_default == 'darkmode' || ($isMobile && $snackyConfig.fullscreenElement == 1 && $hasMobileSlider == 'false' && ($snackyConfig.headerType == 4 || $snackyConfig.headerType == 5))}
{append var='cssArray' value='/templates/Snackys/themes/darkmode/css/header-darkmode.css'}
{/if}
{if $Einstellungen.template.theme.theme_default == 'darkmode'}
{append var='cssArray' value='/templates/Snackys/themes/darkmode/css/footer-darkmode.css'}
{/if}
{if $snackyConfig.designWidth == 1}
{append var='cssArray' value='/templates/Snackys/themes/base/css/config/boxlayout.css'}
{/if}
{if $snackyConfig.headerUsps != 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/usps.css'}
{/if}
{if $snackyConfig.headerPromo != 0 && !isset($smarty.session.km_promo)}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/promobar.css'}
{/if}
{if $snackyConfig.showTrusted == 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/config/trusted.css'}
{/if}
{if $snackyConfig.posTrusted == 0 && $snackyConfig.showTrusted == 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/config/trusted-left.css'}
{elseif $snackyConfig.posTrusted == 1 && $snackyConfig.showTrusted == 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/config/trusted-right.css'}
{/if}
{if $snackyConfig.paymentWall != 0 && !$isMobile}
{append var='cssArray' value='/templates/Snackys/themes/base/css/footer/payment-wall.css'}
{/if}
{if $isMobile}
{append var='cssArray' value='/templates/Snackys/themes/base/css/mobile.css'}
{else}
{append var='cssArray' value='/templates/Snackys/themes/base/css/elements/scrollbars.css'}
{/if}
{if $snackyConfig.manSlider == 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/index/manuslider.css'}
{/if}
{if $snackyConfig.sidepanelEverywhere == 'Y'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/listing/sidepanel.css'}
{elseif $nSeitenTyp === 2}
{append var='cssArray' value='/templates/Snackys/themes/base/css/listing/sidepanel.css'}
{/if}
{if $isMobile}
{append var='cssArray' value='/templates/Snackys/themes/base/css/listing/sidepanel-m.css'}
{/if}
{if (!empty($oUploadSchema_arr) && $nSeitenTyp === 3) || (!empty($oUploadSchema_arr) && $nSeitenTyp === 1)}
{append var='cssArray' value='/templates/Snackys/themes/base/css/details/fileupload.css'}
{/if}
{if $nSeitenTyp === 25}
{append var='cssArray' value='/templates/Snackys/themes/base/css/page/404.css'}
{/if}
{if isset($oSlider) && count($oSlider->getSlides()) > 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/elements/slider.css'}
{/if}
{if $snackyConfig.headerTopbar == 0 && !$isMobile}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/topbar.css'}
{/if}
{if $snackyConfig.headerTopbar == 0 && $isMobile && $snackyConfig.show_topbar_mobile == 1}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/topbar.css'}
{/if}
{if $snackyConfig.hover_productlist === 'Y' && !$isMobile && $nSeitenTyp == 2}
{append var='cssArray' value='/templates/Snackys/themes/base/css/listing/product-hover-jtl.css'}
{/if}
{if $snackyConfig.listShowCart != 1}
{append var='cssArray' value='/templates/Snackys/themes/base/css/listing/product-hover-km.css'}
{/if}
{if !empty($oAuswahlAssistent->kAuswahlAssistentGruppe) || isset($AWA)}
{append var='cssArray' value='/templates/Snackys/themes/base/css/elements/selectionwizard.css'}
{/if}
{if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern === 'Y' && isset($NavigationBlaettern) && $nSeitenTyp == 1 && !$isMobile}
{append var='cssArray' value='/templates/Snackys/themes/base/css/details/prevnext.css'}
{elseif $Einstellungen.artikeldetails.artikeldetails_navi_blaettern === 'Y' && isset($NavigationBlaettern) && $nSeitenTyp == 1 && $isMobile}
{append var='cssArray' value='/templates/Snackys/themes/base/css/details/prevnext_m.css'}
{/if}
{if $nSeitenTyp == 1}
{append var='cssArray' value='/templates/Snackys/themes/base/css/details/configurator.css'}
{/if}
{if $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen == 'N' || $isMobile}
{append var='cssArray' value='/templates/Snackys/themes/base/css/details/tabs-blank.css'}
{else}
{append var='cssArray' value='/templates/Snackys/themes/base/css/details/tabs-nav.css'}
{/if}
{if $snackyConfig.filterOpen == 1}
{append var='cssArray' value='/templates/Snackys/themes/base/css/listing/filter-left-collapse.css'}
{/if}
{if $snackyConfig.scrollSidebox == 'Y'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/listing/filter-left-scroll.css'}
{/if}
{if $snackyConfig.footerBoxesOpen == 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/footer/boxes-collapse.css'}
{/if}
{if $snackyConfig.roundProductImages == 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/elements/images-not-round.css'}
{/if}
{if $snackyConfig.roundButtons == 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/elements/buttons-not-round.css'}
{/if}
{if $snackyConfig.quantityButtons == '1'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/details/styled-quantity.css'}
{/if}
{if $snackyConfig.full_bootstrap == 'Y'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/config/override-fullbootstrap.css'}
{/if}
{if isset($oImageMap) || "Banner\Banner"|in_array:$opcItems}
{append var='cssArray' value='/templates/Snackys/themes/base/css/elements/banner.css'}
{/if}
{if $snackyConfig.dropdown_plus != 0}
{append var='cssArray' value='/templates/Snackys/themes/base/css/header/dropdown-plus.css'}
{/if}
{if $Einstellungen.bilder.container_verwenden == 'N'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/elements/images-contain.css'}
{/if}
{if \JTL\Shop::isAdmin(true)}
{append var='cssArray' value='/templates/Snackys/themes/base/css/elements/admin.css'}
{/if}
{if ((!empty($AktuelleKategorie->categoryFunctionAttributes['darstellung'])
&& $AktuelleKategorie->categoryFunctionAttributes['darstellung'] == 1)
|| (empty($AktuelleKategorie->categoryFunctionAttributes['darstellung'])
&& ((!empty($oErweiterteDarstellung->nDarstellung) && $oErweiterteDarstellung->nDarstellung == 1)
|| (empty($oErweiterteDarstellung->nDarstellung)
&& isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht)
&& $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht == 1))
)) && !$isMobile && $nSeitenTyp == '2'}
{append var='cssArray' value='/templates/Snackys/themes/base/css/elements/productlist.css'}
{/if}

                {/block}

            {if $opc->isEditMode() === false && $opc->isPreviewMode() === false && \JTL\Shop::isAdmin(true)}
            <link type="text/css" href="{$ShopURL}/admin/opc/css/startmenu.css" rel="stylesheet">
            {/if}
                {foreach $opcPageService->getCurPage()->getCssList($opc->isEditMode()) as $cssFile => $cssTrue}
                    {append var='cssArray' value=$cssFile|replace:$ShopURL:''}
                {/foreach}

                {block name="layout-header-head-css"}
                    {loadCSS css=$cssArray cPageType=$nSeitenTyp}
                    {* restliche CSS ans Seitenende gepackt layout/footer.tpl *}
                {/block}

                {* RSS *}
            {if isset($Einstellungen.rss.rss_nutzen) && $Einstellungen.rss.rss_nutzen === 'Y'}
            <link rel="alternate" type="application/rss+xml" title="Newsfeed {$Einstellungen.global.global_shopname}" href="{$ShopURL}/rss.xml">
            {/if}
                {* Languages *}
            {block name="layout-header-hreflang"}
            {if !empty($smarty.session.Sprachen) && count($smarty.session.Sprachen) > 1}
            {foreach $smarty.session.Sprachen as $language}
            <link rel="alternate"
                  hreflang="{$language->getIso639()}"
                  href="{if $language->getShopDefault() === 'Y' && isset($Link) && $Link->getLinkType() === $smarty.const.LINKTYP_STARTSEITE}{$ShopURL}/{else}{$language->getUrl()}{/if}">
            {/foreach}
            {/if}
            {/block}



            {/block}

            {if !empty($snackyConfig.backgroundcolor) && $snackyConfig.backgroundcolor|strlen > 1}
                <style>
                    body { background-color: {$snackyConfig.backgroundcolor}!important; }
                </style>
            {/if}
            {block name="layout-header-theme-color"}
            <meta name="theme-color" content="{if !empty($snackyConfig.themecolor)}{$snackyConfig.themecolor}{else}{$snackyConfig.css_brand}{/if}">
            {/block}
            {if !empty($snackyConfig.appleTouchIcon)}<link rel="apple-touch-icon" href="{$snackyConfig.appleTouchIcon}"/>{/if}
            {if !empty($snackyConfig.pwa_icon192) && $snackyConfig.pwa == 'Y'}<link rel="icon" sizes="192x192" href="{$snackyConfig.pwa_icon192}">{/if}
                {if !empty($snackyConfig.pwa_icon512) && $snackyConfig.pwa == 'Y'}<link rel="icon" sizes="512x512" href="{$snackyConfig.pwa_icon512}">{/if}

                {$additionalHeadTags}
                {$dbgBarHead}
                {snackys_content id="html_head_end" title="html_head_end"}
            {/block}
        </head>
    {/block}

    {assign var="isFluidContent" value=false}
    {if $nSeitenTyp == 11}
        {assign var="step3_active" value=($bestellschritt[5] == 1)}
    {/if}
    {if isset($snackyConfig.pagelayout) && $snackyConfig.pagelayout === 'fluid' && isset($Link) && $Link->getIsFluid()}
        {assign var="isFluidContent" value=true}
    {/if}
    {has_boxes position='left' assign='hasLeftPanel'}
{block name="body-tag"}
{strip}
<body data-headtype="{$snackyConfig.headerType}" data-page="{$nSeitenTyp}" class="
body-offcanvas{if isset($bSeiteNichtGefunden) && $bSeiteNichtGefunden} error404{/if}{if empty($snackyConfig.youtubeID) && $nSeitenTyp == 18} no-yt{/if}{if $snackyConfig.headerUsps != 0} usps-visible{/if}
{if $Einstellungen.template.theme.theme_default == darkmode} darkmode{/if}{if $snackyConfig.designWidth == 1} boxed-layout{/if}
{if $snackyConfig.boxedMargin == 1} bxt-nm{/if}{if $snackyConfig.boxedBorder == 1} bxt-nb{/if}
{if $snackyConfig.fwSlider == 1 && $nSeitenTyp == 18} boxed-slider{/if}
{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5} full-head{/if}
{if $snackyConfig.productBorder == 1} product-border{/if}
{if $isMobile} mobile{/if}
{if $isTablet} tablet{/if}
{if !empty($hinweis)}{if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt} basked-added sidebasket-open{/if}{/if}
{if $snackyConfig.sidepanelEverywhere == 'Y'} sidebar-overall{/if}
{if $snackyConfig.mmenu_link_clickable == 'N'} mmlca-n{/if}
{if  isset($step3_active) && $step3_active} no-pd{/if}
{if $isMobile} mobile{/if}
"
        {if isset($maintenance) && $maintenance && !empty($snackyConfig.maintenanceBG)} style="background: url({$snackyConfig.maintenanceBG})no-repeat center center/cover;"{/if}
        {if isset($Link) && !empty($Link->getIdentifier())} id="{$Link->getIdentifier()}"{/if}
        {if !empty($snackyConfig.boxedImg) && $snackyConfig.designWidth == 1} style="background: url({$snackyConfig.boxedImg})no-repeat center center/cover;{if !$isMobile} background-attachment: fixed{/if}"{/if}
>
{/strip}
    {snackys_content id="html_body_start" title="html_body_start"}
{/block}
{if $snackyConfig.designWidth == 1}
<div id="bxt-w">
{/if}
    {include file=$opcDir|cat:'tpl/startmenu.tpl'}
{block name="main-wrapper-starttag"}
{if isset($smallversion) && $smallversion}
    <div id="main-wrapper" class="main-wrapper{if $bExclusive} exclusive{/if}{if isset($snackyConfig.pagelayout) && $snackyConfig.pagelayout === 'boxed'} boxed{else} fluid{/if}{if $hasLeftPanel} aside-active{/if}">
{/if}
{/block}
    {if !$bExclusive}
        {if $bAdminWartungsmodus === true}
            <div id="maintenance-mode" class="navbar navbar-inverse">
                <div class="container">
                    <div class="navbar-text text-center">
                        {lang key="adminMaintenanceMode" section="global"}
                    </div>
                </div>
            </div>
        {/if}

        {if ($snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5) && $nSeitenTyp === 18}
            {if !$isMobile || ($isMobile && $snackyConfig.fullscreenElement != 1) || ($isMobile && $snackyConfig.fullscreenElement == 1 && $hasMobileSlider == 'true')}
                <div id="km-fw" class="mb-lg">
            {/if}
        {/if}

        {block name="header-promo"}
            {if $snackyConfig.headerPromo != 0 && $nSeitenTyp !== 11 && !isset($smarty.session.km_promo)}
                {include file="layout/header_promo.tpl"}
            {/if}
        {/block}

        {block name="header-usps"}
            {if $snackyConfig.headerUsps != 0 && $nSeitenTyp !== 11 && !$isMobile}
                {include file="layout/header_usps.tpl"}
            {/if}
        {/block}
        {block name="header-branding-top-bar"}
            {if (!isset($smallversion) || !$smallversion) && (!isset($maintenance) || !$maintenance)}
                {if $snackyConfig.headerTopbar == 0 || ($isMobile && $snackyConfig.show_topbar_mobile == 1)}
                    <div id="top-bar-wrapper"{if $snackyConfig.show_topbar_mobile == 0} class="hidden-xs"{/if}>
                        <div id="top-bar" class="dpflex-j-between dpflex-a-center small mw-container">
                            {include file="layout/header_top_bar.tpl"}
                        </div>
                    </div>
                {/if}
            {/if}
        {/block}
        {if $smarty.const.SAFE_MODE === true}
            <div id="safe-mode" class="navbar navbar-inverse">
                <div class="container">
                    <div class="navbar-text text-center">
                        {lang key='safeModeActive' section='global'}
                    </div>
                </div>
            </div>
        {/if}
        {block name="header"}
            {if (!isset($smallversion) || !$smallversion) && (!isset($maintenance) || !$maintenance)}
                {if $snackyConfig.headerType == 1  && $nSeitenTyp !== 11}
                    {include file="layout/header/1.tpl"}
                {else if $snackyConfig.headerType == 2 || $snackyConfig.headerType == 3 && $nSeitenTyp !== 11}
                    {include file="layout/header/2.tpl"}
                {else if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6 && $nSeitenTyp !== 11}
                    {include file="layout/header/4-5.tpl"}
                {else if $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5 && $nSeitenTyp !== 11}
                    {include file="layout/header/1.tpl"}
                {else if $snackyConfig.headerType == 7  && $nSeitenTyp !== 11}
                    {include file="layout/header/1.tpl"}
                {else}
                    {include file="layout/header/default.tpl"}
                {/if}
            {elseif isset($smallversion) && $smallversion}
                <div id="shop-nav">
                    <div class="mw-container dpflex-a-center dpflex-wrap">
                        <div class="col-6 col-lg-4 xs-order-1">
                            <a href="{get_static_route id='warenkorb.php'}" title="{lang key="backToBasket" section="checkout"}" class="visible-xs pr">
							<span class="img-ct icon">
								<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
								  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-logout"></use>
								</svg>
							</span>
                            </a>
                            <a href="{get_static_route id='warenkorb.php'}" title="{lang key="backToBasket" section="checkout"}" class="btn text-muted hidden-xs">{lang key="backToBasket" section="checkout"}</a>
                        </div>
                        <div class="col-6 col-lg-4" id="logo">
                            {block name="logo"}
                                <a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="pr">
                                    {if !empty($snackyConfig.svgLogo)}
                                        <img src="{$snackyConfig.svgLogo}" alt="{$Einstellungen.global.global_shopname}">
                                    {else}
                                        {if isset($ShopLogoURL)}
                                            {image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive"}
                                        {else}
                                            <span class="h2">{$Einstellungen.global.global_shopname}</span>
                                        {/if}
                                    {/if}
                                </a>
                            {/block}
                        </div>
                        {block name="header-branding-shop-nav"}
                        {/block}
                    </div>
                </div>
            {/if}
        {/block}
        {include file="snippets/zonen.tpl" id="after_mainmenu"}

        {if ($snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5) && $nSeitenTyp === 18}
            {if !$isMobile || ($isMobile && $snackyConfig.fullscreenElement != 1) || ($isMobile && $snackyConfig.fullscreenElement == 1 && $hasMobileSlider == 'true')}
                {include file="snippets/extension-fullscreen.tpl"}
                </div>
            {/if}
        {/if}
        {if $nSeitenTyp === 18 && ((isset($oSlider) && count($oSlider->getSlides()) > 0) || isset($oImageMap) || !empty($snackyConfig.youtubeID))}
            {include file="snippets/extension.tpl"}
        {/if}
    {/if}
{block name="content-all-starttags"}

    {if $nSeitenTyp === 2}
        <div class="pl-heading mb-md">
            <div class="mw-container">
                {block name="productlist-header"}
                    {if !isset($hasFilters)}{assign var="hasFilters" value=false}{/if}
                    {include file='productlist/header.tpl' hasFilters=$hasFilters}
                {/block}
            </div>
        </div>
    {/if}

{block name="content-wrapper-starttag"}
    <div id="content-wrapper" class="mw-container">
{/block}

    {block name="content-container-starttag"}
    {/block}

    {block name="content-container-block-starttag"}
    {/block}

    {block name="product-pagination"}
        {if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern === 'Y' && isset($NavigationBlaettern)}
            <div class="visible-lg product-pagination next">
                {if isset($NavigationBlaettern->naechsterArtikel) && $NavigationBlaettern->naechsterArtikel->kArtikel}<a href="{$NavigationBlaettern->naechsterArtikel->cURLFull}" title="{$NavigationBlaettern->naechsterArtikel->cName}"></a>{/if}
            </div>
            <div class="visible-lg product-pagination previous">
                {if isset($NavigationBlaettern->vorherigerArtikel) && $NavigationBlaettern->vorherigerArtikel->kArtikel}<a href="{$NavigationBlaettern->vorherigerArtikel->cURLFull}" title="{$NavigationBlaettern->vorherigerArtikel->cName}"></a>{/if}
            </div>
        {/if}
    {/block}


    {if !$bExclusive && !empty($boxes.left|strip_tags|trim) && $nSeitenTyp == 2}
        {assign var="hasFilters" value="true"}
    {else}
        {assign var="hasFilters" value=false}
    {/if}
{block name="content-row-starttag"}
    <div class="row row-ct{if $nSeitenTyp === 2 && $hasFilters} dpflex-j-between ct-mw dpflex-a-s{/if}">
{/block}
{block name="content-starttag"}

    <div id="content" class="col-12">
    {include file='snippets/alert_list.tpl'}
    {include file="snippets/zonen.tpl" id="before_content" title="before_content"}
{/block}

    {block name="header-bc"}
    {/block}
{/block}{* /content-all-starttags *}
{/block}