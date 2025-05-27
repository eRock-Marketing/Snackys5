{block name='account-downloads'}
    {if !empty($Bestellung->oDownload_arr)}
	    {block name='account-downloads-order'}
            <hr class="invisible">
            {block name='account-downloads-order-headline'}
                <span class="h4 block">{lang key='yourDownloads'}</span>
            {/block}
            {block name='account-downloads-order-body'}
                <div class="card" role="tablist">
                    <div class="card-body">
                        {foreach $Bestellung->oDownload_arr as $oDownload}
                            {block name='account-downloads-order-item'}
                                <div class="flx-ac item" id="download-{$oDownload@iteration}">
                                    {block name='account-downloads-order-item-description'}
                                        <span class="w100">
                                            <strong class="block">{$oDownload->oDownloadSprache->getName()}</strong>
                                            <span class="text-muted small"></span>{lang key='downloadOrderDate'}: {$Bestellung->dErstellt|default:'--'|date_format:'d.m.Y H:i'}, {lang key='downloadLimit'}: {if isset($oDownload->cLimit)}{$oDownload->cLimit}{else}{lang key='unlimited'}{/if}, {lang key='validUntil'}: {if isset($oDownload->dGueltigBis)}{$oDownload->dGueltigBis}{else}{lang key='unlimited'}{/if}</span>
                                        </span>
                                    {/block}
                                    {block name='account-downloads-order-item-download'}
                                        <span class="dl-add">
                                            {if $Bestellung->cStatus == $smarty.const.BESTELLUNG_STATUS_BEZAHLT
                                            || $Bestellung->cStatus == $smarty.const.BESTELLUNG_STATUS_VERSANDT
                                            || $Bestellung->cStatus == $smarty.const.BESTELLUNG_STATUS_TEILVERSANDT}
                                                {block name='account-downloads-order-item-download-allowed'}
                                                    <form method="post" action="{get_static_route id='jtl.php'}">
                                                        {$jtl_token}
                                                        <input name="a" type="hidden" value="getdl" />
                                                        <input name="bestellung" type="hidden" value="{$Bestellung->kBestellung}" />
                                                        <input name="dl" type="hidden" value="{$oDownload->getDownload()}" />
                                                        <button class="btn btn-default btn-xs" type="submit">
                                                            {lang key='download'}
                                                        </button>
                                                    </form>
                                                {/block}
                                            {else}
                                                {block name='account-downloads-order-item-download-not-allowed'}
                                                    {lang key='downloadPending'}
                                                {/block}
                                            {/if}
                                        </span>
                                    {/block}
                                </div>
                            {/block}
                        {/foreach}
                    </div>
                </div>
            {/block}
	    {/block}
    {elseif !empty($oDownload_arr)}
	    {block name='account-downloads-account'}
            <hr class="invisible">
            {block name='account-downloads-account-headline'}
                <span class="h4 block">{lang key='yourDownloads'}</span>
            {/block}
            {block name='account-downloads-account-body'}
                <div class="card" role="tablist">
                    <div class="card-body">
                        {foreach $oDownload_arr as $oDownload}
                            {block name='account-downloads-account-item'}
                                <div class="flx-ac item" id="download-{$oDownload@iteration}">
                                    {assign var=cStatus value=$smarty.const.BESTELLUNG_STATUS_OFFEN}
                                    {foreach $Bestellungen as $Bestellung}
                                        {if $Bestellung->kBestellung == $oDownload->kBestellung}
                                            {assign var=cStatus value=$Bestellung->cStatus}
                                            {assign var=dErstellt value=$Bestellung->dErstellt}
                                        {/if}
                                    {/foreach}
                                    {block name='account-downloads-account-item-description'}
                                        <span class="w100">
                                            <strong class="block">{$oDownload->oDownloadSprache->getName()}</strong>
                                            <span class="text-muted small">{lang key='downloadOrderDate'}: {$dErstellt|default:'--'|date_format:'d.m.Y H:i'}, {lang key='downloadLimit'}: {if isset($oDownload->cLimit)}{$oDownload->cLimit}{else}{lang key='unlimited'}{/if}, {lang key='validUntil'}: {if isset($oDownload->dGueltigBis)}{$oDownload->dGueltigBis}{else}{lang key='unlimited'}{/if}</span>
                                        </span>
                                    {/block}
                                    {block name='account-downloads-account-item-download'}
                                        <span class="dl-add">
                                            <form method="post" action="{get_static_route id='jtl.php'}">
                                                {$jtl_token}
                                                <input name="kBestellung" type="hidden" value="{$oDownload->kBestellung}"/>
                                                {input name="kKunde" type="hidden" value=JTL\Session\Frontend::getCustomer()->getID()}
                                                {if $cStatus == $smarty.const.BESTELLUNG_STATUS_BEZAHLT
                                                || $cStatus == $smarty.const.BESTELLUNG_STATUS_VERSANDT
                                                || $cStatus == $smarty.const.BESTELLUNG_STATUS_TEILVERSANDT}
                                                    {block name='account-downloads-account-item-download-allowed'}
                                                        <input name="dl" type="hidden" value="{$oDownload->getDownload()}"/>
                                                        <button class="btn btn-default btn-xs" type="submit">
                                                            {lang key='download'}
                                                        </button>
                                                    {/block}
                                                {else}
                                                    {block name='account-downloads-account-item-download-not-allowed'}
                                                        <small class="status-0 block text-right">{lang key='downloadPending'}</small>
                                                    {/block}
                                                {/if}
                                            </form>
                                        </span>
                                    {/block}
                                </div>
                            {/block}
                        {/foreach}
                    </div>
                </div>
            {/block}
	    {/block}
    {/if}
{/block}