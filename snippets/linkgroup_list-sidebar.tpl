{block name='snippets-linkgroup-list-sidebar'}
{if isset($linkgroupIdentifier)}
{strip}
{assign var=checkLinkParents value=false}
    {if isset($Link) && $Link->getID() > 0}
        {assign var='activeId' value=$Link->getID()}
    {elseif \JTL\Shop::$kLink > 0}
        {assign var='activeId' value=\JTL\Shop::$kLink}
        {assign var='Link' value=\JTL\Shop::Container()->getLinkService()->getLinkByID($activeId)}
    {/if}
    {if !isset($activeParents) && (isset($Link))}
        {assign var='activeParents' value=\JTL\Shop::Container()->getLinkService()->getParentIDs($activeId)}
        {assign var=checkLinkParents value=true}
    {/if}
    {get_navigation linkgroupIdentifier=$linkgroupIdentifier assign='links'}
    {if !empty($links)}
        {foreach $links as $li}
            <li class="{if $li->getIsActive() || ($checkLinkParents === true && isset($activeParents) && in_array($li->getID(), $activeParents))}active open{/if}{if $tplscope === 'megamenu' && $li->getChildLinks()->count() > 0} bs-hover-enabled{/if}">
				<span>
				<a href="{$li->getURL()}"{if $li->getNoFollow()} rel="nofollow"{/if}{if !empty($li->getTitle())} title="{$li->getTitle()}"{/if}{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)} data-hover-delay="100" data-delay="300"{/if}>
					{$li->getName()}
				</a>
				{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)} <span class="{if !empty($caret)}{$caret}{else}caret{/if}"></span>{/if}
				</span>
				{if $li->getChildLinks()->count() > 0}
					<ul class="">
						{foreach $li->getChildLinks() as $subli}
							{if !empty($subli->getName())}
							<li{if $subli->getIsActive() || ($checkLinkParents === true && isset($activeParents) && in_array($subli->getID(), $activeParents))} class="active"{/if}>
								<a href="{$subli->getURL()}"{if $subli->getNoFollow()} rel="nofollow"{/if}{if !empty($subli->getTitle())} title="{$subli->getTitle()}"{/if}>
									{$subli->getName()}
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