{block name='productdetails-mediafile'}
	{if !empty($Artikel->oMedienDatei_arr)}
		{block name='mediafile-assigns'}
			{assign var=mp3List value=false}
			{assign var=titles value=false}
		{/block}
		{block name='mediafile-content'}
    		<div class="row row-multi">
    			{foreach $Artikel->oMedienDatei_arr as $oMedienDatei}
					{if ($mediaType->name == $oMedienDatei->cMedienTyp && $oMedienDatei->cAttributTab|strlen == 0) 
					|| ($oMedienDatei->cAttributTab|strlen > 0 && $mediaType->name == $oMedienDatei->cAttributTab)}
            			{if $oMedienDatei->nErreichbar == 0}
							{block name='mediafile-content-nofile'}
								<div class="col-12">
									<p class="alert alert-danger">
										{lang key='noMediaFile' section='errorMessages'}
									</p>
								</div>
							{/block}
            			{else}
							{block name='mediafile-content-assigns'}
								{assign var=cName value=$oMedienDatei->cName}
								{assign var=titles value=$titles|cat:$cName}
								{if !$oMedienDatei@last}
									{assign var=titles value=$titles|cat:'|'}
								{/if}
							{/block}
                			{if $oMedienDatei->nMedienTyp == 1}
								{block name='mediafile-content-images'}
									<div class="col-xxs-12 col-6 col-lg-4{if $snackyConfig.css_maxTabsWidth >= 1600} col-xl-3{/if}">
										<div class="card">
											{block name='mediafile-content-images-header'}
												<div class="card-header">
													<span class="h6 m0 block">{$oMedienDatei->cName}</span>
												</div>
											{/block}
											{block name='mediafile-content-images-body'}
												<div class="card-body">
													{if $oMedienDatei->cBeschreibung}<span class="block mb-xxs">{$oMedienDatei->cBeschreibung}</span>{/if}
													{if isset($oMedienDatei->oMedienDateiAttribut_arr) && $oMedienDatei->oMedienDateiAttribut_arr|count > 0}
														{foreach $oMedienDatei->oMedienDateiAttribut_arr as $oAttribut}
															{if $oAttribut->cName === 'img_alt'}
																{assign var=cMediaAltAttr value=$oAttribut->cWert}
															{/if}
														{/foreach}
													{/if}
													{image src="{if !empty($oMedienDatei->cPfad)}{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}{elseif !empty($oMedienDatei->cURL)}{$oMedienDatei->cURL}{/if}" alt="{$cMediaAltAttr}" lazy=true}
												</div>
											{/block}
										</div>
									</div>
								{/block}
							{elseif $oMedienDatei->nMedienTyp == 2}
								{block name='mediafile-content-audio'}
                    				{if $oMedienDatei->cName|strlen > 1}
										<div class="col-xxs-12 col-6 col-lg-4{if $snackyConfig.css_maxTabsWidth >= 1600} col-xl-3{/if}">
											<div class="card">
												{block name='mediafile-content-audio-header'}
													<div class="card-header">
														<span class="h6 m0 block">{$oMedienDatei->cName}</span>
													</div>
												{/block}
												{block name='mediafile-content-audio-body'}
													<div class="card-body">
														{if $oMedienDatei->cBeschreibung}<span class="block mb-xxs">{$oMedienDatei->cBeschreibung}</span>{/if}
														{if $oMedienDatei->cPfad|strlen > 1 || $oMedienDatei->cURL|strlen > 1}
															{assign var=audiosrc value=$oMedienDatei->cURL}
															{if $oMedienDatei->cPfad|strlen > 1}
																{assign var=audiosrc value=$smarty.const.PFAD_MEDIAFILES|cat:$oMedienDatei->cPfad}
															{/if}
															{if $audiosrc|strlen > 1}
																<audio controls controlsList="nodownload">
																	<source src="{$audiosrc}" type="audio/mpeg">
																	{lang key='audioTagNotSupported' section='errorMessages'}
																</audio>
															{/if}
														{/if}
													</div>
												{/block}
											</div>
										</div>
									{/if}
								{/block}
							{elseif $oMedienDatei->nMedienTyp === 3}
								{block name='productdetails-mediafile-video'}
									<div class="col-xxs-12 col-6 col-lg-4{if $snackyConfig.css_maxTabsWidth >= 1600} col-xl-3{/if}">
										<div class="card">
											{block name='productdetails-mediafile-video-header'}
												<div class="card-header">
													<span class="h6 m0 block">{$oMedienDatei->cName}</span>
												</div>
											{/block}
											{block name='productdetails-mediafile-video-body'}
												<div class="card-body">
													{if ($oMedienDatei->videoType === 'mp4' 
													|| $oMedienDatei->videoType === 'webm'
													|| $oMedienDatei->videoType === 'ogg')}
														<video class="product-detail-video" controls>
															<source src="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" type="video/{$oMedienDatei->videoType}">
															{lang key='videoTagNotSupported' section='errorMessages'}
														</video> 
													{else}
														<div class="alert alert-info">{lang key='videoTypeNotSupported' section='errorMessages'}</div>
													{/if}   
												</div>
											{/block}
										</div>
									</div>
								{/block}
							{elseif $oMedienDatei->nMedienTyp == 4}
								{block name='mediafile-content-sonstiges'}
									<div class="col-xxs-12 col-6 col-lg-4{if $snackyConfig.css_maxTabsWidth >= 1600} col-xl-3{/if}">
										<div class="card">
											{block name='mediafile-content-sonstiges-header'}
												<div class="card-header">
													<span class="h6 m0 block">{$oMedienDatei->cName}</span>
												</div>
											{/block}
											{block name='mediafile-content-sonstiges-body'}
												<div class="card-body">
													{if $oMedienDatei->cBeschreibung}<span class="block mb-xxs">{$oMedienDatei->cBeschreibung}</span>{/if}
													{if strpos($oMedienDatei->cURL, 'youtube') !== false || strpos($oMedienDatei->cURL, 'youtu.be') !== false}
														{include file='productdetails/mediafile_youtube_embed.tpl'}
													{else}
														{if isset($oMedienDatei->oEmbed) && $oMedienDatei->oEmbed->code}
															{$oMedienDatei->oEmbed->code}
														{/if}
														{if !empty($oMedienDatei->cPfad)}
															<a href="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" target="_blank" class="td-u">{$oMedienDatei->cName}</a>
														{elseif !empty($oMedienDatei->cURL)}
															<a href="{$oMedienDatei->cURL}" target="_blank" class="td-u"><i class="fa fa-external-link"></i> {$oMedienDatei->cName}</a>
														{/if}
													{/if}
												</div>
											{/block}
										</div>
									</div>
								{/block}
							{elseif $oMedienDatei->nMedienTyp == 5}
								{block name='mediafile-content-pdf'}
									<div class="col-xxs-12 col-6 col-lg-4{if $snackyConfig.css_maxTabsWidth >= 1600} col-xl-3{/if}">
										<div class="card">
											{block name='mediafile-content-pdf-header'}
												<div class="card-header">
													<span class="h6 m0 block">{$oMedienDatei->cName}</span>
												</div>
											{/block}
											{block name='mediafile-content-pdf-body'}
												<div class="card-body">
													{if $oMedienDatei->cBeschreibung}<span class="block mb-xxs">{$oMedienDatei->cBeschreibung}</span>{/if}
													{if !empty($oMedienDatei->cPfad)}
														<a href="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" target="_blank" class="flx-ac">
															<span class="img-ct icon icon-xl icon-wt">
																<img alt="PDF" src="{$ShopURL}/{$smarty.const.PFAD_BILDER}intern/file-pdf.png" />
															</span>
															{$oMedienDatei->cName}
														</a>
													{elseif !empty($oMedienDatei->cURL)}
														<a href="{$oMedienDatei->cURL}" target="_blank" class="flx-ac">
															<span class="img-ct icon icon-xl icon-wt">
																<img alt="PDF" src="{$ShopURL}/{$smarty.const.PFAD_BILDER}intern/file-pdf.png" />
															</span>
															{$oMedienDatei->cName}
														</a>
													{/if}
												</div>
											{/block}
										</div>
									</div>
								{/block}
							{/if}
						{/if}
					{/if}
				{/foreach}
			</div>
		{/block}
	{/if}
{/block}