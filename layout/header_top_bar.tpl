{block name='layout-header-top-bar'}
{strip}
{if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1 || isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1 || $snackyConfig.headerSocial == 0}
    {block name="top-bar-user-settings"}
    <ul class="list-inline">
        {block name="top-bar-user-settings-currency"}
        {if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
            <li class="dropdown">
                <a href="#" class="dropdown-toggle dpflex-a-center" data-toggle="dropdown" title="{lang key='selectCurrency'}">
					{$smarty.session.Waehrung->getName()} <span class="caret"></span>
				</a>
                <ul class="dropdown-menu">
                {foreach from=$smarty.session.Waehrungen item=oWaehrung}
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
        {* /language-dropdown *}
        {/if}
        {/block}
		{if $snackyConfig.headerSocial == 0 && $snackyConfig.headerType != 2  && $snackyConfig.headerType != 3}
		<li>
			{include file="snippets/socialprofiles.tpl"}
		</li>
		{/if}
    </ul>{* user-settings *}
    {/block}
{/if}
{if $linkgroups->getLinkGroupByTemplate('Kopf') !== null}
<ul class="list-inline">
    {block name="top-bar-cms-pages"}
        {foreach $linkgroups->getLinkGroupByTemplate('Kopf')->getLinks() as $Link}
			<li{if $Link->getIsActive()} class="active"{/if}>
				<a class="defaultlink" href="{$Link->getURL()}"{if $Link->getNoFollow()} rel="nofollow"{/if} title="{$Link->getTitle()}">{$Link->getName()}</a>
			</li>
        {/foreach}
    {/block}
</ul>
{/if}
{/strip}
{/block}