{block name='basket-notice-shipping'}
        {assign var="currentCartValue" value=0}
        {if !isset($tplscope)}
            {assign var="tplscope" value=''}
        {/if}
        {foreach JTL\Session\Frontend::getCart()->PositionenArr as $oPosition name=positionen}
            {if $oPosition->nPosTyp == '1'}
                {assign var="currentCartValue" value=$currentCartValue + ($oPosition->fVK[$NettoPreise] * $oPosition->nAnzahl)}
            {/if}
        {/foreach}
        {if $currentCartValue > 0 && $snackyConfig.shippingProgress == 'Y'}
            <div class="flx-ac gifthint{if $tplscope != 'detail'} mb-xs{/if}">
                {if $tplscope != 'detail'}
                    <div class="img-ct icon">
                        <svg>
                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-truck"></use>
                        </svg>
                    </div>
                {/if}
                <div class="right w100">
                    {if isset(JTL\Session\Frontend::getCart()->oFavourableShipping->fVersandkostenfreiAbX) && JTL\Session\Frontend::getCart()->oFavourableShipping->fVersandkostenfreiAbX > 0 && $smarty.session.Warenkorb->oFavourableShipping->fVersandkostenfreiAbX > $currentCartValue}
                    {assign var="shippingThreshold" value=JTL\Session\Frontend::getCart()->oFavourableShipping->fVersandkostenfreiAbX}
                    {assign var="progressPercent" value=($currentCartValue / $shippingThreshold * 100)|round}    
                    <div class="progress">
                            <div class="progress-bar" role="progressbar"
                                aria-valuenow="{$progressPercent|round}" aria-valuemin="0"
                                aria-valuemax="100" style="--progress-width: {$progressPercent|round}%;">
                            </div>
                        </div>
                    {/if}
                    <div class="small"> 
                        {$WarenkorbVersandkostenfreiHinweis}
                    </div>
                </div>
            </div>
        {else}
            <div class="flx-ac gifthint small{if $tplscope != 'detail'} mb-xxs{/if}">
                {if $tplscope != 'detail'}
                    <div class="img-ct icon">
                        <svg>
                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-truck"></use>
                        </svg>
                    </div>
                {/if}
                {$WarenkorbVersandkostenfreiHinweis}
            </div>
        {/if}
{/block}