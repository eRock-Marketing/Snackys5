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
        <a class="btn-store-availability" data-toggle="modal" data-target="#popover-warehouse"><i class="info" title="{lang key='availability' section='productDetails'}"></i></a>
    {/if}
    <div class="modal modal-dialog" id="popover-warehouse" tabindex="-1" role="dialog">
      <div class="modal-content">
          <div class="modal-header">
              <span class="modal-title block h5">
                  {lang key='availability' section='productDetails'}
              </span>
              <button type="button" class="close-btn" data-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
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
    </div>
</div>
{/if}
{/block}
