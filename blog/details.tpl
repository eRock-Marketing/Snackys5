{block name='blog-details'}
{include file='snippets/extension.tpl'}

{if !empty($cNewsErr)}
    <div class="alert alert-danger">{lang key='newsRestricted' section='news'}</div>
{else}
    <article itemprop="mainEntity" itemscope itemtype="https://schema.org/BlogPosting">
        <div id="nw-ct">
            <meta itemprop="mainEntityOfPage" content="{$oNewsArchiv->getURL()}">
            <h1 itemprop="headline">
                {$oNewsArchiv->getTitle()}
            </h1>
            {if $oNewsArchiv->getPreviewImage() !== ''}
                <meta itemprop="image" content="{$imageBaseURL}/{$oNewsArchiv->getPreviewImage()}">
            {/if}
            <p class="text-muted">
                {if empty($oNewsArchiv->getDateValidFrom())}
                    {assign var=dDate value=$oNewsArchiv->getDateCreated()->format('Y-m-d H:i:s')}
                {else}
                    {assign var=dDate value=$oNewsArchiv->getDateValidFrom()->format('Y-m-d H:i:s')}
                {/if}
                {if $oNewsArchiv->getAuthor() !== null}
                    {include file="snippets/author.tpl" oAuthor=$oNewsArchiv->getAuthor() dDate=$dDate cDate=$oNewsArchiv->getDateValidFrom()->format('Y-m-d H:i:s')}
                {else}
                    <div itemprop="author publisher" itemscope itemtype="http://schema.org/Organization" class="hidden">
                        <span itemprop="name">{$meta_publisher}</span>
                        <span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject"><meta itemprop="url" content="{$ShopLogoURL}"></span>
                    </div>
                {/if}
                {if !empty($oNewsArchiv->getDateValidFrom())}<time itemprop="dateModified" class="hidden">>{$oNewsArchiv->getDateValidFrom()->format('Y-m-d H:i:s')}</time>{/if}
                <time itemprop="datePublished" datetime="{$dDate}" class="hidden">{$dDate}</time><span class="v-box">
                {if empty($oNewsArchiv->getDateValidFrom())}
                    {assign var=dDate value=$oNewsArchiv->getDateCreated()->format('d.m.Y')}
                {else}
                    {assign var=dDate value=$oNewsArchiv->getDateValidFrom()->format('d.m.Y')}
                {/if}
                </span>
            </p>

            <div itemprop="articleBody" class="mb-spacer mb-small">
                {if $snackyConfig.optimize_news == "Y"}{$oNewsArchiv->getContent()|optimize}{else}{$oNewsArchiv->getContent()}{/if}
            </div>

            {if isset($Einstellungen.news.news_kategorie_unternewsanzeigen) && $Einstellungen.news.news_kategorie_unternewsanzeigen === 'Y' && !empty($oNewsKategorie_arr)}
                <div class="top10 news-categorylist mb-spacer mb-small">
                    {foreach $oNewsKategorie_arr as $oNewsKategorie}
                        <a itemprop="articleSection" href="{$oNewsKategorie->cURLFull}" title="{$oNewsKategorie->cBeschreibung|strip_tags|escape:"html"|truncate:60}" class="badge btn btn-xs">{$oNewsKategorie->cName}</a>
                    {/foreach}
                </div>
            {/if}
        </div>

        {if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
        <div id="nw-cmt">
            {if $comments|@count > 0}
                {if !empty($oNewsArchiv->getSeo())}
                    {assign var=articleURL value=$oNewsArchiv->getURL()}
                    {assign var=cParam_arr value=[]}
                {else}
                    {assign var=articleURL value='news.php'}
                    {assign var=cParam_arr value=['kNews'=>$oNewsArchiv->getID(),'n'=>$oNewsArchiv->getID()]}
                {/if}
                <div class="mb-md" id="comments">
                    <h3 class="mb-sm">{lang key="newsComments" section="news"}<span itemprop="commentCount" class="hidden">{$comments|count}</span></h3>
                    {foreach $comments as $comment}
                        <blockquote class="news-comment m0">
                            <p itemprop="comment">
                                {$comment->getText()}
                            </p>
                            <small>{$comment->getName()}, {$comment->getDateCreated()->format('d.m.y H:i')}</small>
                        </blockquote>
                        {if !($comment@last)}<hr>{/if}
                    {/foreach}
                </div>
                {include file='snippets/pagination.tpl' oPagination=$oPagiComments cThisUrl=$articleURL cParam_arr=$cParam_arr}
            {/if}

            {if $userCanComment === true}
            <div class="panel panel-default mt-md">
                <div class="panel-heading"><h4 class="panel-title">{lang key="newsCommentAdd" section="news"}</h4></div>
                <div class="panel-body">
                    <form method="post" action="{if !empty($oNewsArchiv->getSEO())}{$oNewsArchiv->getURL()}{else}{get_static_route id='news.php'}{/if}" class="form evo-validate" id="news-addcomment">
                        {$jtl_token}
                        <input type="hidden" name="kNews" value="{$oNewsArchiv->getID()}" />
                        <input type="hidden" name="kommentar_einfuegen" value="1" />
                        <input type="hidden" name="n" value="{$oNewsArchiv->getID()}" />

                        <fieldset>
                            <div class="form-group float-label-control{if $nPlausiValue_arr.cKommentar > 0} has-error{/if} required">
                                <label class="control-label" for="comment-text"><strong>{lang key="newsComment" section="news"}</strong></label>
                                <textarea id="comment-text" class="form-control" name="cKommentar" required></textarea>
                                {if $nPlausiValue_arr.cKommentar > 0}
                                    <div class="form-error-msg text-danger">
                                        {lang key="fillOut" section="global"}
                                    </div>
                                {/if}
                            </div>
                            <input class="btn btn-primary" name="speichern" type="submit" value="{lang key="newsCommentSave" section="news"}" />
                        </fieldset>
                    </form>
                </div>
            </div>{* /panel *}
            {else}
                <hr>
                <div class="alert alert-danger">{lang key="newsLogin" section="news"}</div>
            {/if}
        </div>
        {/if}
    </article>
{/if}
{/block}
