{block name='snippets-categories-dropdown'}
{strip}
{block name='snippets-categories-mega-assigns'}
    {if !isset($i)}
        {assign var=i value=0}
    {/if}
    {if !isset($activeId)}
        {if $NaviFilter->hasCategory()}
            {$activeId = $NaviFilter->getCategory()->getValue()}
        {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($Artikel)}
            {$activeId = $Artikel->gibKategorie()}
        {elseif $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && isset($smarty.session.LetzteKategorie)}
            {$activeId = $smarty.session.LetzteKategorie}
        {else}
            {$activeId = 0}
        {/if}
    {/if}
    {assign var=max_subsub_items value=$snackyConfig.megamenu_subcats}
{/block}
{if $snackyConfig.megaHome == 0}
<li class="is-lth{if $nSeitenTyp == 18} active{/if}">
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="home-icon mm-mainlink">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 26.25"><path d="M3.75 26.25h9.37v-7.5h3.76v7.5h9.37V15H30L15 0 0 15h3.75z"/></svg>
        <span class="sr-only">{lang key="linkHome" section="custom"}</span>
	</a>
</li>
{elseif $snackyConfig.megaHome == 1}
<li class="is-lth{if $nSeitenTyp == 18} active{/if}">
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="mm-mainlink">
		{lang key="linkHome" section="custom"}
	</a>
</li>
{/if}
{if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
    {include file='snippets/linkgroup_list.tpl' linkgroupIdentifier='megamenu_start' dropdownSupport=true tplscope='megamenu_start'}
{/if}

{block name="megamenu-categories"}
{if isset($snackyConfig.show_categories) && $snackyConfig.show_categories !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || JTL\Session\Frontend::getCustomer()->getID() > 0)}
    {assign var='show_subcategories' value=false}
    {if isset($snackyConfig.show_subcategories) && $snackyConfig.show_subcategories !== 'N'}
        {assign var='show_subcategories' value=true}
    {/if}

    {get_category_array categoryId=0 assign='categories'}
    {if !empty($categories)}
        {if !isset($activeParents) && ($nSeitenTyp == 1 || $nSeitenTyp == 2)}
            {get_category_parents categoryId=$activeId assign='activeParents'}
        {/if}
		{if $snackyConfig.drodownMaincat == 1}
            {assign var='isDropdown' value=false}
			<li class="mgm-fw dropdown-style">
			<span class="no-link mm-mainlink">
				{lang key="allCats" section="custom"}
				<span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
			</span>
			<ul class="dropdown-menu keepopen first">
		{/if}
        {foreach name='categories' from=$categories item='category'}
            {if isset($category->hasChildren()) && !empty($category->getChildren())}
                {assign var='isDropdown' value=true}
            {/if}
            {assign var="catFunctions" value=$category->getFunctionalAttributes()}
            <li class="{if isset($isDropdown) && $isDropdown && $category->hasChildren()}mgm-fw dropdown-style{/if}{if $category->getID() == $activeId || (isset($activeParents[0]) && $activeParents[0]->getID() == $category->getID())} active{/if}{if !empty($catFunctions["css_klasse"])} {$catFunctions["css_klasse"]}{/if}{if $snackyConfig.dropdown_plus == 1 && isset($isDropdown) && $isDropdown && $category->hasChildren() && $snackyConfig.drodownMaincat == 1} dd-plus{/if}">
                <a href="{$category->getURL()}" class="{if $snackyConfig.drodownMaincat == 0}mm-mainlink{else}dropdown-link defaultlink{/if}">
                    <span class="notextov">{$category->getShortName()}</span>
                    {if isset($isDropdown) && $isDropdown && $category->hasChildren()}
						{if $snackyConfig.drodownMaincat == 0}
						<span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
						{else}
						<span class="ar ar-r hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
						{/if}
					{/if}
                </a>   
                {if $snackyConfig.dropdown_plus == 1 && isset($isDropdown) && $isDropdown && $category->hasChildren() && $snackyConfig.drodownMaincat == 1}
                    <button class="hidden-xs dd-toggle" type="button" data-toggle="collapse" data-target="#mm-{$category->getID()}" aria-expanded="false" aria-controls="mm-{$category->getID()}">
                        <span class="ar ar-d"></span>
                    </button>
                {/if}
                {if isset($isDropdown) && $isDropdown && $category->hasChildren()}
                    <ul class="dropdown-menu keepopen{if $snackyConfig.drodownMaincat != 1} first{/if}"{if $snackyConfig.dropdown_plus == 1 && $snackyConfig.drodownMaincat == 1} id="mm-{$category->getID()}"{/if}>
						{if $category->hasChildren()}
							{if !empty($category->getChildren())}
								{assign var=sub_categories value=$category->getChildren()}
							{else}
								{get_category_array categoryId=$category->getID() assign='sub_categories'}
							{/if}
							{foreach name='sub_categories' from=$sub_categories item='sub'}
                                {assign var="catFunctions" value=$category->getFunctionalAttributes()}
                                {include file='snippets/categories_dropdown_recursive.tpl' mainCategory=$sub show_subcategories=$show_subcategories catFunctions=$catFunctions i=0 limit={$snackyConfig.megamenu_subcats_recursive}}
							{/foreach}
						{/if}
                    </ul>
                {/if}
            </li>
        {/foreach}
					
		{if $snackyConfig.drodownMaincat == 1}
		</ul>	
		</li>
		{/if}
    {/if}
{/if}
{/block}{* /megamenu-categories*}

{block name="megamenu-pages"}
{if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
    {include file='snippets/linkgroup_list.tpl' linkgroupIdentifier='megamenu' dropdownSupport=true tplscope='megamenu'}
{/if}
{/block}{* megamenu-pages *}

{block name="megamenu-manufacturers"}
{if isset($snackyConfig.show_manufacturers) && $snackyConfig.show_manufacturers !== 'N' 
    && ($Einstellungen.global.global_sichtbarkeit != 3 || JTL\Session\Frontend::getCustomer()->getID() > 0)}
    {get_manufacturers assign='manufacturers'}
    {if !empty($manufacturers)}
        <li class="dropdown-style mgm-fw{if $NaviFilter->hasManufacturer() || $nSeitenTyp == PAGE_HERSTELLER} active{/if}">
            {assign var='linkKeyHersteller' value=\JTL\Shop::Container()->getLinkService()->getSpecialPageID(LINKTYP_HERSTELLER, false)|default:0}
            {assign var='linkSEOHersteller' value=\JTL\Shop::Container()->getLinkService()->getLinkByID($linkKeyHersteller)|default:null}
            {if $linkSEOHersteller !== null && !empty($linkSEOHersteller->getName())}
                <a href="{$linkSEOHersteller->getURL()}" class="mm-mainlink">
                    {$linkSEOHersteller->getName()}
                    <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
                </a>
            {else}
                <span class="mm-mainlink">
                    {lang key="manufacturers"}
                    <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
                </span>
            {/if}
            <ul class="dropdown-menu keepopen dropdown-manu first">
				{foreach name=hersteller from=$manufacturers item=hst}
					<li class="title{if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller == $hst->kHersteller} active{/if}"><a href="{$hst->getURL()}" class="dropdown-link defaultlink"><span class="notextov">{$hst->getName()|escape:'html'}</span></a></li>
				{/foreach}
            </ul>
        </li>
    {/if}
{/if}
{/block}{* megamenu-manufacturers *}
{/strip}
{/block}