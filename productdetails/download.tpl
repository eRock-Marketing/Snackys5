{block name='productdetails-download'}
<div class="row">
    {foreach $Artikel->oDownload_arr as $oDownload}
        {if isset($oDownload->oDownloadSprache)}
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                <div class="card">
                    <div class="card-body">
                        <strong class="block h5">{$oDownload->oDownloadSprache->getName()}</strong>
                        <p>{$oDownload->oDownloadSprache->getBeschreibung()}</p>
                        {*<td>{$oDownload->getExtension()}</td>*}
                        {if $oDownload->hasPreview()}
                            <div class="prev mt-xxs">
                            {if $oDownload->getPreviewType() === 'music'}
                                <audio controls controlsList="nodownload" preload="none">
                                    <source src="{$smarty.const.PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}" >
                                    Your browser does not support the audio element.
                                </audio>
                            {elseif $oDownload->getPreviewType() === 'video'}
                                <video width="320" height="240" controls controlsList="nodownload" preload="none">
                                    <source src="{$smarty.const.PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}" >
                                    Your browser does not support the video tag.
                                </video>
                            {elseif $oDownload->getPreviewType() === 'image'}
                                <img src="{$smarty.const.PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}"
                                     class="img-responsive" alt="{$oDownload->oDownloadSprache->getBeschreibung()|strip_tags}">
                            {else}
                                <a href="{$smarty.const.PFAD_DOWNLOADS_PREVIEW_REL}{$oDownload->cPfadVorschau}"
                                   title="{$oDownload->oDownloadSprache->getName()}" target="_blank">
                                    {$oDownload->oDownloadSprache->getName()}
                                </a>
                            {/if}
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        {/if}
    {/foreach}
</div>
{/block}