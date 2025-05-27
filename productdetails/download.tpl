{block name='productdetails-download'}
	<div class="row">
		{foreach $Artikel->oDownload_arr as $oDownload}
			{if isset($oDownload->oDownloadSprache)}
				<div class="col-12 col-sm-6 col-md-4 col-lg-3">
					<div class="card">
						<div class="card-body">
							{block name='download-title'}
								<strong class="block h5">{$oDownload->oDownloadSprache->getName()|default:''}</strong>
							{/block}
							{block name='download-description'}
								<p>{$oDownload->oDownloadSprache->getBeschreibung()}</p>
							{/block}
							{block name='download-file'}
								{if $oDownload->hasPreview()}
									<div class="prev mt-xxs">
										{if $oDownload->getPreviewType() === 'music'}
											{block name='download-file-music'}
												<audio controls controlsList="nodownload" preload="none">
													<source src="{$ShopURL}/{$smarty.const.PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}" >
													Your browser does not support the audio element.
												</audio>
											{/block}
										{elseif $oDownload->getPreviewType() === 'video'}
											{block name='download-file-video'}
												<video width="320" height="240" controls controlsList="nodownload" preload="none">
													<source src="{$ShopURL}/{$smarty.const.PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}" >
													Your browser does not support the video tag.
												</video>
											{/block}
										{elseif $oDownload->getPreviewType() === 'image'}
											{block name='download-file-image'}
												{image src="{$ShopURL}/{$smarty.const.PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}"
												fluid=true alt=$oDownload->oDownloadSprache->getBeschreibung()|default:''|strip_tags}
											{/block}
										{else}
											{block name='download-file-other'}
												<a href="{$ShopURL}/{$smarty.const.PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}"
												   title="{$oDownload->oDownloadSprache->getName()|default:''}" target="_blank">
													{$oDownload->oDownloadSprache->getName()|default:''}
												</a>
											{/block}
										{/if}
									</div>
								{/if}
							{/block}
						</div>
					</div>
				</div>
			{/if}
		{/foreach}
	</div>
{/block}