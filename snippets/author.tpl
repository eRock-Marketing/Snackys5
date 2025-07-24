{block name='snippets-author'}
{block name='news-author'}
<div>
    <a class="dropdown-toggle" href="#" title="{$oAuthor->cName}" data-toggle="modal" data-target="#author-{$oAuthor->kContentAuthor}">{$oAuthor->cName}</a>&nbsp;&ndash;&nbsp;
    {if isset($cDate)}
        <span class="creation-date">{$cDate}</span>
    {/if}
    <div class="modal fade" tabindex="-1" role="dialog" id="author-{$oAuthor->kContentAuthor}">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header v-wrap">
                    {if !empty($oAuthor->cAvatarImgSrcFull)}
                        <img alt="{$oAuthor->cName}" src="{$oAuthor->cAvatarImgSrcFull}" height="80" class="img-circle" />
                    {/if}
                    <div class="top10">{$oAuthor->cName}</div>
                </div>
                {if !empty($oAuthor->cVitaShort)}
                    <div class="modal-body">
                        {$oAuthor->cVitaShort}
                    </div>
                {/if}
            </div>
        </div>
    </div>
</div>
{/block}
{/block}