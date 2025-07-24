{block name='account-order-item-wrapper'}
{foreach $Bestellung->Positionen as $oPosition}
    {if !(is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem > 0)}
        <div class="type-{$oPosition->nPosTyp} c-it">
            <div class="row">
                <div class="img-col col-3 col-md-2">
                    {if !empty($oPosition->Artikel->cVorschaubild)}
                    <a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}" class="img-ct">
                        {if isset($nSeitenTyp) && $nSeitenTyp == 37}
                            {include file='snippets/image.tpl'
                                fluid=false
                                item=$oPosition->Artikel
                                square=false
                                lazy=false
                                class='img-responsive-width'}
                        {else}
                            {include file='snippets/image.tpl'
                                fluid=false
                                item=$oPosition->Artikel
                                square=false
                                class='img-responsive-width'}
                        {/if}
                    </a>
                    {/if}
                </div>
                <div class="col-9 col-md-10">
                    <div class="row first">
                        <div class="col-8 col-md-8 col-lg-9">
                             {if $oPosition->nPosTyp == $smarty.const.C_WARENKORBPOS_TYP_ARTIKEL}
                                <a href="{$oPosition->Artikel->cURLFull}" title="{$oPosition->cName|trans|escape:'html'}" class="block"><strong class="title">{$oPosition->cName|trans}</strong></a>
                                <ul class="blanklist text-muted small info-ul">
                                    <li class="sku"><strong>{lang key="productNo" section="global"}:</strong> {$oPosition->Artikel->cArtNr}</li>
                                    {if isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
                                        <li title="{lang key='productMHDTool' section='global'}" class="best-before">
                                            <strong>{lang key="productMHD" section="global"}:</strong> {$oPosition->Artikel->dMHD_de}
                                        </li>
                                    {/if}
                                    {if $oPosition->Artikel->cLocalizedVPE 
										&& $oPosition->Artikel->cVPE !== 'N'
										&& $oPosition->nPosTyp != $C_WARENKORBPOS_TYP_GRATISGESCHENK
									}
                                        <li class="baseprice"><strong>{lang key="basePrice" section="global"}:</strong> {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}</li>
                                    {/if}
                                    {if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
                                        {foreach name=variationen from=$oPosition->WarenkorbPosEigenschaftArr item=Variation}
                                            <li class="variation">
                                                <strong>{$Variation->cEigenschaftName|trans}:</strong> {$Variation->cEigenschaftWertName|trans}
                                            </li>
                                        {/foreach}
                                    {/if}
                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans}
                                        <li class="delivery-status"><strong>{lang key="deliveryStatus" section="global"}:</strong> {$oPosition->cLieferstatus|trans}</li>
                                    {/if}
                                    {if !empty($oPosition->cHinweis)}
                                        <li class="text-info notice">{$oPosition->cHinweis}</li>
                                    {/if}

                                    {* Buttonloesung eindeutige Merkmale *}
                                    {if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
                                         <li class="manufacturer">
                                            <strong>{lang key="manufacturer" section="productDetails"}</strong>:
                                            <span class="values">
                                               {$oPosition->Artikel->cHersteller}
                                            </span>
                                         </li>
                                    {/if}

                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr)}
                                        {foreach $oPosition->Artikel->oMerkmale_arr as $oMerkmale_arr}
                                            <li class="characteristic">
                                                <strong>{$oMerkmale_arr->cName}</strong>:
                                                <span class="values">
													{foreach $oMerkmale_arr->oMerkmalWert_arr as $oWert}
														{if !$oWert@first}, {/if}
                                                        {$oWert->cWert}
                                                    {/foreach}
                                                </span>
                                            </li>
                                        {/foreach}
                                    {/if}

                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute)}
                                        {foreach $oPosition->Artikel->Attribute as $oAttribute_arr}
                                            <li class="attribute">
                                                <strong>{$oAttribute_arr->cName}</strong>:
                                                <span class="values">
                                                    {$oAttribute_arr->cWert}
                                                </span>
                                            </li>
                                        {/foreach}
                                    {/if}
                                </ul>
                            {else}
                                <strong>{$oPosition->cName|trans}{if isset($oPosition->discountForArticle)}{$oPosition->discountForArticle|trans}{/if}</strong>
                                {if isset($oPosition->cArticleNameAffix)}
                                    {if is_array($oPosition->cArticleNameAffix)}
                                        <ul class="small text-muted">
                                            {foreach $oPosition->cArticleNameAffix as $cArticleNameAffix}
                                                <li>{$cArticleNameAffix|trans}</li>
                                            {/foreach}
                                        </ul>
                                    {else}
                                        <ul class="small text-muted">
                                            <li>{$oPosition->cArticleNameAffix|trans}</li>
                                        </ul>
                                    {/if}
                                {/if}
                                {if !empty($oPosition->cHinweis)}
                                    <small class="text-info notice">{$oPosition->cHinweis}</small>
                                {/if}
                            {/if}

                            {if is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem === 0} {*istKonfigVater()*}
                                {block name='account-order-item-config-items'}
                                    <ul class="config-items text-muted small">
                                        {foreach $Bestellung->Positionen as $KonfigPos}
                                            {if $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0}
                                                <li>
                                                    <span class="qty">{if !(is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem === 0)}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
                                                    {$KonfigPos->cName|trans} &raquo;<br/>
                                                    <span class="price_value">
                                                        {if $KonfigPos->cEinzelpreisLocalized[$NettoPreise]|substr:0:1 !== '-'}+{/if}{$KonfigPos->cEinzelpreisLocalized[$NettoPreise]}
                                                        {lang key='pricePerUnit' section='checkout'}
                                                    </span>
                                                </li>
                                            {/if}
                                        {/foreach}
                                    </ul>
                                {/block}
                            {/if}
							{if !empty($oPosition->Artikel->kStueckliste) && !empty($oPosition->Artikel->oStueckliste_arr)}
								<ul class="partlist-items text-muted small">
									{foreach $oPosition->Artikel->oStueckliste_arr as $partListItem}
										<li>
											<span class="qty">{$partListItem->fAnzahl_stueckliste}x</span>
											{$partListItem->cName|trans}
										</li>
									{/foreach}
								</ul>
							{/if}
                        </div>
                        <div class="col-4 col-md-4 col-lg-3 text-right">
                            <div class="price-block">
                            {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                                {if $oPosition->nPosTyp == 1}
                                    {if !(is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem === 0)}
                                        <span class="single-price small block nowrap">
                                            {lang key="pricePerUnit" section="checkout"}: {$oPosition->cEinzelpreisLocalized[$NettoPreise]}
                                        </span>
                                    {else}
                                        <span class="single-price small block nowrap">
                                            {lang key="pricePerUnit" section="checkout"}: {$oPosition->cKonfigeinzelpreisLocalized[$NettoPreise]}
                                        </span>
                                    {/if}
                                {/if}
                            {/if}
                            <strong class="price block nowrap">
                                {if is_string($oPosition->cUnique) && !empty($oPosition->cUnique) && (int)$oPosition->kKonfigitem === 0}
                                    {$oPosition->cKonfigpreisLocalized[$NettoPreise]}
                                {else}
                                    {$oPosition->cGesamtpreisLocalized[$NettoPreise]}
                                {/if}
                            </strong>
                                                                                                          </div>
                                {lang key="quantity"}: {$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}           
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/if}
{/foreach}
{block name='account-order-item'}
    <div class="order-items card-table mb-spacer c-it">
        {block name='account-order-items-total-wrapper'}
        {row class="dpflex-j-end"}
            {col xl=5 md=6 class='order-items-total'}
                {block name='account-order-items-total'}
                    {if $NettoPreise}
                        {block name='account-order-items-total-price-net'}
                            {row class="total-net dpflex-j-between"}
                                {col }
                                    <span class="price_label"><strong>{lang key='totalSum'} ({lang key='net'}):</strong></span>
                                {/col}
                                {col class="col-auto price-col"}
                                    <strong class="price total-sum">{$Bestellung->WarensummeLocalized[1]}</strong>
                                {/col}
                            {/row}
                        {/block}
                    {/if}
                    {if $Bestellung->GuthabenNutzen == 1}
                        {block name='account-order-items-total-customer-credit'}
                            {row class="customer-credit dpflex-j-between"}
                                {col}
                                    {lang key='useCredit' section='account data'}
                                {/col}
                                {col class="col-auto ml-auto-util text-right-util"}
                                    {$Bestellung->GutscheinLocalized}
                                {/col}
                            {/row}
                        {/block}
                    {/if}
                    {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N'}
                        {block name='account-order-items-total-tax'}
                            {foreach $Bestellung->Steuerpositionen as $taxPosition}
                                {row class="tax dpflex-j-between"}
                                    {col class="col-auto"}
                                        <span class="tax_label">{$taxPosition->cName}:</span>
                                    {/col}
                                    {col class="col-auto price-col"}
                                        <span class="tax_label">{$taxPosition->cPreisLocalized}</span>
                                    {/col}
                                {/row}
                            {/foreach}
                        {/block}
                    {/if}
                    {block name='account-order-items-total-total'}
                        <hr>
                        {row class="dpflex-j-between"}
                            {col class="col-auto"}
                                <span class="price_label"><strong>{lang key='totalSum'} {if $NettoPreise}{lang key='gross' section='global'}{/if}:</strong></span>
                            {/col}
                            {col class="col-auto price-col"}
                                <strong class="price total-sum">{$Bestellung->WarensummeLocalized[0]}</strong>
                            {/col}
                        {/row}
                    {/block}
                    {if !empty($Bestellung->OrderAttributes)}
                        {block name='account-order-items-total-order-attributes'}
                            {foreach $Bestellung->OrderAttributes as $attribute}
                                {if $attribute->cName === 'Finanzierungskosten'}
                                    {row class="type-{$smarty.const.C_WARENKORBPOS_TYP_ZINSAUFSCHLAG}"}
                                        {block name='account-order-items-finance-costs'}
                                            {col}
                                                {lang key='financeCosts' section='order'}
                                            {/col}
                                        {/block}
                                        {block name='account-order-items-finance-costs-value'}
                                            {col class="col-auto price-col"}
                                                <strong class="price_overall">
                                                    {$attribute->cValue}
                                                </strong>
                                            {/col}
                                        {/block}
                                    {/row}
                                {/if}
                            {/foreach}
                        {/block}
                    {/if}
                {/block}
            {/col}
        {/row}
        {/block}
    </div>
{/block}
{/block}