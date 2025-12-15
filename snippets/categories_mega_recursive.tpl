{block name='snippets-categories-mega-recursive'}
    {block name='snippets-categories-mega-recursive-max-subsub-items'}
        {assign var=max_subsub_items value=$snackyConfig.megamenu_subcats}
    {/block}
    <a href="{$mainCategory->getURL()}" class="block">   
        {if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N'}                                                                
            <span class="hidden-xs img-ct{if $snackyConfig.imageratioCategory == '43'}  rt4x3{/if}">
                {assign var='subImgAlt' value="{lang key="categoryImage" section="custom"} {$mainCategory->getShortName()}"}
                {include file='snippets/image.tpl' class='image' item=$mainCategory srcSize='sm' alt=$subImgAlt}
            </span>
        {/if}
        <span class="defaultlink h6 title block">
            {$mainCategory->getShortName()}
            {if $show_subcategories && $mainCategory->hasChildren()}
            {include file='snippets/mobile-menu-arrow.tpl'}
            {/if}
        </span>
    </a>
    {if $show_subcategories && $mainCategory->hasChildren()}
        <ul class="blanklist small subsub">
            {foreach name='subsub_categories' from=$mainCategory->getChildren() item='category'}
                {if $smarty.foreach.subsub_categories.iteration <= $max_subsub_items}
                    {assign var="subCatFunctions" value=$category->getFunctionalAttributes()}
                    <li class="{if $category->getID() == $activeId || (isset($activeParents[2]) && $activeParents[2]->getID() == $category->getID())} active{/if}{if !empty($subCatFunctions["css_klasse"])} {$subCatFunctions["css_klasse"]}{/if}">
                        <a href="{$category->getURL()}" class="defaultlink">
                            {$category->getShortName()}
                        </a>
                    </li>
                {else}
                    <li class="more"><a href="{$mainCategory->getURL()}">{lang key="more" section="global"} <span class="remaining">({math equation='total - max' total=$mainCategory->getChildren()|count max=$max_subsub_items})</span></a></li>
                    {break}
                {/if}
            {/foreach}
        </ul>
    {/if}
{/block}