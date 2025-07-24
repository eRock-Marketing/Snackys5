{block name="rich-snippets-main"}
	{if $nSeitenTyp === $smarty.const.PAGE_NEWSDETAIL && empty($cNewsErr)}
		{assign var="oAuthor" value=$newsItem->getAuthor()}
		{if empty($newsItem->getDateValidFrom())}
			{assign var=dDate value=$newsItem->getDateCreated()->format('Y-m-d H:i:s')}
		{else}
			{assign var=dDate value=$newsItem->getDateValidFrom()->format('Y-m-d H:i:s')}
		{/if}
		{block name="rich-snippets-blog"}
			<script type="application/ld+json">
			{
				{block name="rich-snippets-blog-inner"}
				  "@context": "https://schema.org",
				  "@type": "NewsArticle",
				  "headline": "{$newsItem->getTitle()|escape:'html'}",
				  {if !empty($newsItem->getPreviewImage())}
				  "image": [
					"{$imageBaseURL}{$newsItem->getPreviewImage()}"
				   ],
				   {/if}
				  "datePublished": "{$dDate}",
				  "dateModified": "{$newsItem->getDateCreated()->format('c')}",
				  "author": [{
					  "@type": "{if !empty($oAuthor->cName)}Person{else}Organization{/if}",
					  "name": "{if !empty($oAuthor->cName)}{$oAuthor->cName|escape:'html'}{else}{$meta_publisher|escape:'html'}{/if}",
					  "url": "{$ShopURL}"
				  }],
				  "publisher": [{
					  "@type": "Organization",
					  "name": "{$meta_publisher|escape:'html'}",
					  "url": "{$ShopURL}"
				  }]
				{/block}
			}
			</script>
		{/block}
	{else}
		{block name="rich-snippets-shop"}
			<script type="application/ld+json">
			{
				{block name="rich-snippets-shop-inner"}
					"@context": "http://schema.org",
					{if $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && !empty($Artikel->Bilder)}
						"@type": "ItemPage",
						"image": "{$Artikel->Bilder[0]->cURLGross}",
					{elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE
						&& $oNavigationsinfo->getImageURL() !== 'gfx/keinBild.gif'
						&& $oNavigationsinfo->getImageURL() !== 'gfx/keinBild_kl.gif'
					}
						"@type": "CollectionPage",
						"image": "{$imageBaseURL}{$oNavigationsinfo->getImageURL()}",
					{else}
						"@type": "Organization",
						"logo": "{$ShopLogoURL}",
					{/if}
					"url": "{if !empty($cCanonicalURL)}{$cCanonicalURL}{else}{$ShopURL}{/if}",
					"potentialAction": {
						"@type": "SearchAction",
						"target": "{get_static_route id='index.php'}/?qs={ldelim}search_term_string{rdelim}",
						"query-input": "required name=search_term_string"
					}
				{/block}
			}
			</script>
		{/block}
	{/if}

	{block name="rich-snippets-breadcrumb"}
		<script type="application/ld+json">
		{
			{block name="rich-snippets-breadcrumb-inner"}
				"@context": "http://schema.org",
				"@type": "BreadcrumbList",
				"itemListElement": [
					{foreach $Brotnavi as $oItem}
						{if !$oItem@first},{/if}
						{
							"@type": "ListItem",
							"position": {$oItem@iteration},
							"item": "{$oItem->getURLFull()}",
							"name": "{$oItem->getName()|escape:'html'}"
						}
					{/foreach}
				]
			{/block}
		}
		</script>
	{/block}
	{block name="rich-snippets-detail"}
		{if $nSeitenTyp === $smarty.const.PAGE_ARTIKEL}
			{block name="rich-snippets-product"}
				<script type="application/ld+json">
				{
					{block name="rich-snippets-product-inner"}
						"@context": "http://schema.org",
						"@type": {if !empty($Artikel->cISBN)}["Product","Book"]{else}"Product"{/if},
						"name": "{$Artikel->cName|escape:'html'}",
						"image": [
							{foreach $Artikel->Bilder as $image}
								{if !$image@first},{/if}
									"{$image->cPfadGross}"
							{/foreach}
						],
						"url": "{$cCanonicalURL}",
						{block name='rich-snippets-description'}
							"description": "{$Artikel->cKurzBeschreibung|escape:'html'}",
						{/block}
						{block name='rich-snippets-sku'}
						"sku": "{$Artikel->cArtNr}",
						{/block}
						{block name='rich-snippets-barcode'}
							{if !empty($Artikel->cBarcode)}
								"{if $Artikel->cBarcode|count_characters === 8}gtin8{else}gtin13{/if}": "{$Artikel->cBarcode}",
							{/if}
							{if !empty($Artikel->cISBN)}
								"isbn": "{$Artikel->cISBN}",
							{/if}
						{/block}
						{block name='rich-snippets-brand'}
							"brand": {
								"@type": "Brand",
								"name": "{$Artikel->cHersteller|escape:'html'}"
								{if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
									,
									"url": "{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerSeo}{/if}"
								{/if}
								{if ($Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B' || $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'BT') && !empty($Artikel->cHerstellerBildURLKlein)}
									,
									"image": "{$Artikel->cHerstellerBildURLKlein}"
								{/if}
							},
						{/block}
						{block name='rich-snippets-offer'}
							"offers": {
								"@type": "Offer",
								"price": "{if $Artikel->Preise->oPriceRange->isRange()}{$Artikel->Preise->oPriceRange->minBruttoPrice}{else}{$Artikel->Preise->fVKBrutto}{/if}",
								"priceCurrency": "{$smarty.session.Waehrung->getName()}",
								{block name='rich-snippets-availability'}
									"availability": "{if $Artikel->cLagerBeachten === 'N' || $Artikel->fLagerbestand > 0 || $Artikel->cLagerKleinerNull === 'Y'}https://schema.org/InStock{elseif $Artikel->nErscheinendesProdukt && $Artikel->Erscheinungsdatum_de !== '00.00.0000' && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y'}https://schema.org/PreOrder{elseif $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull === 'N' && $Artikel->fLagerbestand <= 0}https://schema.org/OutOfStock{/if}",
								{/block}
								"businessFunction": "http://purl.org/goodrelations/v1#Sell",
								"url": "{$cCanonicalURL}"
								{if $Artikel->Preise->Sonderpreis_aktiv && $Artikel->dSonderpreisStart_en !== null && $Artikel->dSonderpreisEnde_en !== null}
									,
									"validFrom": "{$Artikel->dSonderpreisStart_en}",
									"validThrough": "{$Artikel->dSonderpreisEnde_en}",
									"priceValidUntil": "{$Artikel->dSonderpreisEnde_en}"
								{/if}
							}
						{/block}
						{if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}
							{block name="rich-snippets-review"}
								,
								"review":[
									{foreach $Artikel->HilfreichsteBewertung->oBewertung_arr as $oBewertung}
										{if !$oBewertung@first},{/if}
										{
										  "@type": "Review",
										  "datePublished": "{$oBewertung->dDatum}",
										  "description": "{$oBewertung->cText|escape:'html'}",
										  "name": "{$oBewertung->cTitel|escape:'html'}",
										  "reviewRating": {
											"@type": "Rating",
											"ratingValue": "{$oBewertung->nSterne}",
											"bestRating": "5",
											"worstRating": "1"
										  },
										  "author": {
											"@type": "Person",
											"name": "{$oBewertung->cName|escape:'html'}"
										  }
										}
									{/foreach}
								]
							{/block}
							{block name="rich-snippets-aggregateRating"}
								,
								"aggregateRating": {
								  "@type": "AggregateRating",
								  "ratingValue": "{$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}",
								  "reviewCount": "{$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}"
								}
							{/block}
						{/if}
					{/block}
				}
				</script>
			{/block}
		{elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE && $snackyConfig.richSnippetsLists == 1}
			{block name="rich-snippets-productlist"}
				<script type="application/ld+json">
				{
					{block name="rich-snippets-productlist-inner"}
					  "@context":"https://schema.org",
					  "@type":"ItemList",
					  "itemListElement":[
						{foreach name=artikel from=$Suchergebnisse->getProducts() item=Artikel}
							{if !$Artikel@first},{/if}
							{
								"@type": {if !empty($Artikel->cISBN)}["Product","Book"]{else}"Product"{/if},
								"position":{$Artikel@iteration},
								"name": "{$Artikel->cName|escape:'html'}",
								"image": [
									{foreach $Artikel->Bilder as $image}
										{if $image@iteration < 3}	{* In List view, max 2 pictures *}
											{if !$image@first},{/if}
												"{$image->cPfadGross}"
										{/if}
									{/foreach}
								],
								"url": "{$cCanonicalURL}",
								{block name='rich-snippets-list-barcode'}
								"sku": "{$Artikel->cArtNr}",
								{/block}
								{block name='rich-snippets-list-barcode'}
									{if !empty($Artikel->cBarcode)}
										"{if $Artikel->cBarcode|count_characters === 8}gtin8{else}gtin13{/if}": "{$Artikel->cBarcode}",
									{/if}
									{if !empty($Artikel->cISBN)}
										"isbn": "{$Artikel->cISBN}",
									{/if}
								{/block}
								{block name='rich-snippets-list-brand'}
									"brand": {
										"@type": "Brand",
										"name": "{$Artikel->cHersteller|escape:'html'}"
									},
								{/block}
								{block name='rich-snippets-list-offer'}
									"offers": {
										"@type": "Offer",
										"price": "{if $Artikel->Preise->oPriceRange->isRange()}{$Artikel->Preise->oPriceRange->minBruttoPrice|string_format:"%.2f"}{else}{$Artikel->Preise->fVKBrutto|string_format:"%.2f"}{/if}",
										"priceCurrency": "{$smarty.session.Waehrung->getName()}",
										{block name='rich-snippets-list-availability'}
											"availability": "{if $Artikel->cLagerBeachten === 'N' || $Artikel->fLagerbestand > 0 || $Artikel->cLagerKleinerNull === 'Y'}https://schema.org/InStock{elseif $Artikel->nErscheinendesProdukt && $Artikel->Erscheinungsdatum_de !== '00.00.0000' && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y'}https://schema.org/PreOrder{elseif $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull === 'N' && $Artikel->fLagerbestand <= 0}https://schema.org/OutOfStock{/if}",
										{/block}
										"businessFunction": "http://purl.org/goodrelations/v1#Sell",
										"url": "{$cCanonicalURL}"
										{if $Artikel->Preise->Sonderpreis_aktiv && $Artikel->dSonderpreisStart_en !== null && $Artikel->dSonderpreisEnde_en !== null}
											,
											"validFrom": "{$Artikel->dSonderpreisStart_en}",
											"validThrough": "{$Artikel->dSonderpreisEnde_en}",
											"priceValidUntil": "{$Artikel->dSonderpreisEnde_en}"
										{/if}
									}
								{/block}
							}
						{/foreach}
					  ]
					{/block}
				}
				</script>
			{/block}
		{/if}
	{/block}
{/block}