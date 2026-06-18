{block name='layout-gtagmanager-tracking'}
	<script>
		{block name='layout-gtagmanager-tracking-basics'}
			window.dataLayer = window.dataLayer || [];
			function gtag(){
				dataLayer.push(arguments);
			}
		{/block}
		{block name='layout-gtagmanager-tracking-consent'}
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
		{/block}
		{block name='layout-gtagmanager-tracking-basics'}
		{* Google Ads Conversion / Remarketing & Basic Google Analytics Purchase *}
			dataLayer.push({ldelim}
				{if $nSeitenTyp == 18}
				{* Startseite *}
				ecomm_prodid: '',
				ecomm_pagetype: 'home',
				page_type: 'home',
				ecomm_totalvalue: 0.00
				{elseif $nSeitenTyp == 1}
				{* Artikel *}
				ecomm_prodid: '{if $snackyConfig.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr|escape}{/if}',
				ecomm_pagetype: 'product',
				page_type: 'product',
				ecomm_totalvalue: {$Artikel->Preise->fVKNetto|number_format:2:".":""}
				{elseif $nSeitenTyp == 2 && $NaviFilter->hasSearchFilter()}
				{* Suche *}
				ecomm_prodid: [{foreach from=$Suchergebnisse->getProducts() item="prodid" name="prodid"}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->cArtNr}"{/foreach}],
				ecomm_pagetype: 'searchresults',
				page_type: 'searchresults',
				ecomm_totalvalue: [{foreach from=$Suchergebnisse->getProducts() item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->Preise->fVKNetto|number_format:2:".":""}{/foreach}]
				{elseif $nSeitenTyp == 2}
				{* Artikelliste *}
				ecomm_prodid: [{foreach from=$Suchergebnisse->getProducts() item="prodid" name="prodid"}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->cArtNr}"{/foreach}],
				ecomm_pagetype: 'category',
				page_type: 'category',
				ecomm_totalvalue: [{foreach from=$Suchergebnisse->getProducts() item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->Preise->fVKNetto|number_format:2:".":""}{/foreach}]
				{elseif $nSeitenTyp == 33 && $Bestellung->Positionen !== null && $Bestellung->Positionen|count > 0}
				{* Bestellbestätigung *}
				ecomm_prodid: [{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}{if $prodid->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}{if !$smarty.foreach.prodid.first},{/if}"{$prodid->Artikel->cArtNr}"{/if}{/foreach}],
				ecomm_pagetype: 'purchase',
				page_type: 'purchase',
				ecomm_totalvalue: [{foreach from=$Bestellung->Positionen item="totalvalue" name="totalvalue"}{if $prodid->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->fPreis|number_format:2:".":""}{/if}{/foreach}],
				transactionTotal: {$Bestellung->fWarensummeNetto|number_format:2:".":""},
				transactionId: '{$Bestellung->cBestellNr}',
				transactionProducts: [{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}
					{if $prodid->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}
					{if !$smarty.foreach.prodid.first},{/if}
					{
						sku: '{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}',
						name: '{getTrackingName article=$prodid->Artikel }',
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
				page_type: 'cart',
				ecomm_totalvalue: [{foreach from=$smarty.session.Warenkorb->PositionenArr item="totalvalue" name="totalvalue"}{if !$smarty.foreach.totalvalue.first},{/if}{$totalvalue->fPreis|number_format:2:".":""}{/foreach}]
				{else}
				{* Content *}
				ecomm_prodid: '',
				ecomm_pagetype: 'other',
				page_type: 'other',
				ecomm_totalvalue: 0.00
				{/if}
				{* now user hashed data sending *}
				,
				event_name: 'page_view',
				{if JTL\Session\Frontend::getCustomer()->getID() > 0}
				sha256_email_address: '{hashEmail}',
				user_id: {JTL\Session\Frontend::getCustomer()->getID()},
				{/if}
				logged_in: {if JTL\Session\Frontend::getCustomer()->getID() === 0}false{else}true{/if}
			{rdelim});
		{/block}
		{block name='layout-gtagmanager-tracking-advanced'}
			{* Erweitertes Google Analytics eCommerce *}

			{* Produt List View *}
			{if $nSeitenTyp == 2}
				{assign var="listName" value="unknown"}
				{if !isset($oNavigationsinfo) || (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory())}
				{assign var="listName" value=$Suchergebnisse->getSearchTermWrite()}
				{elseif $oNavigationsinfo->getName()}
				{assign var="listName" value=$oNavigationsinfo->getName()}
				{/if}
				dataLayer.push({ ecommerce: null });
				dataLayer.push({
					'event': 'view_item_list',
					'ecommerce': {
						'currency': '{$smarty.session.Waehrung->getCode()}',
						'item_list_name': '{$listName|escape}',
						{if $oNavigationsinfo->getCategory()}
							'item_list_id': '{$oNavigationsinfo->getCategory()->getID()}',
						{/if}
						'items': [
							{foreach from=$Suchergebnisse->getProducts() item="prodid" name="prodid"}
							{if !$smarty.foreach.prodid.first},{/if}
							{
								'item_name': '{getTrackingName article=$prodid }',
								'item_id': '{if $snackyConfig.artnr == "id"}{$prodid->kArtikel}{else}{$prodid->cArtNr|escape}{/if}',
								'price': {$prodid->Preise->fVKNetto|number_format:2:".":""},
								{if !empty($prodid->cHersteller)}
								'brand': '{$prodid->cHersteller|escape}',
								'item_brand': '{$prodid->cHersteller|escape}',
								{/if}
								{getTrackingCategory article=$prodid}
								'quantity': 1
							}
							{/foreach}
						]
					}
				});
				
				//select_item
				document.addEventListener('click', function (event) {
					const link = event.target.closest('.p-w a');
					if (!link) {
						return;
					}
					const href = link.getAttribute('href');
					if (!href || href === '#') {
						return;
					}
					const productBox = link.closest('.p-w');
					if (!productBox) {
						return;
					}
					const jsonElement = productBox.querySelector('.json-article-data');
					if (!jsonElement) {
						return;
					}
					const jsonText = jsonElement.textContent;
					if (!jsonText) {
						return;
					}
					let item;
					try {
						item = JSON.parse(jsonText.replace(/'/g, '"'));
					} catch (error) {
						console.error('Ungültiges Produkt-JSON', error);
						return;
					}

					window.dataLayer = window.dataLayer || [];
					window.dataLayer.push({ ecommerce: null });
					window.dataLayer.push({
						event: 'select_item',
						item_list_name: '{$listName|escape}',
						{if $oNavigationsinfo->getCategory()}
						item_list_id: '{$oNavigationsinfo->getCategory()->getID()}',
						{/if}
						ecommerce: {
							currency: '{$smarty.session.Waehrung->getCode()}',
							value: item.price || 0,
							items: [item]
						}
					});
				});
			{/if}
			
			{* Product Detail View *}
			{if $nSeitenTyp == 1 && !isset($bWarenkorbHinzugefuegt)}
				{assign var=i_kat value=($Brotnavi|@count)-2}
				{if $i_kat < 0}{assign var=i_kat value=0}{/if}
				dataLayer.push({ ecommerce: null });
				dataLayer.push({
					'event': 'view_item',
					'currency': '{$smarty.session.Waehrung->getCode()}',
					'value': {$Artikel->Preise->fVKNetto|number_format:2:".":""},
					'ecommerce': {
						'items': [{
							'item_name': '{getTrackingName article=$Artikel }', 
							'item_id': '{if $snackyConfig.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr|escape}{/if}',
							'price': {$Artikel->Preise->fVKNetto|number_format:2:".":""},
							{if !empty($Artikel->cHersteller)}
							'brand': '{$Artikel->cHersteller|escape}',
							'item_brand': '{$Artikel->cHersteller|escape}',
							{/if}
							{getTrackingCategory article=$Artikel}
							'quantity': 1
						}]
					}
				});
				
				//Wishlist
				document.addEventListener('click', function (event) {
					const link = event.target.closest('#wl-action');
					if (!link) {
						return;
					}
					const productBox = link.closest('#buy_form');
					if (!productBox) {
						return;
					}
					const jsonElement = productBox.querySelector('.json-article-data');
					if (!jsonElement) {
						return;
					}
					const jsonText = jsonElement.textContent;
					if (!jsonText) {
						return;
					}
					let item;
					try {
						item = JSON.parse(jsonText.replace(/'/g, '"'));
					} catch (error) {
						console.error('Ungültiges Produkt-JSON', error);
						return;
					}

					window.dataLayer = window.dataLayer || [];
					window.dataLayer.push({ ecommerce: null });
					window.dataLayer.push({
						event: 'add_to_wishlist',
						ecommerce: {
							currency: '{$smarty.session.Waehrung->getCode()}',
							value: item.price || 0,
							items: [item]
						}
					});
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
						'currency': '{$smarty.session.Waehrung->getCode()}',
						'value': {$pushedArtikel->Preise->fVKNetto|number_format:2:".":""},
						'items': [{
							'item_name': '{getTrackingName article=$pushedArtikel }', // Name or ID is required.
							'item_id': '{if $snackyConfig.artnr == "id"}{$pushedArtikel->kArtikel}{else}{$pushedArtikel->cArtNr|escape}{/if}',
							'price': {$pushedArtikel->Preise->fVKNetto|number_format:2:".":""},
							{if !empty($pushedArtikel->cHersteller)}
							'brand': '{$pushedArtikel->cHersteller|escape}',
							'item_brand': '{$pushedArtikel->cHersteller|escape}',
							{/if}
							{getTrackingCategory article=$pushedArtikel}
							'quantity': {if $smarty.request.anzahl>0}{$smarty.request.anzahl}{else}1{/if}
						}]
					}
				});
			{/if}
			
			{* Begin Checkout *}
			{if ($nSeitenTyp == 11 || $nSeitenTyp == 3) && $smarty.session.Warenkorb->PositionenArr|@count > 0}
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
					'event': '{if $nSeitenTyp == 3}view_cart{else}{if $activeStep == 1 || $activeStep == 2}begin_checkout{else}checkout_step_{$activeStep}{/if}{/if}',
					'ecommerce': {
						'currency': '{$smarty.session.Waehrung->getCode()}',
						'value': {$smarty.session.Warenkorb->gibGesamtsummeWaren()|number_format:2:".":""},
						'items': [
							{foreach from=$smarty.session.Warenkorb->PositionenArr item="prodid" name="prodid"}
							{if $prodid->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}
							{if !$smarty.foreach.prodid.first},{/if}
							{
								'item_name': '{getTrackingName article=$prodid->Artikel }',       // Name or ID is required.
								'item_id': '{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}',
								'price': {$prodid->fPreis|number_format:2:".":""},
								{if !empty($prodid->Artikel->cHersteller)}
								'brand': '{$prodid->Artikel->cHersteller|escape}',
								'item_brand': '{$prodid->Artikel->cHersteller|escape}',
								{/if}
								{getTrackingCategory article=$prodid->Artikel}
								'quantity': {$prodid->nAnzahl}
							}
							{/if}
							{/foreach}
						]
					}
				});
				
				{* Observe Payment/Shipping Submit *}
				{if $activeStep==3 || $activeStep==4}					
					document.addEventListener('click', function (event) {
						const submitButton = event.target.closest(
							'button[type="submit"], input[type="submit"], .submit, .btn-primary'
						);
						
						if (!submitButton) {
							return;
						}
						
						dataLayer.push({ ecommerce: null });
						dataLayer.push({
							'event': 'add_shipping_info',
							'ecommerce': {
								'currency': '{$smarty.session.Waehrung->getCode()}',
								'value': {$smarty.session.Warenkorb->gibGesamtsummeWaren()|number_format:2:".":""},
								'items': [
									{foreach from=$smarty.session.Warenkorb->PositionenArr item="prodid" name="prodid"}
									{if $prodid->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}
									{if !$smarty.foreach.prodid.first},{/if}
									{
										'item_name': '{getTrackingName article=$prodid->Artikel }',       // Name or ID is required.
										'item_id': '{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}',
										'price': {$prodid->fPreis|number_format:2:".":""},
										{if !empty($prodid->Artikel->cHersteller)}
										'brand': '{$prodid->Artikel->cHersteller|escape}',
										'item_brand': '{$prodid->Artikel->cHersteller|escape}',
										{/if}
										{getTrackingCategory article=$prodid->Artikel}
										'quantity': {$prodid->nAnzahl}
									}
									{/if}
									{/foreach}
								]
							}
						});

						dataLayer.push({ ecommerce: null });
						dataLayer.push({
							'event': 'add_payment_info',
							'ecommerce': {
								'currency': '{$smarty.session.Waehrung->getCode()}',
								'value': {$smarty.session.Warenkorb->gibGesamtsummeWaren()|number_format:2:".":""},
								'items': [
									{foreach from=$smarty.session.Warenkorb->PositionenArr item="prodid" name="prodid"}
									{if $prodid->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}
									{if !$smarty.foreach.prodid.first},{/if}
									{
										'item_name': '{getTrackingName article=$prodid->Artikel }',       // Name or ID is required.
										'item_id': '{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}',
										'price': {$prodid->fPreis|number_format:2:".":""},
										{if !empty($prodid->Artikel->cHersteller)}
										'brand': '{$prodid->Artikel->cHersteller|escape}',
										'item_brand': '{$prodid->Artikel->cHersteller|escape}',
										{/if}
										{getTrackingCategory article=$prodid->Artikel}
										'quantity': {$prodid->nAnzahl}
									}
									{/if}
									{/foreach}
								]
							}
						});
					});
				{/if}
			{/if}
			
			{* Purchase *}
			{if $nSeitenTyp == 33 && $Bestellung->Positionen !== null && $Bestellung->Positionen|count > 0}
				dataLayer.push({ ecommerce: null });
				{assign var="coupon" value=""}
				dataLayer.push({
					'event': 'purchase',
					'ecommerce': {
						'transaction_id': '{$Bestellung->cBestellNr}',
						'value': {$Bestellung->fWarensummeNetto|number_format:2:".":""},
						'tax': {$Bestellung->fSteuern|number_format:2:".":""},
						'shipping': {$Bestellung->fVersandNetto|number_format:2:".":""},
						'currency': '{$smarty.session.Waehrung->getCode()}',
						'items': [
							{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}
							{if $prodid->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}
							{if !$smarty.foreach.prodid.first},{/if}
							{
								'item_id': '{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}',
								'item_name': '{getTrackingName article=$prodid->Artikel }',
								{if !empty($prodid->Artikel->cHersteller)}
								'brand': '{$prodid->Artikel->cHersteller|escape}',
								'item_brand': '{$prodid->Artikel->cHersteller|escape}',
								{/if}
								'price': {$prodid->fPreis|number_format:2:".":""},
								{getTrackingCategory article=$prodid->Artikel}
								'quantity': {$prodid->nAnzahl}
							}
							{elseif $prodid->nPosTyp==3}
							{assign var="coupon" value=$prodid->cName|escape}
							{/if}
							{/foreach}
						]
						{if $coupon!=""}
						,'coupon': '{$coupon}'
						{/if}
					}
				});
			{/if}
			
			//Wishlist remove
			document.addEventListener('click', function (event) {
				const link = event.target.closest('.wl-remove');
				if (!link) {
					return;
				}
				const productBox = link.closest('.p-c');
				if (!productBox) {
					return;
				}
				const jsonElement = productBox.querySelector('.json-article-data');
				if (!jsonElement) {
					return;
				}
				const jsonText = jsonElement.textContent;
				if (!jsonText) {
					return;
				}
				let item;
				try {
					item = JSON.parse(jsonText.replace(/'/g, '"'));
				} catch (error) {
					console.error('Ungültiges Produkt-JSON', error);
					return;
				}

				window.dataLayer = window.dataLayer || [];
				window.dataLayer.push({ ecommerce: null });
				window.dataLayer.push({
					event: 'remove_from_wishlist',
					ecommerce: {
						currency: '{$smarty.session.Waehrung->getCode()}',
						value: item.price || 0,
						items: [item]
					}
				});
			});
			
			//Mengenänderung Warenkorb (sidebar & standard)
			document.addEventListener('click', function (event) {
				const link = event.target.closest('button[type=submit]');
				if (!link) {
					return;
				}
				let productBox = link.closest('.choose_quantity');
				if (!productBox) {
					productBox = link.closest('.edit-item');
					if (!productBox) {
						return;
					}
				}
				
				const quantityInput = productBox.querySelector('.quantity');
				const oldQuantity = parseFloat(quantityInput.defaultValue || 0);
				const newQuantity = parseFloat(quantityInput.value || 0);
				const difference = newQuantity - oldQuantity;
				const jsonElement = productBox.querySelector('.json-article-data');
				if (!jsonElement) {
					return;
				}
				
				const jsonText = jsonElement.textContent;
				if (!jsonText) {
					return;
				}
				let item;
				try {
					item = JSON.parse(jsonText.replace(/'/g, '"'));
				} catch (error) {
					console.error('Ungültiges Produkt-JSON', error);
					return;
				}
			
				item.quantity = Math.abs(difference);
				tag_event = 'add_to_cart';
				if (difference < 0) {
					tag_event = 'remove_from_cart';
				}
				window.dataLayer = window.dataLayer || [];
				window.dataLayer.push({ ecommerce: null });
				window.dataLayer.push({
					event: tag_event,
					ecommerce: {
						currency: '{$smarty.session.Waehrung->getCode()}',
						value: item.price || 0,
						items: [item]
					}
				});
			});
			
			//Position aus warenkorb entfernen (komplett)
			document.addEventListener('click', function (event) {
				const link = event.target.closest('button[name=dropPos]');
				if (!link) {
					return;
				}
				let productBox = link.closest('.row.bskt');
				if (!productBox) {
					productBox = link.closest('.edit-item');
					if (!productBox) {
						return;
					}
				}
				
				const quantityInput = productBox.querySelector('.quantity');
				const quantity = parseFloat(quantityInput.defaultValue || 0);
				const jsonElement = productBox.querySelector('.json-article-data');
				if (!jsonElement) {
					return;
				}
				
				const jsonText = jsonElement.textContent;
				if (!jsonText) {
					return;
				}
				let item;
				try {
					item = JSON.parse(jsonText.replace(/'/g, '"'));
				} catch (error) {
					console.error('Ungültiges Produkt-JSON', error);
					return;
				}
			
				item.quantity = quantity;
				window.dataLayer = window.dataLayer || [];
				window.dataLayer.push({ ecommerce: null });
				window.dataLayer.push({
					event: 'remove_from_cart',
					ecommerce: {
						currency: '{$smarty.session.Waehrung->getCode()}',
						value: item.price || 0,
						items: [item]
					}
				});
			});
			
			{* Customer Registered *}
			{if !empty($smarty.session.tracking_customer_registered)}
				dataLayer.push({
					'event': 'sign_up',
					'sha256_email_address': '{hashEmail}',
					'user_id': {if JTL\Session\Frontend::getCustomer()->getID() > 0}{JTL\Session\Frontend::getCustomer()->getID()}{else}undefined{/if},
					'logged_in': true
				});
				{unsetRegisterTracking}
			{/if}
			
			{* Customer LoggedIn *}
			{if JTL\Session\Frontend::getCustomer()->getID() !== 0 && !empty($smarty.post.login)}
				dataLayer.push({
					'event': 'login',
					'sha256_email_address': '{hashEmail}',
					'user_id': {JTL\Session\Frontend::getCustomer()->getID()},
					'logged_in': true
				});
			{/if}
		{/block}
	</script>	
	
	{block name='layout-gtagmanager-tracking-script-loading'}
		<script>
			function loadTagmanager() {
				{if $snackyConfig.use_tagmanager_gateway != 1}
					(function(w,d,s,l,i){ldelim}w[l]=w[l]||[];w[l].push({ldelim}'gtm.start':
					new Date().getTime(),event:'gtm.js'{rdelim});var f=d.getElementsByTagName(s)[0],
					j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
					{if $snackyConfig.use_taggrs == 1}
						'{$snackyConfig.taggrs_subdomain}/{$snackyConfig.taggrs_containerid}.js?id='+i+dl;f.parentNode.insertBefore(j,f);
					{else}
						'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
					{/if}		
					{rdelim})(window,document,'script','dataLayer','{$snackyConfig.gtag|trim}');
				{/if}
			}
		</script>
	{/block}
{/block}