{*
{assign var="categoryImgRatio" value="{$Einstellungen.bilder.bilder_kategorien_hoehe / $Einstellungen.bilder.bilder_kategorien_breite * 100}"}
{assign var="variationImgRatio" value="{$Einstellungen.bilder.bilder_variationen_hoehe / $Einstellungen.bilder.bilder_variationen_breite * 100}"}
{assign var="articleImgRatio" value="{$Einstellungen.bilder.bilder_artikel_normal_hoehe / $Einstellungen.bilder.bilder_artikel_normal_breite * 100}"}
{assign var="manufacturerImgRatio" value="{$Einstellungen.bilder.bilder_hersteller_normal_hoehe / $Einstellungen.bilder.bilder_hersteller_normal_breite * 100}"}
{assign var="merkmalImgRatio" value="{$Einstellungen.bilder.bilder_merkmal_normal_hoehe / $Einstellungen.bilder.bilder_merkmal_normal_breite * 100}"}
{assign var="merkmalwertImgRatio" value="{$Einstellungen.bilder.bilder_merkmalwert_normal_hoehe / $Einstellungen.bilder.bilder_merkmalwert_normal_breite * 100}"}
{assign var="configroupImgRatio" value="{$Einstellungen.bilder.bilder_konfiggruppe_normal_hoehe / $Einstellungen.bilder.bilder_konfiggruppe_normal_breite * 100}"}
{assign var="blogImgRatio" value="{$Einstellungen.bilder.bilder_news_normal_hoehe / $Einstellungen.bilder.bilder_news_normal_breite * 100}"}
{assign var="blogCategoryImgRatio" value="{$Einstellungen.bilder.bilder_newskategorie_normal_hoehe / $Einstellungen.bilder.bilder_newskategorie_normal_breite * 100}"}

/* Categorys */
#cat-ul .img-ct:before, .sc-w .img-ct:before{ldelim}
padding-top: {$categoryImgRatio}%
{rdelim}

/* Variations */

/* Artikel */
.p-c .img-ct:before, .product-gallery .img-ct:before, .cols-img .img-ct:before, .img-col .img-ct:before, .box-wishlist a.img-ct:first-child:before, .cpr-f .img-w .img-ct:before{ldelim}
padding-top: {$articleImgRatio}%
{rdelim}

/* Hersteller */
.img-manu.img-ct:before{ldelim}
padding-top: {$manufacturerImgRatio}%
{rdelim}
*}