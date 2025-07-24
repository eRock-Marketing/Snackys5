{block name='productdetails-variation'}
{assign var='modal' value=isset($smarty.get.quickView) && $smarty.get.quickView == 1}
{if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0 && !$showMatrix}
    {assign var="VariationsSource" value="Variationen"}
    {if isset($ohneFreifeld) && $ohneFreifeld}
        {assign var="VariationsSource" value="VariationenOhneFreifeld"}
    {/if}
    {assign var="oVariationKombi_arr" value=$Artikel->getChildVariations()}
    <div class="updatingStockInfo col-12 text-center"></div>

    <div class="variations {if $simple}simple{else}switch{/if}-variations {if !isset($smallView) || !$smallView}mb-sm{else}mb-xxs{/if}">
        {foreach name=Variationen from=$Artikel->$VariationsSource key=i item=Variation}
        <dl class="var-it">
        {strip}
            {if !isset($smallView) || !$smallView}
            <dt class="var-head">{$Variation->cName}
                {if $Variation->cTyp === 'IMGSWATCHES'}
                    <span class="swatches-selected text-success" data-id="{$Variation->kEigenschaft}">
                        {foreach $Variation->Werte as $variationValue}
                            {if isset($oVariationKombi_arr[$variationValue->kEigenschaft])
                            && in_array($variationValue->kEigenschaftWert, $oVariationKombi_arr[$variationValue->kEigenschaft])}
                                {$variationValue->cName}
                                {break}
                            {/if}
                        {/foreach}
                    </span>
                {/if}
            </dt>
            {/if}
            <dd class="var-body form-group">
                {if $Variation->cTyp === 'SELECTBOX'}
                    {block name='productdetails-info-variation-select'}
                    <select data-site="10" class="form-control" title="{if isset($smallView) && $smallView}{$Variation->cName} - {/if}{lang key='pleaseChooseVariation' section='productDetails'}" name="eigenschaftwert[{$Variation->kEigenschaft}]"{if !$showMatrix} required{/if}>
                        {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                            {assign var="bSelected" value=false}
                            {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                            {/if}
                            {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                {assign var="bSelected" value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                            {/if}
                            {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                            $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                            !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                            {else}
                                {include file='productdetails/variation_value.tpl' assign='cVariationsWert'}
                                <option value="{$Variationswert->kEigenschaftWert}" class="variation"
                                        data-type="option"
                                        data-original="{$Variationswert->cName}"
                                        data-key="{$Variationswert->kEigenschaft}"
                                        data-value="{$Variationswert->kEigenschaftWert}"
                                        data-content="{trim($cVariationsWert)|escape:'html'}{if $Variationswert->notExists}<span class='tag label label-default label-not-available'>{lang key='notAvailableInSelection'}</span>{elseif !$Variationswert->inStock}<span class='tag label label-default label-not-available'>{lang key='ampelRot'}</span>{/if}"
                                        {if !empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))}
                                            data-list='{prepare_image_details item=$Variationswert json=true}'
                                            data-title='{$Variationswert->cName}'
                                        {/if}
                                        {if isset($Variationswert->oVariationsKombi)}
                                            data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                        {/if}
                                        {if $bSelected} selected="selected"{/if}>
                                    {$Variationswert->cName}
                                </option>
                            {/if}
                        {/foreach}
                    </select>
                    {/block}
                {elseif $Variation->cTyp === 'RADIO'}
                    {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                        {assign var="bSelected" value=false}
                        {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                           {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                        {/if}
                        {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                            {assign var="bSelected" value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                        {/if}
                        {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                        $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                        !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                        {else}
                            {block name='productdetails-info-variation-radio'}
                            <label class="variation" for="{if $modal}modal-{elseif isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                   data-type="radio"
                                   data-original="{$Variationswert->cName}"
                                   data-key="{$Variationswert->kEigenschaft}"
                                   data-value="{$Variationswert->kEigenschaftWert}"
                                   {if !empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))}
                                        data-list='{prepare_image_details item=$Variationswert json=true}'
                                        data-title='{$Variationswert->cName}{if $Variationswert->notExists} - {lang key='notAvailableInSelection'}{elseif !$Variationswert->inStock} - {lang key='ampelRot'}{/if}'
                                   {/if}
                                   {if !$Variationswert->inStock}
                                        data-stock="out-of-stock"
                                   {/if}
                                   {if isset($Variationswert->oVariationsKombi)}
                                        data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                   {/if}>
                                <input type="radio"
                                       name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                       id="{if $modal}modal-{elseif isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                       value="{$Variationswert->kEigenschaftWert}"
                                       {if $bSelected}checked="checked"{/if}
                                       {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                       >
                                {include file="productdetails/variation_value.tpl"}{if $Variationswert->notExists}<span class='tag label label-default label-not-available'>{lang key='notAvailableInSelection'}</span>{elseif !$Variationswert->inStock}<span class='tag label label-default label-not-available'>{lang key='ampelRot'}</span>{/if}
                            </label>
                            {/block}
                        {/if}
                    {/foreach}
                {elseif $Variation->cTyp === 'IMGSWATCHES' || $Variation->cTyp === 'TEXTSWATCHES'}
                    <div class="flx-w swatches {$Variation->cTyp|lower}">
                        {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                            {assign var="bSelected" value=false}
                            {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                {assign var="bSelected" value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                            {/if}
                            {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                {assign var="bSelected" value=($Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert)}
                            {/if}
                            {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                            $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                            !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                {* /do nothing *}
                            {else}
                                {block name='productdetails-info-variation-swatch'}
                                    <label class="variation block btn btn-default{if $bSelected} active{/if}{if $Variationswert->notExists} not-available{/if}{if isset($smallView) && $smallView} btn-xs{/if}{if !empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))} btn-img{/if}"
                                            data-type="swatch"
                                            data-original="{$Variationswert->cName}"
                                            data-key="{$Variationswert->kEigenschaft}"
                                            data-value="{$Variationswert->kEigenschaftWert}"
                                            for="{if $modal}modal-{elseif isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                            {if !empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))}
                                                data-list='{prepare_image_details item=$Variationswert json=true}'
                                            {/if}
                                            {if $Variationswert->notExists}
                                                title="{lang key='notAvailableInSelection'}"
                                                data-title="{$Variationswert->cName} - {lang key='notAvailableInSelection'}"
                                                data-toggle="tooltip"
                                            {elseif $Variationswert->inStock}
                                                data-title="{$Variationswert->cName}"
                                            {else}
                                                title="{lang key='ampelRot'}"
                                                data-title="{$Variationswert->cName} - {lang key='ampelRot'}"
                                                data-toggle="tooltip"
                                                data-stock="out-of-stock"
                                            {/if}
                                            {if isset($Variationswert->oVariationsKombi)}
                                                data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                            {/if}>
                                        <input type="radio"
                                               disabled="disabled"
                                               class="control-hidden"
                                               name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                               id="{if $modal}modal-{elseif isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                               value="{$Variationswert->kEigenschaftWert}"
                                               {if $bSelected}checked="checked"{/if}
                                               {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                               />
                                       <span class="label-variation">
                                            {if !empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))}
                                           <span class="img-ct">
                                                <img src="{$Variationswert->getImage(\JTL\Media\Image::SIZE_XS)}" alt="{$Variationswert->cName|escape:'quotes'}"
                                                     data-list='{prepare_image_details item=$Variationswert json=true}'
                                                     title="{$Variationswert->cName}" />
                                               </span>
                                            {else}
                                                {$Variationswert->cName}
                                            {/if}
                                        </span>
                                        {include file='productdetails/variation_value.tpl' hideVariationValue=true}
                                    </label>
                                {/block}
                            {/if}
                        {/foreach}
                    </div>
                {elseif $Variation->cTyp === 'FREIFELD' || $Variation->cTyp === 'PFLICHT-FREIFELD'}
                    {block name='productdetails-info-variation-text'}
                    <input type="text"
                       class="form-control"
                       name="eigenschaftwert[{$Variation->kEigenschaft}]"
                       value="{if isset($oEigenschaftWertEdit_arr[$Variation->kEigenschaft])}{$oEigenschaftWertEdit_arr[$Variation->kEigenschaft]->cEigenschaftWertNameLocalized}{/if}"
                       data-key="{$Variation->kEigenschaft}"{if $Variation->cTyp === 'PFLICHT-FREIFELD'} required{/if} maxlength=255>
                    {/block}
                {/if}
            </dd>
        {/strip}
        </dl>
        {/foreach}
    </div>
{/if}
{/block}
