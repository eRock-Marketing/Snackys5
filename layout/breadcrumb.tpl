{block name='layout-breadcrumb'}
{strip}
{has_boxes position='left' assign='hasLeftBox'}
{if !empty($Brotnavi) && !$bExclusive && !$bAjaxRequest && $nSeitenTyp !== $smarty.const.PAGE_STARTSEITE && $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG && $nSeitenTyp !== $smarty.const.PAGE_BESTELLSTATUS}
<div id="bc-w" class="hidden-xs small">
	<ol id="bc" class="bc mw-container dpflex-a-center">
		{foreach name=navi from=$Brotnavi item=oItem}
			{if $smarty.foreach.navi.first}
				{block name="bc-first-item"}
				   <li class="bc-item first">
						<a href="{$oItem->getURLFull()}" title="{$oItem->getName()|escape:'html'}">
							<span class="img-ct icon">
								<svg>
								  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-home"></use>
								</svg>
							</span>
						</a>
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
					<li class="bc-item" >
						<a href="{$oItem->getURLFull()}" title="{$oItem->getName()|escape:'html'}">
							<span >{$oItem->getName()}</span>
						</a>
					</li>
				{/block}
			{/if}
		{/foreach}
	</ol>
</div>
{/if}
{/strip}
{/block}