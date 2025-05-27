{block name='layout-header-top-bar'}
{strip}
    {if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1 || isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1 || $snackyConfig.headerSocial == 0}
        {block name="top-bar-user-settings"}
            <ul class="list-inline">
                {block name="top-bar-user-settings-currency"}
					{if JTL\Session\Frontend::getCurrencies()|count > 1}
						<li class="dropdown">
							<a href="#" class="dropdown-toggle flx-ac" data-toggle="dropdown" title="{lang key='selectCurrency'}">
								{JTL\Session\Frontend::getCurrency()->getName()} <span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
							{foreach JTL\Session\Frontend::getCurrencies() item=oWaehrung}
								<li>
									<a href="{$oWaehrung->getURL()}" rel="nofollow">{$oWaehrung->getName()}</a>
								</li>
							{/foreach}
							</ul>
						</li>
					{/if}
                {/block}
                {block name="top-bar-user-settings-language"}
					{if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
						{include file="snippets/language_dropdown.tpl"}
					{/if}
                {/block}
				{block name="top-bar-socialprofiles"}
					{if $snackyConfig.headerSocial == 0 && $snackyConfig.headerType != 2  && $snackyConfig.headerType != 3}
						<li>
							{include file="snippets/socialprofiles.tpl"}
						</li>
					{/if}
				{/block}
            </ul>
        {/block}
    {/if}
	{block name="top-bar-cms-pages-wrapper"}
		{if $linkgroups->getLinkGroupByTemplate('Kopf') !== null}
			<ul class="list-inline">
				{block name="top-bar-cms-pages"}
					{foreach $linkgroups->getLinkGroupByTemplate('Kopf')->getLinks() as $Link}
						{if $Link->getParent() == '0'}
							{assign var='hasItems' value=$Link->getChildLinks()->count() > 0}
							<li class="dropdown dropdown-toggle {if $Link->getIsActive()}active{/if}">
								<a class="defaultlink {if $hasItems}dropdown-toggle{/if}" href="{$Link->getURL()}"{if $Link->getNoFollow()} rel="nofollow"{/if} title="{$Link->getTitle()}" target="{$Link->getTarget()}" 
							   		{if $hasItems}data-toggle="dropdown" aria-expanded="false"{/if}>{$Link->getName()}
									{if $hasItems}<span class="caret"></span>{/if}
								</a>
								{if $hasItems}
									<ul class="dropdown-menu dropdown-menu-right">
										{foreach $Link->getChildLinks() as $SubLink}
											<li{if $SubLink->getIsActive()} class="active"{/if}>
												<a class="defaultlink kk0" href="{$SubLink->getURL()}"{if $SubLink->getNoFollow()} rel="nofollow"{/if} title="{$SubLink->getTitle()}">{$SubLink->getName()}</a>
											</li>
										{/foreach}
									</ul>
								{/if}
							</li>
						{/if}
					{/foreach}
				{/block}
			</ul>
		{/if}
	{/block}
{/strip}
{/block}