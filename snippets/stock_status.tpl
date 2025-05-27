{block name='snippets-stock-status'}
    {assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
    {if $anzeige !== 'nichts'
    && $currentProduct->getBackorderString() !== ''
    && ($currentProduct->cLagerKleinerNull === 'N'
    || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')
    && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N'}
        <span class="status status-1 icon-wt">{$currentProduct->getBackorderString()}</span>
    {elseif $anzeige !== 'nichts'
    && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N'
    && $currentProduct->cLagerBeachten === 'Y'
    && $currentProduct->fLagerbestand <= 0
    && $currentProduct->fLieferantenlagerbestand > 0
    && $currentProduct->fLieferzeit > 0
    && ($currentProduct->cLagerKleinerNull === 'N'
    && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'I'
    || $currentProduct->cLagerKleinerNull === 'Y'
    && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
        <span class="status status-1">{lang key='supplierStockNotice' printf=$currentProduct->fLieferzeit}</span>
    {elseif $anzeige === 'verfuegbarkeit'
    || $anzeige === 'genau'}
        <span class="status status-{$currentProduct->Lageranzeige->nStatus} icon-wt">
            {$currentProduct->Lageranzeige->cLagerhinweis[$anzeige]}
        </span>
    {elseif $anzeige === 'ampel'}
        <span class="status status-{$currentProduct->Lageranzeige->nStatus} icon-wt">
            {$currentProduct->Lageranzeige->AmpelText}
        </span>
    {/if}
    {include file='productdetails/warehouse.tpl' tplscope='detail'}
{/block}