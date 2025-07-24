{block name='productdetails-review-form'}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{include file='snippets/extension.tpl'}

{block name="content"}
    {block name="productdetails-review-form-main"}
    <div class="panel-wrap">
        <form method="post" action="{get_static_route id='bewertung.php'}#tab-votes" class="jtl-validate">
            {$jtl_token}

            {$alertList->displayAlertByKey('productNotBuyed')}
            {$alertList->displayAlertByKey('loginFirst')}
            {if $ratingAllowed}
            <div class="row dpflex-j-center">
                <div class="col-12 col-sm-9 col-md-7 col-lg-6{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-5{/if}">
                    <div class="mb-sm">
                        <h1 class="h2">{lang key="productRating" section="product rating"}: {$Artikel->cName}</h1>
                    </div>
                    <div class="panel">
                        <span class="img-ct">
                            {include file='snippets/image.tpl' item=$Artikel square=false class="image vmiddle"}
                        </span>
                        <div class="alert alert-info">{lang key='shareYourRatingGuidelines' section='product rating'}</div>
                        <div class="form-group required">
                            <select name="nSterne" id="stars" class="form-control" required>
                                <option value="" disabled>{lang key='starPlural' section='product rating'}</option>
                                {$ratings = [5,4,3,2,1]}
                                {foreach $ratings as $rating}
                                    <option value="{$rating}"{if isset($oBewertung->nSterne) && (int)$oBewertung->nSterne === $rating} selected{/if}>
                                        {$rating}
                                        {if (int)$rating === 1}
                                            {lang key='starSingular' section='product rating'}
                                        {else}
                                            {lang key='starPlural' section='product rating'}
                                        {/if}
                                    </option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="form-group float-label-control required">
                            <label for="headline">{lang key="headline" section="product rating"}</label>
                            <input type="text" name="cTitel" value="{$oBewertung->cTitel|default:""}" id="headline" class="form-control" required>
                        </div>
                        <div class="form-group float-label-control required">
                            <label for="comment">{lang key="comment" section="product rating"}</label>
                            <textarea name="cText" cols="80" rows="8" id="comment" class="form-control" required>{$oBewertung->cText|default:""}</textarea>
                        </div>
                    </div>
                    <p class="small text-muted">(* = {lang key='mandatoryFields'})</p>
                </p>
                    <input name="bfh" type="hidden" value="1">
                    <input name="a" type="hidden" value="{$Artikel->kArtikel}">
                    <input name="submit" type="submit" value="{lang key="submitRating" section="product rating"}" class="submit btn btn-primary btn-block">
                </div>
            </div>
            {/if}
        </form>
    </div>
    {/block}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}