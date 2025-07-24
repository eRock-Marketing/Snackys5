{block name='page-sitemap'}
<hr class="invisible">
    {if $Einstellungen.sitemap.sitemap_seiten_anzeigen === 'Y'}
        {block name='sitemap-pages'}
            {include file="snippets/zonen.tpl" id="opc_before_pages"}
            <div class="sitemap panel-default mb-md">
                <h2 class="h5">{block name='sitemap-pages-title'}{lang key='sitemapSites'}{/block}</h2>
                {block name='sitemap-pages-body'}
                    {foreach $linkgroups as $linkgroup}
                        {if isset($linkgroup->getName()) && $linkgroup->getName() !== 'hidden' && !empty($linkgroup->getLinks())}
                            <ul class="list-unstyled mb-sm">
                                {include file='snippets/linkgroup_list.tpl' linkgroupIdentifier=$linkgroup->getTemplate() tplscope='sitemap'}
                            </ul>
                        {/if}
                    {/foreach}
                {/block}
            </div>
        {/block}
    {/if}
{if $Einstellungen.sitemap.sitemap_kategorien_anzeigen === 'Y' && isset($oKategorieliste->elemente) && $oKategorieliste->elemente|@count > 0}
    {block name='sitemap-categories'}
		{include file="snippets/zonen.tpl" id="opc_before_categories"}

        <div class="sitemap mb-md">
            <h2 class="h5">{block name='sitemap-categories-title'}{lang key='sitemapKats'}{/block}</h2>
            {block name='sitemap-categories-body'}
                    {* first: categories with subcategories only *}
                    {foreach $oKategorieliste->elemente as $oKategorie}
                        {if $oKategorie->getChildren()|@count > 0}
                            <ul class="list-unstyled mb-sm">
                                <li>
                                    <a href="{$oKategorie->getURL()}" title="{$oKategorie->getName()}">
                                        <strong>
                                            {$oKategorie->getShortName()}
                                        </strong>
                                    </a>
                                </li>
                                {foreach $oKategorie->getChildren() as $oSubKategorie}
                                    <li>
                                        <a href="{$oSubKategorie->getURL()}" title="{$oKategorie->getName()}">
                                            {$oSubKategorie->getShortName()}
                                        </a>
                                    </li>
                                    {if $oSubKategorie->getChildren()|@count > 0}
                                        <li>
                                            <ul class="list-unstyled sub-categories">
                                                {foreach $oSubKategorie->getChildren() as $oSubSubKategorie}
                                                    <li>
                                                        <a href="{$oSubSubKategorie->getURL()}"
                                                           title="{$oKategorie->getName()}">
                                                            {$oSubSubKategorie->getShortName()}
                                                        </a>
                                                    </li>
                                                {/foreach}
                                            </ul>
                                        </li>
                                    {/if}
                                {/foreach}
                            </ul>
                        {/if}
                    {/foreach}

                    {* last: all categories without subcategories *}
                    <ul class="list-unstyled mb-sm">
                        {* <li><b>{lang key='otherCategories'}</b></li> *}
                        {foreach $oKategorieliste->elemente as $oKategorie}
                            {if $oKategorie->getChildren()|@count == 0}
                                <li>
                                    &nbsp;&nbsp;<a href="{$oKategorie->getURL()}" title="{$oKategorie->getName()}">
                                        {$oKategorie->getShortName()}
                                    </a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
            {/block}
        </div>
    {/block}
{/if}
{if $Einstellungen.sitemap.sitemap_hersteller_anzeigen === 'Y' && $oHersteller_arr|@count > 0}
    {block name='sitemap-manufacturer'}
		{include file="snippets/zonen.tpl" id="opc_before_manufacturers"}

        <div class="sitemap mb-md">
            <h2 class="h5">{block name='sitemap-manufacturer-title'}{lang key='sitemapNanufacturer'}{/block}</h2>
            {block name='sitemap-manufacturer-body'}
                <ul class="list-unstyled">
                    {foreach $oHersteller_arr as $oHersteller}
                        <li><a href="{$oHersteller->cURL}">{$oHersteller->cName}</a></li>
                    {/foreach}
                </ul>
            {/block}
        </div>
    {/block}
{/if}
{if $Einstellungen.news.news_benutzen === 'Y' && $Einstellungen.sitemap.sitemap_news_anzeigen === 'Y' && !empty($oNewsMonatsUebersicht_arr) && $oNewsMonatsUebersicht_arr|@count > 0}
    {block name='sitemap-news'}
		{include file="snippets/zonen.tpl" id="opc_before_news"}

        <div class="sitemap mb-md">
            <h2 class="h5">{block name='sitemap-news-title'}{lang key='sitemapNews'}{/block}</h2>
            {block name='sitemap-news-body'}
                {foreach $oNewsMonatsUebersicht_arr as $oNewsMonatsUebersicht}
                    {if $oNewsMonatsUebersicht->oNews_arr|@count > 0}
                        {math equation='x-y' x=$oNewsMonatsUebersicht@iteration y=1 assign='i'}
                        <strong class="h5 block"><a href="{$oNewsMonatsUebersicht->cURLFull}">{$oNewsMonatsUebersicht->cName}</a></strong>
                        <ul class="list-unstyled mb-sm">
                            {foreach $oNewsMonatsUebersicht->oNews_arr as $oNews}
                                <li><a href="{$oNews->cURLFull}">{$oNews->cBetreff}</a></li>
                            {/foreach}
                        </ul>
                    {/if}
                {/foreach}
            {/block}
        </div>
    {/block}
{/if}
{if $Einstellungen.news.news_benutzen === 'Y' && $Einstellungen.sitemap.sitemap_newskategorien_anzeigen === 'Y' && !empty($oNewsKategorie_arr) && $oNewsKategorie_arr|@count > 0}
    {block name='sitemap-news-categories'}
		{include file="snippets/zonen.tpl" id="opc_before_news_categories"}

        <div class="sitemap mb-md">
            <h2 class="h5">{block name='sitemap-news-categories-title'}{lang key='sitemapNewsCats'}{/block}</h2>
            {block name='sitemap-news-categories-body'}
                <div class="row">
                    {foreach $oNewsKategorie_arr as $oNewsKategorie}
                        {if $oNewsKategorie->oNews_arr|@count > 0}
                            <div class="col-12">
                                <strong><a href="{$oNewsKategorie->cURLFull}">{$oNewsKategorie->cName}</a></strong>
                                <ul class="list-unstyled">
                                    {foreach $oNewsKategorie->oNews_arr as $oNews}
                                        <li>&nbsp;&nbsp;<a href="{$oNews->cURLFull}">{$oNews->cBetreff}</a></li>
                                    {/foreach}
                                </ul>
                            </div>
                        {/if}
                    {/foreach}
                </div>
            {/block}
        </div>
    {/block}
{/if}
{/block}
