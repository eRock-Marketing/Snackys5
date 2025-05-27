{block name='account-uploads'}
	{if !empty($Bestellung->oUpload_arr)}
		{block name='account-uploads-assigns'}
			{assign var=nNameLength value=50}
			{assign var=nImageMaxWidth value=480}
			{assign var=nImageMaxHeight value=320}
			{assign var=nImagePreviewWidth value=35}
		{/block}
		{block name='account-uploads-wrapper'}
			<div id="uploads" class="mt-sm">
				{block name='account-uploads-headline'}
					<h3>{lang key="yourUploads"}</h3>
				{/block}
				{block name='account-uploads-table'}
					<div class="table-responsive">
						<table class="table table-striped m0" id="customerupload">
							<thead>
							<tr>
								<th>{lang key='name' section='global'}</th>
								<th class="text-center">{lang key='uploadFilesize' section='global'}</th>
								<th class="text-center">{lang key='uploadAdded' section='global'}</th>
								<th class="text-center">{lang key='uploadFile' section='global'}</th>
							</tr>
							</thead>
							<tbody>
							{foreach $Bestellung->oUpload_arr as $oUpload}
								{block name='account-uploads-table-item'}
									<tr>
										{block name='account-uploads-table-item-name'}
											<td class="vcenter">{$oUpload->cName}</td>
										{/block}
										{block name='account-uploads-table-item-size'}
											<td class="text-center vcenter">{$oUpload->cGroesse}</td>
										{/block}
										{block name='account-uploads-table-item-date'}
											<td class="text-center vcenter">
												<span class="infocur" title="{$oUpload->dErstellt|date_format:'%d.%m.%Y - %H:%M:%S'}">
													{$oUpload->dErstellt|date_format:'d.m.Y'}
												</span>
											</td>
										{/block}
										{block name='account-uploads-table-item-upload'}
											<td class="text-center">
												<form method="post" action="{get_static_route id='jtl.php'}">
													{$jtl_token}
													<input name="kUpload" type="hidden" value="{$oUpload->kUpload}" />
													<button class="btn btn-blank btn-xs" name="{$oUpload->cName}">
														<span class="img-ct icon">
															<svg>
															  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-show"></use>
															</svg>
														</span>
													</button>
												</form>
											</td>
										{/block}
									</tr>
								{/block}
							{/foreach}
							</tbody>
						</table>
					</div>
				{/block}
			</div>
		{/block}
	{/if}
{/block}