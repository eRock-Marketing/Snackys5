{block name='basket-freegift-hint'}
    {assign var="currentCartValue" value=0}
    {$freeGiftService = JTL\Shop::Container()->getFreeGiftService()}
    {if $Einstellungen.sonstiges.sonstiges_gratisgeschenk_wk_hinweis_anzeigen === 'Y'
        && $Einstellungen.sonstiges.sonstiges_gratisgeschenk_nutzen === 'Y'
        && $freeGiftService->getFreeGifts()->count() > 0}
        {if $freeGiftService->basketHoldsFreeGift(JTL\Session\Frontend::getCart()) === false}
            {foreach JTL\Session\Frontend::getCart()->PositionenArr as $oPosition name=positionen}
                {if $oPosition->nPosTyp == '1'}
                    {assign var="currentCartValue" value=$currentCartValue + ($oPosition->fVK[$NettoPreise] * $oPosition->nAnzahl)}
                {/if}
            {/foreach}
            {if $currentCartValue > 0}
                {if !empty($nextFreeGiftMissingAmount)}
                    {block name='basket-freegift-hint-still-missing-amount'}
                        {assign var="giftThreshold" value=$currentCartValue + $nextFreeGiftMissingAmount}
                        {assign var="progressPercent" value=($currentCartValue / $giftThreshold * 100)|round}
                        <div class="flx-ac mb-xs gifthint">
                            <div class="img-ct icon">
                                <svg>
                                <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-gift"></use>
                                </svg>
                            </div>
                            <div class="right w100"> 
                                {if $snackyConfig.freeGiftProgress == 'Y'}
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar"
                                            aria-valuenow="{$progressPercent|round}" aria-valuemin="0"
                                            aria-valuemax="100" style="--progress-width: {$progressPercent|round}%;">
                                        </div>
                                    </div>
                                {/if}
                                <div class="small"> 
                                    {lang section='basket' key='freeGiftsStillMissingAmountForNextFreeGift'
                                    printf=JTL\Catalog\Product\Preise::getLocalizedPriceString($nextFreeGiftMissingAmount)}
                                </div>
                            </div>
                        </div>
                    {/block}
                {else}
                    {block name='basket-freegift-hint-next-free-gift'}
                        <div class="flx-ac mb-xs gifthint">
                            <div class="img-ct icon">
                                <svg>
                                <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-gift"></use>
                                </svg>
                            </div>
                            <div class="right w100">
                                <div class="small">
                                    <strong>{lang section='basket' key='freeGiftsAvailableText'}</strong>
                                    <a href="{get_static_route id='warenkorb.php'}#freeGiftsHeading">
                                        {lang section='basket' key='chooseFreeGiftNow'}
                                    </a>
                                </div>
                            </div>
                        </div>
                    {/block}
                {/if}
            {/if}
        {/if}
    {/if}
{/block}
