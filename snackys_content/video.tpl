{block name="snackys_content_video"}
    {block name="video_preview_image"}
        {$previewImageUrl = $entry->cPreview}
        {if $entry->nZone|strstr:'gallery_' && empty($previewImageUrl)}
            {assign var="previewImageSplit" value="_"|explode:$entry->nZone}    
            {math assign="previewImageCount" equation="x-1" x=$previewImageSplit[1]}
            {$image = $Artikel->Bilder[$previewImageCount]}
            {$previewImageUrl = $image->cURLNormal}
        {/if}
    {/block}
    {block name="video_content"}
        <div class="snackys-content {$entry->cClass|default:''}{if $entry->nZone|strstr:'gallery_'} gal-video{/if}">
            {if $entry->videoProvider == 'html'}
                {block name="video_content_html"}
                    <div class="embed-responsive embed-responsive-16by9">
                        <video controls preload="metadata" {if !empty($previewImageUrl)}poster="{$previewImageUrl}"{/if}>
                            <source src="{$entry->cVideo}" type="video/mp4" />
                        </video>
                    </div>
                {/block}
            {else}
                {block name="video_content_youtube"}
                    {assign var="youtubeId" value=$entry->cEmbed}
                    {if $youtubeId|strstr:'?v='}
                        {assign var="youtubeIdSplit" value="?v="|explode:$youtubeId}
                        {assign var="youtubeId" value=$youtubeIdSplit[1]}
                    {/if}
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe data-src="https://www.youtube-nocookie.com/embed/{$youtubeId}?rel=0"
                                class="needs-consent {$entry->videoProvider}"
                                width="100%"
                                height="auto"
                                allowfullscreen>
                        </iframe>
                        <button class="trigger give-consent give-consent-preview"
                            data-consent="{$entry->videoProvider}"
                            type="button"
                            style="background-image:
                                    url({$ShopURL}/templates/NOVA/themes/base/images/video/preview.svg)
                                    {if !empty($previewImageUrl)},url({$previewImageUrl}){/if}; 
                                    background-size: cover;
                                    background-position: center;">
                                {lang key='allowConsentYouTube'}
                        </button>
                    </div>
                {/block}
            {/if}
        </div>
    {/block}
    {block name="video_gallery_script"}
        {if $entry->nZone|strstr:'gallery_'}
            {inline_script}
                {literal}
                    <script>
                        $(function () {
                            var $gallery = $('#gallery');
                            var $videoAnchors = $gallery.find('a').filter(function () {
                                return $(this).find('.gal-video').length > 0;
                            });            
                            $videoAnchors.each(function () {
                                var $a = $(this);
                                $a.addClass('has-video');
                                $a.find('img.zoomImg').remove();
                            });            
                            const observer = new MutationObserver(function (mutations) {
                                mutations.forEach(function (m) {
                                    $(m.addedNodes).each(function () {
                                    var $node = $(this);
                                    if ($node.is('img.zoomImg')) {
                                        // Only remove if it was injected into a video anchor
                                        var $parentA = $node.closest('a');
                                        if ($parentA.length && $parentA.find('.gal-video').length) {
                                        $node.remove();
                                        }
                                    }
                                    });
                                });
                            });
                            observer.observe($gallery.get(0), { childList: true, subtree: true });
                        });
                    </script>
                {/literal}
            {/inline_script}
        {/if}
    {/block}
{/block}