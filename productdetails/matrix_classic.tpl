{block name='productdetails-matrix-classic'}
{assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
{capture name='outofstock' assign='outofstockInfo'}<span class="delivery-status"><small class="status-0">{lang key='soldout'}</small></span>{/capture}
<div class="table-responsive w100 mtrx">
    <table class="table table-striped variation-matrix">
        {* ****** 2-dimensional ****** *}
        {if $Artikel->VariationenOhneFreifeld|count == 2}
            <thead>
            <tr>
                <td>&nbsp;</td>
                {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWertHead}
                    <td class="vcenter">
                        {if $Artikel->oVariBoxMatrixBild_arr|count > 0 && (($Artikel->nIstVater == 1 && $Artikel->oVariBoxMatrixBild_arr[0]->nRichtung == 0) || $Artikel->nIstVater == 0)}
                            {foreach $Artikel->oVariBoxMatrixBild_arr as $oVariBoxMatrixBild}
                                {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWertHead->kEigenschaftWert}
                                    {image src=$oVariBoxMatrixBild->cBild fluid=true lazy=true alt=$oVariationWertHead->cName}<br>
                                {/if}
                            {/foreach}
                        {/if}
                        <strong>{$oVariationWertHead->cName}</strong>
                    </td>
                {/foreach}
            </tr>
            </thead>
            <tbody>
            {assign var=pushed value=0}
            {if isset($Artikel->VariationenOhneFreifeld[1]->Werte)}
                {foreach $Artikel->VariationenOhneFreifeld[1]->Werte as $oVariationWert1}
                    {assign var=kEigenschaftWert1 value=$oVariationWert1->kEigenschaftWert}
                    <tr>
                        <td class="vcenter">
                            {if $Artikel->oVariBoxMatrixBild_arr|count > 0 && (($Artikel->nIstVater == 1 && $Artikel->oVariBoxMatrixBild_arr[0]->nRichtung == 1) || $Artikel->nIstVater == 0)}
                                {foreach $Artikel->oVariBoxMatrixBild_arr as $oVariBoxMatrixBild}
                                    {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWert1->kEigenschaftWert}
                                        {image src=$oVariBoxMatrixBild->cBild fluid=true lazy=true alt=$oVariationWert1->cName}<br>
                                    {/if}
                                {/foreach}
                            {/if}
                            <strong>{$oVariationWert1->cName}</strong>
                        </td>
                        {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWert0}
                            {assign var=bAusblenden value=false}
                            {assign var=cVariBox value=$oVariationWert0->kEigenschaft|cat:':'|cat:$oVariationWert0->kEigenschaftWert|cat:'_'|cat:$oVariationWert1->kEigenschaft|cat:':'|cat:$oVariationWert1->kEigenschaftWert}
                            {if isset($Artikel->oVariationKombiKinderAssoc_arr[$cVariBox])}
                                {assign var=child value=$Artikel->oVariationKombiKinderAssoc_arr[$cVariBox]}
                            {elseif $Artikel->nIstVater}
                                {assign var=bAusblenden value=true}
                            {/if}
                            {if !$bAusblenden}
                                <td class="form-inline vcenter">
                                    {if $Einstellungen.global.global_erscheinende_kaeuflich === 'N' && isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <small>
                                            {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                        </small>
                                    {elseif isset($child->nNichtLieferbar) && $child->nNichtLieferbar == 1}
                                        {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                            <small>
                                                {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        {else}
                                            {if !empty($child)}
                                                {include file='snippets/stock_status.tpl' currentProduct=$child}
                                            {else}
                                                {$outofstockInfo}
                                            {/if}
                                        {/if}
                                    {elseif (isset($child->bHasKonfig) && $child->bHasKonfig == true) || (isset($child->nVariationAnzahl) && isset($child->nVariationOhneFreifeldAnzahl) && $child->nVariationAnzahl > $child->nVariationOhneFreifeldAnzahl)}
                                        <div class="center-sm">
                                            <a class="btn btn-default configurepos" href="{$child->cSeo}"><i class="fa fa-cogs"></i><span class="hidden-xs"> {lang key='configure'}</span></a>
                                        </div>
                                        {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                            <div>
                                                <small>
                                                    {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                </small>
                                            </div>
                                        {/if}
                                        <div class="delivery-status">
                                            <small>
                                                {if !isset($child->nErscheinendesProdukt) || !$child->nErscheinendesProdukt}
                                                    {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                {else}
                                                    {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                    {elseif $anzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                    {/if}
                                                {/if}
                                            </small>
                                        </div>
                                    {else}
                                        <div class="input-group{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError)} has-error{/if}">
                                            <input
                                                size="3" placeholder="0"
                                                class="form-control text-right{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError)} error{/if}"
                                                name="variBoxAnzahl[{$oVariationWert1->kEigenschaft}:{$oVariationWert1->kEigenschaftWert}_{$oVariationWert0->kEigenschaft}:{$oVariationWert0->kEigenschaftWert}]"
                                                type="text"
                                                value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}">
                                            {if $Artikel->nIstVater == 1}
                                                {if isset($child->Preise->cVKLocalized[$NettoPreise]) && $child->Preise->cVKLocalized[$NettoPreise] > 0}
                                                    <span class="input-group-addon add flx-ac nowrap">
                                                        &times; {$child->Preise->cVKLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                                    </span>
                                                {elseif isset($child->Preise->cVKLocalized[$NettoPreise]) && $child->Preise->cVKLocalized[$NettoPreise]}
                                                    {assign var=cVariBox value=$oVariationWert1->kEigenschaft|cat:':'|cat:$oVariationWert1->kEigenschaftWert|cat:'_'|cat:$oVariationWert0->kEigenschaft|cat:':'|cat:$oVariationWert0->kEigenschaftWert}
                                                    <span class="input-group-addon add flx-ac nowrap">
                                                        &times; {$child->Preise->cVKLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                                    </span>
                                                {/if}
                                            {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && ($oVariationWert0->fAufpreisNetto != 0 || $oVariationWert1->fAufpreisNetto != 0)}
                                                {if !isset($oVariationWert1->fAufpreis[1])}
                                                    {assign var=ovw1 value=0}
                                                {else}
                                                    {assign var=ovw1 value=$oVariationWert1->fAufpreis[1]}
                                                {/if}
                                                {if !isset($oVariationWert0->fAufpreis[1])}
                                                    {assign var=ovw0 value=0}
                                                {else}
                                                    {assign var=ovw0 value=$oVariationWert0->fAufpreis[1]}
                                                {/if}

                                                {math equation='x+y' x=$ovw0 y=$ovw1 assign='fAufpreis'}
                                                <span class="input-group-addon add flx-ac nowrap">
                                                    {gibPreisStringLocalizedSmarty bAufpreise=true fAufpreisNetto=$fAufpreis fVKNetto=$Artikel->Preise->fVKNetto kSteuerklasse=$Artikel->kSteuerklasse nNettoPreise=$NettoPreise fVPEWert=$Artikel->fVPEWert cVPEEinheit=$Artikel->cVPEEinheit FunktionsAttribute=$Artikel->FunktionsAttribute}
                                                </span>
                                            {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && ($oVariationWert0->fAufpreisNetto != 0 || $oVariationWert1->fAufpreisNetto != 0)}
                                                {if !isset($oVariationWert1->fAufpreis[1])}
                                                    {assign var=ovw1 value=0}
                                                {else}
                                                    {assign var=ovw1 value=$oVariationWert1->fAufpreis[1]}
                                                {/if}
                                                {if !isset($oVariationWert0->fAufpreis[1])}
                                                    {assign var=ovw0 value=0}
                                                {else}
                                                    {assign var=ovw0 value=$oVariationWert0->fAufpreis[1]}
                                                {/if}

                                                {math equation='x+y' x=$ovw0 y=$ovw1 assign='fAufpreis'}
                                                <span class="input-group-addon add flx-ac nowrap">
                                                    &times; {gibPreisStringLocalizedSmarty bAufpreise=false fAufpreisNetto=$fAufpreis fVKNetto=$Artikel->Preise->fVKNetto kSteuerklasse=$Artikel->kSteuerklasse nNettoPreise=$NettoPreise fVPEWert=$Artikel->fVPEWert cVPEEinheit=$Artikel->cVPEEinheit FunktionsAttribute=$Artikel->FunktionsAttribute}&nbsp;<span class="footnote-reference">*</span>
                                                </span>
                                            {/if}
                                        </div>
                                        {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                            <div>
                                                <small>
                                                    {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                </small>
                                            </div>
                                        {/if}
                                        <div class="delivery-status">
                                            <small>
                                                {if $Artikel->nIstVater == 1}
                                                    {if isset($child->nErscheinendesProdukt) && !$child->nErscheinendesProdukt}
                                                        {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                    {else}
                                                        {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                        {elseif $anzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                        {/if}
                                                    {/if}
                                                {/if}
                                            </small>
                                        </div>
{*
                                        {if isset($child->Lageranzeige->AmpelText)}
                                            <span class="delivery-status"><small class="status-{$child->Lageranzeige->nStatus}">{$child->Lageranzeige->AmpelText}</small></span>
                                        {/if}
*}
                                    {/if}
                                </td>
                            {else}
                                <td class="not-available">&nbsp;</td>
                            {/if}
                        {/foreach}
                    </tr>
                {/foreach}
            {/if}
        </tbody>
        {else}{* ****** 1-dimensional ****** *}
            {if $Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_anzeigeformat === 'Q' && $Artikel->VariationenOhneFreifeld[0]->Werte|count <= 10}
                {* QUERFORMAT *}
                <thead>
                <tr>
                    {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWertHead}
                        {if $Einstellungen.global.artikeldetails_variationswertlager != 3 || (!isset($oVariationWertHead->nNichtLieferbar) || $oVariationWertHead->nNichtLieferbar != 1)}
                            {assign var=cVariBox value=$oVariationWertHead->kEigenschaft|cat:':'|cat:$oVariationWertHead->kEigenschaftWert}
                            <td class="vcenter text-center" style="width: {100/$Artikel->VariationenOhneFreifeld[0]->Werte|count}%;">
                                {if $Artikel->oVariBoxMatrixBild_arr|count > 0}
                                    {foreach $Artikel->oVariBoxMatrixBild_arr as $oVariBoxMatrixBild}
                                        {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWertHead->kEigenschaftWert}
                                        <span class="img-ct ma mb-xxs">
											{image src=$oVariBoxMatrixBild->cBild fluid=true lazy=true alt=$oVariationWertHead->cName}
                                        </span>
                                        {/if}
                                    {/foreach}
                                {/if}
                                <strong>{$oVariationWertHead->cName}</strong>
                            </td>
                        {/if}
                    {/foreach}
                </tr>
                <thead>
                <tbody>
                <tr>
                    {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWertHead}
                        {if $Einstellungen.global.artikeldetails_variationswertlager != 3 || !isset($oVariationWertHead->nNichtLieferbar) || $oVariationWertHead->nNichtLieferbar != 1}
                            {assign var=cVariBox value=$oVariationWertHead->kEigenschaft|cat:':'|cat:$oVariationWertHead->kEigenschaftWert}
                            {if isset($Artikel->oVariationKombiKinderAssoc_arr[$cVariBox])}
                                {assign var=child value=$Artikel->oVariationKombiKinderAssoc_arr[$cVariBox]}
                            {/if}
                            <td class="vcenter text-center">
                                {if $Einstellungen.global.global_erscheinende_kaeuflich === 'N' && isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                    <small>
                                        {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                    </small>
                                {elseif isset($oVariationWertHead->nNichtLieferbar) && $oVariationWertHead->nNichtLieferbar == 1}
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <small>
                                            {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                        </small>
                                    {else}
                                        {if !empty($child)}
                                            {include file='snippets/stock_status.tpl' currentProduct=$child}
                                        {else}
                                            {$outofstockInfo}
                                        {/if}
                                    {/if}
                                {elseif (isset($child->bHasKonfig) && $child->bHasKonfig == true) || (isset($child->nVariationAnzahl) && isset($child->nVariationOhneFreifeldAnzahl) && $child->nVariationAnzahl > $child->nVariationOhneFreifeldAnzahl)}
                                    <div class="center-sm">
                                        <a class="btn btn-default configurepos" href="{$child->cSeo}"><i class="fa fa-cogs"></i><span class="hidden-xs"> {lang key='configure'}</span></a>
                                    </div>
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <div>
                                            <small>
                                                {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        </div>
                                    {/if}
                                    <div class="delivery-status mt-xxs">
                                        <small>
                                            {if !$child->nErscheinendesProdukt}
                                                {include file='snippets/stock_status.tpl' currentProduct=$child}
                                            {else}
                                                {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && ($child->fLagerbestand > 0 || $child->cLagerKleinerNull === 'Y')}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                {elseif $anzeige === 'ampel' && ($child->fLagerbestand > 0 || $child->cLagerKleinerNull === 'Y')}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                {/if}
                                            {/if}
                                        </small>
                                    </div>
                                {else}
                                    <div class="input-group{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError} has-error{/if}">
                                        <input class="form-control text-right" placeholder="0"
                                            name="variBoxAnzahl[_{$oVariationWertHead->kEigenschaft}:{$oVariationWertHead->kEigenschaftWert}]"
                                            type="text"
                                            value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}"{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError} style="background-color: red;"{/if} />
                                        {if $Artikel->nVariationAnzahl == 1 && ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
                                            {assign var=kEigenschaftWert value=$oVariationWertHead->kEigenschaftWert}
                                            <span class="input-group-addon add flx-ac nowrap">&times; {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]) && !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}){/if}</small></span>
                                        {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationWertHead->fAufpreisNetto != 0}
                                            <span class="input-group-addon add flx-ac nowrap">{$oVariationWertHead->cAufpreisLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise]})</small>{/if}</span>
                                        {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationWertHead->fAufpreisNetto != 0}
                                            <span class="input-group-addon add flx-ac nowrap">&times; {$oVariationWertHead->cPreisInklAufpreis[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}</span>
                                        {/if}
                                    </div>
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <div>
                                            <small>
                                                {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        </div>
                                    {/if}
                                    <div class="delivery-status mt-xxs">
                                        <small>
                                            {if $Artikel->nIstVater == 1}
                                                {if isset($child->nErscheinendesProdukt) && !$child->nErscheinendesProdukt}
                                                    {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                {else}
                                                    {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && ($child->fLagerbestand > 0 || $child->cLagerKleinerNull === 'Y')}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                    {elseif $anzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                    {/if}
                                                {/if}
                                            {/if}
                                        </small>
                                    </div>
                                {/if}
                            </td>
                        {/if}
                    {/foreach}
                </tr>
                </tbody>
            {else}
                {* HOCHFORMAT *}
                <tbody>
                {foreach $Artikel->VariationenOhneFreifeld[0]->Werte as $oVariationWertHead}
                    {if $Einstellungen.global.artikeldetails_variationswertlager != 3 || (!isset($oVariationWertHead->nNichtLieferbar) || $oVariationWertHead->nNichtLieferbar != 1)}
                        {assign var=cVariBox value=$oVariationWertHead->kEigenschaft|cat:':'|cat:$oVariationWertHead->kEigenschaftWert}
                        {if isset($Artikel->oVariationKombiKinderAssoc_arr[$cVariBox])}
                            {assign var=child value=$Artikel->oVariationKombiKinderAssoc_arr[$cVariBox]}
                        {/if}
                        <tr>
                            <td class="vcenter">
                                <div class="flx-ac">
                                    {if $Artikel->oVariBoxMatrixBild_arr|count > 0}
                                        {foreach $Artikel->oVariBoxMatrixBild_arr as $oVariBoxMatrixBild}
                                            {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWertHead->kEigenschaftWert}
                                                <span class="img-ct mr-xxs">
                                                 {image src=$oVariBoxMatrixBild->cBild fluid=true lazy=true alt=$oVariationWertHead->cName}
                                                </span>
                                            {/if}
                                        {/foreach}
                                    {/if}
                                    <strong> {$oVariationWertHead->cName}</strong>
                                </div>
                            </td>
                            <td class="form-inline">
                                {if $Einstellungen.global.global_erscheinende_kaeuflich === 'N' && isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                    <small>
                                        {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                    </small>
                                {elseif isset($oVariationWertHead->nNichtLieferbar) && $oVariationWertHead->nNichtLieferbar == 1}
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <small>
                                            {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                        </small>
                                    {else}
                                        {if !empty($child)}
                                            {include file='snippets/stock_status.tpl' currentProduct=$child}
                                        {else}
                                            {$outofstockInfo}
                                        {/if}
                                    {/if}
                                {elseif (isset($child->bHasKonfig) && $child->bHasKonfig == true) || (isset($child->nVariationAnzahl) && isset($child->nVariationOhneFreifeldAnzahl) && $child->nVariationAnzahl > $child->nVariationOhneFreifeldAnzahl)}
                                    <a class="btn btn-default configurepos" href="{$child->cSeo}"><i class="fa fa-cogs"></i><span class="hidden-xs"> {lang key='configure'}</span></a>
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <div>
                                            <small>
                                                {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        </div>
                                    {/if}
                                    <div class="delivery-status">
                                        <small>
                                            {if !$child->nErscheinendesProdukt}
                                                {include file='snippets/stock_status.tpl' currentProduct=$child}
                                            {else}
                                                {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && ($child->fLagerbestand > 0 || $child->cLagerKleinerNull === 'Y')}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                {elseif $anzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                {/if}
                                            {/if}
                                        </small>
                                    </div>
                                {else}
                                    <div class="input-group{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError} has-error{/if}">
                                        <input
                                            class="form-control text-right" placeholder="0"
                                            name="variBoxAnzahl[_{$oVariationWertHead->kEigenschaft}:{$oVariationWertHead->kEigenschaftWert}]"
                                            type="text" value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}">
                                    {if $Artikel->nVariationAnzahl == 1 && ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
                                        {assign var=kEigenschaftWert value=$oVariationWertHead->kEigenschaftWert}
                                        <span class="input-group-addon add flx-ac nowrap">
                                            &times; {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]) && !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                        </span>
                                    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationWertHead->fAufpreisNetto!=0}
                                        <span class="input-group-addon add flx-ac nowrap">
                                            {$oVariationWertHead->cAufpreisLocalized[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise]})</small>{/if}
                                        </span>
                                    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationWertHead->fAufpreisNetto!=0}
                                        <span class="input-group-addon add flx-ac nowrap">
                                            &times; {$oVariationWertHead->cPreisInklAufpreis[$NettoPreise]}&nbsp;<span class="footnote-reference">*</span>{if !empty($oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                        </span>
                                    {/if}
                                    </div>
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <div>
                                            <small>
                                                {lang key='productAvailableFrom'}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        </div>
                                    {/if}
                                    <div class="delivery-status">
                                        <small>
                                            {if $Artikel->nIstVater == 1}
                                                {if isset($child->nErscheinendesProdukt) && !$child->nErscheinendesProdukt}
                                                    {include file='snippets/stock_status.tpl' currentProduct=$child}
                                                {else}
                                                    {if $anzeige === 'verfuegbarkeit' || $anzeige === 'genau' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->cLagerhinweis[$anzeige]}</span>
                                                    {elseif $anzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"><i class="fa fa-truck"></i> {$child->Lageranzeige->AmpelText}</span>
                                                    {/if}
                                                {/if}
                                            {/if}
                                        </small>
                                    </div>
                                {/if}
                            </td>
                        </tr>
                    {/if}
                {/foreach}
                </tbody>
            {/if}
        {/if}
    </table>
</div>
<input type="hidden" name="variBox" value="1" />
<button name="inWarenkorb" type="submit" value="{lang key='addToCart'}" class="submit btn btn-primary btn-lg pull-right">{lang key='addToCart'}</button>
{/block}
