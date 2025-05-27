{block name='snippets-linkgroup-recursive'}
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
				<li class="title{if $li->getIsActive() || (isset($activeParent) && $activeParent == $li->getID())} active{/if}{if $snackyConfig.dropdown_plus == 1 && $hasItems} dd-plus{/if}">
					<a href="{$li->getURL()}" class="dropdown-link defaultlink"{if $li->getNoFollow()} rel="nofollow"{/if}{if !empty($li->getTitle())} title="{$li->getTitle()}"{/if} data-ref="{$li->getID()}" target="{$li->getTarget()}">
						<span class="notextov">{$li->getName()}</span>
                        {if $hasItems}
                            <span class="ar ar-r hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
                        {/if}
					</a>
                    {if $snackyConfig.dropdown_plus == 1 && $hasItems}
                        <span class="hidden-xs dd-toggle" type="button" data-toggle="collapse" data-target="#dd-{$li->getID()}" aria-expanded="false" aria-controls="dd-{$li->getID()}">
                            <span class="ar ar-d"></span>
                        </span>
                    {/if}
					{if $hasItems}
						<ul class="dropdown-menu keepopen"{if $snackyConfig.dropdown_plus == 1} id="dd-{$li->getID()}"{/if}>
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