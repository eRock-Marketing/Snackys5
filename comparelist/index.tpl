{block name='comparelist-index'}
	{block name='comparelist-assigns'}
		{if !isset($viewportImages)}
			{assign var="viewportImages" value=0}
		{/if}
	{/block}
	{block name="header"}
		{include file='layout/header.tpl'}
	{/block}
	{block name='comparelist-settings'}
		{$languageID = \JTL\Shop::getLanguageID()}
		{$fallback = $languageID}
		{$isDefault = \JTL\Language\LanguageHelper::isDefaultLanguageActive()}
		{if !$isDefault}
			{$fallback = \JTL\Language\LanguageHelper::getDefaultLanguage()->getId()}
		{/if}
		{assign var='descriptionLength' value=200}
	{/block}
	{block name="content"}
		{block name='comparelist-content-headline'}
			{include file="snippets/zonen.tpl" id="opc_before_heading"}
			<h1 class="text-center mb-sm">{lang key="compare" section="global"}</h1>
			{include file="snippets/zonen.tpl" id="opc_after_heading"}
		{/block}
		{block name='comparelist-content-extension'}
    		{include file="snippets/extension.tpl"}
		{/block}
		{block name='comparelist-content-list'}
    		{if $oVergleichsliste->oArtikel_arr|count > 0}
				{block name='comparelist-content-list-articles'}
					{include file="snippets/zonen.tpl" id="opc_before_compare_list"}
					{block name='comparelist-content-list-image-name'}
						<div class="row cpr-f flx-jc first">
							{foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
								<div class="col- text-center">
									<div class="is">										
										<a href="{$oArtikel->cURLFull}" class="block">
											{block name='comparelist-content-list-image'}
												<span class="img-w block mb-sm">
													<span class="img-ct">
														{image src=$oArtikel->cVorschaubild alt=$oArtikel->cName class="image"}
													</span>
												</span>
											{/block}
											{block name='comparelist-content-list-name'}
												<span class="title h4 mt-xs block m0">{$oArtikel->cName}</span>
											{/block}
										</a>
										{block name='comparelist-content-list-delete'}
											<a href="{$oArtikel->cURLDEL}" data-id="{$oArtikel->kArtikel}" class="close-btn">
											</a>
										{/block}
									</div>
								</div>
							{/foreach}
						</div>
					{/block}
					{block name='comparelist-content-list-price'}
						<div class="row cpr-f flx-jc mt-xxs">
							{foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
								<div class="col- text-center">
									{block name='comparelist-content-list-price-prices'}
										{if $oArtikel->getOption('nShowOnlyOnSEORequest', 0) === 1}
											<span class="block small">{lang key='productOutOfStock' section='productDetails'}</span>
										{elseif $oArtikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
											<span class="block small">{lang key='priceOnApplication' section='global'}</span>
										{else}
											<span>
												{include file='productdetails/price.tpl' Artikel=$oArtikel tplscope='detail'}
											</span>
										{/if}
									{/block}
									{block name='comparelist-content-list-price-show-article'}
										<div class="mt-xs">
											<a href="{$oArtikel->cURLFull}" class="btn btn-primary btn-block">{lang key="details"}</a>
										</div>
									{/block}
								</div>
							{/foreach}
						</div>
					{/block}
					{block name='comparelist-content-list-elements'}
        				{foreach $prioRows as $row}
            				{if $row['key'] !== 'Merkmale' && $row['key'] !== 'Variationen'}
								{block name='comparelist-content-list-elements-headline'}
                					<div class="row cpr-f flx-jc {if isset($bAjaxRequest) && $bAjaxRequest}mt-sm{else}mt-lg{/if} title">
                						{foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                    						<div class="col-">
                        						{if $oArtikel@index == 0}
                        							<div class="{if isset($bAjaxRequest) && $bAjaxRequest}h4{else}h3{/if} m0">{$row['name']}</div>
                        						{/if}
                    						</div>
                						{/foreach}
                					</div>
								{/block}
								{block name='comparelist-content-list-elements-content'}
                					<div class="row cpr-f flx-jc{if isset($bAjaxRequest) && $bAjaxRequest}{else} text-lg{/if}" data-id="row-{$row['key']}">
                    					{foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                        					{if $row['key'] === 'verfuegbarkeit'}
												{block name='comparelist-content-list-elements-avaiability'}
                            						<div class="col- text-center">
                                						{include file='productdetails/stock.tpl' Artikel=$oArtikel availability=true}
														{if $oArtikel->nErscheinendesProdukt}
															<div>
																{lang key='productAvailableFrom' section='global'}: <strong>{$oArtikel->Erscheinungsdatum_de}</strong>
																{if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $oArtikel->inWarenkorbLegbar == 1}
																	({lang key='preorderPossible' section='global'})
																{/if}
															</div>
														{/if}
													</div>
												{/block}
                        					{elseif $row['key'] === 'lieferzeit'}
												{block name='comparelist-content-list-elements-stock'}
                            						<div class="col- text-center">{include file='productdetails/stock.tpl' Artikel=$oArtikel shippingTime=true}</div>
												{/block}
                        					{elseif $oArtikel->$row['key'] !== ''}
												{block name='comparelist-content-list-elements-other'}
                            						<div class="col- text-center">
                                						{if $row['key'] === 'fArtikelgewicht' || $row['key'] === 'fGewicht'}
															{block name='comparelist-content-list-elements-weight'}
                                    							{$oArtikel->$row['key']} {lang key='weightUnit' section='comparelist'}
															{/block}
                                						{elseif $row['key'] === 'cBeschreibung' || $row['key'] === 'cKurzBeschreibung'}
                                    						{block name='comparelist-index-products-row-description'}
                                        						{if $oArtikel->$row['key']|strlen < $descriptionLength}
                                            						{$oArtikel->$row['key']}
                                        						{else}
                                            						<div>
                                                						<span>
                                                    						{substr($oArtikel->$row['key'], $descriptionLength)}
                                                						</span>
                                            						</div>
                                        						{/if}
                                    						{/block}
                                						{else}
                                    						{$oArtikel->$row['key']}
                                						{/if}
                            						</div>
												{/block}
                        					{else}
												{block name='comparelist-content-list-elements-empty'}
                            						<div class="col- text-center">--</div>
												{/block}
                        					{/if}
                    					{/foreach}
                					</div>
								{/block}
							{/if}
							{block name='comparelist-content-list-elements-characteristic'}
								{if $row['key'] === 'Merkmale'}
									{foreach $oMerkmale_arr as $characteristic}
										{$name = $characteristic->getName($languageID)|default:$characteristic->getName($fallback)}
										{block name='comparelist-content-list-elements-characteristic-headline'}
											<div class="row cpr-f flx-jc {if isset($bAjaxRequest) && $bAjaxRequest}mt-sm{else}mt-lg{/if} title">
												{foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
													<div class="col-">
														{if $oArtikel@index == 0}
															<div class="{if isset($bAjaxRequest) && $bAjaxRequest}h4{else}h3{/if} m0">{$characteristic->getName()|default:$characteristic->getName($fallback)}</div>
														{/if}
													</div>
												{/foreach}
											</div>
										{/block}
										{block name='comparelist-content-list-elements-characteristic-content'}
											<div class="row cpr-f flx-jc{if isset($bAjaxRequest) && $bAjaxRequest}{else} text-lg{/if}" data-id="row-attr-{$characteristic->getName()|default:$characteristic->getName($fallback)}">
												{foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
													<div class="col- text-center">
														{if count($oArtikel->oMerkmale_arr) > 0}
															{foreach $oArtikel->oMerkmale_arr as $oMerkmaleArtikel}
																{$innerName = $oMerkmaleArtikel->getName($languageID)|default:$oMerkmaleArtikel->getName($fallback)}
																{if $name === $innerName}
																	{foreach $oMerkmaleArtikel->getCharacteristicValues() as $characteristicValue}
																		{$characteristicValue->getValue()}{if !$characteristicValue@last}, {/if}
																	{/foreach}
																{/if}
															{/foreach}
														{else}
															--
														{/if}
													</div>
												{/foreach}
											</div>
										{/block}
									{/foreach}
								{/if}
							{/block}
							{block name='comparelist-content-list-elements-variations'}
								{if $row['key'] === 'Variationen'}
									{foreach $oVariationen_arr as $oVariationen}
										<div class="row cpr-f flx-jc mt-xxs" data-id="row-vari-{$oVariationen->cName}">
											{foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
												<div class="col- text-center">
													{if isset($oArtikel->oVariationenNurKind_arr) && $oArtikel->oVariationenNurKind_arr|count > 0}
														{foreach $oArtikel->oVariationenNurKind_arr as $oVariationenArtikel}
															{if $oVariationen->cName == $oVariationenArtikel->cName}
																{foreach $oVariationenArtikel->Werte as $oVariationsWerte}
																	{$oVariationsWerte->cName}
																	{if $oArtikel->nVariationOhneFreifeldAnzahl == 1 && ($oArtikel->kVaterArtikel > 0 || $oArtikel->nIstVater == 1)}
																		{assign var=kEigenschaftWert value=$oVariationsWerte->kEigenschaftWert}
																		({$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}{if !empty($oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}, {$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
																	{/if}
																{/foreach}
															{/if}
														{/foreach}
													{elseif $oArtikel->Variationen|count > 0}
														{foreach $oArtikel->Variationen as $oVariationenArtikel}
															{if $oVariationen->cName == $oVariationenArtikel->cName}
																{foreach $oVariationenArtikel->Werte as $oVariationsWerte}
																	{$oVariationsWerte->cName}
																	{if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationsWerte->fAufpreisNetto != 0}
																		({$oVariationsWerte->cAufpreisLocalized[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise]}{/if})
																	{elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationsWerte->fAufpreisNetto != 0}
																		({$oVariationsWerte->cPreisInklAufpreis[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
																	{/if}
																	{if !$oVariationsWerte@last},{/if}
																{/foreach}
															{/if}
														{/foreach}
													{else}
														&nbsp;
													{/if}
												</div>
											{/foreach}
										</div>
									{/foreach}
								{/if}
							{/block}
						{/foreach}
					{/block}
				{/block}
			{else}
				{block name='comparelist-content-list-empty'}
					<div class="alert alert-info text-center">{lang key='productNumberHint' section='comparelist'}</div>
				{/block}
			{/if}
		{/block}
		{block name='comparelist-content-javascript'}    
    		{if isset($bAjaxRequest) && $bAjaxRequest}
				{inline_script}
				<script type="text/javascript">
					$('.modal a.remove').click(function(e) {
						var kArtikel = $(e.currentTarget).data('id');
						$('section.box-compare li[data-id="' + kArtikel + '"]').remove();
						eModal.ajax({
							size: 'lg',
							url: e.currentTarget.href,
							title: '{lang key="compare" section="global"}',
							keyboard: true,
							tabindex: -1
						});

						return false;
					});
					new function(){
						var clCount = {if isset($oVergleichsliste->oArtikel_arr)}{$oVergleichsliste->oArtikel_arr|count}{else}0{/if};
						$('.navbar-nav .compare-list-menu .badge em').html(clCount);
						if (clCount > 1) {
							$('section.box-compare .panel-body').removeClass('hidden');
						} else {
							{if !isset($bAjaxRequest) || !$bAjaxRequest}
							$('.navbar-nav .compare-list-menu .link_to_comparelist').removeAttr('href').removeClass('popup');
							eModal.close();
							{/if}
						}
					}();
				</script>
				{/inline_script}
			{/if}
		{/block}
	{/block}
	{block name="footer"}
		{include file='layout/footer.tpl'}
	{/block}
{/block}