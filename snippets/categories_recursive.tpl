{block name='snippets-categories-recursive'}
{if (!empty($categories) ||isset($categoryId)) && (!isset($i) || isset($i) && isset($limit) && $i < $limit)}
    {strip}
        {if !isset($i)}
            {assign var='i' value=0}
        {/if}
        {if !isset($limit)}
            {assign var='limit' value=3}
        {/if}
        {if !isset($caret)}
            {assign var='caret' value='down'}
        {/if}
        {if !isset($activeId)}
            {if $NaviFilter->hasCategory()}
                {$activeId = $NaviFilter->getCategory()->getValue()}
            {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($Artikel)}
                {assign var='activeId' value=$Artikel->gibKategorie()}
            {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($smarty.session.LetzteKategorie)}
                {$activeId = $smarty.session.LetzteKategorie}
            {else}
                {$activeId = 0}
            {/if}
        {/if}
        {if !isset($activeParents)
        && ($nSeitenTyp === $smarty.const.PAGE_ARTIKEL || $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE)}
            {get_category_parents categoryId=$activeId assign='activeParents'}
        {/if}
        {if !isset($activeParents)}
            {assign var="activeParents" value=null}
        {/if}
        {if empty($categories)}
            {if !isset($categoryBoxNumber)}
                {assign var='categoryBoxNumber' value=null}
            {/if}
            {get_category_array categoryId=$categoryId categoryBoxNumber=$categoryBoxNumber assign='categories'}
        {/if}
        {if !empty($categories)}
            {foreach $categories as $category}
                {assign var='hasItems' value=$category->hasChildren() && (($i+1) < $limit)}
                {if isset($activeParents) && is_array($activeParents) && isset($activeParents[$i])}
                    {assign var='activeParent' value=$activeParents[$i]}
                {/if}
				{assign var="catFunctions" value=$category->getFunctionalAttributes()}
                <li class="nav-it{if $category->getID() == $activeId || ((isset($activeParent) && isset($activeParent->getID())) && $activeParent->getID() == $category->getID())} active open{/if}{if is_array($catFunctions) && !empty($catFunctions["css_klasse"])} {$catFunctions["css_klasse"]}{/if}">
                    <a href="{$category->getURL()}"{if $hasItems} class="nav-sub dpflex{if $category->getID() == $activeId || ((isset($activeParent) && isset($activeParent->getID())) && $activeParent->getID() == $category->getID())} active open{/if}"{/if} data-ref="{$category->getID()}" title="{$category->getShortName()|escape:'html'}">
                        {$category->getShortName()}
                        {if $hasItems}<i class="fa fa-caret-{$caret} nav-toggle"></i>{/if}
                    </a>
                    {if $hasItems}
                        <ul class="nav">
                            {if !empty($category->getChildren())}
                                {include file='snippets/categories_recursive.tpl' i=$i+1 categories=$category->getChildren() limit=$limit activeId=$activeId activeParents=$activeParents}
                            {else}
                                {include file='snippets/categories_recursive.tpl' i=$i+1 categoryId=$category->getID() limit=$limit categories=null activeId=$activeId activeParents=$activeParents}
                            {/if}
                        </ul>
                    {/if}
                </li>
            {/foreach}
        {/if}
    {/strip}
{/if}
{/block}