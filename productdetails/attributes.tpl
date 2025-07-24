{block name='productdetails-attributes'}
	{$inQuickView = !empty($smarty.get.quickView)}
	{if $showAttributesTable}
		<ul class="product-attributes blanklist p-att">
			{block name='productdetails-attributes-main'}
				{if $Einstellungen.artikeldetails.merkmale_anzeigen === 'Y'}
					{block name='productdetails-attributes-characteristics'}
						{foreach $Artikel->oMerkmale_arr as $characteristic}
							<li class="flx">
								{block name='productdetails-attributes-characteristics-name'}
									<strong class="first mr-xxs">{$characteristic->getName()}: </strong>
								{/block}
								{strip}
								{block name='productdetails-attributes-characteristics-value'}
									<span class="right flx-ac flx-w">
										{foreach $characteristic->getCharacteristicValues() as $characteristicValue}
											{if $characteristic->getType() === 'TEXT' || $characteristic->getType() === 'SELECTBOX' || $characteristic->getType() === ''}
												{block name='productdetails-attributes-characteristics-value-text'}
													<a {if !$inQuickView}href="{$characteristicValue->getURL()}"{/if} class="tag">{$characteristicValue->getValue()|escape:'html'}</a>
												{/block}
											{else}
												{block name='productdetails-attributes-characteristics-value-image'}
													<a {if !$inQuickView}href="{$characteristicValue->getURL()}"{/if} data-toggle="tooltip" data-placement="top" title="{$characteristicValue->getValue()|escape:'html'}">
														{$img = $characteristicValue->getImage(\JTL\Media\Image::SIZE_XS)}
														{if $img !== null && strpos($img, $smarty.const.BILD_KEIN_MERKMALBILD_VORHANDEN) === false
														&& strpos($img, $smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN) === false}
															<span class="img-ct icon icon-xl">
															{include file='snippets/image.tpl'
																item=$characteristicValue
																square=false
																srcSize='xs'
																sizes='40px'
																width='40'
																height='40'
																class='img-aspect-ratio'
																alt=$characteristicValue->getValue()}
															</span>
														{else}
															<span class="tag">{$characteristicValue->getValue()|escape:'html'}</span>
														{/if}
													</a>
												{/block}
											{/if}
										{/foreach}
									</span>
								{/block}
								{/strip}
							</li>
						{/foreach}
					{/block}
				{/if}
				{block name='productdetails-attributes-shipping-weight-outer'}
					{if $showShippingWeight}
						{block name='productdetails-attributes-shipping-weight'}
							<li class="flx-ac">
								<strong class="first mr-xxs">{lang key='shippingWeight' section='global'}: </strong>
								<span class="tag">{$Artikel->cGewicht} {lang key='weightUnit' section='global'}</span>
							</li>
						{/block}
					{/if}
				{/block}
				{block name='productdetails-attributes-product-weight-outer'}
					{if $showProductWeight}
						{block name='productdetails-attributes-product-weight'}
							<li class="flx-ac">
								<strong class="first mr-xxs">{lang key='productWeight' section='global'}: </strong>
								<span class="tag">{$Artikel->cArtikelgewicht} {lang key='weightUnit' section='global'}</span>
							</li>
						{/block}
					{/if}
				{/block}
				{block name='productdetails-attributes-unit-outer'}
					{if $Einstellungen.artikeldetails.artikeldetails_inhalt_anzeigen === 'Y'
						&& isset($Artikel->cMasseinheitName)
						&& isset($Artikel->fMassMenge)
						&& $Artikel->fMassMenge > 0
						&& $Artikel->cTeilbar !== 'Y'
						&& ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1)
						&& isset($Artikel->cMassMenge)}
						{block name='productdetails-attributes-unit'}
							<li class="flx-ac">
								<strong class="first mr-xxs">{lang key='contents' section='productDetails'}: </strong>
								<span class="tag">{$Artikel->cMassMenge} {$Artikel->cMasseinheitName}</span>
							</li>
						{/block}
					{/if}
				{/block}
				{block name='productdetails-attributes-dimensions-outer'}
					{if $dimension && $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y'}
						{block name='productdetails-attributes-dimensions'}
							{assign var=dimensionArr value=$Artikel->getDimensionLocalized()}
							{if $dimensionArr|count > 0}
								<li class="flx-ac">
									<strong class="first mr-xxs">{lang key='dimensions' section='productDetails'}
										<br><small>({foreach $dimensionArr as $dimkey => $dim}
										{$dimkey}{if $dim@last}{else} &times; {/if}
										{/foreach}):</small>
									</strong>
									<span class="tag">
										{foreach $dimensionArr as $dim}
											{$dim}{if $dim@last} cm {else} &times; {/if}
										{/foreach}
									</span>
								</li>
							{/if}
						{/block}
					{/if}
				{/block}
				{block name='productdetails-attributes-shop-attributes'}
					{assign var=funcAttrVal value=$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]|default:0}
					{if $Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y' || $funcAttrVal == 1}
						{block name='productdetails-attributes-shop-attributes'}
							{foreach $Artikel->Attribute as $Attribut}
								<li class="flx-ac">
									<strong class="first mr-xxs">{$Attribut->cName}: </strong>
									<span class="tag">{$Attribut->cWert}</span>
								</li>
							{/foreach}
						{/block}
					{/if}
				{/block}
			{/block}
		</ul>
	{/if}
{/block}