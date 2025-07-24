{block name='layout-gtagmanager-tracking'}
	<script type="text/javascript">
		window.dataLayer = window.dataLayer || [];
        function gtag(){
            dataLayer.push(arguments);
        }
		{if $Einstellungen.consentmanager.consent_manager_active === 'Y'}
		//Consent Data
		gtag('consent', 'default', {
			'ad_storage': 'denied',
			'analytics_storage': 'denied',
			'ad_user_data': 'denied',
			'ad_personalization': 'denied',
			'wait_for_update': 1500
		});
		{/if}
	</script>
	<script>
	(function(w,d,s,l,i){ldelim}w[l]=w[l]||[];w[l].push({ldelim}'gtm.start':
	new Date().getTime(),event:'gtm.js'{rdelim});var f=d.getElementsByTagName(s)[0],
	j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
	'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
	{rdelim})(window,document,'script','dataLayer','{$snackyConfig.gtag|trim}');
	</script>
	<script type="text/javascript">
		{* Google Ads Conversion / Remarketing & Basic Google Analytics Purchase *}
		dataLayer.push({ldelim}
			{if $nSeitenTyp == 18}
			{* Startseite *}
			ecomm_prodid: '',
			ecomm_pagetype: 'home',
			ecomm_totalvalue: 0.00
			{elseif $nSeitenTyp == 1}
			{* Artikel *}
			ecomm_prodid: '{if $snackyConfig.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr|escape}{/if}',
			ecomm_pagetype: 'product',
			ecomm_totalvalue: {$Artikel->Preise->fVKNetto|number_format:2:".":""}
			{elseif $nSeitenTyp == 2 && $NaviFilter->hasSearchFilter()}
			{* Suche *}
			ecomm_prodid: [{foreach from=$Suchergebnisse->getProducts() item="prodid" name="prodid"}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->cArtNr}"{/foreach}],
			ecomm_pagetype: 'searchresults',
			ecomm_totalvalue: [{foreach from=$Suchergebnisse->getProducts() item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->Preise->fVKNetto|number_format:2:".":""}{/foreach}]
			{elseif $nSeitenTyp == 2}
			{* Artikelliste *}
			ecomm_prodid: [{foreach from=$Suchergebnisse->getProducts() item="prodid" name="prodid"}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->cArtNr}"{/foreach}],
			ecomm_pagetype: 'category',
			ecomm_totalvalue: [{foreach from=$Suchergebnisse->getProducts() item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->Preise->fVKNetto|number_format:2:".":""}{/foreach}]
			{elseif $nSeitenTyp == 33 && $Bestellung->Positionen|count > 0}
			{* Bestellbestätigung *}
			ecomm_prodid: [{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}{if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->Artikel->cArtNr}"{/if}{/foreach}],
			ecomm_pagetype: 'purchase',
			ecomm_totalvalue: [{foreach from=$Bestellung->Positionen item="totalvalue" name="totalvalue"}{if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->fPreis|number_format:2:".":""}{/if}{/foreach}],
			transactionTotal: {$Bestellung->fWarensummeNetto|number_format:2:".":""},
			transactionId: '{$Bestellung->cBestellNr}',
			transactionProducts: [{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}
				{if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
				{if !$smarty.foreach.prodid.first},{/if}
				{
					sku: '{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}',
					name: '{$prodid->Artikel->cName|escape}',
					price: {$prodid->fPreis|number_format:2:".":""},
					quantity: {$prodid->nAnzahl}
				}
				{/if}
				{/foreach}],
			transactionShipping: {$Bestellung->fVersandNetto|number_format:2:".":""},
			transactionTax: {$Bestellung->fSteuern|number_format:2:".":""}
			{elseif $nSeitenTyp == 3}
			{* Warenkorb *}
			ecomm_prodid: [{foreach from=$smarty.session.Warenkorb->PositionenArr item="Artikel" name="prodid"}{if !$smarty.foreach.prodid.first},{/if}"{if $snackyConfig.artnr == "id"}{$Artikel->Artikel->kArtikel}{else}{$Artikel->Artikel->cArtNr|escape}{/if}"{/foreach}],
			ecomm_pagetype: 'cart',
			ecomm_totalvalue: [{foreach from=$smarty.session.Warenkorb->PositionenArr item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->fPreis|number_format:2:".":""}{/foreach}]
			{else}
			{* Content *}
			ecomm_prodid: '',
			ecomm_pagetype: 'other',
			ecomm_totalvalue: 0.00
			{/if}
			{rdelim});
		{* Erweitertes Google Analytics eCommerce *}

		{* Produt List View *}
		{if $nSeitenTyp == 2}
		{assign var="listName" value="unknown"}
		{if !isset($oNavigationsinfo)
	|| (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory())}
		{assign var="listName" value=$Suchergebnisse->getSearchTermWrite()}
		{elseif $oNavigationsinfo->getName()}
		{assign var="listName" value=$oNavigationsinfo->getName()}
		{/if}
		dataLayer.push({ ecommerce: null });
		dataLayer.push({
			'event': 'view_item_list',
			'ecommerce': {
				'currencyCode': '{$smarty.session.Waehrung->getCode()}',
				'impressions': [
					{foreach from=$Suchergebnisse->getProducts() item="prodid" name="prodid"}
					{if !$smarty.foreach.prodid.first},{/if}
					{
						'name': '{$prodid->cName|escape}',       // Name or ID is required.
						'id': '{if $snackyConfig.artnr == "id"}{$prodid->kArtikel}{else}{$prodid->cArtNr|escape}{/if}',
						'price': {$prodid->Preise->fVKNetto|number_format:2:".":""},
						{if !empty($prodid->cHersteller)}
						'brand': '{$prodid->cHersteller|escape}',
						{/if}
						'category': '{$listName|escape}',
						'quantity': '1'
					}
					{/foreach}
				]
			}
		});
		{/if}
		{* Product Detail View *}
		{if $nSeitenTyp == 1}
		{assign var=i_kat value=($Brotnavi|@count)-2}
		{if $i_kat < 0}{assign var=i_kat value=0}{/if}
		dataLayer.push({ ecommerce: null });
		dataLayer.push({
			'event': 'view_item',
			'ecommerce': {
				'detail': [{
					'name': '{$Artikel->cName|escape}', // Name or ID is required.
					'id': '{if $snackyConfig.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr|escape}{/if}',
					'price': {$Artikel->Preise->fVKNetto|number_format:2:".":""},
					{if !empty($Artikel->cHersteller)}
					'brand': '{$Artikel->cHersteller|escape}',
					{/if}
					{if isset($Brotnavi[$i_kat])}
					'category': '{$Brotnavi[$i_kat]->getName()|escape}',
					{/if}
					'quantity': '1'
				}]
			}
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
		dataLayer.push({ ecommerce: null });
		dataLayer.push({
			'event': 'add_to_cart',
			'ecommerce': {
				'add': {
					'currencyCode': '{$smarty.session.Waehrung->getCode()}',
					'products': [{
						'name': '{$pushedArtikel->cName|escape}', // Name or ID is required.
						'id': '{if $snackyConfig.artnr == "id"}{$pushedArtikel->kArtikel}{else}{$pushedArtikel->cArtNr|escape}{/if}',
						'price': {$pushedArtikel->Preise->fVKNetto|number_format:2:".":""},
						{if !empty($pushedArtikel->cHersteller)}
						'brand': '{$pushedArtikel->cHersteller|escape}',
						{/if}
						{if isset($Brotnavi[$i_kat])}
						'category': '{$Brotnavi[$i_kat]->getName()|escape}',
						{/if}
						'quantity': '{if $smarty.request.anzahl>0}{$smarty.request.anzahl}{else}1{/if}'
					}]
				}
			}
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

		dataLayer.push({ ecommerce: null });
		dataLayer.push({
			'event': 'checkout',
			'ecommerce': {
				'checkout': {
					'actionField': {
						'step': {$activeStep}
					},
					'products': [
						{foreach from=$smarty.session.Warenkorb->PositionenArr item="prodid" name="prodid"}
						{if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
						{if !$smarty.foreach.prodid.first},{/if}
						{
							'name': '{$prodid->Artikel->cName|escape}',       // Name or ID is required.
							'id': '{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}',
							'price': {$prodid->fPreis|number_format:2:".":""},
							{if !empty($prodid->Artikel->cHersteller)}
							'brand': '{$prodid->Artikel->cHersteller|escape}',
							{/if}
							'quantity': {$prodid->nAnzahl}
						}
						{/if}
						{/foreach}
					]
				}
			}
		});
		{/if}
		{* Purchase *}
		{if $nSeitenTyp == 33 && $Bestellung->Positionen|count > 0}
		dataLayer.push({ ecommerce: null });
		{assign var="coupon" value=""}
		dataLayer.push({
			'event': 'purchase',
			'ecommerce': {
				'purchase': {
					'products': [
						{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}
						{if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
						{if !$smarty.foreach.prodid.first},{/if}
						{
							'name': '{$prodid->Artikel->cName|escape}',       // Name or ID is required.
							'id': '{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}',
							'price': {$prodid->fPreis|number_format:2:".":""},
							{if !empty($prodid->Artikel->cHersteller)}
							'brand': '{$prodid->Artikel->cHersteller|escape}',
							{/if}
							'quantity': {$prodid->nAnzahl}
						}
						{elseif $prodid->nPosTyp==3}
						{assign var="coupon" value=$prodid->cName|escape}
						{/if}
						{/foreach}
					],
					'actionField': {
						'id': '{$Bestellung->cBestellNr}',                         // Transaction ID. Required for purchases and refunds.
						'revenue': '{$Bestellung->fWarensummeNetto|number_format:2:".":""}',                     // Total transaction value (incl. tax and shipping)
						'tax':'{$Bestellung->fSteuern|number_format:2:".":""}',
						'shipping': '{$Bestellung->fVersandNetto|number_format:2:".":""}',
						'currency': '{$smarty.session.Waehrung->getCode()}'
						{if $coupon!=""}
						,'coupon': '{$coupon}'
						{/if}
					}
				}
			}
		});
		{/if}
	</script>
{/block}