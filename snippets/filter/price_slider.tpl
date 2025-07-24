{block name='snippets-filter-price-slider'}
    {block name='snippets-filter-price-slider-content'}
        {input data=['id'=>'js-price-range'] type="hidden" value="{$priceRange}"}
        {input data=['id'=>'js-price-range-max'] type="hidden" value="{$priceRangeMax}"}
        {input data=['id'=>'js-price-range-id'] type="hidden" value="{$id}"}
        <div id="{$id}" class="price-range-slide mb-xs"></div>
        <div class="flx-jb text-center flx-ac unit">
            {input id="{$id}-from" class="rng-f rng" placeholder=0 aria=["label" => {lang key='differentialPriceFrom' section='productOverview'}]}
            <span class="block add">{JTL\Session\Frontend::getCurrency()->getName()}</span>
            {input id="{$id}-to" class="rng-l rng text-right"  placeholder=$priceRangeMax aria=["label" => {lang key='differentialPriceTo' section='productOverview'}]}
        </div>
    {/block}
    {block name='snippets-filter-price-slider-script'}
        {inline_script}<script>
            $(window).on('load', function() {
                $.evo.initPriceSlider($('.js-price-range-box'), false);
            });
        </script>{/inline_script}
    {/block}
	{block name='snippets-filter-price-slider-submit'}
		<hr class="invisible hr-xs">
		<button type="submit" class="btn btn-block btn-sm" id="{$id}-submit">{lang key='filterGo'}</button>
	{/block}
{/block}