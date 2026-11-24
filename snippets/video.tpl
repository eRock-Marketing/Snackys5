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
        {$captions = $video->getCaptionsURL()}
        {$transcript = $video->getTranscript()}
        <video class="product-detail-video mw-100" preload="metadata"
               {if $video->isShowControls()}controls{/if}
               {if $video->isLoop()}loop{/if}
               {if $video->isAutoplay()}autoplay{/if}
               {if $video->isMuted()}muted{/if}
               {if !empty($video->getWidth())}width="{$video->getWidth()}"{/if}
               {if !empty($video->getHeight())}height="{$video->getHeight()}"{/if}
               {if !$video->isAllowFullscreen()}controlslist="nofullscreen"{/if}>
            <source src="{$video->getEmbedUrl()}#t=0.001"
                    {if !empty($video->getFileFormat())}type="video/{$video->getFileFormat()}"{/if}>
            {if $captions !== ''}
                <track default kind="captions"
                       srclang="{$video->getLocale()}"
                       src="{$captions}"
                       label="{$video->getLanguageName()}" />
            {/if}
            {lang key='videoTagNotSupported' section='errorMessages' printf=$video->getEmbedUrl()}
        </video>
    {/if}
</div>
{if $video->getType() === \JTL\Media\Video::TYPE_FILE}
    {if !$isPreview && !$video->isShowControls()}
        <button tabindex="0" class="btn btn-secondary btn-sm opc-video-pause btn-pause" onclick="togglePausePlayVideo()" title="{lang key='pause' section='aria'}">
            <i class="fas fa-pause"></i>
        </button>
        {inline_script}<script>
            function togglePausePlayVideo()
            {
                let button = $(event.currentTarget);
                let fa = button.find('i');
                let video  = button.parent('.opc-Video').find('video');

                if (fa.hasClass('fa-pause')) {
                    video[0].pause();
                    fa.removeClass('fa-pause').addClass('fa-play');
                } else {
                    video[0].play();
                    fa.addClass('fa-pause').removeClass('fa-play');
                }
            }
        </script>{/inline_script}
    {/if}
    {if $transcript !== '' && $video->showTranscriptInPopup()}
        <a href="#"
           class="btn btn-link"
           target="TranscriptWindow"
           tabindex="0"
           data-video-transcript="{$transcript|escape:'html'}">
            {lang key='showVideoTranscriptPopup' section='media'}
        </a>
    {/if}
    {$transcript = $video->getTranscript()}
    {if $transcript !== '' && $video->showTranscriptInPopup() === false}
        <div class="card video-transcript">
            <div class="card-header">
                <button class="btn btn-link w-100"
                        type="button"
                        data-toggle="collapse"
                        aria-expanded="false">
                    {lang key='showVideoTranscript' section='media'}
                </button>
            </div>
            <div class="card-body collapse">
                {$transcript}
            </div>
        </div>
    {/if}
{/if}
