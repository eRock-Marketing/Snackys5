{block name='productlist-filter-top'}
{assign var=ismobile value=false}
{if $isMobile && !$isTablet}
    {assign var=ismobile value=true}
{/if}
{if $show_filters}
    {if $NaviFilter->getFilterCount() > 0}
        <div class="active-filters mb-xs">
                {foreach $NaviFilter->getActiveFilters() as $activeFilter}
                    {assign var=activeFilterValue value=$activeFilter->getValue()}
                    {assign var=activeValues value=$activeFilter->getActiveValues()}
                    {if $activeFilterValue !== null}
                        {if $activeValues|is_array}
                            {foreach $activeValues as $filterOption}
                                {strip}
                                    <a href="{$activeFilter->getUnsetFilterURL($filterOption->getValue())}" rel="nofollow" title="Filter {lang key='delete'}" class="btn filter-type-{$activeFilter->getNiceName()}{if $ismobile} btn-block{/if}">
                                        <div class="img-ct icon mr-xxs">
                                            <svg>
                                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
                                            </svg>
                                        </div>
                                        {$filterOption->getFrontendName()}
                                    </a>
                                {/strip}
                            {/foreach}
                        {else}
                            {strip}
                                <a href="{$activeFilter->getUnsetFilterURL($activeFilter->getValue())}" rel="nofollow" title="Filter {lang key='delete'}" class="btn filter-type-{$activeFilter->getNiceName()}{if $ismobile} btn-block{/if}">
                                    <div class="img-ct icon mr-xxs">
                                        <svg>
                                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
                                        </svg>
                                    </div>
                                    {$activeValues->getFrontendName()}  
                                </a>
                            {/strip}
                        {/if}
                    {/if}
                {/foreach}
                {if $NaviFilter->getURL()->getUnsetAll() !== null}
                    {strip}
                        <a href="{$NaviFilter->getURL()->getUnsetAll()}" title="{lang key='removeFilters'}" class="btn{if $ismobile} btn-block{/if}">
                            <div class="img-ct icon mr-xxs">
                                <svg>
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
                                </svg>
                            </div>
                            {lang key='removeFilters'}
                        </a>
                    {/strip}
                {/if}
        </div>
    {/if}
    {if count($contentFilters) > 0}
        {if !$ismobile}
        <div class="ftr-tg visible-sm visible-xs mb-xs">
            <a class="btn btn-default btn-block" data-toggle="collapse" href="#filter-collapsible" aria-expanded="true" aria-controls="filter-collapsible">
                <span class="fa fa-filter"></span> {lang key='filterBy'}
                <span class="caret"></span>
            </a>
        </div>
        {/if}
        <div id="filter-collapsible"
             class="collapse mb-sm{if $ismobile} in{/if}" aria-expanded="{if !$ismobile}false{else}true{/if}" role="button">
                <div id="nav-ft">
                    <div class="row">
                        {foreach $contentFilters as $filter}
                            {if count($filter->getFilterCollection()) > 0}
                                {block name='productlist-result-options-'|cat:$filter->getNiceName()}
                                    {foreach $filter->getOptions() as $subFilter}
                                        {if $subFilter->getVisibility() !== \JTL\Filter\Visibility::SHOW_NEVER && $subFilter->getVisibility() !== \JTL\Filter\Visibility::SHOW_BOX}
                                        <div class="col-12 col-sm-12 col-md-4 col-lg-3{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-2{/if}">
                                            <div class="form-group dropdown filter-type-{$filter->getNiceName()}">
                                                <a href="#" class="btn dropdown-toggle btn-block btn-default" data-toggle="dropdown" role="button" aria-expanded="false">
                                                    <span class="name">{$subFilter->getFrontendName()}</span> <span class="caret"></span>
                                                </a>
                                                {include file='snippets/filter/genericFilterItem.tpl' itemClass='' class='dropdown-menu' filter=$subFilter sub=true}
                                            </div>
                                        </div>
                                        {/if}
                                    {/foreach}
                                {/block}
                            {else}
                                {block name='productlist-result-options-'|cat:$filter->getNiceName()}
                                <div class="col-12 col-sm-12 col-md-4 col-lg-3{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-2{/if}">
                                    {if $filter->getInputType() === \JTL\Filter\InputType::SELECT}
                                        {assign var=outerClass value='form-group dropdown filter-type-'|cat:$filter->getNiceName()}
                                        {assign var=innerClass value='dropdown-menu'}
                                        {assign var=itemClass value=''}
                                    {elseif $filter->getInputType() === \JTL\Filter\InputType::BUTTON}
                                        {assign var=outerClass value='form-group no-dropdown filter-type-'|cat:$filter->getNiceName()}
                                        {assign var=innerClass value='no-dropdown'}
                                        {assign var=itemClass value='btn'}
                                    {else}
                                        {assign var=outerClass value='form-group no-dropdown filter-type-'|cat:$filter->getNiceName()}
                                        {assign var=innerClass value='no-dropdown'}
                                        {assign var=itemClass value=''}
                                    {/if}
                                    <div class="{$outerClass}">
                                        {if $filter->getInputType() === \JTL\Filter\InputType::SELECT}
                                            <a href="#" class="btn dropdown-toggle btn-block btn-default" data-toggle="dropdown" role="button" aria-expanded="false">
                                                <span class="name">{$filter->getFrontendName()}</span> <span class="caret"></span>
                                            </a>
                                        {/if}
                                        {include file='snippets/filter/genericFilterItem.tpl' class=$innerClass itemClass=$itemClass filter=$filter}
                                    </div>
                                </div>
                                {/block}
                            {/if}
                        {/foreach}
                    </div>{* /form-inline2 *}
                </div>
                {*/.navbar-collapse*}
        </div>
    {/if}
{/if}
{/block}