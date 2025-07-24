{block name="km-sonderpreis-bis"}	
	{if $snackyConfig.specialpriceDate == "C"}
		{block name="specialprice-countdown"}
			{block name="specialprice-countdown-assigns"}
				{assign var="uid" value="art_c_{$Artikel->kArtikel}_{1|mt_rand:20}"}
			{/block}
			{block name="specialprice-countdown-wrapper"}
				<div id="{$uid}" class="sale-wp mb-sm mt-sm text-center panel">
					<div class="mb-xs h4">{lang key="sonderpreisBisDetail" section="custom"}</div>
					<div class="flx-jc">
						<div class="ct-wp days">
							<div class="ct-it">0</div>
							<div class="ct-un">{lang key='days'}</div>
						</div>
						<div class="ct-wp hours">
							<div class="ct-it">0</div>
							<div class="ct-un">{lang key='hours'}</div>
						</div>
						<div class="ct-wp minutes">
							<div class="ct-it">0</div>
							<div class="ct-un">{lang key='minutes'}</div>
						</div>
						<div class="ct-wp seconds">
							<div class="ct-it">0</div>
							<div class="ct-un">{lang key='seconds'}</div>
						</div>
					</div>
				</div>
			{/block}
			{block name="specialprice-countdown-javscript"}
				{inline_script}<script>
					$(() => {
						let until = new Date("{$Artikel->dSonderpreisEnde_de|date_format:"Y-m-d"}T23:59:59");
						let countDownDate = until.getTime();
						let timeout = setInterval(update, 1000);

						update();
						$(window).trigger('resize');

						function update()
						{
							let now      = new Date().getTime();
							let distance = countDownDate - now; 
							let days     = Math.floor(distance / (1000 * 60 * 60 * 24));
							let hours    = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
							let minutes  = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
							let seconds  = Math.floor((distance % (1000 * 60)) / 1000);

							if (distance <= 0) {
								clearInterval(timeout);
								days    = 0;
								hours   = 0;
								minutes = 0;
								seconds = 0;
								$("#{$uid}").hide();
								$(window).trigger('resize');
							}

							$("#{$uid} .days .ct-it").html(days);
							$("#{$uid} .hours .ct-it").html(hours);
							$("#{$uid} .minutes .ct-it").html(minutes);
							$("#{$uid} .seconds .ct-it").html(seconds);
						}
					});
				</script>{/inline_script}
			{/block}
		{/block}
	{elseif $snackyConfig.specialpriceDate == "D"}
		{block name="specialprice-date"}
			<div class="mb-sm mt-sm panel text-center">
				<div class="h4 m0">
					{lang key="sonderpreisBisDetail" section="custom"} {$Artikel->dSonderpreisEnde_de|date_format:"{$snackyConfig.deliveryDateFormat}"}
				</div>
			</div>
		{/block}
	{/if}
{/block}