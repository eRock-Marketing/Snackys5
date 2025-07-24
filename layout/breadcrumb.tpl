{block name='layout-breadcrumb'}
{strip}
{has_boxes position='left' assign='hasLeftBox'}
{if !empty($Brotnavi) && !$bExclusive && !$bAjaxRequest && $nSeitenTyp !== $smarty.const.PAGE_STARTSEITE && $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG && $nSeitenTyp !== $smarty.const.PAGE_BESTELLSTATUS}
<div id="bc-w" class="hidden-xs small">
	<ol id="bc" class="bc mw-container dpflex-a-center" itemprop="breadcrumb" itemscope itemtype="http://schema.org/breadcrumbList">
		{foreach name=navi from=$Brotnavi item=oItem}
			{if $smarty.foreach.navi.first}
				{block name="bc-first-item"}
				   <li class="bc-item first" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
						<a itemprop="item" href="{$oItem->getURLFull()}" title="{$oItem->getName()|escape:'html'}">
							<span class="img-ct icon">
								<svg>
								  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-home"></use>
								</svg>
							</span>
							<span itemprop="name" class="hidden">{$oItem->getName()|escape:'html'}</span>
						</a>
						<meta itemprop="url" content="{$oItem->getURLFull()}" />
						<meta itemprop="position" content="{$smarty.foreach.navi.iteration}" />
					</li>
				{/block}
			{elseif $smarty.foreach.navi.last}
				{block name="bc-last-item"}
					{* Letztes Element nicht in Microdaten angeben, das passiert automatisiert! *}
                    {if $nSeitenTyp != 1}
                        <li class="separator">/</li>
                        {if $oItem->getName() !== null}
                            <li class="bc-item last">
                                <span >
                                    <span>{$oItem->getName()}</span>
                                </span>
                            </li>
                        {elseif isset($Suchergebnisse->getSearchTermWrite())}
                            <li class="bc-item last">
                                {$Suchergebnisse->getSearchTermWrite()}
                            </li>
                        {/if}
					{/if}
				{/block}
			{else}
				{block name="bc-item"}              
					<li class="separator">/</li>
					<li class="bc-item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
						<a itemprop="item" href="{$oItem->getURLFull()}" title="{$oItem->getName()|escape:'html'}">
							<span itemprop="name">{$oItem->getName()}</span>
						</a>
						<meta itemprop="url" content="{$oItem->getURLFull()}" />
						<meta itemprop="position" content="{$smarty.foreach.navi.iteration}" />
					</li>
				{/block}
			{/if}
		{/foreach}
	</ol>
</div>
{/if}
{/strip}
{/block}