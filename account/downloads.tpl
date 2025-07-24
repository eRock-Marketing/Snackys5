{block name='account-downloads'}
{if !empty($Bestellung->oDownload_arr)}
    <hr class="invisible">
    <span class="h4 block">{lang key='yourDownloads'}</span>
    <div class="card" role="tablist">
        <div class="card-body">
        {foreach $Bestellung->oDownload_arr as $oDownload}
            <div class="dpflex-a-center item" id="download-{$oDownload@iteration}">
                <span class="w100">
                    <strong class="block">{$oDownload->oDownloadSprache->getName()}</strong>
                    <span class="text-muted small"></span>{lang key='downloadOrderDate'}: {if isset($Bestellung->dErstellt)}{$Bestellung->dErstellt|date_format:"%d.%m.%Y %H:%M"}{else}--{/if}, {lang key='downloadLimit'}: {if isset($oDownload->cLimit)}{$oDownload->cLimit}{else}{lang key='unlimited'}{/if}, {lang key='validUntil'}: {if isset($oDownload->dGueltigBis)}{$oDownload->dGueltigBis}{else}{lang key='unlimited'}{/if}</span>
                </span>
                <span class="dl-add">
                {if $Bestellung->cStatus == $smarty.const.BESTELLUNG_STATUS_BEZAHLT
                || $Bestellung->cStatus == $smarty.const.BESTELLUNG_STATUS_VERSANDT
                || $Bestellung->cStatus == $smarty.const.BESTELLUNG_STATUS_TEILVERSANDT}
                    <form method="post" action="{get_static_route id='jtl.php'}">
                        {$jtl_token}
                        <input name="a" type="hidden" value="getdl" />
                        <input name="bestellung" type="hidden" value="{$Bestellung->kBestellung}" />
                        <input name="dl" type="hidden" value="{$oDownload->getDownload()}" />
                        <button class="btn btn-default btn-xs" type="submit">
                            {lang key='download'}
                        </button>
                    </form>
                {else}
                    {lang key='downloadPending'}
                {/if}
                </span>
            </div>
        {/foreach}
        </div>
    </div>
{elseif !empty($oDownload_arr)}
    <hr class="invisible">
    <span class="h4 block">{lang key='yourDownloads'}</span>
    <div class="card" role="tablist">
        <div class="card-body">
        {foreach $oDownload_arr as $oDownload}
            <div class="dpflex-a-center item" id="download-{$oDownload@iteration}">
                {assign var=cStatus value=$smarty.const.BESTELLUNG_STATUS_OFFEN}
                {foreach $Bestellungen as $Bestellung}
                    {if $Bestellung->kBestellung == $oDownload->kBestellung}
                        {assign var=cStatus value=$Bestellung->cStatus}
                        {assign var=dErstellt value=$Bestellung->dErstellt}
                    {/if}
                {/foreach}
                <span class="w100">
                    <strong class="block">{$oDownload->oDownloadSprache->getName()}</strong>
                    <span class="text-muted small">{lang key='downloadOrderDate'}: {if isset($dErstellt)}{$dErstellt|date_format:"%d.%m.%Y %H:%M"}{else}--{/if}, {lang key='downloadLimit'}: {if isset($oDownload->cLimit)}{$oDownload->cLimit}{else}{lang key='unlimited'}{/if}, {lang key='validUntil'}: {if isset($oDownload->dGueltigBis)}{$oDownload->dGueltigBis}{else}{lang key='unlimited'}{/if}</span>
                </span>
                <span class="dl-add">
                    <form method="post" action="{get_static_route id='jtl.php'}">
                        {$jtl_token}
                        <input name="kBestellung" type="hidden" value="{$oDownload->kBestellung}"/>
                        <input name="kKunde" type="hidden" value="{$smarty.session.Kunde->kKunde}"/>
                        {if $cStatus == $smarty.const.BESTELLUNG_STATUS_BEZAHLT
                        || $cStatus == $smarty.const.BESTELLUNG_STATUS_VERSANDT
                        || $cStatus == $smarty.const.BESTELLUNG_STATUS_TEILVERSANDT}
                            <input name="dl" type="hidden" value="{$oDownload->getDownload()}"/>
                            <button class="btn btn-default btn-xs" type="submit">
                                {lang key='download'}
                            </button>
                        {else}
                            <small class="status-0 block text-right">{lang key='downloadPending'}</small>
                        {/if}
                    </form>
                </span>
            </div>
        {/foreach}
        </div>
    </div>
{/if}
{/block}