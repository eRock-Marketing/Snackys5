{block name='page-sitemap'}
    <div id="km_sm">
    <hr class="invisible">
    {if $Einstellungen.sitemap.sitemap_seiten_anzeigen === 'Y'}
        {block name='page-sitemap-pages'}
            {opcMountPoint id='opc_before_pages' inContainer=false}
            {card header={lang key='sitemapSites'} class="mb-md"}
                {block name='page-sitemap-pages-content'}
                    {row class="row-multi"}
                        {foreach $linkgroups as $linkgroup}
                            {assign var="links" value=""}
                            {get_navigation linkgroupIdentifier=$linkgroup->getTemplate() assign='links'}
                            {if !empty($links) && !empty($linkgroup->getName()) && $linkgroup->getName() !== 'hidden' && !empty($linkgroup->getLinks())}
                                {col cols=12 md=4 lg=3}
                                    {nav}
                                            {foreach $links as $li}
                                                <li>
                                                    <a href="{$li->getURL()}" {if $li->getNoFollow()} rel="nofollow"{/if}{if !empty($li->getTitle())} title="{$li->getTitle()}"{/if}>
                                                        {$li->getName()}
                                                        {if $li->getChildLinks()->count() > 0 && isset($dropdownSupport)} <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}{/if}
                                                    </a>
                                                </li>
                                            {/foreach}
                                    {/nav}
                                {/col}
                            {/if}
                        {/foreach}
                    {/row}
                {/block}
            {/card}
        {/block}
    {/if}
    {if $Einstellungen.sitemap.sitemap_kategorien_anzeigen === 'Y' && isset($oKategorieliste->elemente) && $oKategorieliste->elemente|@count > 0}
        {block name='page-sitemap-categories'}
            {opcMountPoint id='opc_before_categories' inContainer=false}
            {card header={lang key='sitemapKats'} class="mb-md"}
                {block name='page-sitemap-categories-content'}
                    {row class="row-multi"}
                        {foreach $oKategorieliste->elemente as $oKategorie}
                            {if $oKategorie->getChildren()|@count > 0}
                                {col cols=12 md=4 lg=3}
                                    <ul class="nav">
                                        <li>
                                            {link href=$oKategorie->getURL() title=$oKategorie->getName()|escape:'html' class="nice-deco"}
                                                <strong>{$oKategorie->getShortName()}</strong>
                                            {/link}
                                        </li>
                                        {foreach $oKategorie->getChildren() as $oSubKategorie}
                                            <li>
                                                {link href=$oSubKategorie->getURL() title=$oKategorie->getName()|escape:'html' class="nice-deco"}
                                                    {$oSubKategorie->getShortName()}
                                                {/link}
                                            </li>
                                            {if $oSubKategorie->getChildren()|@count > 0}
                                                <li>
                                                    <ul class="sub-categories list-unstyled">
                                                        {foreach $oSubKategorie->getChildren() as $oSubSubKategorie}
                                                            <li>
                                                                {link href=$oSubSubKategorie->getURL()
                                                                   title=$oKategorie->getName()|escape:'html' class="nice-deco"}
                                                                    {$oSubSubKategorie->getShortName()}
                                                                {/link}
                                                            </li>
                                                        {/foreach}
                                                    </ul>
                                                </li>
                                            {/if}
                                        {/foreach}
                                    </ul>
                                {/col}
                            {/if}
                        {/foreach}

                        {col cols=12 md=4 lg=3}
                            <ul class="nav">
                                {foreach $oKategorieliste->elemente as $oKategorie}
                                    {if $oKategorie->getChildren()|@count == 0}
                                        <li>
                                            &nbsp;&nbsp;{link href=$oKategorie->getURL() title=$oKategorie->getName()|escape:'html' class="nice-deco"}
                                                {$oKategorie->getShortName()}
                                            {/link}
                                        </li>
                                    {/if}
                                {/foreach}
                            </ul>
                        {/col}
                    {/row}
                {/block}
            {/card}
        {/block}
    {/if}
    {if $Einstellungen.sitemap.sitemap_hersteller_anzeigen === 'Y' && $oHersteller_arr|@count > 0}
        {block name='page-sitemap-manufacturer'}
            {opcMountPoint id='opc_before_manufacturers' inContainer=false}
            {card header={lang key='sitemapNanufacturer'} class="mb-md"}
                {block name='page-sitemap-manufacturer-content'}
                    {row class="row-multi"}
                        {foreach $oHersteller_arr as $oHersteller}
                            {col cols=12 md=4 lg=3 class="sitemap-group-item"}
                                {link href=$oHersteller->cURL  class="nice-deco"}{$oHersteller->cName}{/link}
                            {/col}
                        {/foreach}
                    {/row}
                {/block}
            {/card}
        {/block}
    {/if}
    {if $Einstellungen.news.news_benutzen === 'Y' && $Einstellungen.sitemap.sitemap_news_anzeigen === 'Y' && !empty($oNewsMonatsUebersicht_arr) && $oNewsMonatsUebersicht_arr|@count > 0}
        {block name='page-sitemap-news'}
            {opcMountPoint id='opc_before_news' inContainer=false}
            {card header={lang key='sitemapNews'} class="mb-md"}
                {block name='page-sitemap-news-content'}
                    {row class="row-multi"}
                        {foreach $oNewsMonatsUebersicht_arr as $oNewsMonatsUebersicht}
                            {if $oNewsMonatsUebersicht->oNews_arr|@count > 0}
                                {math equation='x-y' x=$oNewsMonatsUebersicht@iteration y=1 assign='i'}
                                {col cols=12 md=4 lg=3}
                                    <strong class="block mb-xxs">{link href=$oNewsMonatsUebersicht->cURLFull class="nice-deco"}{$oNewsMonatsUebersicht->cName}{/link}</strong>
                                    <ul class="nav">
                                        {foreach $oNewsMonatsUebersicht->oNews_arr as $oNews}
                                            <li>{link href=$oNews->cURLFull class="nice-deco"}{$oNews->cBetreff}{/link}</li>
                                        {/foreach}
                                    </ul>
                                {/col}
                            {/if}
                        {/foreach}
                    {/row}
                {/block}
            {/card}
        {/block}
    {/if}
    {if $Einstellungen.news.news_benutzen === 'Y'
        && $Einstellungen.sitemap.sitemap_newskategorien_anzeigen === 'Y'
        && !empty($oNewsKategorie_arr)
        && $oNewsKategorie_arr|@count > 0
    }
        {block name='page-sitemap-news-categories'}
            {opcMountPoint id='opc_before_news_categories' inContainer=false}
            {card header={lang key='sitemapNewsCats'} class="mb-md"}
                {block name='page-sitemap-news-categories-content'}
                    {row class="row-multi"}
                        {foreach $oNewsKategorie_arr as $oNewsKategorie}
                            {if $oNewsKategorie->oNews_arr|@count > 0}
                                {col cols=12 md=4 lg=3}
                                    <strong class="block mb-xxs">{link href=$oNewsKategorie->cURLFull}{$oNewsKategorie->cName}{/link}</strong>
                                    <ul class="nav">
                                        {foreach $oNewsKategorie->oNews_arr as $oNews}
                                            <li>
                                                {link href=$oNews->cURLFull class="nice-deco"}{$oNews->cBetreff}{/link}
                                            </li>
                                        {/foreach}
                                    </ul>
                                {/col}
                            {/if}
                        {/foreach}
                    {/row}
                {/block}
            {/card}
        {/block}
    {/if}
    </div>
{/block}
