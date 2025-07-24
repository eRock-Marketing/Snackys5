{block name='productlist-filter-top'}
{assign var=ismobile value=false}
{if $isMobile && !$isTablet}
    {assign var=ismobile value=true}
{/if}
{if $show_filters}
<div id="ftr-tp" class="mb-sm">
    {if !$isMobile}
    <div class="dpflex-a-c dpflex-j-b">
        <div class="h5 m0">{lang key='filterAndSort'}</div>
        {if $Suchergebnisse->getProductCount() >= 1}<div>{$Suchergebnisse->getProductCount()} {lang key='products'}</div>{/if}
    </div>
    <hr class="invisible hr-sm">
    {/if}
    {if count($contentFilters) > 0 || count($Suchergebnisse->getProducts()) > 0}
        {if !$isMobile}
        <div class="ftr-tg visible-sm visible-xs mb-xs">
            <a class="btn btn-default btn-block" data-toggle="collapse" href="#filter-collapsible" aria-expanded="true" aria-controls="filter-collapsible">
                {lang key='filterBy'}
                <span class="caret"></span>
            </a>
        </div>
        {/if}
        <div id="filter-collapsible"
             class="collapse{if $ismobile} in{/if}" aria-expanded="{if !$ismobile}false{else}true{/if}" role="button">
                <div id="nav-ft">
                    <div class="row">
                        {foreach $contentFilters as $filter}
                            {if count($filter->getFilterCollection()) > 0}
                                {block name='productlist-result-options-'|cat:$filter->getNiceName()}
                                    {foreach $filter->getOptions() as $subFilter}
                                        {if $subFilter->getVisibility() !== \JTL\Filter\Visibility::SHOW_NEVER && $subFilter->getVisibility() !== \JTL\Filter\Visibility::SHOW_BOX}
                                        <div class="col-12 col-sm-12 col-md-6 col-lg-4{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-3{/if}">
                                            <div class="form-group dropdown filter-type-{$filter->getNiceName()}">
                                                <a href="#" class="btn dropdown-toggle btn-block btn-default" data-toggle="dropdown" role="button" aria-expanded="false">
                                                    <span class="name">{$subFilter->getFrontendName()}</span> <span class="caret"></span>
                                                </a>
                                                <div class="dropdown-menu">
                                                    {include file='snippets/filter/characteristic.tpl' Merkmal=$subFilter}
                                                </div>
                                            </div>
                                        </div>
                                        {/if}
                                    {/foreach}
                                {/block}
                            {else}
                                {block name='productlist-result-options-'|cat:$filter->getNiceName()}
                                {if $filter->getOptions()|@count > 0}
                                <div class="col-12 col-sm-12 col-md-6 col-lg-4{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-3{/if}">
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
                                        {if $innerClass == "dropdown-menu"}<div class="dropdown-menu">{/if}
                                            {include file='snippets/filter/genericFilterItem.tpl' class=$innerClass itemClass=$itemClass filter=$filter}
                                        {if $innerClass == "dropdown-menu"}</div>{/if}
                                    </div>
                                </div>
                                {/if}
                                {/block}
                            {/if}
                        {/foreach}
                        {if !$isMobile}
                            {include file="productlist/improve_search.tpl"} 
                            {has_boxes position='left' assign='hasLeftBox'}
                            {if !empty($boxes.left)}
                                {assign var="hasFilters" value="true"}	
                            {else}
                                {assign var="hasFilters" value=false}	
                            {/if}
                            {if ($hasFilters) == true}
                            <div class="col-12 col-sm-12 col-md-6 col-lg-4{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-3{/if} more-ftr">
                                <div class="form-group">
                                    <div class="btn dpflex-a-c" id="ftr-tg">
                                        {lang key="moreFilters" section="custom"} 
                                        <div class="img-ct icon ic-md"> 
                                            <svg class="">
                                                <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-filter"></use>
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {/if}
                        {/if}
                    </div>{* /form-inline2 *}
                </div>
                {*/.navbar-collapse*}
        </div>
    {/if}
    {if !$isMobile}
        {include file="productlist/active_filters.tpl"} 
    {/if}
</div>
{elseif !$isMobile && !empty($boxes.left)}
<div class="visible-xs visible-sm mb-sm">
    <div class="btn dpflex-a-c dpflex-j-b w100" id="ftr-tg">
        <div class="dpflex-a-c">
            <div class="img-ct icon ic-md mr-xxs"> 
                <svg class="">
                    <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-filter"></use>
                </svg>
            </div>
            {lang key='filterBy'}
        </div>
        {if $Suchergebnisse->getProductCount() >= 1}{$Suchergebnisse->getProductCount()} {lang key='products'}{/if} 
    </div>
</div>
{/if}
{/block}