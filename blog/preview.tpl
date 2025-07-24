{block name='blog-preview'}
<div class="panel pn-news">    
    {if !empty($newsItem->getPreviewImage())}
        <div class="img-w">
            <a href="{$newsItem->getURL()}" title="{$newsItem->getTitle()|escape:'quotes'}" class="img-ct rt4x3">
                {include file='snippets/image.tpl'
                    item=$newsItem
                    square=false
                    alt="{$newsItem->getTitle()|escape:'quotes'} - {$newsItem->getMetaTitle()|escape:'quotes'}"}
            </a>
        </div>
        <hr class="invisible hr-xs">
    {/if}
    <a href="{$newsItem->getURL()}" class="title block h4 m0">
        {$newsItem->getTitle()}
    </a>
    <hr class="invisible hr-xxs">
    <div class="text-muted small dpflex-a-c v-box">
        {assign var='dDate' value=$newsItem->getDateValidFrom()->format('Y-m-d H:i:s')}
        {if $newsItem->getAuthor() !== null}
            <div class="hidden-xs">{$newsItem->getAuthor()->cName}</div>
            <span class="sep">|</span>
        {/if}
        {$newsItem->getDateCreated()->format('d.m.Y')}
        {if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
            <span class="sep">|</span>
            <a class="dpflex-a-center" href="{$newsItem->getURL()}#comments" title="{lang key="readComments" section="news"}">
                <span class="img-ct icon">
                    <svg>
                      <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-comment"></use>
                    </svg>
                </span>
                {$newsItem->getCommentCount()}
            </a>
        {/if}
    </div>
    <hr class="invisible hr-xs">
    <div class="panel-body">
        {if $newsItem->getPreview()|strip_tags|strlen > 0}
            {$newsItem->getPreview()|strip_tags}
        {else}
            {$newsItem->getContent()|strip_tags|truncate:300:"...":true}
        {/if}
    </div>
    <hr class="invisible hr-xs">
    <a class="more" href="{$newsItem->getURL()}">
        {lang key='moreLink' section='news'}
    </a>
</div>
{/block}