{block name='snippets-linkgroup-recursive-mobile'}
{if isset($linkgroupIdentifier) && (!isset($i) || isset($limit) && $i < $limit)}
	{strip}
        {if !isset($i)}
            {assign var='i' value=0}
        {/if}
        {if !isset($limit)}
            {assign var='limit' value=3}
        {/if}
        {if !isset($activeId)}
            {assign var='activeId' value=0}
            {if isset($Link) && $Link->getID() > 0}
                {assign var='activeId' value=$Link->getID()}
            {elseif \JTL\Shop::$kLink > 0}
                {assign var='activeId' value=\JTL\Shop::$kLink}
                {assign var='Link' value=\JTL\Shop::Container()->getLinkService()->getLinkByID($activeId)}
            {/if}
        {/if}
        {if !isset($activeParents) && $activeId}
            {assign var='activeParents' value=\JTL\Shop::Container()->getLinkService()->getParentIDs($activeId)}
        {/if}
        {if !isset($links)}
            {get_navigation linkgroupIdentifier=$linkgroupIdentifier assign='links'}
        {/if}
        {if !empty($links)}
            {foreach $links as $li}
                {assign var='hasItems' value=$li->getChildLinks()->count() > 0 && (($i+1) < $limit)}
                {if isset($activeParents) && is_array($activeParents) && isset($activeParents[$i])}
                    {assign var='activeParent' value=$activeParents[$i]}
                {/if}
				<li class="{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)}mgm-fw dropdown-style{/if}{if $li->getIsActive() || (isset($activeParent) && $activeParent == $li->getID())} active{/if}">
					<a href="{$li->getURL()}" class="mm-mainlink"{if $li->getNoFollow()} rel="nofollow"{/if}{if !empty($li->getTitle())} title="{$li->getTitle()}"{/if} data-ref="{$li->getID()}" target="{$li->getTarget()}">
						{$li->getName()}
						{if $li->getChildLinks()->count() > 0 && isset($dropdownSupport) && $hasItems}<span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}{/if}
					</a>
					{if $hasItems}
						<ul class="dropdown-menu keepopen">
							{if $snackyConfig.mmenu_link_clickable == 'N'}
							<li class="title{if $li->getIsActive()} active{/if}">
								<a href="{$li->getURL()}" class="mm-mainlink"{if $li->getNoFollow()} rel="nofollow"{/if}{if !empty($li->getTitle())} title="{$li->getTitle()}"{/if} data-ref="{$li->kLink}" target="{$li->getTarget()}">
									{lang key="showAll" section="global"}
								</a>
							</li>
							{/if}
							{if $li->getChildLinks()->count() > 0}
								{include file='snippets/linkgroup_recursive_mobile.tpl' i=$i+1 links=$li->getChildLinks() limit=$limit activeId=$activeId activeParents=$activeParents}
							{else}
								{include file='snippets/linkgroup_recursive_mobile.tpl' i=$i+1 links=array($li) limit=$limit activeId=$activeId activeParents=$activeParents}
							{/if}
						</ul>
					{/if}
				</li>
			{/foreach}
		{/if}
	{/strip}
{/if}
{/block}