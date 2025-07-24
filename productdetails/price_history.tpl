{block name='productdetails-price-history'}
    {block name='productdetails-price-history-canvas'}
        <div>
            <canvas id="priceHistoryChart"></canvas>
        </div>
    {/block}
    {block name='productdetails-price-history-script'}
        {inline_script}<script>
            var ctx = document.getElementById('priceHistoryChart').getContext('2d'),
                priceHistoryChart = null,
                chartDataTitle = "{lang key='priceFlow' section='productDetails'}";
                chartData = {
                labels:   [],
                datasets: [
                    {
                        label:            "{lang section='productDetails' key='PriceFlowTitle' printf=(string)$Einstellungen.preisverlauf.preisverlauf_anzahl_monate} " + "({JTL\Session\Frontend::getCurrency()->getName()})",
                        backgroundColor:  "rgba(248,191,0,0.2)",
                        borderColor:      "#F8BF00",
                        fill:             false,
                        lineTension:      0,
                        pointRadius:      5,
                        pointHoverRadius: 8,
                        data:             []
                    }
                ]
            };

            {foreach array_reverse($preisverlaufData) as $pv}
                chartData.labels.push('{$pv->date}');
                chartData.datasets[0].data.push('{$pv->fPreis}');
                chartDataCurrency = '{$pv->currency}';
                chartDataTooltip = "{lang key='price'}: ";
            {/foreach}
        </script>{/inline_script}
    {/block}
{/block}