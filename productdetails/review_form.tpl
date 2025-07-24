{block name='productdetails-review-form'}
    {block name="header"}
        {include file='layout/header.tpl'}
    {/block}
    {block name='review-form-extension'}
        {include file='snippets/extension.tpl'}
    {/block}
    {block name="content"}
        {block name="productdetails-review-form-main"}
            <div class="panel-wrap">
                <form method="post" action="{get_static_route id='bewertung.php'}#tab-votes" class="jtl-validate">
                    {$jtl_token}
                    {block name='review-form-alertlist'}
                        {$alertList->displayAlertByKey('productNotBuyed')}
                        {$alertList->displayAlertByKey('loginFirst')}
                    {/block}
                    {if $ratingAllowed}
                        {block name='review-form-inner'}
                            <div class="row flx-jc">
                                <div class="col-12 col-sm-9 col-md-7 col-lg-6{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-5{/if}">
                                    {block name='review-form-headline'}
                                        <div class="mb-sm">
                                            <h1 class="h2">{lang key="productRating" section="product rating"}: {$Artikel->cName}</h1>
                                        </div>
                                    {/block}
                                    {block name='review-form-panel'}
                                        <div class="panel">
                                            {block name='review-form-image'}
                                                <span class="img-ct">
                                                    {include file='snippets/image.tpl' item=$Artikel square=false class="image vmiddle"}
                                                </span>
                                            {/block}
                                            {block name='review-form-description'}
                                                <div class="alert alert-info">{lang key='shareYourRatingGuidelines' section='product rating'}</div>
                                            {/block}
                                            {block name='review-form-stars'}
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
                                            {/block}
                                            {block name='review-form-review-headline'}
                                                <div class="form-group float-label-control required">
                                                    <label for="headline">{lang key="headline" section="product rating"}</label>
                                                    <input type="text" name="cTitel" value="{$oBewertung->cTitel|default:""}" id="headline" class="form-control" required>
                                                </div>
                                            {/block}
                                            {block name='review-form-review-text'}
                                                <div class="form-group float-label-control required">
                                                    <label for="comment">{lang key="comment" section="product rating"}</label>
                                                    <textarea name="cText" cols="80" rows="8" id="comment" class="form-control" required>{$oBewertung->cText|default:""}</textarea>
                                                </div>
                                            {/block}
                                        </div>
                                    {/block}
                                    {block name='review-form-mandatory'}
                                        <p class="small text-muted">(* = {lang key='mandatoryFields'})</p>
                                    {/block}
                                    {block name='review-form-submit'}
                                        <input name="bfh" type="hidden" value="1">
                                        <input name="a" type="hidden" value="{$Artikel->kArtikel}">
                                        <input name="submit" type="submit" value="{lang key="submitRating" section="product rating"}" class="submit btn btn-primary btn-block">
                                    {/block}
                                </div>
                            </div>
                        {/block}
                    {/if}
                </form>
            </div>
        {/block}
    {/block}
    {block name="footer"}
        {include file='layout/footer.tpl'}
    {/block}
{/block}