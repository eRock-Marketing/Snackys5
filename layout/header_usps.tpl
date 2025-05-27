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
		<div id="h-us" class="hidden-xs small nowrap{if $snackyConfig.uspsStyle == 1} th-l{elseif $snackyConfig.uspsStyle == 2} th-d{/if}">
			<div class="mw-container text-center row">
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
	{/block}
{/block}