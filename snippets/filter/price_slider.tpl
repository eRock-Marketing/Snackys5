{block name='snippets-filter-price-slider'}
    {block name='snippets-filter-price-slider-content'}
        {input data=['id'=>'js-price-range'] type="hidden" value="{$priceRange}"}
        {input data=['id'=>'js-price-range-max'] type="hidden" value="{$priceRangeMax}"}
        {input data=['id'=>'js-price-range-id'] type="hidden" value="{$id}"}
        <div id="{$id}" class="price-range-slide mb-xs"></div>
        <div class="dpflex-j-b text-center dpflex-a-c unit">
            {input id="{$id}-from" class="rng-f rng" placeholder=0 aria=["label" => {lang key='differentialPriceFrom' section='productOverview'}]}
            <span class="block add">{$smarty.session.Waehrung->getName()}</span>
            {input id="{$id}-to" class="rng-l rng text-right"  placeholder=$priceRangeMax aria=["label" => {lang key='differentialPriceTo' section='productOverview'}]}
        </div>
    {/block}
    {block name='snippets-filter-price-slider-script'}
        {inline_script}<script>
            $(window).on('load', function() {
                $.evo.initPriceSlider($('.js-price-range-box'), $('#js-price-redirect').val() != 1);
            });
        </script>{/inline_script}
    {/block}
{/block}
