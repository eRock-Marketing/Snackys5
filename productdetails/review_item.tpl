{block name='productdetails-review-item'}
<div id="comment{$oBewertung->kBewertung}" class="review-comment {if $Einstellungen.bewertung.bewertung_hilfreich_anzeigen === 'Y' && isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde > 0 && $smarty.session.Kunde->kKunde != $oBewertung->kKunde}use_helpful{/if} {if isset($bMostUseful) && $bMostUseful}most_useful{/if}">
    {block name="productdetails-review-content"}
    <div class="top5" itemprop="review" itemscope itemtype="http://schema.org/Review">
        <div class="title dpflex-j-between dpflex-a-start">
            <strong itemprop="name">{$oBewertung->cTitel}</strong>
            <span itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
                {include file='productdetails/rating.tpl' stars=$oBewertung->nSterne}
                <small class="hide">
                    <span itemprop="ratingValue">{$oBewertung->nSterne}</span> {lang key="from" section="global"}
                    <span itemprop="bestRating">5</span>
                    <meta itemprop="worstRating" content="1">
                </small>
            </span>
        </div>
        {if $oBewertung->nHilfreich > 0}
        {block name="productdetails-review-helpful"}
        <div class="review-helpful-total">
            <small class="text-muted">
                {if $oBewertung->nHilfreich > 0}
                    {$oBewertung->nHilfreich}
                {else}
                    {lang key="nobody" section="product rating"}
                {/if}
                {lang key="from" section="product rating"} {$oBewertung->nAnzahlHilfreich}
                {if $oBewertung->nAnzahlHilfreich > 1}
                    {lang key="ratingHelpfulCount" section="product rating"}
                {else}
                    {lang key="ratingHelpfulCountExt" section="product rating"}
                {/if}
            </small>
        </div>
        {/block}
        {/if}
        <blockquote class="m0">
            <p itemprop="reviewBody">{$oBewertung->cText|nl2br}</p>
            <small>
                <cite><span itemprop="author" itemscope itemtype="http://schema.org/Person"><span itemprop="name">{$oBewertung->cName}</span></span>.</cite>,
                <meta itemprop="datePublished" content="{$oBewertung->dDatum}" />{$oBewertung->Datum}
            </small>
        </blockquote>
        <meta itemprop="thumbnailURL" content="{$Artikel->cVorschaubildURL}">
        
        {if $Einstellungen.bewertung.bewertung_hilfreich_anzeigen === 'Y'}
            {if isset($smarty.session.Kunde) && $smarty.session.Kunde->kKunde > 0 && $smarty.session.Kunde->kKunde != $oBewertung->kKunde}
                <div class="review-helpful btn-group" id="help{$oBewertung->kBewertung}">
                    <button class="helpful btn btn-xs" title="{lang key="yes"}" name="hilfreich_{$oBewertung->kBewertung}" type="submit">
                        <div class="img-ct icon">
                            <svg width="16">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-thumb-up"></use>
                            </svg>
                        </div>
                    </button>
                    <button class="not_helpful btn btn-xs" title="{lang key="no"}" name="nichthilfreich_{$oBewertung->kBewertung}" type="submit">
                        <div class="img-ct icon">
                            <svg width="16">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-thumb-up"></use>
                            </svg>
                        </div>
                    </button>
                </div>
            {/if}
        {/if}
        {if !empty($oBewertung->cAntwort)}
            <div class="card answer">
                <div class="card-body">
                <strong>{lang key='reply' section='product rating'} {$cShopName}:</strong>
                <blockquote class="m0">
                    <p>{$oBewertung->cAntwort}</p>
                    <small>{$oBewertung->AntwortDatum}</small>
                </blockquote>
                </div>
            </div>
        {/if}
    </div>
    {/block}
</div>
{/block}