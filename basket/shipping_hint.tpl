{block name='basket-notice-shipping'}
    <div class="flx-ac mb-xs gifthint">
        <div class="img-ct icon">
            <svg>
              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-truck"></use>
            </svg>
        </div>
        <div class="right w100">
            {if isset(JTL\Session\Frontend::getCart()->oFavourableShipping->fVersandkostenfreiAbX) && JTL\Session\Frontend::getCart()->oFavourableShipping->fVersandkostenfreiAbX > 0 && $smarty.session.Warenkorb->oFavourableShipping->fVersandkostenfreiAbX > $currentCartValue}
            {assign var="currentCartValue" value=$WarensummeLocalized[$NettoPreise|intval] + 0}
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
{/block}