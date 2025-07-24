{block name='snippets-linkgroup-list'}
{if isset($linkgroupIdentifier)}
{strip}
{assign var=checkLinkParents value=false}
{assign var=activeId value=0}
    {if isset($Link) && $Link->getID() > 0}
        {assign var='activeId' value=$Link->getID()}
    {elseif \JTL\Shop::$kLink > 0}
        {assign var='activeId' value=\JTL\Shop::$kLink}
        {assign var='Link' value=\JTL\Shop::Container()->getLinkService()->getLinkByID($activeId)}
    {/if}
    {if !isset($activeParents) && $activeId > 0}
        {assign var='activeParents' value=\JTL\Shop::Container()->getLinkService()->getParentIDs($activeId)}
        {assign var=checkLinkParents value=true}
    {/if}
    {get_navigation linkgroupIdentifier=$linkgroupIdentifier assign='links'}
    {if !empty($links)}
        {foreach $links as $li}
            <li class="{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)}mgm-fw dropdown-style{/if}{if $li->getIsActive() || ($checkLinkParents === true && isset($activeParents) && in_array($li->getID(), $activeParents))} active{/if}{if $tplscope} {$tplscope}{/if}">
				<a href="{$li->getURL()}" class="mm-mainlink"{if $li->getNoFollow()} rel="nofollow"{/if}{if !empty($li->getTitle())} title="{$li->getTitle()}"{/if} target="{$li->getTarget()}">
					{$li->getName()}
					{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)} <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}{/if}
				</a>
				{if $li->getChildLinks()->count() > 0}
					<ul class="{if isset($dropdownSupport)}dropdown-menu keepopen first mgm-fw{else}submenu list-unstyled{/if}">
                        {if $snackyConfig.dropdown_plus != 0}
                            {assign var='limit' value=100}
                        {else}
                            {assign var='limit' value=3}
                        {/if}
                        {if $li->getChildLinks()->count() > 0}
                            {include file='snippets/linkgroup_recursive_dropdown.tpl' i=$i+1 links=$li->getChildLinks() limit=$limit activeId=$activeId activeParents=$activeParents}
                        {else}
                            {include file='snippets/linkgroup_recursive_dropdown.tpl' i=$i+1 links=array($li) limit=$limit activeId=$activeId activeParents=$activeParents}
                        {/if}
					</ul>
				{/if}
            </li>
        {/foreach}
    {/if}
{/strip}
{/if}
{/block}