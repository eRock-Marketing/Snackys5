{block name='snippets-linkgroup-list-fullscreen'}
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
            <li class="{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)}mgm-fw{/if}{if $li->getIsActive() || ($checkLinkParents === true && isset($activeParents) && in_array($li->getID(), $activeParents))} active{/if}{if $tplscope === 'megamenu' && $li->getChildLinks()->count() > 0} bs-hover-enabled{/if}">
				<a href="{$li->getURL()}"{if $li->getNoFollow()} rel="nofollow"{/if}{if !empty($li->getTitle())} title="{$li->getTitle()}"{/if} class="dropdown-toggle-mmenu" data-toggle="dropdown" data-hover="dropdown">
					{$li->getName()}
					{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)} <span class="ar ar-r"></span><span class="fa-caret-down visible-xs"></span>{/if}
				</a>
				{if $li->getChildLinks()->count() > 0}
					<ul class="mm-fullscreen">
						<li>
									<a class="category-title block" href="{$li->getURL()}"{if $li->getNoFollow()} rel="nofollow"{/if}{if $li->getTitle()} title="{$li->cTitle}"{/if}>
										{$li->getName()}
									</a>
								<ul class="lg-list">
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
						</li>
					</ul>
				{/if}
            </li>
        {/foreach}
    {/if}
{/strip}
{/if}
{/block}