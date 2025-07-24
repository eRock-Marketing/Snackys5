{block name='snippets-linkgroup-list'}
{if isset($linkgroupIdentifier)}
{strip}
{assign var=checkLinkParents value=false}
    {if isset($Link) && $Link->getID() > 0}
        {assign var='activeId' value=$Link->getID()}
    {elseif \JTL\Shop::$kLink > 0}
        {assign var='activeId' value=\JTL\Shop::$kLink}
        {assign var='Link' value=\JTL\Shop::Container()->getLinkService()->getLinkByID($activeId)}
    {/if}
    {if !isset($activeParents) && (isset($Link)) && $activeId}
        {assign var='activeParents' value=\JTL\Shop::Container()->getLinkService()->getParentIDs($activeId)}
        {assign var=checkLinkParents value=true}
    {/if}
    {get_navigation linkgroupIdentifier=$linkgroupIdentifier assign='links'}
    {if !empty($links)}
        {foreach $links as $li}
            <li class="{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)}mgm-fw dropdown-style{/if}{if $li->getIsActive() || ($checkLinkParents === true && isset($activeParents) && in_array($li->getID(), $activeParents))} active{/if}">
				<a href="{$li->getURL()}" class="mm-mainlink"{if $li->getNoFollow()} rel="nofollow"{/if}{if !empty($li->getTitle())} title="{$li->getTitle()}"{/if}>
					{$li->getName()}
					{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)} <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}{/if}
				</a>
				{if $li->getChildLinks()->count() > 0}
					<ul class="{if isset($dropdownSupport)}dropdown-menu keepopen{else}submenu list-unstyled{/if}">
						{foreach $li->getChildLinks() as $subli}
							{if !empty($subli->getName())}
							<li{if $subli->getIsActive() || ($checkLinkParents === true && isset($activeParents) && in_array($subli->getID(), $activeParents))} class="active"{/if}>
								<a href="{$subli->getURL()}" class="dropdown-link defaultlink"{if $subli->getNoFollow()} rel="nofollow"{/if}{if !empty($subli->getTitle())} title="{$subli->getTitle()}"{/if}>
									<span class="notextov">{$subli->getName()}</span>
								</a>
							</li>
							{/if}
						{/foreach}
					</ul>
				{/if}
            </li>
        {/foreach}
    {/if}
{/strip}
{/if}
{/block}