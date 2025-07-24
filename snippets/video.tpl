{if !empty($title)}
    <label>{$title}</label>
{/if}
<div class="{if !empty($class)}{$class}{/if}
        {if $responsive|default:false}embed-responsive embed-responsive-16by9{/if}"
     {if !empty($id)}id="{$id}"{/if}>
    {if $video->getType() === \JTL\Media\Video::TYPE_YOUTUBE}
        {$provider = 'youtube'}
    {elseif $video->getType() === \JTL\Media\Video::TYPE_VIMEO}
        {$provider = 'vimeo'}
    {else}
        {$provider = null}
    {/if}
    {if $provider === 'youtube' || $provider === 'vimeo'}
        <iframe data-src="{$video->getEmbedUrl()}"
                class="needs-consent {$provider}"
                width="{$video->getWidth()|default:'100%'}"
                height="{$video->getHeight()|default:'auto'}"
                {if !empty($title)}title="{$title}"{/if}
                {if $video->isAllowFullscreen()}allowfullscreen{/if}>
        </iframe>
        {$previewImageUrl = $video->getPreviewImageUrl()}
        <a href="#" class="trigger give-consent give-consent-preview"
           data-consent="{$provider}"
           style="background-image:
                   url({$ShopURL}/templates/NOVA/themes/base/images/video/preview.svg)
                   {if !empty($previewImageUrl)},url({$previewImageUrl});{/if}">
            {if $provider === 'youtube'}
                {lang key='allowConsentYouTube'}
            {else}
                {lang key='allowConsentVimeo'}
            {/if}
        </a>
    {elseif $video->getType() === \JTL\Media\Video::TYPE_FILE}
        <video class="product-detail-video mw-100" controls
               {if !empty($video->getWidth())}width="{$video->getWidth()}"{/if}
               {if !empty($video->getHeight())}height="{$video->getHeight()}"{/if}
               {if !$video->isAllowFullscreen()}controlslist="nofullscreen"{/if}>
            <source src="{$video->getEmbedUrl()}"
                    type="video/{$video->getFileFormat()}">
            {lang key='videoTagNotSupported' section='errorMessages'}
        </video>
    {/if}
</div>
</div>