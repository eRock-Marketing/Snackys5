{block name='snippets-categories-dropdown'}
{strip}
{assign var=max_subsub_items value=5}
{if $snackyConfig.megaHome == 0}
<li class="is-lth{if $nSeitenTyp == 18} active{/if}">
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="home-icon mm-mainlink">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 26.25"><path d="M3.75 26.25h9.37v-7.5h3.76v7.5h9.37V15H30L15 0 0 15h3.75z"/></svg>
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
{if isset($snackyConfig.show_categories) && $snackyConfig.show_categories !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
    {assign var='show_subcategories' value=false}
    {if isset($snackyConfig.show_subcategories) && $snackyConfig.show_subcategories !== 'N'}
        {assign var='show_subcategories' value=true}
    {/if}

    {get_category_array categoryId=0 assign='categories'}
    {if !empty($categories)}
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
			<ul class="dropdown-menu keepopen{if $categories|@count > 40} items-threecol{else if $categories|@count > 20} items-twocol{/if}">
		{/if}
        {foreach name='categories' from=$categories item='category'}
            {if isset($category->hasChildren()) && !empty($category->getChildren())}
                {assign var='isDropdown' value=true}
            {/if}
            <li class="{if $isDropdown && $category->hasChildren()}mgm-fw dropdown-style{/if}{if $category->getID() == $activeId || (isset($activeParents[0]) && $activeParents[0]->getID() == $category->getID())} active{/if}{if is_array($category->KategorieAttribute) && !empty($category->KategorieAttribute["css_klasse"])} {$category->KategorieAttribute["css_klasse"]}{/if}">
                <a href="{$category->getURL()}" class="{if $snackyConfig.drodownMaincat == 0}mm-mainlink{else}dropdown-link defaultlink{/if}">
                    <span class="notextov">{$category->getShortName()}</span>
                    {if $isDropdown && $category->hasChildren()}
						{if $snackyConfig.drodownMaincat == 0}
						<span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
						{else}
						<span class="ar ar-r hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
						{/if}
					{/if}
                </a>
                {if $isDropdown && $category->hasChildren() && $category->hasChildren()}
                    <ul class="dropdown-menu keepopen">
						{if $category->hasChildren()}
							{if !empty($category->getChildren())}
								{assign var=sub_categories value=$category->getChildren()}
							{else}
								{get_category_array categoryId=$category->getID() assign='sub_categories'}
							{/if}
							{foreach name='sub_categories' from=$sub_categories item='sub'}
								<li class="title{if $show_subcategories && $sub->hasChildren()} mgm-fw keepopen{/if}{if $sub->getID() == $activeId || (isset($activeParents[1]) && $activeParents[1]->getID() == $sub->getID())} active{/if}{if is_array($sub->KategorieAttribute) && !empty($sub->KategorieAttribute["css_klasse"])} {$sub->KategorieAttribute["css_klasse"]}{/if}">
									{if !empty($sub->getChildren())}
										{assign var=subsub_categories value=$sub->getChildren()}
									{else}
										{get_category_array categoryId=$sub->getID() assign='subsub_categories'}
									{/if}
									<a href="{$sub->getURL()}" class="dropdown-link defaultlink">
										<span class="notextov">
											{$sub->getShortName()}
										</span>
										{if $show_subcategories && $sub->hasChildren() && count($subsub_categories)  > 0}
										<span class="ar ar-r hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
										{/if}
									</a>
									{if $show_subcategories && $sub->hasChildren() && count($subsub_categories)  > 0}
										<ul class="dropdown-menu keepopen">
											{foreach name='subsub_categories' from=$subsub_categories item='subsub'}
													<li class="{if $subsub->getID() == $activeId || (isset($activeParents[2]) && $activeParents[2]->getID() == $subsub->getID())} active{/if}{if is_array($subsub->KategorieAttribute) && !empty($subsub->KategorieAttribute["css_klasse"])} {$subsub->KategorieAttribute["css_klasse"]}{/if}">
														<a href="{$subsub->getURL()}" class="dropdown-link defaultlink notextov">
															{$subsub->getShortName()}
														</a>
													</li>
											{/foreach}
										</ul>
									{/if}
								</li>
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
    && ($Einstellungen.global.global_sichtbarkeit != 3
        || isset($smarty.session.Kunde->kKunde)
        && $smarty.session.Kunde->kKunde != 0)}
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
            <ul class="dropdown-menu keepopen{if $manufacturers|@count > 40} items-threecol{else if $manufacturers|@count > 20} items-twocol{/if}">
				{foreach name=hersteller from=$manufacturers item=hst}
					<li class="title{if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller == $hst->kHersteller} active{/if}"><a href="{$hst->cURLFull}" class="dropdown-link defaultlink"><span class="notextov">{$hst->cName}</span></a></li>
				{/foreach}
            </ul>
        </li>
    {/if}
{/if}
{/block}{* megamenu-manufacturers *}
{/strip}
{/block}