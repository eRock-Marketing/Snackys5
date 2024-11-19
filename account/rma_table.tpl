{block name='account-rma-table'}
<table id="returnable-items" class="table compact">
    <thead>
    <tr>
        <th>&nbsp;</th>
        <th>&nbsp;</th>
    </tr>
    </thead>
    <tbody>
    {block name='account-rma-table-body'}
        {foreach $returnableProducts as $product}
            {assign var=rmaItem value=$rmaService->getRMAItem(
                $rma,
                $product->shippingNotePosID
            )}
            {assign var=itemUniqueID value="{$product->shippingNotePosID}_{$product->id}"}
            <tr>
                <td class="d-none">{$product->getOrderNo()}</td>
                <td class="product px-0">
                    {block name='account-rma-table-body-product'}
                    <div class="d-flex flex-wrap">
                        <div class="d-flex flex-nowrap flex-grow-1">
                            {block name='account-rma-table-body-product-image'}
                            <div class="d-block">
                                {image lazy=true webp=true fluid=true
                                src=$product->getProduct()->Bilder[0]->cURLKlein|default:$smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN
                                alt=$product->name
                                class="img-aspect-ratio product-thumbnail pr-2"}
                            </div>
                            {/block}
                            <div class="d-flex flex-nowrap flex-grow-1 flex-column">
                                {block name='account-rma-table-body-product-name'}
                                <div class="d-inline-flex flex-nowrap justify-content-between">
                                    <a href="{$product->getSeo()}" target="_blank"
                                       class="font-weight-bold mr-2">
                                        {$product->name}
                                    </a>
                                    <div class="custom-control custom-checkbox">
                                        <input type='checkbox'
                                               class='custom-control-input ra-switch'
                                               id="switch-{$itemUniqueID}"
                                               name="returnItem"
                                               {if $rmaItem->id > 0}checked{/if}
                                               aria-label="Lorem ipsum">
                                        <label class="custom-control-label"
                                               for="switch-{$itemUniqueID}">
                                        </label>
                                    </div>
                                </div>
                                {/block}
                                {block name='account-rma-table-body-product-details'}
                                <small class="text-muted-util d-block">
                                    {lang key='orderNo' section='login'}: {$product->getOrderNo()}<br>
                                    {lang key='orderDate' section='login'}: {$product->getOrderDate()|date_format:'d.m.Y'}<br>
                                    {lang key='productNo'}: {$product->getProductNo()}<br>

                                    {if $product->variationName !== null
                                    && $product->variationValue !== null}
                                        {$product->variationName}: {$product->variationValue}
                                    {elseif $product->partListProductName !== ''}
                                        {lang key='partlist' section='rma'}:
                                        {link href=$product->partListProductURL target="_blank"}
                                            {$product->partListProductName}
                                        {/link}
                                    {/if}
                                </small>
                                {/block}
                            </div>
                        </div>
                        {block name='account-rma-table-body-product-form'}
                        <div class="{if $rmaItem->id > 0}d-flex {else}d-none {/if}rmaFormItems flex-wrap mt-2 w-100">
                            <div class="qty-wrapper max-w-md mr-2 mb-2">
                                {inputgroup id="quantity-grp{$itemUniqueID}" class="form-counter choose_quantity"}
                                {inputgroupprepend}
                                {button variant="" class="btn-decrement"
                                data=["count-down"=>""]
                                aria=["label"=>{lang key='decreaseQuantity' section='aria'}]}
                                    <span class="fas fa-minus"></span>
                                {/button}
                                {/inputgroupprepend}
                                {input type="number"
                                required=($product->getProduct()->fAbnahmeintervall > 0)
                                step="{if $product->getProduct()->cTeilbar === 'Y' && $product->getProduct()->fAbnahmeintervall == 0}.01{elseif $product->getProduct()->fAbnahmeintervall > 0}{$product->getProduct()->fAbnahmeintervall}{else}1{/if}"
                                min="1"
                                id="qty-{$itemUniqueID}" class="quantity" name="quantity"
                                aria=["label"=>"{lang key='quantity'}"]
                                value="{if $rmaItem->id > 0}{$rmaItem->quantity}{else}{$product->quantity}{/if}"
                                data=[
                                "snposid" => {$itemUniqueID},
                                "decimals" => {$product->getProduct()->fAbnahmeintervall},
                                "max" => {$product->quantity}]
                                }
                                {inputgroupappend}
                                    <div class="input-group-text unit form-control bg-white">{$product->unit}</div>
                                    {button variant="" class="btn-increment"
                                    data=["count-up"=>""]
                                    aria=["label"=>{lang key='increaseQuantity' section='aria'}]}
                                        <span class="fas fa-plus"></span>
                                    {/button}
                                {/inputgroupappend}
                                {/inputgroup}
                            </div>

                            <div class="flex-grow-1 mr-2 mb-2">
                                {select aria=["label"=>""]
                                name="reason"
                                data=["snposid" => "{$itemUniqueID}"]
                                class="custom-select form-control"}
                                    <option value="-1"{if $rmaItem->id === 0} selected{/if}>{lang key='rma_comment_choose' section='rma'}</option>
                                {foreach $reasons as $reason}
                                    <option value="{$reason->reasonID}"{if $rmaItem->reasonID === $reason->reasonID} selected{/if}>{$reason->title}</option>
                                {/foreach}
                                {/select}
                            </div>

                            <div class="flex-grow-1 mr-2 mb-2">
                                {textarea name="comment"
                                data=["snposid" => "{$itemUniqueID}"]
                                rows=1
                                maxlength="255"
                                placeholder="{lang key='comment' section='productDetails'}"}
                                {if $rmaItem->comment !== null}
                                    {$rmaItem->comment}
                                {/if}
                                {/textarea}
                            </div>
                        </div>
                        {/block}
                    </div>
                    {/block}
                </td>
            </tr>
        {/foreach}
    {/block}
    </tbody>
</table>
{/block}
