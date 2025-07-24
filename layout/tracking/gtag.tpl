{block name='layout-gtag-tracking'}
    <script type="text/javascript">
        window.gtagDataLayer = window.gtagDataLayer || [];
        function gtag(){
            gtagDataLayer.push(arguments);
        }

        {if $snackyConfig.gads_analytics_consentmode == 'Y'}
            gtag('consent', 'default', {
                'ad_storage': 'denied',
                'analytics_storage': 'denied',
                'wait_for_update': 1500
            });
        {/if}

        gtag('js', new Date());
        {if !empty($snackyConfig.google_analytics_four|trim)}
            gtag( 'config', '{$snackyConfig.google_analytics_four|trim}');
            {if $nSeitenTyp == 33 && $Bestellung->Positionen|count > 0}
                gtag('set', 'user_data', {
                    'email': '{$Bestellung->oKunde->cMail}',
                });
            {/if}
        {/if}

        {if !empty($snackyConfig.google_ads|trim)}
            {if $snackyConfig.gads_enhanced_conversions == 'Y'}
                gtag( 'config', '{$snackyConfig.google_ads|trim}', {ldelim}'allow_enhanced_conversions':true{rdelim});
            {else}
                gtag( 'config', '{$snackyConfig.google_ads|trim}');
            {/if}

            {* Google Ads Conversion *}
            {if $nSeitenTyp == 33 && $Bestellung->Positionen|count > 0}
            gtag('event', 'conversion', {
                'send_to': '{$snackyConfig.google_ads|trim}/{$snackyConfig.google_ads_label|trim}',
                'value': {$Bestellung->fWarensummeNetto|number_format:2:".":""},
                'currency': '{$smarty.session.Waehrung->getCode()}'
                {if $snackyConfig.gads_enhanced_conversions == 'Y'}
                    ,'email': '{$Bestellung->oKunde->cMail}'
                {/if}
            });
            {/if}
        {/if}



        {if !empty($snackyConfig.google_analytics_four|trim)}

        {* Produt List View *}
        {if $nSeitenTyp == 2}
        {assign var="listName" value="unknown"}
        {if !isset($oNavigationsinfo)
        || (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory())}
            {assign var="listName" value=$Suchergebnisse->getSearchTermWrite()}
        {elseif $oNavigationsinfo->getName()}
            {assign var="listName" value=$oNavigationsinfo->getName()}
        {/if}
        gtag("event", "view_item_list", {
            item_list_name: "{$listName|escape}",
            items: [
                {foreach from=$Suchergebnisse->getProducts() item="prodid" name="prodid"}
                {if !$smarty.foreach.prodid.first},{/if}
                {
                    item_id: "{if $snackyConfig.artnr == "id"}{$prodid->kArtikel}{else}{$prodid->cArtNr|escape}{/if}",
                    item_name: "{$prodid->cName|escape}",
                    currency: "{$smarty.session.Waehrung->getCode()}",
                    price: {$prodid->Preise->fVKNetto|number_format:2:".":""},
                    item_category: "{$listName|escape}",
                    {if !empty($prodid->cHersteller)}
                    'item_brand': '{$prodid->cHersteller|escape}',
                    {/if}
                    quantity: 1
                }
                {/foreach}
            ]
        });
        {/if}

        {* Product Detail View *}
        {if $nSeitenTyp == 1}
        {assign var=i_kat value=($Brotnavi|@count)-2}
        {if $i_kat < 0}{assign var=i_kat value=0}{/if}
        gtag("event", "view_item", {
            currency: "{$smarty.session.Waehrung->getCode()}",
            value: {$Artikel->Preise->fVKNetto|number_format:2:".":""},
            items: [
                {
                    item_id: "{if $snackyConfig.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr|escape}{/if}",
                    item_name: "{$Artikel->cName|escape}",
                    currency: "{$smarty.session.Waehrung->getCode()}",
                    {if !empty($Artikel->cHersteller)}
                    item_brand: "{$Artikel->cHersteller|escape}",
                    {/if}
                    {if isset($Brotnavi[$i_kat])}
                    item_category: "{$Brotnavi[$i_kat]->getName()|escape}",
                    {/if}
                    price: {$Artikel->Preise->fVKNetto|number_format:2:".":""},
                    quantity: 1
                }
            ]
        });
        {/if}
        {* Add To cart *}
        {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
        {if isset($zuletztInWarenkorbGelegterArtikel)}
        {assign var=pushedArtikel value=$zuletztInWarenkorbGelegterArtikel}
        {else}
        {assign var=pushedArtikel value=$Artikel}
        {/if}
        {assign var=i_kat value=($Brotnavi|@count)-2}
        {if $i_kat < 0}{assign var=i_kat value=0}{/if}
        gtag("event", "add_to_cart", {
            currency: "{$smarty.session.Waehrung->getCode()}",
            value: {$pushedArtikel->Preise->fVKNetto|number_format:2:".":""},
            items: [
                {
                    item_id: "{if $snackyConfig.artnr == "id"}{$pushedArtikel->kArtikel}{else}{$pushedArtikel->cArtNr|escape}{/if}",
                    item_name: "{$pushedArtikel->cName|escape}",
                    currency: "{$smarty.session.Waehrung->getCode()}",
                    {if !empty($pushedArtikel->cHersteller)}
                    item_brand: "{$pushedArtikel->cHersteller|escape}",
                    {/if}
                    {if isset($Brotnavi[$i_kat])}
                    item_category: "{$Brotnavi[$i_kat]->getName()|escape}",
                    {/if}
                    price: {$pushedArtikel->Preise->fVKNetto|number_format:2:".":""},
                    quantity: {if $smarty.request.anzahl>0}{$smarty.request.anzahl}{else}1{/if}
                }
            ]
        });
        {/if}
        {* Begin Checkout *}
        {if !(isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt) && ($nSeitenTyp == 3 || ($nSeitenTyp == 11 && ($bestellschritt[1] == 1 || $bestellschritt[2] == 1)))}
        {assign var="activeStep" value=1}	{*Schritt 1 = Warenkorb, Checkout dann weiterführend: 2=Adresse,3=Zahlung,4=Übersicht *}
        {if $nSeitenTyp == 11}
        {if $bestellschritt[1] == 1 || $bestellschritt[2] == 1}
        {assign var="activeStep" value=2}
        {else if $bestellschritt[3] == 1 || $bestellschritt[4] == 1}
        {assign var="activeStep" value=3}
        {else if $bestellschritt[5] == 1}
        {assign var="activeStep" value=4}
        {/if}
        {/if}
        gtag("event", "{if $activeStep == 1 || $activeStep == 2}begin_checkout{elseif $activeStep==3}add_shipping_info{elseif $activeStep==4}add_payment_info{else}checkout_step_{$activeStep}{/if}", {
            currency: "{$smarty.session.Waehrung->getCode()}",
            value: {$Warensumme|number_format:2:".":""},
            items: [
                {foreach from=$smarty.session.Warenkorb->PositionenArr item="prodid" name="prodid"}
                {if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                {if !$smarty.foreach.prodid.first},{/if}
                {
                    item_id: "{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}",
                    item_name: "{$prodid->Artikel->cName|escape}",
                    currency: "{$smarty.session.Waehrung->getCode()}",
                    {if !empty($prodid->Artikel->cHersteller)}
                    item_brand: "{$prodid->Artikel->cHersteller|escape}",
                    {/if}
                    price: {$prodid->Artikel->Preise->fVKNetto|number_format:2:".":""},
                    quantity: {$prodid->nAnzahl}
                }
                {/if}
                {/foreach}
            ]
        });
        {/if}
        {* Purchase *}
        {if $nSeitenTyp == 33 && $Bestellung->Positionen|count > 0}
        {assign var="coupon" value=""}
        gtag("event", "purchase", {
            transaction_id: "{$Bestellung->cBestellNr}",
            value: {$Bestellung->fWarensummeNetto|number_format:2:".":""},
            tax: {$Bestellung->fSteuern|number_format:2:".":""},
            shipping: {$Bestellung->fVersandNetto|number_format:2:".":""},
            currency: "{$smarty.session.Waehrung->getCode()}",
            items: [
                {foreach from=$Bestellung->Positionen item="prodid" name="prodid"}
                {if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                {if !$smarty.foreach.prodid.first},{/if}
                {
                    item_id: "{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}",
                    item_name: "{$prodid->Artikel->cName|escape}",
                    {if !empty($prodid->Artikel->cHersteller)}
                    item_brand: "{$prodid->Artikel->cHersteller|escape}",
                    {/if}
                    price: {$prodid->Artikel->Preise->fVKNetto|number_format:2:".":""},
                    quantity: {$prodid->nAnzahl}
                }
                {elseif $prodid->nPosTyp==3}
                {assign var="coupon" value=$prodid->cName|escape}
                {/if}
                {/foreach}
            ]
            {if $coupon!=""}
            ,coupon: "{$coupon}"
            {/if}
        });
        {/if}
        {/if}

    </script>
{/block}