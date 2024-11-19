{block name='account-rmalist'}
{row}
    {col cols=12 md=12 class='rmas-wrapper'}
        {block name='account-rmalist-card'}
        {card no-body=true class="account-rmalist-card"}
            {cardheader}
                {block name='account-rmalist-card-header'}
                {row class="align-items-center-util"}
                    {col}
                        <span class="h3">
                            {lang key='myReturns' section='rma'}
                        </span>
                    {/col}
                {/row}
                {/block}
            {/cardheader}
            {cardbody}
                {block name='account-rmalist-card-body'}
                <table id="rmas-liste" class="table display compact stripe">
                    {block name='account-rmalist-card-body-table-head'}
                    <thead class="mainTableHead">
                        <tr>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    {/block}
                    {block name='account-rmalist-card-body-table-body'}
                    <tbody>
                        {foreach $rmaService->rmas as $rma}
                            {$returnAddress = $rma->getReturnAddress()}
                            <tr>
                                <td class="d-none">{$rma->createDate}</td>
                                <td>
                                    <div class="d-block font-weight-bold">
                                        <span class="far fa-calendar mr-2"></span>{$rmaService::localizeDate($rma->createDate)}
                                    </div>

                                    <div class="">
                                        {lang key='rmaID' section='rma'}: <span class="badge badge-primary">{$rma->rmaNr|default:''}</span>
                                    </div>

                                    <div class="">
                                        {$status = $rmaService->getStatus($rma)}
                                        {lang key='rma_status' section='rma'}: <span class="badge badge-{$status->class}">{$status->text}</span>
                                    </div>

                                    <div class="">
                                        {if isset($returnAddress->street)}
                                            {if $returnAddress->companyName}<span class="mr-2">{$returnAddress->companyName}</span>{/if}
                                            <span class="mr-2">{$returnAddress->street} {$returnAddress->houseNumber}</span>
                                            {$returnAddress->postalCode} {$returnAddress->city}
                                        {/if}
                                    </div>

                                    <div id="rmaAdditional{$rma->id}" class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="rmaAdditional{$rma->id}Label" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="rmaAdditional{$rma->id}Label">{lang key='rmaItemsModalTitle' section='rma'}{if isset($rma->rmaNr)} {$rma->rmaNr}{/if}</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="{lang key='rmaClose' section='rma'}">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body p-0">
                                                    {block name='account-rmalist-card-body-table-body-modal'}
                                                    {if count($rma->getRMAItems()) > 0}
                                                        {block name='account-rmalist-card-body-table-body-modal-table'}
                                                        <table class="table dropdown-cart-items">
                                                            <thead class="thead-dark">
                                                                <tr>
                                                                    <th>{lang key='boxItems'}</th>
                                                                    <th>{lang key='quantity'}</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            {block name='account-rmalist-card-body-table-body-modal-table-item'}
                                                            {foreach $rma->getRMAItems() as $item}
                                                                {$product = $item->getProduct()}
                                                                <tr>
                                                                    <td>
                                                                        {formrow}
                                                                            {block name='account-rmalist-card-body-table-body-modal-table-item-image'}
                                                                            {if isset($product->kArtikel)}
                                                                                {col class="col-auto"}
                                                                                    {link href=$item->getSeo() title=$item->name|trans|escape:'html'}
                                                                                        {include file='snippets/image.tpl'
                                                                                        fluid=false
                                                                                        item=$product
                                                                                        square=false
                                                                                        srcSize='xs'
                                                                                        sizes='50px'
                                                                                        class=''
                                                                                        maxWidth=50
                                                                                        maxHeight=50}
                                                                                    {/link}
                                                                                {/col}
                                                                            {/if}
                                                                            {/block}
                                                                            {block name='account-rmalist-card-body-table-body-modal-table-item-desc'}
                                                                            {col}
                                                                                {if $item->getSeo() !== ''}
                                                                                    {link href=$item->getSeo() title=$item->name|trans|escape:'html'}
                                                                                        {$item->name|trans}
                                                                                    {/link}
                                                                                {else}
                                                                                    {$item->name|trans}
                                                                                {/if}
                                                                                <small class="text-muted-util d-block">
                                                                                    {lang key='orderNo' section='login'}: {$item->getOrderNo()}<br>
                                                                                    {lang key='productNo'}: {$item->getProductNo()}<br>

                                                                                    {if $item->variationName !== null && $item->variationName !== ''
                                                                                    && $item->variationValue !== null && $item->variationValue !== ''}
                                                                                        {$item->variationName}: {$item->variationValue}
                                                                                    {elseif $item->partListProductName !== null && $item->partListProductName !== ''}
                                                                                        {lang key='partlist' section='rma'}:
                                                                                        {link href=$item->partListProductURL}
                                                                                        {$item->partListProductName}
                                                                                        {/link}
                                                                                    {/if}
                                                                                </small>
                                                                            {/col}
                                                                            {/block}
                                                                        {/formrow}
                                                                    </td>
                                                                    {block name='account-rmalist-card-body-table-body-modal-table-item-quantity'}
                                                                    <td class="text-right-util text-nowrap-util">
                                                                        {$item->quantity}{$item->unit}
                                                                    </td>
                                                                    {/block}
                                                                </tr>
                                                            {/foreach}
                                                            {/block}
                                                            </tbody>
                                                        </table>
                                                        {/block}
                                                    {else}
                                                        {lang key='noDataAvailable'}
                                                    {/if}
                                                    {/block}
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{lang key='rmaClose' section='rma'}</button>
                                                    <a href="{get_static_route id='jtl.php' params=['showRMA' => $rma->id]}" class="btn btn-primary" target="_blank">
                                                        {lang key='rmaDetails' section='rma'}
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-right">
                                    {buttongroup}
                                        <button type="button" class="btn btn-secondary btn-sm mr-2" data-toggle="modal" data-target="#rmaAdditional{$rma->id}" title="{lang key='showItems' section='rma'}">
                                            <span class="fas fa-list-ol"></span>
                                        </button>
                                        <a href="{get_static_route id='jtl.php' params=['showRMA' => $rma->id]}" class="btn btn-secondary btn-sm" target="_blank" title="{lang key='rmaDetails' section='rma'}">
                                            <span class="far fa-eye"></span>
                                        </a>
                                    {/buttongroup}
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                    {/block}
                </table>
                {/block}
            {/cardbody}
        {/card}
        {/block}
    {/col}
{/row}
{/block}
{block name='account-rmalist-script'}
{inline_script}<script>
    function initDataTable(table, rows = 5) {
        table.DataTable( {
            language: {
                "lengthMenu":        "{lang key='lengthMenu' section='datatables'}",
                "info":              "{lang key='info' section='datatables'}",
                "infoEmpty":         "{lang key='infoEmpty' section='datatables'}",
                "infoFiltered":      "{lang key='infoFiltered' section='datatables'}",
                "search":            "",
                "searchPlaceholder": "{lang key='search' section='datatables'}",
                "zeroRecords":       "{lang key='zeroRecords' section='datatables'}",
                "paginate": {
                    "first":    "{lang key='paginatefirst' section='datatables'}",
                    "last":     "{lang key='paginatelast' section='datatables'}",
                    "next":     "{lang key='paginatenext' section='datatables'}",
                    "previous": "{lang key='paginateprevious' section='datatables'}"
                }
            },
            columns: [
                { data: 'sort' },
                { data: 'address' },
                { data: 'buttons' }
            ],
            lengthMenu: [ [rows, rows*2, rows*3, rows*6, rows*10], [rows, rows*2, rows*3, rows*6, rows*10] ],
            pageLength: rows,
            order: [0, 'desc'],
            initComplete: function (settings, json) {
                table.find('.dataTables_filter input[type=search]').removeClass('form-control-sm');
                table.find('.dataTables_length select').removeClass('custom-select-sm form-control-sm');
            },
            drawCallback: function( settings ) {
                table.find('thead.mainTableHead').remove();
            },
        } );
    }

    $(document).ready(function () {
        initDataTable($('#rmas-liste'));
    });
</script>{/inline_script}
{/block}
