{block name='productdetails-reviews'}
    <div class="flx">
        {block name="productdetails-review-overview"}
            <div id="reviews-overview" class="mb-sm">
                <div class="{if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl != 0}panel {/if}panel-default">
                    {block name="productdetails-review-overview-header"}
                        <div class="panel-heading">
                            {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}
                                <h4 class="panel-title">
                                    <span class="h1 m0">{$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}</span><span class="h2 m0">/5</span>
                                    {include file='productdetails/rating.tpl' total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
                                </h4>
                            {/if}
                        </div>
                    {/block}
                    {block name="productdetails-review-overview-body"}
                        <div class="panel-body hidden-print">
                            <form method="post" action="{get_static_route id='bewertung.php'}#tab-votes" id="article_rating">
                                {$jtl_token}
                                {block name="productdetails-review-overview-progress"}
                                    {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}
                                        <div id="article_votes">
                                            {foreach name=sterne from=$Artikel->Bewertungen->nSterne_arr item=nSterne key=i}
                                                {assign var=int1 value=5}
                                                {math equation='x - y' x=$int1 y=$i assign='schluessel'}
                                                {assign var=int2 value=100}
                                                {math equation='(a/b)*c' a=$nSterne b=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl c=$int2 assign='percent'}
                                                <div class="flx-ac">
                                                    {block name="productdetails-review-overview-progress-text"}
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
                                                    {/block}
                                                    {block name="productdetails-review-overview-progress-bars"}
                                                        <div class="progress">
                                                            {if $nSterne > 0}
                                                                <div class="progress-bar" role="progressbar"
                                                                    aria-valuenow="{$percent|round}" aria-valuemin="0"
                                                                    aria-valuemax="100" style="width: {$percent|round}%;">
                                                                    {$nSterne}
                                                                </div>
                                                            {/if}
                                                        </div>
                                                    {/block}
                                                </div>
                                            {/foreach}
                                            {block name="productdetails-review-overview-progress-reset"}
                                                {if isset($bewertungSterneSelected) && $bewertungSterneSelected > 0}
                                                    <p>
                                                        <a href="{$Artikel->cURLFull}#tab-votes" class="btn btn-default">
                                                            {lang key="allRatings"}
                                                        </a>
                                                    </p>
                                                {/if}
                                            {/block}
                                        </div>
                                    {/if}
                                {/block}
                                {block name="productdetails-review-overview-add-review"}
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
                                {/block}
                            </form>
                        </div>
                    {/block}
                </div>
            </div>
        {/block}
        {block name="productdetails-review-reviews"}
            {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}
                <div id="rv-wp">
                    {block name="productdetails-review-reviews-helpful"}
                        {if isset($Artikel->HilfreichsteBewertung->oBewertung_arr[0]->nHilfreich) && $Artikel->HilfreichsteBewertung->oBewertung_arr[0]->nHilfreich > 0}
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
                    {/block}
                    {block name="productdetails-review-reviews-all"}
                        {if $ratingPagination->getPageItemCount() > 0}
                            {block name='productdetails-reviews-verified-purchase-notice'}
                                {* button type="link" variant="outline-secondary" block="true" class="verified-purchase-notice" data=["toggle"=>"popover","content"=>"{{lang key='verifiedPurchaseNotice' section='product rating'}|escape:"html"}"]}
                                    {lang key='reviewsHowTo' section='product rating'}
                                {/button *}
                            {/block}
                            {block name="productdetails-review-reviews-all-form"}
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
                            {/block}
                            {block name="productdetails-review-reviews-all-pagination"}
                                {if empty($smarty.get.quickView)}
                                    {include file='snippets/pagination.tpl' oPagination=$ratingPagination cThisUrl=$Artikel->cURLFull cParam_arr=['btgsterne'=>$bewertungSterneSelected] cAnchor='tab-votes' showFilter=false}
                                {/if}
                            {/block}
                        {/if}
                    {/block}
                </div>
            {/if}
        {/block}
    </div>
{/block}