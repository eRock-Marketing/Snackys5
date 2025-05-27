{block name='basket-freegift-hint'}
    {$freeGiftService = JTL\Shop::Container()->getFreeGiftService()}
    {if $Einstellungen.sonstiges.sonstiges_gratisgeschenk_wk_hinweis_anzeigen === 'Y'
        && $Einstellungen.sonstiges.sonstiges_gratisgeschenk_nutzen === 'Y'
        && $freeGiftService->getFreeGifts()->count() > 0}
        {if $freeGiftService->basketHoldsFreeGift(JTL\Session\Frontend::getCart()) === false}
            <strong>{lang section='basket' key='freeGiftsAvailableText'}</strong>
            <a href="{get_static_route id='warenkorb.php'}#freeGiftsHeading">
                {lang section='basket' key='chooseFreeGiftNow'}
            </a>

            {block name='basket-freegift-hint-still-missing-amount'}
                {if $Einstellungen.sonstiges.sonstiges_gratisgeschenk_noch_nicht_verfuegbar_anzeigen === 'Y'
                && !empty($nextFreeGiftMissingAmount)}
                    <span class="block mt-xxs">{lang section='basket' key='freeGiftsStillMissingAmountForNextFreeGift'
                    printf=JTL\Catalog\Product\Preise::getLocalizedPriceString($nextFreeGiftMissingAmount)}</span>
                {/if}
            {/block}
        {/if}
    {/if}
{/block}
