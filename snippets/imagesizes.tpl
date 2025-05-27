{assign var="categoryImgRatio" value="{$Einstellungen.bilder.bilder_kategorien_hoehe / $Einstellungen.bilder.bilder_kategorien_breite * 100}"}
{assign var="variationImgRatio" value="{$Einstellungen.bilder.bilder_variationen_hoehe / $Einstellungen.bilder.bilder_variationen_breite * 100}"}
{assign var="articleImgRatio" value="{$Einstellungen.bilder.bilder_artikel_normal_hoehe / $Einstellungen.bilder.bilder_artikel_normal_breite * 100}"}
{assign var="manufacturerImgRatio" value="{$Einstellungen.bilder.bilder_hersteller_normal_hoehe / $Einstellungen.bilder.bilder_hersteller_normal_breite * 100}"}
{assign var="merkmalImgRatio" value="{$Einstellungen.bilder.bilder_merkmal_normal_hoehe / $Einstellungen.bilder.bilder_merkmal_normal_breite * 100}"}
{assign var="merkmalwertImgRatio" value="{$Einstellungen.bilder.bilder_merkmalwert_normal_hoehe / $Einstellungen.bilder.bilder_merkmalwert_normal_breite * 100}"}
{assign var="blogImgRatio" value="{$Einstellungen.bilder.bilder_news_normal_hoehe / $Einstellungen.bilder.bilder_news_normal_breite * 100}"}
{assign var="blogCategoryImgRatio" value="{$Einstellungen.bilder.bilder_newskategorie_normal_hoehe / $Einstellungen.bilder.bilder_newskategorie_normal_breite * 100}"}

/* Categorys */
#cat-ul .img-ct:before, .sc-w .img-ct:before{ldelim}padding-top: {$categoryImgRatio|round:2}%{rdelim}
/* Variations */
.imgswatches .img-ct:before{ldelim}padding-top: {$variationImgRatio|round:2}%{rdelim}
/* Artikel */
.box-last-seen .img-ct:before, .ar-ct-m .ar-ct:before, .col-prd .img-ct:before, #product-configurator .img-ct:before, .p-c .img-ct:before, .product-gallery .img-ct:before, .cols-img .img-ct:before, .img-col .img-ct:before, .box-wishlist a:first-child .img-ct:before, .cpr-f .img-w .img-ct:before{ldelim}padding-top: {$articleImgRatio|round:2}%{rdelim}
/* Hersteller */
#cat-ul .mm-manu .img-ct:before, #manu-row .img-ct:before, #man-sl .img-ct:before, .img-manu.img-ct:before{ldelim}padding-top: {$manufacturerImgRatio|round:2}%;{rdelim}
/* Merkmale */
.box-filter-characteristics .img-ct:before{ldelim}padding-top: {$merkmalImgRatio|round:2}%{rdelim}
/* Merkmalwert */
.product-attributes .img-ct:before, .box-filter-characteristics ul .img-ct:before{ldelim}padding-top: {$merkmalwertImgRatio|round:2}%{rdelim}
/* Blog */
#nw-ct .img-ct.rt4x3:before, .pn-news .img-ct:before{ldelim}padding-top: {$blogImgRatio|round:2}%{rdelim}
/* Blog Kategorie*/
.blog-cat .img-ct:before{ldelim}padding-top: {$blogCategoryImgRatio|round:2}%{rdelim}