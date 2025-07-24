{block name='productdetails-warehouse'}
{* nur anzeigen, wenn >1 Warenlager aktiv und Artikel ist auf Lager/im Zulauf/Ueberverkaeufe erlaubt/beachtet kein Lager *}
{assign var=anzeige value=$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige}
{if $anzeige !== 'nichts'
    && isset($Artikel->oWarenlager_arr)
    && $Artikel->oWarenlager_arr|@count > 1
    && ($Artikel->cLagerBeachten !== 'Y'
        || $Artikel->cLagerKleinerNull === 'Y'
        || $Artikel->fLagerbestand > 0
        || $Artikel->fZulauf > 0)}
    {if $tplscope === 'detail'}
        <a class="btn-store-availability" data-toggle="popover" data-placement="left" data-ref="#popover-warehouse" data-trigger="click hover"><i class="fa fa-map-marker" title="{lang key='availability' section='productDetails'}"></i></a>
    {/if}
    <div class="hidden" id="popover-warehouse">
        <table class="table warehouse-table">
        {foreach $Artikel->oWarenlager_arr as $oWarenlager}
            <tr>
                <td class="name"><strong>{$oWarenlager->getName()}</strong></td>
                <td class="delivery-status">
                {if $anzeige !== 'nichts'
                    && $oWarenlager->getBackorderString($Artikel) !== ''
                    && ($Artikel->cLagerKleinerNull === 'N'
                        || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
                    <span class="signal_image status-1"><span>{$oWarenlager->getBackorderString($Artikel)}</span></span>
				{elseif $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N'
					&& $Artikel->cLagerBeachten === 'Y'
					&& $Artikel->fLagerbestand <= 0
					&& $Artikel->fLieferantenlagerbestand > 0
					&& $Artikel->fLieferzeit > 0
					&& ($Artikel->cLagerKleinerNull === 'N'
					&& $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'I'
					|| $Artikel->cLagerKleinerNull === 'Y'
					&& $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
					<span class="signal_image status-1">{lang key='supplierStockNotice' printf=$Artikel->fLieferzeit}</span>
                {elseif $anzeige === 'verfuegbarkeit' || $anzeige === 'genau'}
                    <span class="signal_image status-{$oWarenlager->oLageranzeige->nStatus}">{$oWarenlager->oLageranzeige->cLagerhinweis[$anzeige]}</span>
                {elseif $anzeige === 'ampel'}
                    <span><span class="signal_image status-{$oWarenlager->oLageranzeige->nStatus}">{$oWarenlager->oLageranzeige->AmpelText}</span></span>
                {/if}
                </td>
            </tr>
        {/foreach}
        </table>
    </div>
{/if}
{/block}
