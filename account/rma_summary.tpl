{block name='account-rma-summary'}
{assign var="returnReturn" value=true}
{assign var="showButtons" value=!isset($showButtons)}
<div class="row">
    <div class="col col-12{if isset($rmaHistory) && count($rmaHistory) > 0} col-md-auto{/if}">
        {block name='account-rma-summary-title'}
        <h2>{lang key='rmaSummaryTitle' section='rma'}</h2>
        {/block}
        {block name='account-rma-summary-text'}
        {if $rmaService->getStatus($rma)->text === ''}
            <p>{lang key='rmaSummaryText' section='rma'}</p>

            {if $returnReturn}
                <p>{lang key='rmaSummaryAddressText' section='rma'}</p>
            {/if}
        {else}
            {lang key='rmaSummaryStatusText' section='rma' assign='rmaSummaryStatusText'}
            {$statusBadge=sprintf('<span class="badge badge-%s">%s</span>', $rmaService->getStatus($rma)->class, $rmaService->getStatus($rma)->text)}
            <p>{sprintf($rmaSummaryStatusText, $statusBadge)}</p>
        {/if}
        {/block}
        {block name='account-rma-summary-address'}
        <div class="mb-3">
            {$returnAddress = $rmaReturnAddressService->getReturnAddress($rma)}

            {if $returnAddress !== null}
                {if $returnAddress->companyName}
                    <h4>
                        {$returnAddress->companyName}
                        {if $returnAddress->companyAdditional}
                            <br><small class="text-muted">{$returnAddress->companyAdditional}</small>
                        {/if}
                    </h4>
                {/if}

                <p>
                    {$returnAddress->academicTitle} {$returnAddress->firstName} {$returnAddress->lastName}<br>

                    <span class="d-block mb-3">
                        {$returnAddress->street} {$returnAddress->houseNumber}{if $returnAddress->addressAdditional},
                            {$returnAddress->addressAdditional}
                        {/if}
                        <br>{$returnAddress->postalCode} {$returnAddress->city}<br>
                        {if $returnAddress->state}
                            {$returnAddress->state}{if $returnAddress->countryISO}, {/if}
                        {/if}
                        {if $returnAddress->countryISO}
                            {$returnAddress->countryISO}
                        {/if}
                    </span>

                    {if $returnAddress->phone}
                        {lang key='tel' section='account data'}: {$returnAddress->phone}<br>
                    {/if}
                    {if $returnAddress->fax}
                        {lang key='fax' section='account data'}: {$returnAddress->fax}<br>
                    {/if}
                    {if $returnAddress->mobilePhone}
                        {lang key='mobile' section='account data'}: {$returnAddress->mobilePhone}<br>
                    {/if}
                    {if $returnAddress->mail}
                        {$returnAddress->mail}
                    {/if}
                </p>
            {/if}

            {if isset($returnShippingLabel)}
                <a href="#rma-label" data-toggle="modal" class="btn btn-outline-primary">
                    <i class="fas fa-barcode"></i> Rücksendeetikett
                </a>

                {modal id="rma-label" title="..." class="fade shipping-order-modal" size="lg"}
                    {lang key='rmaLabelNotGenerated' section='rma'}
                {/modal}
            {/if}
        </div>
        {/block}
    </div>
    {block name='account-rma-summary-history'}
    {if isset($rmaHistory) && count($rmaHistory) > 0}
        <div class="col">
            <div class="card">
                <h5 class="card-header">
                    <i class="fas fa-clipboard-list"></i> {lang key='rmaChangelog' section='rma'}
                </h5>
                <div class="card-body py-0 list-compressed">
                    {foreach $rmaHistory as $historyEvent}
                        {$eventData=$rmaHistoryService->getLocalizedEventDataAsObject($historyEvent)}
                        <div class="border-bottom{if $historyEvent@last}-0{/if} my-3{if !$historyEvent@last} pb-3{/if}">
                            <div class="row">
                                <div class="col">
                                    <h5 class="text-muted mb-1">{$eventData->eventName}</h5>
                                    <p class="card-text">{$eventData->localizedText}</p>
                                </div>
                                <div class="col col-auto my-auto">
                                    <div class="text-center badge badge-light">
                                        <div class="text-muted m-b-0">{$eventData->dateObject->day}</div>
                                        <span class="text-muted font-16">{strtoupper($eventData->dateObject->month)}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    {/if}
    {/block}
</div>
{/block}
{block name='account-rma-summary-items'}
<h3 class="mt-5">{lang key='rmaSummaryItemTableTitle' section='rma'}</h3>

{foreach $rmaService->groupRMAItems($rma->getRMAItems()) as $orderNo => $order}
    <div class="card limit-rows open">
        <div class="card-header limit-rows-toggle">
            <span class="w-100">
                <u>{lang key='order'} {$orderNo}</u>
            </span>
        </div>
        <div class="card-body limit-rows-row">
            {block name='account-rma-summary-items-header'}
            <div class="row py-1 font-weight-bold text-nowrap">
                {block name='account-rma-summary-items-header-image'}
                <div class="col-auto">
                    <div class="w-45">
                        {lang key='rmaImage' section='rma'}
                    </div>
                </div>
                {/block}
                {block name='account-rma-summary-items-header-details'}
                <div class="col">{lang key='rmaName' section='rma'}</div>
                <div class="col col-auto d-none d-md-block">{lang key='rmaQuantity' section='rma'}</div>
                <div class="col col-5 col-sm-4 col-md-3 text-right d-none d-sm-block">{lang key='rmaReason' section='rma'}</div>
                {/block}
            </div>
            {/block}
            {block name='account-rma-summary-items-body'}
            {foreach $order as $pos}
                {block name='account-rma-summary-items-body-item'}
                <div class="row py-1 text-nowrap">
                    {block name='account-rma-summary-items-body-item-image'}
                    <div class="col-auto">
                        <div class="mw-45">
                            {if !empty($pos->getProduct()->cVorschaubildURL)}
                                {include file='snippets/image.tpl' item=$pos->getProduct() square=false srcSize='xs'}
                            {/if}
                        </div>
                    </div>
                    {/block}
                    {block name='account-rma-summary-items-body-item-details'}
                    <div class="col">
                        <div>
                            <a href="{$pos->getProduct()->cSeo}" target="_blank" class="line-clamp">{$pos->name}</a>
                            <small class="">
                                {if ($pos->variationName !== null && $pos->variationValue !== null)}
                                    {$pos->variationName}: {$pos->variationValue}<br>
                                {elseif $pos->partListProductID > 0}
                                    {lang key='partlist' section='rma'}:
                                    {link href=$pos->partListProductURL|default:'#'}
                                        {$pos->partListProductName}
                                    {/link}
                                {/if}
                                {if $pos->comment !== ''}
                                    <span class="line-clamp">
                                        {lang key='comment' section='productDetails'}: <span class="font-italic">
                                            {$pos->comment}
                                        </span>
                                    </span>
                                {/if}
                            </small>
                        </div>
                    </div>

                    <div class="col col-auto d-none d-md-block">
                        <span class="text-nowrap">{$pos->quantity}{$pos->unit}</span>
                    </div>

                    <div class="col col-5 col-sm-4 col-md-3 text-right d-none d-sm-block">
                        {$pos->getReason()->title}
                    </div>
                    {/block}
                </div>
                {/block}
            {/foreach}
            {/block}
        </div>
    </div>
{/foreach}
{/block}
{block name='account-rma-summary-buttons'}
    {if $showButtons}
        <div class="row mt-3">
            <div class="col col-md-6">
                <a href="#" id="goBackOneStep" class="btn btn-outline-primary float-left">
                    {lang key='edit' section='rma'}
                </a>
            </div>
            <div class="col col-md-6">
                {form action="{get_static_route id='jtl.php'}" method="post"}
                    <input type="hidden" name="rmaCreateDateHash" value="{$rmaService->hashCreateDate($rma)}">
                    <button type="submit" class="btn btn-primary float-right">
                        {lang key='createRetoure' section='rma'}
                    </button>
                {/form}
            </div>
        </div>
    {/if}
{/block}
{block name='account-rma-summary-script'}
    {inline_script}
        <script>
            $(document).ready(function () {
                $('.limit-rows-toggle').on('click', function (e) {
                    e.preventDefault();
                    $(this).closest('.limit-rows').toggleClass('open');
                });
                $('.reason-comment-toggle').on('click', function (e) {
                    e.preventDefault();
                    $(this).parent().find('.reason-comment').toggleClass('d-none');
                });
            });
        </script>
    {/inline_script}
{/block}
