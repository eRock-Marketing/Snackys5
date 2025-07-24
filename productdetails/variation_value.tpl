{block name='productdetails-variation-value'}
{strip}
    {if !isset($hideVariationValue) || !$hideVariationValue}
        <span class="label-variation">{$Variationswert->cName}</span>
    {/if}
{* variationskombination *}
{if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
    {if $Artikel->nVariationOhneFreifeldAnzahl == 1}
        {assign var=kEigenschaftWert value=$Variationswert->kEigenschaftWert}
        {if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1}
            {if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cAufpreisLocalized[$NettoPreise])}
                <span class="tag">{$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cAufpreisLocalized[$NettoPreise]}
                {if !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}
                      &nbsp;({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]})
                {/if}
                </span>
            {/if}
        {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2}
            <span class="tag">{$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}
            {if !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}
                &nbsp;({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]})
            {/if}
            </span>
        {/if}
    {/if}
{/if}
{* einfache kombination oder variationskombination mit mindestens 2 nicht-freifeld positionen *}
{if ($Artikel->kVaterArtikel == 0 && $Artikel->nIstVater == 0) && isset($Variationswert->fAufpreisNetto)}
    {if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $Variationswert->fAufpreisNetto!=0}
        <span class="tag">{$Variationswert->cAufpreisLocalized[$NettoPreise]}</span>
    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $Variationswert->fAufpreisNetto!=0}
        <span class="tag">{$Variationswert->cPreisInklAufpreis[$NettoPreise]}</span>
    {/if}
{/if}
{* variationskombination mit mindestens 2 nicht-freifeld positionen *}
{if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl > 1 && isset($Variationswert->fAufpreisNetto)}
    {if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $Variationswert->fAufpreisNetto!=0}
        <span class="tag">{$Variationswert->cAufpreisLocalized[$NettoPreise]}
        {if !empty($Variationswert->cPreisVPEWertAufpreis[$NettoPreise]) && $Artikel->nVariationOhneFreifeldAnzahl == 1}
            &nbsp;({$Variationswert->cPreisVPEWertAufpreis[$NettoPreise]})
        {/if}
        </span>
    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $Variationswert->fAufpreisNetto!=0}
        <span class="tag">{$Variationswert->cPreisInklAufpreis[$NettoPreise]}
        {if !empty($Variationswert->cPreisVPEWertInklAufpreis[$NettoPreise]) && $Artikel->nVariationOhneFreifeldAnzahl == 1}
            &nbsp;({$Variationswert->cPreisVPEWertInklAufpreis[$NettoPreise]})
        {/if}
        </span>
    {/if}
{/if}
{/strip}
{/block}
