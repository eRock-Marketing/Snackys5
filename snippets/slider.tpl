{block name='snippets-slider'}
    {$sliderID             = $sliderID|default:'slider'}
    {$sliderTheme          = $sliderTheme|default:'default'}
    {$sliderSlides         = $sliderSlides|default:[]}
    {$sliderHasThumbs      = $sliderHasThumbs|default:false}
    {$sliderPauseTime      = $sliderPauseTime|default:6000}
    {$sliderAnimationSpeed = $sliderAnimationSpeed|default:1500}
    {$sliderPauseOnHover   = $sliderPauseOnHover|default:false}
    {$sliderDirectionNav   = $sliderDirectionNav|default:false}
    {$sliderControlNav     = $sliderControlNav|default:false}
    {$sliderRandomStart    = $sliderRandomStart|default:false}
    {$sliderCropImages     = $sliderCropImages|default:false}
    {$sliderEffect         = $sliderEffect|default:'slide'}
    {$sliderAutoplay       = $sliderAutoplay|default:true}
    {$sliderUseContainer   = $sliderUseContainer|default:false}
    {$sliderContainerFluid = $sliderContainerFluid|default:false}
    {$sliderMountBefore    = $sliderMountBefore|default:false}

    {if $sliderSlides|count > 0}
        {capture assign='sliderMarkup'}
            <div class="slider-wrapper theme-{$sliderTheme}">
                <div id="slider-{$sliderID}" class="splide" role="group" aria-label="Slider">
                    <div class="splide__track">
                        <ul class="splide__list">
                            {block name='snippets-slider-slides'}
                                {foreach $sliderSlides as $slide}
                                    <li class="splide__slide{if $sliderCropImages} splide__responsive{/if}">
                                        {if !empty($slide.link)}
                                            <a href="{$slide.link}"{if !empty($slide.text)} title="{$slide.text|strip_tags}"{/if}>
                                        {/if}
                                        {block name='snippets-slider-slide-image'}
                                            {image
                                                alt=$slide.alt|escape:'html'
                                                sizes=$slide.srcsizes
                                                data=['splide-lazy' => $slide.src, 'splide-lazy-srcset' => $slide.srcset, 'splide-lazy-sizes' => $slide.srcsizes]}
                                        {/block}
                                        {if !empty($slide.link)}
                                            </a>
                                        {/if}
                                        {if !empty($slide.title) || !empty($slide.text)}
                                            <div class="splide__slide__caption">
                                                {if !empty($slide.title)}
                                                    {block name='snippets-slider-slide-caption-title'}
                                                        <strong class="title">{$slide.title|escape:'html'}</strong>
                                                    {/block}
                                                {/if}
                                                {if !empty($slide.text)}
                                                    {block name='snippets-slider-slide-caption-desc'}
                                                        <p class="desc">{$slide.text|escape:'html'}</p>
                                                    {/block}
                                                {/if}
                                            </div>
                                        {/if}
                                    </li>
                                {/foreach}
                            {/block}
                        </ul>
                    </div>
                </div>

                {if $sliderHasThumbs}
                    <div id="slider-{$sliderID}-thumbs" class="splide splide--thumbs" aria-label="Thumbnail Slider">
                        <div class="splide__track">
                            <ul class="splide__list">
                                {foreach $sliderSlides as $slide}
                                    <li class="splide__slide">
                                        {image
                                            alt=$slide.alt|escape:'html'
                                            src=$slide.thumbSrc
                                        }
                                    </li>
                                {/foreach}
                            </ul>
                        </div>
                    </div>
                {/if}
            </div>
        {/capture}

        {if $sliderUseContainer}
            {container fluid=$sliderContainerFluid class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                {if $sliderMountBefore}
                    {opcMountPoint id='opc_before_slider'}
                {/if}
                {$sliderMarkup}
            {/container}
        {else}
            {$sliderMarkup}
        {/if}

        {block name='snippets-slider-script'}
            {inline_script}<script>
                $(function () {
                    var slider = $('#slider-{$sliderID}');
                    var thumbsSlider = $('#slider-{$sliderID}-thumbs');

                    slider.find('a').on('click', function () {
                        if (!this.href.match(new RegExp('^' + location.protocol + '\\/\\/' + location.host))) {
                            this.target = '_blank';
                        }
                    });

                    var splide = new Splide('#slider-{$sliderID}', {
                        type: '{$sliderEffect}',
                        rewind: true,
                        autoplay: {if $sliderAutoplay}true{else}false{/if},
                        interval: {$sliderPauseTime},
                        speed: {$sliderAnimationSpeed},
                        pauseOnHover: {if $sliderPauseOnHover}true{else}false{/if},
                        pauseOnFocus: false,
                        arrows: {if $sliderDirectionNav}true{else}false{/if},
                        pagination: {if $sliderControlNav}true{else}false{/if},
                        lazyLoad: 'nearby',
                        preloadPages: 1,
                        updateOnMove: true{if $sliderCropImages},
                        heightRatio: 0.5{/if}{if $sliderRandomStart},
                        start: Math.floor(Math.random() * {$sliderSlides|count}){/if}
                    });

                    var thumbs = null;

                    {if $sliderHasThumbs}
                    if (thumbsSlider.length) {
                        thumbs = new Splide('#slider-{$sliderID}-thumbs', {
                            isNavigation: true,
                            pagination: false,
                            arrows: true,
                            gap: '0.5rem',
                            fixedWidth: 100,
                            fixedHeight: 60,
                            focus: 'center',
                            breakpoints: {
                                576: {
                                    fixedWidth: 70,
                                    fixedHeight: 40
                                }
                            }
                        });

                        splide.sync(thumbs);
                    }
                    {/if}

                    splide.on('mounted', function() {
                        slider.addClass('loaded');

                        var pauseButton = $('<button tabindex="0" class="btn btn-secondary btn-sm slider-pause-btn" title="{lang key='pause' section='aria'}" aria-label="{lang key='pause' section='aria'}"><i class="fas fa-pause"></i></button>');
                        var container   = $('<div></div>')
                            .addClass('slider-pause-controls-inside')
                            .append(pauseButton);
                        slider.append(container);

                        var Autoplay = splide.Components.Autoplay;

                        pauseButton.on('click', function () {
                            var fa = pauseButton.find('i');
                            var isPaused = Autoplay.isPaused();

                            if (isPaused) {
                                Autoplay.play();
                                fa.removeClass('fa-play').addClass('fa-pause');
                                pauseButton.attr('title', '{lang key='pause' section='aria'}')
                                    .attr('aria-label', '{lang key='pause' section='aria'}');
                            } else {
                                Autoplay.pause();
                                fa.removeClass('fa-pause').addClass('fa-play');
                                pauseButton.attr('title', '{lang key='play' section='aria'}')
                                    .attr('aria-label', '{lang key='play' section='aria'}');
                            }
                        });

                        splide.on('autoplay:play', function() {
                            pauseButton.find('i').removeClass('fa-play').addClass('fa-pause');
                            pauseButton.attr('title', '{lang key='pause' section='aria'}')
                                .attr('aria-label', '{lang key='pause' section='aria'}');
                        });

                        splide.on('autoplay:pause', function() {
                            pauseButton.find('i').removeClass('fa-pause').addClass('fa-play');
                            pauseButton.attr('title', '{lang key='play' section='aria'}')
                                .attr('aria-label', '{lang key='play' section='aria'}');
                        });
                    });

                    splide.mount();
                    if (thumbs) {
                        thumbs.mount();
                    }
                });
            </script>{/inline_script}
        {/block}
    {/if}
{/block}
