(function () {
    'use strict';

    if (!$.evo) {
        $.evo = {};
    }

    var EvoClass = function() {};

    EvoClass.prototype = {
        options: {},

        constructor: EvoClass,

        panelOpener: function() {
            var e,t, x = document.getElementById("sp-l"),
                a = this;
			if(x)
			{
				t = x.getElementsByClassName("panel-heading");
				for (e = 0; e < t.length; e++) t[e].onclick = function() {
					this.parentNode.classList.contains("open") ? a.closePanels() : (a.closePanels(), this.parentNode.classList.add("open"))
				};
			}
        },
        closePanels: function() {
            for (var e = document.getElementById("sp-l").getElementsByClassName("panel-heading"), t = 0; t < e.length; t++) e[t].parentNode.classList.remove("open")
        },
        generateSlickSlider: function() {
			if($('.evo-slider:not(.slick-initialized)').length)
			{
				/*
				 * box product slider
				 */
				/*
				$('.evo-box-slider:not(.slick-initialized)').slick({
					//dots: true,
					arrows: true,
					lazyLoad: 'ondemand',
					slidesToShow: 1
				});
				*/
				/*
				$('.evo-box-vertical:not(.slick-initialized)').slick({
					//dots: true,
					arrows:          true,
					vertical:        true,
					adaptiveHeight:  true,
					verticalSwiping: true,
					prevArrow:       '<button class="slick-up" aria-label="Previous" type="button"></button>',
					nextArrow:       '<button class="slick-down" aria-label="Next" type="button"></button>',
					lazyLoad:        'progressive',
					slidesToShow:    1,
				}).on('afterChange', function () {
					var heights = [];
					$('.evo-box-vertical:not(.eq-height) .product-wrapper').each(function (i, element) {
						var $element       = $(element);
						var elementHeight;
						// Should we include the elements padding in it's height?
						var includePadding = ($element.css('box-sizing') === 'border-box') || ($element.css('-moz-box-sizing') === 'border-box');
						if (includePadding) {
							elementHeight = $element.innerHeight();
						} else {
							elementHeight = $element.height();
						}
						heights.push(elementHeight);
					});
					$('.evo-box-vertical.evo-box-vertical:not(.eq-height) .product-wrapper').css('height', Math.max.apply(window, heights) + 'px');
					$('.evo-box-vertical.evo-box-vertical:not(.eq-height)').addClass('eq-height');
				});
				*/
				/*
				 * responsive slider (content)
				 */
				let sliders = $('.evo-slider:not(.slick-initialized)').slick({
					//dots: true,
					arrows: true,
					lazyLoad: 'ondemand',
					slidesToShow: 3,
					responsive: [
						{
							breakpoint: 480, // xs
							settings: {
								slidesToShow: 1
							}
						},
						{
							breakpoint: 768, // sm
							settings: {
								slidesToShow: 2
							}
						},
						{
							breakpoint: 992, // md
							settings: {
								slidesToShow: 3
							}
						}
					]
				});

				sliders.each(function(i, slider){
					let $slider = $(slider);
					let accordianHead = $slider.closest('.opc-Accordion-group').find('.opc-Accordion-head');
					accordianHead.on('mousedown', function(){
						$slider.find('.slick-slide').height('auto');
						$slider.find('.slick-list').height('auto');
						$slider.slick('setOption', '', '', true);
						$slider.slick('slickGoTo', 1);
					})
				})
			}
        },


        initPriceSlider: function ($wrapper, redirect) {
            var priceRange      = $wrapper.find('[data-id="js-price-range"]').val(),
                priceRangeID    = $wrapper.find('[data-id="js-price-range-id"]').val(),
                priceRangeMin   = 0,
                priceRangeMax   = $wrapper.find('[data-id="js-price-range-max"]').val(),
                currentPriceMin = priceRangeMin,
                currentPriceMax = priceRangeMax,
                $priceRangeFrom = $("#" + priceRangeID + "-from"),
                $priceRangeTo = $("#" + priceRangeID + "-to"),
                $priceSlider = document.getElementById(priceRangeID);

            if (priceRange) {
                var priceRangeMinMax = priceRange.split('_');
                currentPriceMin = priceRangeMinMax[0];
                currentPriceMax = priceRangeMinMax[1];
                $priceRangeFrom.val(currentPriceMin);
                $priceRangeTo.val(currentPriceMax);
            }
            noUiSlider.create($priceSlider, {
                start: [parseInt(currentPriceMin), parseInt(currentPriceMax)],
                connect: true,
                range: {
                    'min': parseInt(priceRangeMin),
                    'max': parseInt(priceRangeMax)
                },
                step: 1,
                format: {
                    to: function (value) {
                        return parseInt(value);
                    },
                    from: function (value) {
                        return parseInt(value);
                    }
                }
            });
            $priceSlider.noUiSlider.on('change', function (values, handle) {
                setTimeout(function(){
                    $.evo.redirectToNewPriceRange(values[0] + '_' + values[1], redirect, $wrapper);
                },0);
            });
            $priceSlider.noUiSlider.on('update', function (values, handle) {
                $priceRangeFrom.val(values[0]);
                $priceRangeTo.val(values[1]);
            });
            $('.price-range-input').on('change', function () {
                var prFrom = parseInt($priceRangeFrom.val()),
                    prTo = parseInt($priceRangeTo.val());
                $.evo.redirectToNewPriceRange(
                    (prFrom > 0 ? prFrom : priceRangeMin) + '_' + (prTo > 0 ? prTo : priceRangeMax),
                    redirect,
                    $wrapper
                );
            });
        },

        initFilters: function (href) {
            var $wrapper = $('.js-collapse-filter'),
                self=this;
            $.evo.extended().startSpinner($wrapper);

            $.ajax(href, {data: {'useMobileFilters':1}})
                .done(function(data) {
                    $wrapper.html(data);
                    self.initPriceSlider($wrapper, false);
                })
                .always(function() {
                    $.evo.extended().stopSpinner();
                });
        },

        initFilterEvents: function() {
            var initiallized = false;
            $('#js-filters').on('click', function() {
                if (!initiallized) {
                    $.evo.initFilters(window.location.href);
                    initiallized = true;
                }
            });
        },

        redirectToNewPriceRange: function (priceRange, redirect, $wrapper) {
            var currentURL  = window.location.href;
            if (!redirect) {
                currentURL  = $wrapper.find('[data-id="js-price-range-url"]').val();
            }
            var redirectURL = $.evo.updateURLParameter(
                currentURL,
                'pf',
                priceRange
            );
            if (redirect) {
                window.location.href = redirectURL;
            } else {
                $.evo.initFilters(redirectURL);
            }
        },

        updateURLParameter: function (url, param, paramVal) {
            var newAdditionalURL = '',
                tempArray        = url.split('?'),
                baseURL          = tempArray[0],
                additionalURL    = tempArray[1],
                temp             = '';
            if (additionalURL) {
                tempArray = additionalURL.split('&');
                for (var i=0; i<tempArray.length; i++){
                    if(tempArray[i].split('=')[0] != param){
                        newAdditionalURL += temp + tempArray[i];
                        temp = '&';
                    }
                }
            }

            return baseURL + '?' + newAdditionalURL + temp + param + '=' + paramVal;
        },


        addSliderTouchSupport: function () {
            $('.carousel').each(function () {
                if ($(this).find('.item').length > 1) {
                    $(this).find('.carousel-control').css('display', 'block');
                    $(this).swiperight(function () {
                        $(this).carousel('prev');
                    }).swipeleft(function () {
                        $(this).carousel('next');
                    });
                } else {
                    $(this).find('.carousel-control').css('display', 'none');
                }
            });
        },

        scrollStuff: function() {
            var breakpoint = 0,
                pos,
                sidePanel = $('#sp-l');

            if(sidePanel.length) {
                breakpoint = sidePanel.position().top + sidePanel.hiddenDimension('height');
            }

            pos = breakpoint - $(this).scrollTop();

            if ($(this).scrollTop() > 200 && !$('#to-top').hasClass('active')) {
                $('#to-top').addClass('active');
            } else if($(this).scrollTop() < 200 && $('#to-top').hasClass('active')) {
                $('#to-top').removeClass('active');
            }

            if ($(window).width() > 768) {
                var $document = $(document),
                    $element = $('.navbar-fixed-top'),
                    className = 'nav-closed';

                $document.scroll(function() {
                    $element.toggleClass(className, $document.scrollTop() >= 150);
                });

            }
        },

        productTabsPriceFlow: function() {
            $('a[href="#tab-priceFlow"]').on('shown.bs.tab', function () {
                if (typeof window.priceHistoryChart !== 'undefined' && window.priceHistoryChart === null) {
                    window.priceHistoryChart = new Chart(window.ctx).Bar(window.chartData, {
                        responsive:      true,
                        scaleBeginAtZero: false,
                        tooltipTemplate: "<%if (label){%><%=label%> - <%}%><%= parseFloat(value).toFixed(2).replace('.', ',') %> " + window.chartDataCurrency
                    });
                }
            });
        },

        autoheight: function() {
			/*
            $('.row-eq-height').each(function(i, e) {
                $(e).children('[class*="col-"]').children().responsiveEqualHeightGrid();
            });
            $('.row-eq-height.gallery > [class*="col-"], #product-list .product-wrapper').each(function(i, e) {
                $(e).height($('div', $(e)).outerHeight()).addClass('setHeight');
            });
			*/
        },
        
        tooltips: function() {
            //$('[data-toggle="tooltip"]').tooltip();
        },

        imagebox: function(wrapper) {
			/*
				deprecated grap
				
				
            var $wrapper = (typeof wrapper === 'undefined' || wrapper.length === 0)
                    ? $('#result-wrapper, .opc-ProductStream-gallery, .opc-ProductStream-list')
                    : $(wrapper),
                square   = $('.image-box', $wrapper).first().height() + 'px',
                padding  = $(window).height() / 2;

            $('.image-box', $wrapper).each(function(i, item) {
                var box = $(this),
                    img = box.find('img'),
                    src = img.data('src');

                img.css('max-height', square);
                box.css('max-height', square);

                if (src && src.length > 0) {
                    //if (src === 'gfx/keinBild.gif') {
                    //    box.removeClass('loading')
                    //        .addClass('none');
                    //    box.parent().find('.overlay-img').remove();
                    //} else {
                        $(img).lazy(padding, function() {
                            $(this).on('load',function() {
                                img.css('max-height', square);
                                box.css('line-height', square)
                                    .css('max-height', square)
                                    .removeClass('loading')
                                    .addClass('loaded');
                            }).on('error',function() {
                                box.removeClass('loading')
                                    .addClass('error');
                            });
                        });
                    //}
                }
            });
			*/
        },

        bootlint: function() {
            (function(){
                var p = window.alert;
                var s = document.createElement("script");
                window.alert = function() {
                    console.info(arguments);
                };
                s.onload = function() {
                    bootlint.showLintReportForCurrentDocument([]);
                    window.alert = p;
                };
                s.src = "https://maxcdn.bootstrapcdn.com/bootlint/latest/bootlint.min.js";
                document.body.appendChild(s);
            })();
        },
        
        showNotify: function(options) {
            eModal.alert({
                size: 'lg',
                buttons: false,
                title: options.title,
                message: options.text,
                keyboard: true,
                tabindex: -1,
                //onShown: function() {
                //    $.evo.generateSlickSlider();
                //}
            });
        },
        

        renderCaptcha: function(parameters) {
            this.trigger('captcha.render', parameters);
        },
        
        popupDep: function() {
            var that  = this;
            $('#main-wrapper').on('click', '.popup-dep', function(e) {
                var id    = '#popup' + $(this).attr('id'),
                    title = $(this).attr('title'),
                    html  = $(id).html();
                eModal.alert({
                    message: html,
                    title: title,
                    keyboard: true,
                    tabindex: -1,
                    onShown:function () {
                        that.trigger('captcha.render.popup', {popup: $(this)});
                        addValidationListener();
                    }
                });
                return false;
            });
        },

        popover: function() {
            /*
             * <a data-toggle="popover" data-ref="#popover-content123">Click me</a>
             * <div id="popover-content123" class="popover">content here</div>
             */
            /*$('[data-toggle="popover"]').popover({
                html: true,
				sanitize: false,
                content: function() {
                    var ref = $(this).attr('data-ref');
                    return $(ref).html();
                }
            });*/
        },

        smoothScrollToAnchor: function(href, pushToHistory) {
            var anchorRegex = /^#[\w\-]+$/;
            if (!anchorRegex.test(href)) {
                return false;
            }

            var target, targetOffset;
            target = $('#' + href.slice(1));

            if (target.length > 0) {
                // scroll below the static megamenu
                var nav         = $('#cat-w');
                var fixedOffset = nav.length > 0 ? nav.outerHeight() : 0;

                targetOffset = target.offset().top - fixedOffset - parseInt(target.css('margin-top'));
                $('html, body').animate({scrollTop: targetOffset});

                if (pushToHistory) {
                    history.pushState({}, document.title, location.pathname + href);
                }

                return true;
            }

            return false;
        },

        smoothScroll: function() {
            var supportHistory = (history && history.pushState) ? true : false;
            var that = this;

            this.smoothScrollToAnchor(location.hash, false);
            $(document).on('click','a[href^="#"]', function(e) {
                var elem = e.target;
                if (!e.isDefaultPrevented()) {
                    // only runs if no other click event is fired
                    if (that.smoothScrollToAnchor(elem.getAttribute('href'), supportHistory)) {
                        e.preventDefault();
                    }
                }
            });
        },

        preventDropdownToggle: function() {
            $('a.dropdown-toggle').on('click',function(e){
                var elem = e.target;
                if (elem.getAttribute('aria-expanded') == 'true' && elem.getAttribute('href') != '#') {
					var viewport = $('body').data('viewport');

					if (viewport!=='xs' && viewport!=='sm' && elem.getAttribute('aria-expanded') == 'true' && elem.getAttribute('href') != '#') {
						window.location.href = elem.getAttribute('href');
						e.preventDefault();
					}
                }
            });
        },

        checkout: function() {
            // show only the first submit button (i.g. the button from payment plugin)
            var $submits = $('#checkout-shipping-payment')
                .closest('form')
                .find('input[type="submit"]');
            $submits.addClass('hidden');
            $submits.first().removeClass('hidden');

            $('input[name="Versandart"]', '#checkout-shipping-payment').on('change',function() {
                var shipmentid = parseInt($(this).val());
                var paymentid  = $("input[id^='payment']:checked ").val();
                var $form = $(this).closest('form');

                if (isNaN(shipmentid)) {
                    return;
                }

                $form.find('fieldset, input[type="submit"]')
                    .attr('disabled', true);
                var url = 'bestellvorgang.php?kVersandart=' + shipmentid + '&kZahlungsart=' + paymentid;
                $.evo.loadContent(url, function() {
                    $.evo.checkout();
                }, null, true);
            });

            $('#country').on('change', function (e) {
                var val = $(this).find(':selected').val();

                $.evo.io().call('checkDeliveryCountry', [val], {}, function (error, data) {
                    var $shippingSwitch = $('#checkout_register_shipping_address');

                    if (data.response) {
                        $shippingSwitch.removeAttr('disabled');
                        $shippingSwitch.parent().removeClass('hidden');
                    } else {
                        $shippingSwitch.attr('disabled', true);
                        $shippingSwitch.parent().addClass('hidden');
                        if ($shippingSwitch.prop('checked')) {
                            $shippingSwitch.prop('checked', false);
                            $('#select_shipping_address').collapse('show');
                        }
                    }
                });
            });
        },
		
        setCompareListHeight: function() {
            var h = parseInt($('.comparelist .equal-height').outerHeight());
            $('.comparelist .equal-height').outerHeight(h);
        },
		
        loadContent: function(url, callback, error, animation, wrapper) {
            var that        = this;
            var $wrapper    = (typeof wrapper === 'undefined' || wrapper.length === 0) ? $('#result-wrapper') : $(wrapper);
            var ajaxOptions = {data: 'isAjax'};
            if (animation) {
                $wrapper.addClass('loading');
            }

            that.trigger('load.evo.content', { url: url });

            $.ajax(url, ajaxOptions).done(function(html) {
                var $data = $(html);
                if (animation) {
                    $data.addClass('loading');
                }
				if($data.find('#checkout-cart-ajaxversand').length > 0)
				{
					var $sidebasket = $data.find('#checkout-cart-ajaxversand').html();
					$('#checkout-cart').html($sidebasket);
					$data.find('#checkout-cart-ajaxversand').html('');
				}
                $wrapper.replaceWith($data);
                $wrapper = $data;
                if (typeof callback === 'function') {
                    callback();
                }
				//if(sImages) sImages.rewatch();
            })
            .fail(function() {
                if (typeof error === 'function') {
                    error();
                }
            })
            .always(function() {
                $wrapper.removeClass('loading');
                that.trigger('contentLoaded'); // compatibility
                that.trigger('loaded.evo.content', { url: url });
            });
        },
        
        spinner: function(target) {
            var opts = {
              lines: 12             // The number of lines to draw
            , length: 7             // The length of each line
            , width: 5              // The line thickness
            , radius: 10            // The radius of the inner circle
            , scale: 2.0            // Scales overall size of the spinner
            , corners: 1            // Roundness (0..1)
            , color: '#000'         // #rgb or #rrggbb
            , opacity: 1/4          // Opacity of the lines
            , rotate: 0             // Rotation offset
            , direction: 1          // 1: clockwise, -1: counterclockwise
            , speed: 1              // Rounds per second
            , trail: 100            // Afterglow percentage
            , fps: 20               // Frames per second when using setTimeout()
            , zIndex: 2e9           // Use a high z-index by default
            , className: 'spinner'  // CSS class to assign to the element
            , top: '50%'            // center vertically
            , left: '50%'           // center horizontally
            , shadow: false         // Whether to render a shadow
            , hwaccel: false        // Whether to use hardware acceleration (might be buggy)
            , position: 'absolute'  // Element positioning
            };

            if (typeof target === 'undefined') {
                target = document.getElementsByClassName('product-offer')[0];
            }
            if ((typeof target !== 'undefined' && target.id === 'result-wrapper') || $(target).hasClass('product-offer')) {
                opts.position = 'fixed';
            }

            return new Spinner(opts).spin(target);
        },

        trigger: function(event, args) {
            $(document).trigger('evo:' + event, args);
            return this;
        },

        error: function() {
            if (console && console.error) {
                console.error(arguments);
            }
        },
		
		slider: function() {
			$('.sl-ar').unbind();
			$('.sl-nx').on('click',function(){$.evo.slideNext(this);});
			$('.sl-pr').on('click',function(){$.evo.slidePrev(this);});
			$('.no-scrollbar[data-autoplay]').each(function(){
				var that = this;
				setInterval(function(){$.evo.autoSlide(that);},$(this).attr('data-autoplay'));
			});
		},
		slideNext: function(btn) {
			$(btn).closest('.panel-slider').find('.no-scrollbar').animate({
				scrollLeft: ($(btn).closest('.panel-slider').find('.no-scrollbar').scrollLeft()+$(btn).closest('.panel-slider').find('.no-scrollbar').width())
			},300,'swing',function(){$.evo.sliderButtonsAdjust(btn)});
		},
		slidePrev: function(btn) {
			$(btn).closest('.panel-slider').find('.no-scrollbar').animate({
				scrollLeft: ($(btn).closest('.panel-slider').find('.no-scrollbar').scrollLeft()-$(btn).closest('.panel-slider').find('.no-scrollbar').width())
			},300,'swing',function(){$.evo.sliderButtonsAdjust(btn)});
		},
		sliderButtonsAdjust: function(btn){
			$(btn).closest('.panel-slider').find('.sl-ar').removeClass('inactive');
			if($(btn).closest('.panel-slider').find('.no-scrollbar').scrollLeft() <= 1)
				$(btn).closest('.panel-slider').find('.sl-pr').addClass('inactive');
			if($(btn).closest('.panel-slider').find('.no-scrollbar').scrollLeft() >= $(btn).closest('.panel-slider').find('.no-scrollbar')[0].scrollWidth-$(btn).closest('.panel-slider').find('.no-scrollbar').width())
				$(btn).closest('.panel-slider').find('.sl-nx').addClass('inactive');
			
		},
		autoSlide: function(elem)
		{
			if($(elem).is(':hover')) return ;
			if($(elem).closest('.panel-slider').find('.no-scrollbar').scrollLeft() >= $(elem).closest('.panel-slider').find('.no-scrollbar')[0].scrollWidth-$(elem).closest('.panel-slider').find('.no-scrollbar').width())
				$(elem).closest('.panel-slider').find('.no-scrollbar').animate({
					scrollLeft: 0
				},300,'swing',function(){$.evo.sliderButtonsAdjust(elem)});
			else
				$.evo.slideNext(elem);
		},
		
		mobileMenu: function()
		{
			$('#cat-w .fa-caret-down').unbind();
			$('#cat-w .fa-caret-down').click(function(e){
				e.preventDefault();
				if($(this).closest('li').hasClass('open'))
				{
					//$('#cat-w li').removeClass('open');
					$(this).closest('li').removeClass('open');
					//$('#cat-w ul').removeClass('noov');
					$(this).closest('ul').removeClass('noov');
				} else {
					//$('#cat-w li').removeClass('open');
					$(this).closest('li').addClass('open');
					//$('#cat-w ul').reClass('noov');
					$(this).closest('ul').addClass('noov');
				}
			});
		},

        /**
         * $.evo.extended() is deprecated, please use $.evo instead
         */
        extended: function() {
            return $.evo;
        },

        register: function() {
            this.addSliderTouchSupport();
            this.productTabsPriceFlow();
            this.generateSlickSlider();
            //$('.nav-pills, .nav-tabs').tabdrop();
            //this.autoheight();
            //this.tooltips();
            this.imagebox();
            this.renderCaptcha();
            this.popupDep();
            //this.popover();
            this.preventDropdownToggle();
            this.smoothScroll();
            this.checkout();
			this.setCompareListHeight();
			this.slider();
			this.mobileMenu();
			this.panelOpener();
        }
    };

	$(window).on('load', function () {
		$.evo.register();
	});

	/*
    $(window).on('resize', function () {
        $.evo.autoheight();
    });
	*/

    // PLUGIN DEFINITION
    // =================
    $.evo = new EvoClass();
	$.snacky = $.evo;
})(jQuery);