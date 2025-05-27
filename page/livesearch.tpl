{block name='page-livesearch'}
	{if count($LivesucheTop) > 0 || count($LivesucheLast) > 0}
		{opcMountPoint id='opc_before_livesearch'}
		<div class="row" id="livesearch">
			<div class="col-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">{lang key='topsearch'}{$Einstellungen.sonstiges.sonstiges_livesuche_all_top_count}</h4>
					</div>
					<div class="panel-body">
						<ul class=list-unstyled>
							{if count($LivesucheTop) > 0}
								{foreach $LivesucheTop as $suche}
									<li class="tag">
										<a href="{$suche->cURLFull}">{$suche->cSuche}</a>
										<span class="badge pull-right">{$suche->nAnzahlTreffer}</span>
									</li>
								{/foreach}
							{else}
								<li>{lang key='noDataAvailable'}</li>
							{/if}
						</ul>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">{lang key='lastsearch'}</h4>
					</div>
					<div class="panel-body">
						<ul class="list-unstyled">
							{if count($LivesucheLast) > 0}
								{foreach $LivesucheLast as $suche}
									<li class="tag">
										<a href="{$suche->cURLFull}">{$suche->cSuche}</a>
										<span class="badge pull-right">{$suche->nAnzahlTreffer}</span>
									</li>
								{/foreach}
							{else}
								<li>{lang key='noDataAvailable'}</li>
							{/if}
						</ul>
					</div>
				</div>
			</div>
		</div>
	{/if}
{/block}