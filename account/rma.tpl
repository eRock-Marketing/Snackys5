{block name='account-rma'}
{row class="rma-step-1"}
    {col cols=12 md=7 lg=8 class='rma-form-wrapper'}
        {block name='account-rma-card'}
        {card no-body=true id="rma-items"}
            {cardheader}
                {block name='account-rma-card-header'}
                {row class="align-items-center-util"}
                    {col}
                        <span class="h3">
                            {lang key='addItems' section='rma'}
                        </span>
                        <a href="#" class="float-right select_all"
                           data-lang-select="{lang key='addVisibleItems' section='rma'}"
                           data-lang-unselect="{lang key='removeVisibleItems' section='rma'}">
                            {lang key='addVisibleItems' section='rma'}
                        </a>
                    {/col}
                {/row}
                {/block}
            {/cardheader}
            {cardbody}
                {block name='account-rma-card-body'}
                <div class="col-sm-12 col-md-4 dataTable-custom-filter">
                    <label>
                        {select name="orders" aria=["label"=>"Bestellnummer"]
                        class="custom-select custom-select-sm form-control form-control-sm"}
                            <option value="" selected>{lang key='allOrders' section='rma'}</option>
                            {foreach $returnableOrders as $order}
                                <option value="{$order['orderNo']}">{$order['orderNo']} - {$order['orderDate']}</option>
                            {/foreach}
                        {/select}
                    </label>
                </div>
                {include file='account/rma_table.tpl' returnableProducts=$returnableProducts
                rmaService=$rmaService}
                {/block}
            {/cardbody}
        {/card}
        {/block}
    {/col}
    {col cols=12 md=5 lg=4 class='rma-items-wrapper'}
        {card no-body=true class="rma-step-1 sticky-card"}
            <div id="rmaStickyItems">
                <div class="rmaItemContainer">
                    {include file='account/rma_itemlist.tpl' rmaItems=$rma->getRMAItems() rmaService=$rmaService}
                </div>
            </div>
            {block name='account-rma-itemlist-form'}
            {form method="post" id='rma' action="#" class="jtl-validate card p-2 mt-3" slide=true}
                {formgroup label="{lang key='returnAddress' section='rma'}"
                label-for="returnAddress"}
                    <div class="input-group">
                        {select name="returnAddress" id="returnAddress" class="custom-select"
                        autocomplete="shipping Adress"}
                            {include file='account/returnaddress/form_option.tpl' returnAddresses=$shippingAddresses}
                        {/select}
                        <div class="input-group-append">
                            {block name='account-rma-itemlist-form-submit'}
                            {button type="submit" value="1" block=true variant="primary"}
                                {lang key='continueOrder' section='account data'}
                            {/button}
                            {/block}
                        </div>
                    </div>
                {/formgroup}
            {/form}
            {/block}
        {/card}
    {/col}
{/row}
{block name='account-rma-summary'}
{row class="rma-step-2 d-none"}
    {col}
        <div id="rma-summary"></div>
    {/col}
{/row}
{/block}
{/block}
{block name='account-rma-return-address-modal'}
    {modal id="returnAddressModal" class="fade" title={lang key='newReturnAddress' section='rma'}}
        {include file='account/shipping_address_form.tpl' isModal=true LieferLaender=$shippingCountries}
    {/modal}
{/block}
{block name='account-rma-script'}
    {inline_script}<script>
        let rmaID = parseInt('{$rma->id}'),
            formData = [],
            updPosRequest,
            goToStep = 1;

        function initDataTable(tableID, rows = 5) {
            let $table = $(tableID);
            return $table.DataTable( {
                language: {
                    lengthMenu:        '_MENU_',
                    info:              '{lang key='info' section='datatables' addslashes=true}',
                    infoEmpty:         '{lang key='infoEmpty' section='datatables' addslashes=true}',
                    infoFiltered:      '{lang key='infoFiltered' section='datatables' addslashes=true}',
                    search:            '',
                    searchPlaceholder: '{lang key='search' section='datatables' addslashes=true}',
                    zeroRecords:       '{lang key='zeroRecords' section='datatables' addslashes=true}',
                    paginate: {
                        first:    '{lang key='paginatefirst' section='datatables' addslashes=true}',
                        last:     '{lang key='paginatelast' section='datatables' addslashes=true}',
                        next:     '{lang key='paginatenext' section='datatables' addslashes=true}',
                        previous: '{lang key='paginateprevious' section='datatables' addslashes=true}'
                    }
                },
                columns: [
                    { data: 'sort' },
                    { data: 'product' }
                ],
                lengthMenu: [ [rows, rows*2, rows*3, rows*6, rows*10], [rows, rows*2, rows*3, rows*6, rows*10] ],
                pageLength: rows,
                order: [0, 'desc'],
                initComplete: () => {
                    let $tableWrapper = $('#rma-items');

                    $tableWrapper.find('.dataTable-custom-filter')
                        .removeClass('col-sm-12 col-md-6').addClass('col-8 col-sm-8 col-md-8 col-lg-4');

                    $tableWrapper.find('.dataTables_length').parent()
                        .removeClass('col-sm-12 col-md-6').addClass('col-4 col-sm-4 col-md-4 col-lg-2');

                    $tableWrapper.find('.dataTables_filter').parent()
                        .removeClass('col-sm-12 col-md-6').addClass('col-sm-12 col-md-12 col-lg-6');

                    $tableWrapper.find('.custom-select').addClass('w-100');
                    $tableWrapper.find('.dataTable-custom-filter').prependTo($tableWrapper.find('.dataTables_wrapper .row:first-child'));
                },
                drawCallback: () => {
                    $table.find('thead').remove();
                },
            } );
        }

        function setListenerForToggles() {
            $('.ra-switch').off('change').on('change', function () {
                if ($(this).prop('checked')) {
                    $(this).closest('tr').find('.rmaFormItems').removeClass('d-none').addClass('d-flex');
                } else {
                    $(this).closest('tr').find('.rmaFormItems').removeClass('d-flex').addClass('d-none');
                }
                $('#rma').submit();
                let selectAll = $('.select_all');
                selectAll.text(
                    $('.ra-switch').prop('checked') ? selectAll.data('lang-unselect') : selectAll.data('lang-select')
                );
            });
            $('#returnable-items td.product').off('click').on('click', function () {
                let checkbox = $(this).find('input[type="checkbox"]');
                checkbox.prop('checked', !checkbox.prop('checked'));
                checkbox.trigger('change');
            });
            $('#returnable-items td.product a, #returnable-items td.product .rmaFormItems').off('click')
                .on('click', function (e) {
                    e.stopImmediatePropagation();
                });
        }

        function setListenerForQuantities() {
            $('input.quantity').off('change').on('change', function () {
                $('#rma').submit();
            });

            $('.qty-wrapper .btn-decrement, .qty-wrapper .btn-increment').off('click').on('click', function () {
                let $qtyWrapper = $(this).closest('.qty-wrapper'),
                    input = $qtyWrapper.find('input.quantity'),
                    step = input.attr('step') > 0 ? parseFloat(input.attr('step')) : 1,
                    min = parseFloat(input.attr('min')),
                    max = parseFloat(input.attr('data-max')),
                    val = parseFloat(input.val());

                let decimalPlaces = Number.isInteger(step)
                    ? 0
                    : step.toString().split('.')[1].length;

                if ($(this).hasClass('btn-increment')) {
                    val += step;
                } else {
                    val -= step;
                    val = val < min ? min : val;
                }

                $qtyWrapper.find('.form-warning-msg').remove();
                if (val > max) {
                    if ($qtyWrapper.has('.form-warning-msg').length === 0) {
                        let errorMessage = $('<div/>');
                        errorMessage
                            .addClass('form-warning-msg')
                            .html('{lang key='maxAnzahlTitle' section='rma' addslashes=true}'
                                .replace('%s', (val - max)
                                    .toFixed(decimalPlaces)
                                    .replace(',', '.')
                                )
                            );
                        $qtyWrapper.append(errorMessage);
                    }
                }

                input.val(
                    val.toFixed(decimalPlaces).replace(',', '.')
                );
                input.trigger('change');
            });
        }

        function setListenerForBackButton() {
            $('#goBackOneStep').off('click').on('click', function (e) {
                e.preventDefault();
                step(1);
            });
        }

        function showMinItemsAlert() {
            eModal.alert({
                message: '{lang key='noItemsSelectedText' section='rma' addslashes=true}',
                title: '{lang key='noItemsSelectedTitle' section='rma' addslashes=true}',
                keyboard: true,
                tabindex: -1,
                buttons: false
            });
        }

        function step(goTo) {
            if (goTo === 1) {
                $('.rma-step-1').removeClass('d-none');
                $('.rma-step-2').addClass('d-none');
            } else if (goTo === 2) {
                $('.rma-step-2').removeClass('d-none');
                $('.rma-step-1').addClass('d-none');
                setListenerForBackButton();
            }
        }

        function showNoReasonAlert($table) {
            let $selectClone;

            $table.rows().every(function () {
                if ($selectClone === undefined) {
                    let $select = $(this.node()).find('select[name=reason][data-snposid]');
                    if ($select.val() === '-1') {
                        $selectClone = $select.clone().removeAttr('data-snposid').attr('id', 'reasonForAll');
                    }
                }
            });

            if ($selectClone.length === 0) {
                eModal.alert({
                    message: '{lang key='unknownError' section='messages' addslashes=true}',
                    title: '{lang key='rma_error' section='rma' addslashes=true}',
                    keyboard: true,
                    tabindex: -1,
                    buttons: false
                });

                return false;
            }

            eModal.alert({
                message: '<p class="font-weight-bold">{lang key='noReasonSelectedText' section='rma' addslashes=true}</p>'
                    + '<p>{lang key='noReasonSelectedTextDetailed' section='rma' addslashes=true}</p>'
                    + '<div class="mt-3">'
                    + $selectClone.get(0).outerHTML
                    + '</div>',
                title: '{lang key='noReasonSelectedTitle' section='rma' addslashes=true}',
                keyboard: true,
                tabindex: -1,
                buttons: [
                    {
                        text: '{lang key='noReasonSelectedSaveButton' section='rma' addslashes=true}',
                        close: true,
                        click: function() {
                            let newValue = $('#reasonForAll').val();

                            $table.rows().every(function () {
                                if ($(this.node()).find('input[name=returnItem]').prop('checked')) {
                                    let $select = $(this.node()).find('select[name=reason][data-snposid]');
                                    if ($select.val() === '-1') {
                                        $select.val(newValue);
                                    }
                                }
                            });

                            $('#rma button[type=submit]').trigger('click');
                        }
                    }
                ],
            });
        }

        function setFormData(data, $table) {
            let inputs = [];

            $table.rows().every(function () {
                if ($(this.node()).find('input[name=returnItem]').prop('checked')) {
                    $(this.node()).find('[data-snposid]').each(function () {
                        if ($(this).attr('name') === 'quantity') {
                            let max = parseFloat($(this).attr('max')),
                                val = parseFloat($(this).val());
                            if (val > max) {
                                $(this).val(max);
                            }
                        }
                        inputs.push(
                            {
                                name: $(this).attr('name'),
                                value: {
                                    posUniqueID: $(this).attr('data-snposid'),
                                    value: $(this).val()
                                }
                            }
                        );
                    });
                }
            });
            formData = data.concat(inputs);
        }

        $(document).ready(function () {
            const customFilter = $('.dataTable-custom-filter select[name=orders]'),
                orderNo = '{$orderNo|default:''}';

            if (orderNo !== '') {
                customFilter.val(orderNo);
            }

            // Filter by order id
            $.fn.dataTable.ext.search.push(function (settings, data) {
                let orderNo = customFilter.val(),
                    orderNos = data[0] || '';

                return orderNo === orderNos || orderNo === '';
            });

            const $table = initDataTable('#returnable-items');

            // Set toggle listener again when table redraws
            $table.on('draw', function () {
                setListenerForToggles();
                setListenerForQuantities();
            });

            customFilter.on('change', function () {
                $table.draw();
            });

            setListenerForToggles();
            setListenerForQuantities();

            $('#lieferadressen').on('submit', function (e) {
                e.preventDefault();
                $('#lieferadressen button[type=submit]')
                    .addClass('isLoading').attr('disabled', true);
                let formData = $(this).serializeArray();
                $.evo.io().request(
                    {
                        name: 'createShippingAddress',
                        params: [formData]
                    },
                    { },
                    function (error, data) {
                        if (error) {
                            return;
                        }
                        if (data['response']['result'] === false) {
                            alert(data['response']['msg']);
                        } else {
                            $('#returnAddress').html(data['response']['options']);
                            $('#lieferadressen button[type=submit]')
                                .removeClass('isLoading').attr('disabled', false);
                            $('#returnAddressModal').modal('hide');
                            $('#rma button[type=submit]').trigger('click');
                        }
                    }
                );
            });

            $('#rma button[type=submit]').on('click', function (e) {
                e.preventDefault();
                if ($('#returnAddress').val() === '-1') {
                    $('#returnAddressModal').modal('show');
                } else {
                    // Update FormData variable with user input
                    setFormData($(this).closest('form').serializeArray(), $table)
                    // CHECK IF ITEMS ARE SELECTED
                    if (formData.filter(e => e.name === 'quantity').length === 0) {
                        showMinItemsAlert();
                        return;
                    }
                    // Check if reason is set
                    let reasonNotSetInputs = formData.filter(input => input.name === 'reason' && input.value.value ===
                        '-1');
                    if (reasonNotSetInputs.length > 0) {
                        showNoReasonAlert($table);
                        return;
                    }

                    goToStep = 2;
                    $('#rma').submit();
                }
            });

            $('#rma').on('submit', function (e) {
                e.preventDefault();
                setFormData($(this).serializeArray(), $table)

                // Cancel AJAX request if it is still running
                if (updPosRequest !== undefined) {
                    updPosRequest.abort();
                }

                $('#rmaStickyItems').addClass('loadingAJAX');

                updPosRequest = $.evo.io().request(
                        {
                            name: (goToStep === 2) ? 'rmaSummary' : 'rmaItems',
                            params: [formData]
                        },
                    { },
                    function (error, data) {
                        $('#rmaStickyItems').removeClass('loadingAJAX');
                        if (error) {
                            return;
                        }
                        if (data['response']['result'] === false) {
                            alert(data['response']['msg']);
                        } else {
                            if (goToStep === 1) {
                                $('#rma-summary').html('');
                                $('#rmaStickyItems .rmaItemContainer').html(data['response']['html']);
                                step(1);
                            } else if (goToStep === 2) {
                                $('#rma-summary').html(data['response']['html']);
                                step(2);
                                goToStep = 1;
                            }
                        }
                    }
                );
            });
            $('.select_all').on('click', function (e) {
                e.preventDefault();
                let switches = $('.ra-switch');
                switches.prop('checked', !switches.prop('checked'));
                switches.trigger('change');
                $(this).text(
                    switches.prop('checked') ? $(this).data('lang-unselect') : $(this).data('lang-select')
                );
            });
        });
    </script>{/inline_script}
{/block}
