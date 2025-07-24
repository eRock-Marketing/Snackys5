{block name='productdetails-reviews'}

<div class="dpflex">
        {block name="productdetails-review-overview"}
        <div id="reviews-overview" class="mb-sm">
            <div class="{if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl != 0}panel {/if}panel-default">
                <div class="panel-heading">
                    {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}
                    <h4 class="panel-title">
                        <span class="h1 m0">{$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}</span><span class="h2 m0">/5</span>
                        {include file='productdetails/rating.tpl' total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
                    </h4>
                    {/if}
                </div>
                <div class="panel-body hidden-print">
                    <form method="post" action="{get_static_route id='bewertung.php'}#tab-votes" id="article_rating">
                        {$jtl_token}
                            {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}
                                <div id="article_votes">
                                    {foreach name=sterne from=$Artikel->Bewertungen->nSterne_arr item=nSterne key=i}
                                        {assign var=int1 value=5}
                                        {math equation='x - y' x=$int1 y=$i assign='schluessel'}
                                        {assign var=int2 value=100}
                                        {math equation='a/b*c' a=$nSterne b=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl c=$int2 assign='percent'}
                                        <div class="dpflex-a-center">
                                            <div class="text">
                                                {if isset($bewertungSterneSelected) && $bewertungSterneSelected === $schluessel}
                                                    <strong>
                                                {/if}
                                                {if $nSterne > 0 && (!isset($bewertungSterneSelected) || $bewertungSterneSelected !== $schluessel)}
                                                    <a href="{$Artikel->cURLFull}?btgsterne={$schluessel}#tab-votes"><strong>{$schluessel} {if $i == 4}{lang key="starSingular" section="product rating"}{else}{lang key="starPlural" section="product rating"}{/if}</strong></a>
                                                {else}
                                                    {$schluessel} {if $i == 4}{lang key="starSingular" section="product rating"}{else}{lang key="starPlural" section="product rating"}{/if}
                                                {/if}
                                                {if isset($bewertungSterneSelected) && $bewertungSterneSelected === $schluessel}
                                                    </strong>
                                                {/if}
                                            </div>
                                            <div class="progress">
                                                {if $nSterne > 0}
                                                    <div class="progress-bar" role="progressbar"
                                                         aria-valuenow="{$percent|round}" aria-valuemin="0"
                                                         aria-valuemax="100" style="width: {$percent|round}%;">
                                                        {$nSterne}
                                                    </div>
                                                {/if}
                                            </div>
                                        </div>
                                    {/foreach}
                                    {if isset($bewertungSterneSelected) && $bewertungSterneSelected > 0}
                                        <p>
                                            <a href="{$Artikel->cURLFull}#tab-votes" class="btn btn-default">
                                                {lang key="allRatings"}
                                            </a>
                                        </p>
                                    {/if}
                                </div>
                            {/if}
                            <div class="add-review{if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl == 0} m0{/if}">
                                {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl == 0}
                                    <p>{lang key="firstReview" section="global"}: </p>
                                {else}
                                    <p>{lang key="shareYourExperience" section="product rating"}</p>
                                {/if}
                                <input name="bfa" type="hidden" value="1" />
                                <input name="a" type="hidden" value="{$Artikel->kArtikel}" />
                                <input name="bewerten" type="submit" 
									value="{if $bereitsBewertet === false}{lang key='productAssess' section='product rating'}{else}{lang key='edit' section='product rating'}{/if}" 
									class="submit btn btn-primary btn-block" />
                            </div>
                    </form>
                </div>
            </div>{* /panel *}
        </div>{* /reviews-overview *}
        {/block}
    {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}
    <div id="rv-wp">
		{if $ratingPagination->getPageItemCount() > 0 || isset($Artikel->HilfreichsteBewertung->oBewertung_arr[0]->nHilfreich) &&
        $Artikel->HilfreichsteBewertung->oBewertung_arr[0]->nHilfreich > 0}
            {*<p class="alert alert-info m0">{lang key='reviewsInCurrLang' section='product rating'}</p>
            <hr class="invisible hr-sm">*}
        {else}
            <p class="alert alert-info m0">{lang key='noReviewsInCurrLang' section='product rating'}</p>
            <hr class="invisible hr-sm">
        {/if}
        {if isset($Artikel->HilfreichsteBewertung->oBewertung_arr[0]->nHilfreich) &&
            $Artikel->HilfreichsteBewertung->oBewertung_arr[0]->nHilfreich > 0
        }
            <div class="review-wrapper reviews-mosthelpful panel mb-sm review">
                <form method="post" action="{get_static_route id='bewertung.php'}#tab-votes">
                    {$jtl_token}
                    {block name="productdetails-review-most-helpful"}
                    <input name="bhjn" type="hidden" value="1" />
                    <input name="a" type="hidden" value="{$Artikel->kArtikel}" />
                    <input name="btgsterne" type="hidden" value="{$BlaetterNavi->nSterne}" />
                    <input name="btgseite" type="hidden" value="{$BlaetterNavi->nAktuelleSeite}" />
                    <div class="panel-heading">
                        <h4 class="panel-title">{lang key="theMostUsefulRating" section="product rating"}</h4>
                    </div>
                    <div class="panel-body">
                        {foreach $Artikel->HilfreichsteBewertung->oBewertung_arr as $oBewertung}
                            {include file='productdetails/review_item.tpl' oBewertung=$oBewertung bMostUseful=true}
                        {/foreach}
                    </div>
                    {/block}
                </form>
            </div>
        {/if}

        {if $ratingPagination->getPageItemCount() > 0}
            <form method="post" action="{get_static_route id='bewertung.php'}#tab-votes" class="reviews-list">
                {$jtl_token}
                <input name="bhjn" type="hidden" value="1" />
                <input name="a" type="hidden" value="{$Artikel->kArtikel}" />
                <input name="btgsterne" type="hidden" value="{$BlaetterNavi->nSterne}" />
                <input name="btgseite" type="hidden" value="{$BlaetterNavi->nAktuelleSeite}" />

                {foreach $ratingPagination->getPageItems() as $oBewertung}
                    <div class="review panel panel-default {if $oBewertung@last}last{else} mb-sm{/if}">
                        {include file="productdetails/review_item.tpl" oBewertung=$oBewertung}
                    </div>
                {/foreach}
            </form>
            {include file="snippets/pagination.tpl" oPagination=$ratingPagination cThisUrl=$Artikel->cURLFull cAnchor='tab-votes' showFilter=false}
        {/if}
    </div>{* /col *}
    {/if}
</div>{* /row *}
{/block}