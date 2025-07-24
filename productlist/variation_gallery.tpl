{block name='productlist-variation'}
    {if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0 && !$showMatrix}
        {block name='productlist-variation-assigns'}
            {assign var=VariationsSource value='Variationen'}
            {if isset($ohneFreifeld) && $ohneFreifeld}
                {assign var=VariationsSource value='VariationenOhneFreifeld'}
            {/if}
            {assign var=oVariationKombi_arr value=$Artikel->getChildVariations()}
        {/block}
        {block name='productlist-variation-spinner'}
            {row}
            {col class="updatingStockInfo text-center-util d-none"}
                <i class="fa fa-spinner fa-spin" title="{lang key='updatingStockInformation' section='productDetails'}"></i>
            {/col}
            {/row}
        {/block}
        {block name='productlist-variation-variation'}
            {row class="variations {if $simple}simple{else}switch{/if}-variations"}
            {col}
                <dl>
                    {foreach name=Variationen from=$Artikel->$VariationsSource key=i item=Variation}
                        {$showSwatchSlider=count($Variation->Werte) > $Einstellungen.template.productdetails.swatch_slider}
                        <div class="variation-wrapper variation-{$Variation->kEigenschaft} {if $i>0}collapse{/if} {if $Variation->cTyp === 'IMGSWATCHES'}js-slider-wrapper {if !$showSwatchSlider}js-slider-disabled{/if}{/if}">
                            {strip}
                                {block name='productlist-variation-name-outer'}
                                    <dt class="js-btn-slider-wrapper">
                                        {block name='productlist-variation-name'}
                                        {if $Variation->cTyp === 'IMGSWATCHES'}
                                            <div>
                                        {/if}
                                            {$Variation->cName}&nbsp;
                                        {/block}
                                        {block name='productlist-variation-value-name'}
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
                                            </div>
                                                {if $showSwatchSlider}
                                                    <div class="js-btn-slider-btns">
                                                        {button class="js-btn-slider-sb" variant="link" disabled=true}<span class="fa fa-chevron-left"></span>{/button}
                                                        {button class="js-btn-slider-sf" variant="link"}<span class="fa fa-chevron-right"></span>{/button}
                                                    </div>
                                                {/if}
                                            {/if}
                                        {/block}
                                    </dt>
                                {/block}
                                <dd class="form-group text-left-util">
                                    {if $Variation->cTyp === 'SELECTBOX'}
                                        {block name='productlist-variation-select-outer'}
                                            {select data=["size"=>"10"] class='custom-select selectpicker' title="{lang key='pleaseChooseVariation' section='productDetails'}" name="eigenschaftwert[{$Variation->kEigenschaft}]" required=!$showMatrix}
                                            {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                                {assign var=bSelected value=false}
                                                {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                                    {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                                {/if}
                                                {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                                    {assign var=bSelected value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
                                                {/if}
                                                {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                                $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                                !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                                {else}
                                                    {block name='productlist-variation-select-inner'}
                                                        {block name='productlist-variation-select-include-variation-value'}
                                                            {include file='productdetails/variation_value.tpl' assign='cVariationsWert'}
                                                        {/block}
                                                        <option value="{$Variationswert->kEigenschaftWert}" class="variation"
                                                                data-content="<span data-value='{$Variationswert->kEigenschaftWert}'>{trim($cVariationsWert)|escape:'html'}
                                                    {if $Variationswert->notExists} <span class='badge badge-danger badge-not-available'>{lang key='notAvailableInSelection'}</span>
                                                    {elseif !$Variationswert->inStock}<span class='badge badge-danger badge-not-available'>{lang key='ampelRot'}</span>{/if}</span>"
                                                                data-type="option"
                                                                data-original="{$Variationswert->cName}"
                                                                data-key="{$Variationswert->kEigenschaft}"
                                                                data-value="{$Variationswert->kEigenschaftWert}"
                                                                {if !empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))}
                                                                    data-list='{prepare_image_details item=$Variationswert json=true}'
                                                                    data-title='{$Variationswert->cName}'
                                                                {/if}
                                                                {if isset($Variationswert->oVariationsKombi)}
                                                                    data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                                                {/if}
                                                                {if $bSelected} selected="selected"{/if}>
                                                            {trim($cVariationsWert)|escape:'html'}
                                                        </option>
                                                    {/block}
                                                {/if}
                                            {/foreach}
                                            {/select}
                                        {/block}
                                    {elseif $Variation->cTyp === 'IMGSWATCHES'}
                                        {block name='productlist-variation-swatch-outer'}
                                            {formrow class="swatches js-slider-items no-scrollbar {$Variation->cTyp|lower}"}
                                            {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                                {assign var=bSelected value=false}
                                                {assign var=hasImage value=!empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))
                                            && strpos($Variationswert->getImage(\JTL\Media\Image::SIZE_XS), $smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN) === false}
                                                {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                                    {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                                {/if}
                                                {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                                    {assign var=bSelected value=($Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert)}
                                                {/if}
                                                {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                                $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                                !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                                    {* /do nothing *}
                                                {else}
                                                    {block name='productlist-variation-swatch-inner'}
                                                        {col class='col-auto js-slider-item'}
                                                            <label class="variation gall-preview swatches {if $hasImage}swatches-image{else}swatches-text{/if} {if $bSelected}active{/if} {if $Variationswert->notExists}swatches-not-in-stock not-available{elseif !$Variationswert->inStock}swatches-sold-out not-available{/if}"
                                                                   data-type="swatch"
                                                                   data-original="{$Variationswert->cName}"
                                                                   data-key="{$Variationswert->kEigenschaft}"
                                                                   data-value="{$Variationswert->kEigenschaftWert}"
                                                                   for="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                                    {if !empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))}
                                                                        data-list='{prepare_image_details item=$Variationswert json=true}'
                                                                    {/if}
                                                                    {if $Variationswert->notExists}
                                                                        title="{lang key='notAvailableInSelection'}"
                                                                        data-title="{$Variationswert->cName} - {lang key='notAvailableInSelection'}"
                                                                    {elseif $Variationswert->inStock}
                                                                        data-title="{$Variationswert->cName}"
                                                                    {else}
                                                                        title="{lang key='ampelRot'}"
                                                                        data-title="{$Variationswert->cName} - {lang key='ampelRot'}"
                                                                        data-stock="out-of-stock"
                                                                    {/if}
                                                                    {if isset($Variationswert->oVariationsKombi)}
                                                                data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                                                    {/if}>
                                                                <input type="radio"
                                                                       class="control-hidden"
                                                                       name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                                                       id="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                                       value="{$Variationswert->kEigenschaftWert}"
                                                                       {if $bSelected}checked="checked"{/if}
                                                                        {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                                                />
                                                                {if $hasImage}
                                                                    {include file='snippets/image.tpl' sizes='90px' item=$Variationswert srcSize='xs'}
                                                                {else}
                                                                    {$Variationswert->cName}
                                                                {/if}
{*                                                                {block name='productdetails-variation-swatch-include-variation-value'}*}
{*                                                                    {include file='productdetails/variation_value.tpl' hideVariationValue=true}*}
{*                                                                {/block}*}
                                                            </label>
                                                        {/col}
                                                    {/block}
                                                {/if}
                                            {/foreach}
                                            {/formrow}
                                        {/block}
                                    {elseif $Variation->cTyp === 'TEXTSWATCHES'}
                                        {block name='productlist-variation-textswatch-outer'}
                                            {formrow class="swatches {$Variation->cTyp|lower}"}
                                            {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                                {assign var=bSelected value=false}
                                                {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                                    {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                                {/if}
                                                {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                                    {assign var=bSelected value=($Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert)}
                                                {/if}
                                                {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                                $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                                !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                                    {* /do nothing *}
                                                {else}
                                                    {block name='productlist-variation-textswatch-inner'}
                                                        {col class='col-auto'}
                                                            <label class="variation gall-preview swatches swatches-text{if $bSelected} active{/if} {if $Variationswert->notExists}swatches-not-in-stock{elseif !$Variationswert->inStock}swatches-sold-out{/if}"
                                                                   data-type="swatch"
                                                                   data-original="{$Variationswert->cName}"
                                                                   data-key="{$Variationswert->kEigenschaft}"
                                                                   data-value="{$Variationswert->kEigenschaftWert}"
                                                                   for="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                                    {if !empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))}
                                                                        data-list='{prepare_image_details item=$Variationswert json=true}'
                                                                    {/if}
                                                                    {if $Variationswert->notExists}
                                                                        title="{lang key='notAvailableInSelection'}"
                                                                        data-title="{$Variationswert->cName} - {lang key='notAvailableInSelection'}"
                                                                    {elseif $Variationswert->inStock}
                                                                        data-title="{$Variationswert->cName}"
                                                                    {else}
                                                                        title="{lang key='ampelRot'}"
                                                                        data-title="{$Variationswert->cName} - {lang key='ampelRot'}"
                                                                        data-stock="out-of-stock"
                                                                    {/if}
                                                                    {if isset($Variationswert->oVariationsKombi)}
                                                                data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                                                    {/if}>
                                                                <input type="radio"
                                                                       class="control-hidden"
                                                                       name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                                                       id="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                                       value="{$Variationswert->kEigenschaftWert}"
                                                                       {if $bSelected}checked="checked"{/if}
                                                                        {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                                                />
                                                                <span class="label-variation">
                                                            {$Variationswert->cName}
                                                        </span>
                                                                {block name='productlist-variation-textswatch-include-variation-value'}
                                                                    {include file='productdetails/variation_value.tpl' hideVariationValue=true}
                                                                {/block}
                                                            </label>
                                                        {/col}
                                                    {/block}
                                                {/if}
                                            {/foreach}
                                            {/formrow}
                                        {/block}
                                    {/if}
                                </dd>
                            {/strip}
                        </div>
                    {/foreach}
                </dl>
            {/col}
            {/row}
        {/block}
    {/if}
{/block}
