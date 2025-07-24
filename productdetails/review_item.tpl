{block name='productdetails-review-item'}
    <div id="comment{$oBewertung->kBewertung}" class="review-comment {if $Einstellungen.bewertung.bewertung_hilfreich_anzeigen === 'Y' && JTL\Session\Frontend::getCustomer()->getID() > 0 && JTL\Session\Frontend::getCustomer()->getID() !== $oBewertung->kKunde}use_helpful{/if} {if isset($bMostUseful) && $bMostUseful}most_useful{/if}">
        {block name="productdetails-review-content"}
            <div class="top5">
                {block name="productdetails-review-header"}
                    <div class="title flx-jb flx-as">
                        <strong>{$oBewertung->cTitel}</strong>
                        <span>
                            {include file='productdetails/rating.tpl' stars=$oBewertung->nSterne}
                            <small class="hide">
                                <span>{$oBewertung->nSterne}</span> {lang key="from" section="global"}
                                <span>5</span>
                            </small>
                        </span>
                    </div>
                {/block}
                {block name="productdetails-review-helpful-outer"}
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
                {/block}
                {block name="productdetails-review-item-details"}
                    <blockquote class="m0">
                        <p>{$oBewertung->cText|nl2br}</p>
                        <small>
                            <cite><span><span>{$oBewertung->cName}</span></span>.</cite>,
                            {$oBewertung->Datum}
                        </small>
                        {block name='productdetails-review-item-details-verified-purchase'}
                            {if !empty($oBewertung->wasPurchased)}
                                <span class="blockquote-divider"></span>
                                <span class="verified-purchase">{lang key='verifiedPurchase' section='product rating'}</span>
                            {/if}
                        {/block}
                    </blockquote>
                {/block}
                {block name="productdetails-review-helpful-voting"}
                    {if $Einstellungen.bewertung.bewertung_hilfreich_anzeigen === 'Y'}
                        {if JTL\Session\Frontend::getCustomer()->getID() > 0 && JTL\Session\Frontend::getCustomer()->getID() !== $oBewertung->kKunde}
                            <div class="review-helpful btn-group" id="help{$oBewertung->kBewertung}">
                                {block name="productdetails-review-helpful-voting-downvote"}
                                    <button class="helpful btn btn-xs" title="{lang key="yes"}" name="hilfreich_{$oBewertung->kBewertung}" type="submit">
                                        <div class="img-ct icon">
                                            <svg width="16">
                                            <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-thumb-up"></use>
                                            </svg>
                                        </div>
                                    </button>
                                {/block}
                                {block name="productdetails-review-helpful-voting-upvote"}
                                    <button class="not_helpful btn btn-xs" title="{lang key="no"}" name="nichthilfreich_{$oBewertung->kBewertung}" type="submit">
                                        <div class="img-ct icon">
                                            <svg width="16">
                                            <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-thumb-up"></use>
                                            </svg>
                                        </div>
                                    </button>
                                {/block}
                            </div>
                        {/if}
                    {/if}
                {/block}
                {block name="productdetails-review-answer"}
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
                {/block}
            </div>
        {/block}
    </div>
{/block}