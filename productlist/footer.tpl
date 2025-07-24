{block name='productlist-footer'}
{assign var=Suchergebnisse value=$NaviFilter->getSearchResults(false)}
{if $Suchergebnisse->getProducts()|@count > 0 && $snackyConfig.useEndlessScrolling != 'Y' && $snackyConfig.useEndlessScrolling != 'B'}
	{if $Einstellungen.navigationsfilter.suchtrefferfilter_nutzen === 'Y'
		&& $Suchergebnisse->getSearchFilterOptions()|@count > 0
		&& $Suchergebnisse->getSearchFilterJSON()
		&& !$NaviFilter->hasSearchFilter()}
			<div class="panel panel-default tags tags-list">
				<div class="panel-heading"><h3 class="panel-title">{lang key="productsSearchTerm" section="productOverview"}</h3></div>
				<div class="panel-body">
					{foreach $Suchergebnisse->getSearchFilterOptions() as $oSuchFilter}
						<a href="{$oSuchFilter->getURL()}" class="btn btn-xs badge tag{$oSuchFilter->getClass()}">{$oSuchFilter->getName()}</a>
					{/foreach}
				</div>
			</div>
	{/if}
{/if}

{if $Suchergebnisse->getPages()->getMaxPage() > 1}
	{include file="snippets/zonen.tpl" id="opc_before_footer"}
	<div class="row">
		<div class="col-12">
	{include file="snippets/zonen.tpl" id="opc_before_footer"}
    <ul class="pagination pagination-ajax dpflex-j-center blanklist">
        {if $filterPagination->getPrev()->getPageNumber() > 0}
            <li class="prev icon-wt">
                <a href="{$filterPagination->getPrev()->getURL()}" class="btn btn-rd btn-blank">&laquo;</a>
            </li>
        {/if}

        {foreach $filterPagination->getPages() as $page}
            <li class="page icon-wt{if $page->isActive()} active{/if}">
                <a href="{$page->getURL()}" class="btn btn-rd btn-blank{if $page->isActive()} btn-primary{/if}">{$page->getPageNumber()}</a>
            </li>
        {/foreach}

        {if $filterPagination->getNext()->getPageNumber() > 0}
            <li class="next icon-wt">
                <a href="{$filterPagination->getNext()->getURL()}" class="btn btn-rd btn-blank">&raquo;</a>
            </li>
        {/if}
    </ul>
    <hr class="hr-sm invisible">
    <form action="{$ShopURL}/" method="get" class="pagination dpflex-j-center">
        {$jtl_token}
        {if $NaviFilter->hasCategory()}
            <input type="hidden" name="k" value="{$NaviFilter->getCategory()->getValue()}" />
        {/if}
        {if $NaviFilter->hasManufacturer()}
            <input type="hidden" name="h" value="{$NaviFilter->getManufacturer()->getValue()}" />
        {/if}				
        {if $NaviFilter->hasSearchQuery()}
            <input type="hidden" name="l" value="{$NaviFilter->getSearchQuery()->getValue()}" />
        {/if}
        {if $NaviFilter->hasCategoryFilter()}
            {assign var=cfv value=$NaviFilter->getCategoryFilter()->getValue()}
            {if is_array($cfv)}
                {foreach $cfv as $val}
                    <input type="hidden" name="hf" value="{$val}" />
                {/foreach}
            {else}
                <input type="hidden" name="kf" value="{$cfv}" />
            {/if}
        {/if}
        {if $NaviFilter->hasManufacturerFilter()}
            {assign var=mfv value=$NaviFilter->getManufacturerFilter()->getValue()}
            {if is_array($mfv)}
                {foreach $mfv as $val}
                    <input type="hidden" name="hf" value="{$val}" />
                {/foreach}
            {else}
                <input type="hidden" name="hf" value="{$mfv}" />
            {/if}
        {/if}
        {foreach $NaviFilter->getCharacteristicFilter() as $filter}
            <input type="hidden" name="mf{$filter@iteration}" value="{$filter->getValue()}" />
        {/foreach}

        <div class="dropdown">
            <button class="btn btn btn-sm btn-blank dropdown-toggle m0" type="button" id="pagination-dropdown" data-toggle="dropdown" aria-expanded="true">
                {lang key="goToPage" section="productOverview"}
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pagination-ajax small" role="menu" aria-labelledby="pagination-dropdown">
                {foreach $filterPagination->getPages() as $page}
                    {if $page->isActive()}
                        <li class="active">
                            <a role="menuitem" class="disabled" href="{$page->getURL()}">{$page->getPageNumber()}</a>
                        </li>
                    {else}
                        <li>
                            <a role="menuitem" tabindex="-1" href="{$page->getURL()}">{$page->getPageNumber()}</a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
        </div>
    </form>
		</div>
	</div>
{/if}


{if isset($oNavigationsinfo->getCategory()->categoryAttributes.seo_longtext)}
	<div class="item_desc custom_content">
		{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->getCategory()->categoryAttributes.seo_longtext->cWert|optimize}{else}{$oNavigationsinfo->getCategory()->categoryAttributes.seo_longtext->cWert}{/if}
	</div>
{/if}
{/block}