{block name='boxes-box-filter-pricerange'}
    {if !empty($oBox->getItems()->getOptions())
        && $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}
        {block name='boxes-box-filter-pricerange-content'}
            <section id="sidebox{$oBox->getID()}" class="box box-price panel js-price-range-box">
                <div class="h5 panel-heading dpflex-a-c">
                    {lang key='rangeOfPrices'}
                    {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                </div>
                <div class="panel-body">
                {block name='boxes-box-filter-pricerange-include-price-slider'}
                    {include file='snippets/filter/price_slider.tpl' id='price-slider-box'}
                {/block}
                </div>
            </section>
        {/block}
    {/if}
{/block}
