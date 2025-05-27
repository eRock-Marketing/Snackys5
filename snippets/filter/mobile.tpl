{block name='snippets-filter-mobile'}
    {if $isMobile && !$isTablet}
        <span class="h2 snippets-filter-mobile-heading" id="productlist-filter">{lang key='filterAndSort'}</span>
    {/if}
    <div class="productlist-filter-wrapper dropdown-full-width">
        {block name='snippets-filter-mobile-top-include-active-filter'}
            <div class="productlist-applied-filter productlist-applied-filter-top">
                {include file='snippets/filter/active_filter.tpl'}
            </div>
        {/block}
        <ul class="productlist-filter-accordion border-md-bottom border-lg-bottom-0">
        {block name='snippets-filter-mobile-sorting'}
            {if count($Suchergebnisse->getSortingOptions()) > 0}
            <li class="snippets-filter-mobile-sorting">
                {link class="snippets-filter-mobile-sorting-link filter-type-FilterItemSort" rel="nofollow"
                    data=["toggle"=> "collapse", "target"=>"#sorting-collapse"]}
                    {lang key='sorting' section='productOverview'}
                    <span class="font-italic text-truncate">
                        {foreach $Suchergebnisse->getSortingOptions() as $option}
                            {if $option->isActive()} {$option->getName()}{/if}
                        {/foreach}
                    </span>
                {/link}
                {collapse id="sorting-collapse" class="snippets-filter-mobile-sorting-collapse"}
                    {foreach $Suchergebnisse->getSortingOptions() as $option}
                        {dropdownitem class="filter-item"
                            active=$option->isActive()
                            href=$option->getURL()
                            rel='nofollow'}
                        {$option->getName()}
                        {/dropdownitem}
                    {/foreach}
                {/collapse}
            </li>
            {/if}
        {/block}
        {if $show_filters}
            {if count($NaviFilter->getAvailableContentFilters()) > 0}
                {block name='snippets-filter-mobile-filters'}
                    {foreach $NaviFilter->getAvailableContentFilters() as $filter}
                        {if count($filter->getFilterCollection()) > 0}
                            {foreach $filter->getOptions() as $subFilter}
                                {if $subFilter->getVisibility() !== \JTL\Filter\Visibility::SHOW_NEVER
                                    && $subFilter->getVisibility() !== \JTL\Filter\Visibility::SHOW_BOX
                                    && $filter->getOptions()|count > 0}
                                    <li class="snippets-filter-mobile-item">
                                        {block name='snippets-filter-mobile-filters-button'}
                                            {link class="collapsed" rel="nofollow"
                                                data=["toggle"=> "collapse", "target"=>"#filter-collapse-{$subFilter->getFrontendName()|@seofy}"]}
                                                <span class="characteristic-collapse-btn-inner">
                                                    {$img = $subFilter->getImage(\JTL\Media\Image::SIZE_XS)}
                                                    {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T'
                                                    && $img !== null
                                                    && strpos($img, $smarty.const.BILD_KEIN_MERKMALBILD_VORHANDEN) === false
                                                    && strpos($img, $smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN) === false}
                                                        {include file='snippets/image.tpl'
                                                        item=$subFilter
                                                        square=false
                                                        class='img-xs'
                                                        srcSize='xs'
                                                        sizes='24px'}
                                                    {/if}
                                                    {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'B'}
                                                        <span class="text-truncate">{$subFilter->getFrontendName()}</span>
                                                    {/if}
                                                </span>
                                            {/link}
                                        {/block}
                                        {block name='snippets-filter-mobile-filters-collapse'}
                                            {collapse id="filter-collapse-{$subFilter->getFrontendName()|@seofy}"
                                                class="snippets-filter-mobile-item-collapse"
                                                visible=$subFilter->isActive() || $Einstellungen.template.productlist.filter_items_always_visible === 'Y'}
                                                {if ($subFilter->getData('cTyp') === 'SELECTBOX') && $subFilter->getOptions()|@count > 0}
                                                    {dropdown variant="outline-secondary" text="{lang key='selectFilter' section='global'} " toggle-class="btn-block"}
                                                        {include file='snippets/filter/characteristic.tpl' Merkmal=$subFilter sub=true}
                                                    {/dropdown}
                                                {else}
                                                    {include file='snippets/filter/characteristic.tpl' Merkmal=$subFilter sub=true}
                                                {/if}
                                            {/collapse}
                                        {/block}
                                    </li>
                                {/if}
                            {/foreach}
                        {elseif $filter->getOptions()|count > 0}
                            <li class="snippets-filter-mobile-item">
                                {if $filter->getClassName() === "JTL\Filter\Items\PriceRange"}
                                    {block name='snippets-filter-mobile-filters-price-range'}
                                        {link class="collapsed" rel="nofollow"
                                            data=["toggle"=> "collapse", "target"=>"#filter-collapse-{$filter->getFrontendName()|@seofy}"]}
                                            {$filter->getFrontendName()}
                                        {/link}
                                        {collapse id="filter-collapse-{$filter->getFrontendName()|@seofy}"
                                            class="snippets-filter-mobile-item-collapse"
                                            visible=true}
                                            {block name='snippets-filter-mobile-include-price-slider'}
                                                {input data=['id'=>'js-price-range-url'] type="hidden" value="{$NaviFilter->getFilterURL()->getURL()}"}
                                                {include file='snippets/filter/price_slider.tpl' id='price-slider-content'}
                                            {/block}
                                        {/collapse}
                                    {/block}
                                {elseif $filter->getClassName() === "JTL\Filter\Items\Search"}
                                    {block name='snippets-filter-mobile-filters-search'}
                                        {link class="collapsed" rel="nofollow"
                                            data=["toggle"=> "collapse", "target"=>"#filter-collapse-{$filter->getFrontendName()|@seofy}"]}
                                            {$filter->getFrontendName()}
                                        {/link}
                                        {collapse id="filter-collapse-{$filter->getFrontendName()|@seofy}"
                                            class="snippets-filter-mobile-item-collapse"
                                            visible=$filter->isActive() || $Einstellungen.template.productlist.filter_items_always_visible === 'Y'}
                                            {block name='snippets-filter-mobile-include-search'}
                                                {include file='snippets/filter/search.tpl'}
                                            {/block}
                                        {/collapse}
                                    {/block}
                                {elseif $filter->getClassName() === "JTL\Filter\Items\Manufacturer"}
                                    {block name='snippets-filter-mobile-filters-manufacturer'}
                                        {link class="collapsed" rel="nofollow"
                                            data=["toggle"=> "collapse", "target"=>"#filter-collapse-{$filter->getFrontendName()|@seofy}"]}
                                            <span class="text-truncate">{$filter->getFrontendName()}</span>
                                        {/link}
                                        {collapse id="filter-collapse-{$filter->getFrontendName()|@seofy}"
                                            class="snippets-filter-mobile-item-collapse"
                                            visible=$filter->isActive() || $Einstellungen.template.productlist.filter_items_always_visible === 'Y'}
                                            {block name='snippets-filter-mobile-include-manufacturer'}
                                                {include file='snippets/filter/manufacturer.tpl'}
                                            {/block}
                                        {/collapse}
                                    {/block}
                                {elseif $filter->getOptions()|count > 0}
                                    {block name='snippets-filter-mobile-filters-generic'}
                                        {link data=["toggle"=> "collapse", "target"=>"#filter-collapse-{$filter->getFrontendName()|@seofy}"] rel="nofollow"}
                                            <span class="text-truncate">{$filter->getFrontendName()}</span>
                                        {/link}
                                        {collapse id="filter-collapse-{$filter->getFrontendName()|@seofy}"
                                            class="snippets-filter-mobile-item-collapse"
                                            visible=$filter->isActive() || $Einstellungen.template.productlist.filter_items_always_visible === 'Y'}
                                            {block name='snippets-filter-mobile-include-generic-filter-item'}
                                                {include file='snippets/filter/genericFilterItem.tpl' filter=$filter}
                                            {/block}
                                        {/collapse}
                                    {/block}
                                {/if}
                            </li>
                        {/if}
                    {/foreach}
                {/block}
            {/if}
        {/if}
        </ul>
        {block name='snippets-filter-mobile-include-active-filter'}
            <div class="productlist-applied-filter">
                {include file='snippets/filter/active_filter.tpl'}
            </div>
        {/block}
    </div>
    {block name='snippets-filter-mobile-footer-buttons'}
        <div class="productlist-filter-footer">
            {formrow class="snippets-filter-mobile-buttons"}
                {col}
                    {button block=true
                        variant="outline-primary"
                        class="no-caret"
                        data=['toggle'=>'collapse', 'dismiss'=>'modal']
                        href="#collapseFilter"
                        aria=['expanded'=>'true','controls'=>'collapseFilter']}
                        {lang key='filterCancel'}
                    {/button}
                {/col}
                {col}
                    {button type="link"
                        block=true
                        variant="primary"
                        class="min-w-sm text-nowrap-util"
                        href="{$NaviFilter->getURL()->getCategories()}"}
                        {lang key='filterShowItem' printf=$itemCount}
                    {/button}
                {/col}
            {/formrow}
        </div>
    {/block}
    {block name='snippets-filter-mobile-js-helpers'}
        <div class="js-helpers">
            {input id="js-price-redirect" type="hidden" value=1}
        </div>
    {/block}
    {block name='snippets-filter-mobile-scripts'}
        {inline_script}<script>
            {literal}
                $('.js-collapse-filter .filter-item, .js-collapse-filter .js-filter-item').on('click', function(e) {
                    e.preventDefault();
                    $.evo.initFilters($(this).attr('href'));
                });
            {/literal}
        </script>{/inline_script}
    {/block}
{/block}
