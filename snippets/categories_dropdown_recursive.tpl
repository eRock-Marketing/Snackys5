{block name='snippets-categories-dropdown-recursive'}
{if $i < $limit}
    {if !isset($i)}
        {assign var='i' value=0}
    {else}
        {assign var='i' value=$i+1}
    {/if}
    <li class="title{if $show_subcategories && $sub->hasChildren()} mgm-fw keepopen{/if}{if $sub->getID() == $activeId || (isset($activeParents[1]) && $activeParents[1]->getID() == $sub->getID())} active{/if}{if !empty($catFunctions["css_klasse"])} {$catFunctions["css_klasse"]}{/if}{if $snackyConfig.dropdown_plus == 1 && $show_subcategories && $sub->hasChildren()} dd-plus{/if}">
        {if !empty($mainCategory->getChildren())}
            {assign var=sub_categories value=$mainCategory->getChildren()}
        {else}
            {get_category_array categoryId=$mainCategory->getID() assign='sub_categories'}
        {/if}
        <a href="{$mainCategory->getURL()}" class="dropdown-link defaultlink">
            <span class="notextov">
                {$mainCategory->getShortName()}
            </span>
            {if $show_subcategories && $mainCategory->hasChildren() && $i < $limit}
            <span class="ar ar-r hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
            {/if}
        </a>
        {if $snackyConfig.dropdown_plus == 1 && $show_subcategories && $mainCategory->hasChildren() && $i < $limit}
            <button class="hidden-xs dd-toggle" type="button" data-toggle="collapse" data-target="#mm-{$mainCategory->getID()}" aria-expanded="false" aria-controls="mm-{$mainCategory->getID()}">
                <span class="ar ar-d"></span>
            </button>
        {/if}
        {if $show_subcategories && $mainCategory->hasChildren() && $i < $limit}
            <ul class="dropdown-menu keepopen"{if $snackyConfig.dropdown_plus == 1} id="mm-{$mainCategory->getID()}"{/if}>
                {foreach name='sub_categories' from=$sub_categories item='sub'}
                    {assign var="catFunctions" value=$mainCategory->getFunctionalAttributes()}
                    {include file='snippets/categories_dropdown_recursive.tpl' mainCategory=$sub show_subcategories=$show_subcategories catFunctions=$catFunctions i=$i limit=$limit}
                {/foreach}
            </ul>
        {/if}
    </li>
{/if}
{/block}