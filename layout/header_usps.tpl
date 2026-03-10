{block name='layout-header-usps'}
	{block name='usps-assigns'}
		{if $snackyConfig.headerUsps == 1}
			{assign "uspsCol" "12"}
		{elseif $snackyConfig.headerUsps == 2}
			{assign "uspsCol" "6"}
		{elseif $snackyConfig.headerUsps == 3}
			{assign "uspsCol" "4"}
		{elseif $snackyConfig.headerUsps == 4}
			{assign "uspsCol" "3"}
		{/if}
	{/block}
	{block name='usps-bar'}
		<div id="h-us" class="small nowrap">
			<div class="mw-container text-center row flx-nw">
				{block name='usps-benefit1'}
					<span class="col-{$uspsCol} css-check notextov">
						{lang key="headerBenefit1" section="custom"}
					</span>
				{/block}
				{if $snackyConfig.headerUsps >= 2}
					{block name='usps-benefit2'}
						<span class="col-{$uspsCol} css-check notextov">
							{lang key="headerBenefit2" section="custom"}
						</span>
					{/block}
					{if $snackyConfig.headerUsps >= 3}
						{block name='usps-benefit3'}
							<span class="col-{$uspsCol} css-check notextov">
								{lang key="headerBenefit3" section="custom"}
							</span>
						{/block}
						{if $snackyConfig.headerUsps >= 4}
							{block name='usps-benefit4'}
								<span class="col-{$uspsCol} css-check notextov">
									{lang key="headerBenefit4" section="custom"}
								</span>
							{/block}
						{/if}
					{/if}
				{/if}
			</div>
		</div>
		{if $snackyConfig.headerUsps >= 2}
		{inline_script}
		(function(){
			var mql = window.matchMedia('(max-width: 767px)');
			if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
			var row = document.querySelector('#h-us .row');
			var items = row && row.querySelectorAll('.css-check');
			if (!items || items.length < 2) return;
			var i = 0, len = items.length, tid;
			function slide(){
				if (!mql.matches) return;
				items.forEach(function(el, idx){
					el.style.width = idx === i ? '100%' : '0';
					el.style.minWidth = idx === i ? '100%' : '0';
					el.style.overflow = 'hidden';
				});
				i = (i + 1) % len;
			}
			function clear(){ items.forEach(function(el){ el.style.cssText = ''; }); }
			function run(){
				if (mql.matches) { slide(); tid = setInterval(slide, 4000); }
				else { clearInterval(tid); clear(); }
			}
			run();
			mql.addEventListener('change', run);
		})();
		{/inline_script}
		{/if}
	{/block}
{/block}