'use strict';

(function ( $ ) {

    $.fn.swipeleft = function(callback) {
        var startX,
            callbackFired;
        this[0].addEventListener('touchstart', function (e) {
            startX = e.changedTouches[0].pageX;
            callbackFired = 0;
        });
        this[0].addEventListener('touchmove', function (e) {
            var mainNode = $(this);
            if (!mainNode.hasClass('slick-initialized')
                && startX - e.changedTouches[0].pageX > 80
            ) {
                if (typeof callback === 'function') {
                    if (callbackFired < 1) {
                        callback();
                        callbackFired++;
                    }
                }
            }
        });

        return this;
    };

    $.fn.swiperight = function(callback) {
        var startX,
            callbackFired;

        this[0].addEventListener('touchstart', function (e) {
            startX = e.changedTouches[0].pageX;
            callbackFired = 0;
        });

        this[0].addEventListener('touchmove', function (e) {
            var mainNode = $(this);
            if (!mainNode.hasClass('slick-initialized')
                && e.changedTouches[0].pageX - startX  > 80
            ) {
                if (typeof callback === 'function') {
                    if (callbackFired < 1) {
                        callback();
                        callbackFired++;
                    }
                }
            }
        });

        return this;
    };

}( jQuery ));

$('.submit_once').closest('form').on('submit', function() {
    $(this).find('.submit_once').prop('disabled', 'true');
    return true;
});

/*
$('body').on('click', '.option li', function (e) {
    var i = $(this).parents('.select').attr('id'),
        v = $(this).children().text(),
        o = $(this).attr('id');
    $('#' + i + ' .selected').attr('id', o).text(v);
});
*/

function sanitizeOutput(val) {
    return val.replace(/\&/g, '&amp;')
        .replace(/\</g, '&lt;')
        .replace(/\>/g, '&gt;')
        .replace(/\"/g, '&quot;')
        .replace(/\'/g, '&#x27;')
        .replace(/\//g, '&#x2F;');
}

/**
 *  Format file size
 */
function formatSize(size) {
    var fileSize = Math.round(size / 1024),
        suffix = 'KB',
        fileSizeParts;

    if (fileSize > 1000) {
        fileSize = Math.round(fileSize / 1000);
        suffix = 'MB';
    }

    fileSizeParts = fileSize.toString().split('.');
    fileSize = fileSizeParts[0];

    if (fileSizeParts.length > 1) {
        fileSize += '.' + fileSizeParts[1].substr(0, 2);
    }
    fileSize += suffix;

    return fileSize;
}

function getCategoryMenu(categoryId, success) {
	/*
    var xx = {};
    var io = $.evo.io();

    io.call('getCategoryMenu', [categoryId], xx, function (error, data) {
        if (error) {
            console.error(data);
        } else if (typeof success === 'function') {
            success(xx.response);
        }
    });

    return true;
	*/
}

function initWow()
{
	//Only initialize if Lib is loaded
	if(typeof WOW != "undefined")
		new WOW().init();
}

function categoryMenu(rootcategory) {
	/*
    if (typeof rootcategory === 'undefined') {
        rootcategory = $('.sidebar-offcanvas .navbar-categories').html();
    }

    $('.sidebar-offcanvas li a.nav-sub').on('click', function(e) {
        var navbar = $('.sidebar-offcanvas .navbar-categories'),
            ref = $(this).data('ref');

        if (ref === 0) {
            $(navbar).html(rootcategory);
            categoryMenu(rootcategory);
        }
        else {
            getCategoryMenu(ref, function(data) {
                $(navbar).html(data);
                categoryMenu(rootcategory);
            });
        }

        return false;
    });
	*/
}

function compatibility() {
	/*
    var __enforceFocus = $.fn.modal.Constructor.prototype.enforceFocus;
    $.fn.modal.Constructor.prototype.enforceFocus = function () {
        if ($('.modal-body .g-recaptcha').length === 0) {
            __enforceFocus.apply(this, arguments);
        }
    };
	*/
}

function regionsToState() {
    var state = $('#state');
    if (state.length === 0) {
		return ;
    }
	
    var title           = state.attr('title');
    var stateIsRequired = state.attr('required') === 'required';

    $('#country').change(function() {
        var result = {};
        var io     = $.evo.io();
        var val    = $(this).find(':selected').val();

        io.call('getRegionsByCountry', [val], result, function (error, data) {
            if (error) {
                console.error(data);
            } else {
                var data = result.response;
                var def = $('#state').val();
                if (data !== null && data.length > 0) {
                    if (stateIsRequired) {
                        var state = $('<select />').attr({
                            id:           'state',
                            name:         'bundesland',
                            class:        'required form-control',
                            autocomplete: 'billing address-level1',
                            required:     'required'
                        });
                    } else {
                        var state = $('<select />').attr({
                            id:           'state',
                            name:         'bundesland',
                            autocomplete: 'billing address-level1',
                            class:        'form-control'
                        });
                    }

                    state.append('<option value="">' + title + '</option>');
                    $(data).each(function(idx, item) {
                        state.append(
                            $('<option></option>').val(item.cCode).html(item.cName)
                                .attr('selected', item.cCode == def || item.cName == def ? 'selected' : false)
                        );
                    });
                    $('#state').replaceWith(state);
                } else {
                    if (stateIsRequired) {
                            var state = $('<input />').attr({
                            type:         'text',
                            id:           'state',
                            name:         'bundesland',
                            class:        'required form-control',
                            placeholder:  title,
                            autocomplete: 'billing address-level1',
                            required:     'required'
                        });
                    } else {
                        var state = $('<input />').attr({
                            type:         'text',
                            id:           'state',
                            name:         'bundesland',
                            class:        'form-control',
                            placeholder:  title,
                            autocomplete: 'billing address-level1',
                        });
                    }
                    $('#state').replaceWith(state);
                }
            }
        });
		
        return false;

    });

    var state2 = $('#register-shipping_address-state');
    if (state2.length === 0) {

        return;
    }
    var title2           = state2.attr('title');
    var stateIsRequired2 = state2.attr('required') === 'required';

    $('#register-shipping_address-country').change(function () {
        var result = {};
        var io     = $.evo.io();
        var val    = $(this).find(':selected').val();

        io.call('getRegionsByCountry', [val], result, function (error, data) {
            if (error) {
                console.error(data);
            } else {
                var data = result.response;
                var def  = $('#register-shipping_address-state').val();
                if (data !== null && data.length > 0) {
                    if (stateIsRequired2) {
                        var state2 = $('<select />').attr({
                            id:           'register-shipping_address-state',
                            name:         'register[shipping_address][bundesland]',
                            class:        'required form-control',
                            autocomplete: 'shipping address-level1',
                            required:     'required'
                        });
                    } else {
                        var state2 = $('<select />').attr({
                            id:           'register-shipping_address-state',
                            name:         'register[shipping_address][bundesland]',
                            autocomplete: 'shipping address-level1',
                            class:        'form-control'
                        });
                    }
                    state2.append('<option value="">' + title2 + '</option>');
                    $(data).each(function (idx, item) {
                        state2.append(
                            $('<option></option>').val(item.cCode).html(item.cName)
                                .attr('selected', item.cCode == def || item.cName == def ? 'selected' : false)
                        );
                    });
                    $('#register-shipping_address-state').replaceWith(state2);
                } else {
                    if (stateIsRequired2) {
                        var state2 = $('<input />').attr({
                            type:         'text',
                            id:           'register-shipping_address-state',
                            name:         'register[shipping_address][bundesland]',
                            class:        'required form-control',
                            placeholder:  title2,
                            autocomplete: 'shipping address-level1',
                            required:     'required'
                        });
                    } else {
                        var state2 = $('<input />').attr({
                            type:         'text',
                            id:           'register-shipping_address-state',
                            name:         'register[shipping_address][bundesland]',
                            class:        'form-control',
                            autocomplete: 'shipping address-level1',
                            placeholder:  title2
                        });
                    }
                    $('#register-shipping_address-state').replaceWith(state2);
                }
            }
        });

        return false;
    });
}

function loadContent(url)
{
    $.evo.extended().loadContent(url, function() {
        $.evo.extended().register();

        if (typeof $.evo.article === 'function') {
            $.evo.article().onLoad();
            $.evo.article().register();
            addValidationListener();
        }

        //$('html,body').animate({
        //    scrollTop: $('.list-pageinfo').offset().top - $('#evo-main-nav-wrapper').outerHeight() - 10
        //}, 100);
    });
}

function navigation()
{
	/*
    var navWrapper = $('#evo-main-nav-wrapper');
    if (navWrapper.hasClass('do-affix')) {
        navWrapper.parent()
            .height(navWrapper.height());
        navWrapper.affix({
            offset: {
                top: navWrapper.offset().top
            }
        });
    }
	*/
}

function addValidationListener() {
    var forms      = $('form.evo-validate'),
        inputs     = $('form.evo-validate input, form.evo-validate textarea').not('[type="radio"],[type="checkbox"]'),
        selects    = $('form.evo-validate select'),
        checkables = $('form.evo-validate input[type="radio"], form.evo-validate input[type="checkbox"]'),
        $body      = $('body');

    for (var i = 0; i < forms.length; i++) {
        forms[i].addEventListener('invalid', function (event) {
            event.preventDefault();
            $(event.target).closest('.form-group').find('div.form-error-msg').remove();
            $(event.target).closest('.form-group').addClass('has-error').append('<div class="form-error-msg text-danger"><i class="fa fa-warning"></i> ' + sanitizeOutput(event.target.validationMessage) + '</div>');

            if (!$body.data('doScrolling')) {
                var $firstError = $(event.target).closest('.form-group.has-error');
                if ($firstError.length > 0) {
                    $body.data('doScrolling', true);
                    var $nav        = $('#cat-w'),
                        fixedOffset = $nav.length > 0 ? $nav.outerHeight() : 0,
                        vpHeight    = $(window).height(),
                        scrollTop   = $(window).scrollTop();
                    if ($firstError.offset().top > (scrollTop + vpHeight) || $firstError.offset().top < scrollTop) {
                        $('html, body').animate(
                            {
                                scrollTop: $firstError.offset().top - fixedOffset - parseInt($firstError.css('margin-top'))
                            },
                            {
                                done: function () {
                                    $body.data('doScrolling', false);
                                }
                            }, 300
                        );
                    }
                }
            }
        }, true);
    }
	

    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('blur', function (event) {
            checkInputError(event);
        }, true);
    }
    for (var i = 0; i < checkables.length; i++) {
        checkables[i].addEventListener('click', function (event) {
            checkInputError(event);
        }, true);
    }
    for (var i = 0; i < selects.length; i++) {
        selects[i].addEventListener('change', function (event) {
            checkInputError(event);
        }, true);
    }



	
	$('.p-c.thumbnail a').hover(function(){
		var s = $(this).find('.second-img img');
		if(s)
		{
			s.attr('src',s.attr('data-hover'));
			s.removeAttr('data-hover');
		}
	});
	

			
}

function checkInputError(event)
{

	var $target = $(event.target);
    if ($target.parents('.cfg-group') != undefined) {
        $target.parents('.cfg-group').find('div.form-error-msg').remove();
    }
    $target.parents('.form-group').find('div.form-error-msg').remove();

	if ($target.data('must-equal-to') !== undefined) {
		var $equalsTo = $($target.data('must-equal-to'));
		if ($equalsTo.length === 1) {
			var theOther = $equalsTo[0];
			if (theOther.value !== '' && theOther.value !== event.target.value && event.target.value !== '') {
				event.target.setCustomValidity($target.data('custom-message') !== undefined ? $target.data('custom-message') : sanitizeOutput(event.target.validationMessage));
			} else {
				event.target.setCustomValidity('');
			}
		}
	}

	if (event.target.validity.valid) {
		$target.closest('.form-group').removeClass('has-error');
	} else {
        $target.closest('.form-group').addClass('has-error').append('<div class="form-error-msg text-danger"><i class="fa fa-warning"></i> ' + sanitizeOutput(event.target.validationMessage) + '</div>');
	}
}

function lazyLoadMenu(viewport){
	//no need for snackys, it's just implemented for compability
	return;
	/*
    if (viewport !== 'xs' && viewport != 'sm'){
        $('#evo-main-nav-wrapper .dropdown').on('mouseenter mouseleave', function(e) {
            $(this).find('img.lazy').each(function(i, item) {
                var img = $(item);
                $(img).lazy(0, function() {
                    $(this).on('load', function() {
                        img.removeClass('loading')
                            .addClass('loaded');
                    }).on('error', function() {
                        img.removeClass('loading')
                            .addClass('error');
                    });
                });
            });
        });
    }
	*/
}

function isTouchCapable() {
    return 'ontouchstart' in window || (window.DocumentTouch && document instanceof window.DocumentTouch);
}

function removeFromSessionStorage(entryKey) {
    if (0 < sessionStorage.length && sessionStorage.getItem(entryKey)) {
        sessionStorage.removeItem(entryKey);
    }
}

function snackys()
{
	var tElem,i,t,e,tElemList;


	$("a[href='#top']").on('click',function() {
		window.scrollTo({ top: 0, behavior: 'smooth' });
		return false;
	});

	//Sidebar NAV
	if(document.getElementById("ftr-tg"))
	{
		for (document.getElementById("ftr-tg").addEventListener("click", function(e) {
			
				//Checken ob Sidebarnav gefüllt ist, oder noch gefüllt werden muss!
				if($('#sp-l').hasClass('lazy'))
				{
					//Load Sidebar and set listeners!
					var url = window.location.href;
					url += url.includes('?') ? '&sidebar=1' : '?sidebar=1';
					$.evo.extended().loadContent(url, function() {
						mainEventListener();
						if($.snackyList)
							$.snacky.panelOpener();
						for(t = document.querySelectorAll("#sp-l .overlay-bg,#sp-l .close-sidebar"), e = 0; e < t.length; e++) t[e].addEventListener("click", function(e) {
							e.preventDefault(), document.body.classList.remove("show-sidebar")
						});
						//Set Price Range Slider
						if( $('.js-price-range-box').length )
							$.evo.initPriceSlider($('.js-price-range-box'), $('#js-price-redirect').val() != 1);
					},false,false,'#sp-l');
					$('#sp-l').removeClass('lazy');
				}
				e.preventDefault(), document.body.classList.contains("show-sidebar") ? document.body.classList.remove("show-sidebar") : document.body.classList.add("show-sidebar")
			}), t = document.querySelectorAll("#sp-l .overlay-bg,#sp-l .close-sidebar"), e = 0; e < t.length; e++) t[e].addEventListener("click", function(e) {
			e.preventDefault(), document.body.classList.remove("show-sidebar")
		})
		
		if($.snacky)
			$.snacky.panelOpener();
	}
	
	$('#header-promo-close').on('click',function(){
		$.evo.io().call('km_promo',false,function(){});
		$('#header-promo').remove();
	});
	
	//Search Toggle
	$('.sr-tg').on('click',function(e){
		$('body').toggleClass('shw-sr-d');
		window.setTimeout(function ()
		{
			document.querySelector('input[name=qs]').focus();
		}, 150);
		
		e.preventDefault();
	});
	
	//touch/mobile megamenu klick = 1ter klick open sub, 2ter klick = zur URL
	if(($('body').hasClass('mobile') || 'ontouchstart' in window)) {
		if(window.screen.width > 767)
		{
			$('.mgm-fw > a').on('click',function(e) {
				e.preventDefault();
				var link = $(this);
				if(link.hasClass('tapped'))
					window.location = link.attr('href');
				else
				{
					link.addClass('tapped');
					link.parent().mouseleave(function(){link.removeClass('tapped')});
				}
			});
		}
	}
	
	// per burgerbutton moviles menu öffnen 
	tElem = document.getElementById('mobile-nav-toggle');
	if(tElem)
		tElem.addEventListener('click',function(e){
			if(!e) e = window.event;
			e.preventDefault();
			if(document.body.classList.contains('shw-sb'))
				document.body.classList.remove('shw-sb');
			else
				document.body.classList.add('shw-sb');
		});
	
	tElemList = document.querySelectorAll('#cat-w .close-btn');
	if(tElemList)
		for(i=0;i<tElemList.length;i++)
		{
			tElemList[i].addEventListener('click',function(e){
				document.body.classList.remove('shw-sb');
			});
		}
		

	// mobil footer boxen öffnen 
	tElem = document.getElementById('footer');
	if(tElem)
	tElem = tElem.getElementsByClassName('panel-heading');
		if(tElem)
			for(i=0;i<tElem.length;i++)
				tElem[i].addEventListener('click',function(e){
					if(!e) e = window.event;
					e.preventDefault();
					if(e.target.parentNode.parentNode.classList.contains('open-show'))
						e.target.parentNode.parentNode.classList.remove('open-show')
					else
						e.target.parentNode.parentNode.classList.add('open-show')
				});
	

	// wenn n alert button n schließen button hat 
	tElem = document.querySelectorAll('.alert button.close');
	for(i=0;i<tElem.length;i++)
		tElem[i].addEventListener('click',function(e){
		if(!e) e = window.event;
		e.preventDefault();
		e.target.parentNode.classList.add('hidden');
	});
	
	// mobile suche öffnen/schließen 
	tElem = document.getElementById('sr-tg-m');
	if(tElem)
		tElem.addEventListener('click',function(e){
			if(!e) e = window.event;
			e.preventDefault();
			if(document.body.classList.contains('show-search'))
				document.body.classList.remove('show-search');
			else
			{
				document.body.classList.add('show-search');
				window.setTimeout(function ()
				{
					document.querySelector('input[name=qs]').focus();
				}, 150);
			}
		});
	
	//.x Close aus account/index.tpl 
	$('.x').on('click',function(e){e.preventDefault();$(this).closest('.modal-dialog').remove();});
	

	//KLick auf Category Nav Wrapper
	tElem = document.getElementById('cat-w');
	if(tElem)
		tElem.addEventListener('click',function(e){
			if(e.target == document.getElementById('cat-w') || e.target.classList.contains('fullscreen-menu'))
				document.body.classList.remove('shw-sb');
		});
}

function mainEventListener()
{
	//Background from mobile menu
	$(document).click(function(){
		$('#cls-catw').click(function(e) {
			if ($(e.target).is('#cls-catw')) {
				document.body.classList.remove('shw-sb');
			}
		});
	});
	//Modal Background to close Modal
	$(document).click(function(){
		$('.modal-dialog').click(function(e) {
			if ($(e.target).is('.modal-dialog')) {
				$(this).parent().modal('hide');
			}
		});
	});
	$(document).on('evo:contentLoaded', function(){
		$(document).click(function(){
			$('.modal-dialog').click(function(e) {
				if ($(e.target).is('.modal-dialog')) {
					$(this).parent().modal('hide');
				}
			});
		});
	});
	var tElem,i;
	
	$('.cart-menu, .cart-menu>a, .cart-menu>a *').on('click',function(e)
	{
		if(e.target !== e.currentTarget) return;
		e.preventDefault();
		$('.cart-menu').addClass('open');
		$('body').addClass('sidebasket-open');
	});
	

	// hintergrund bei sidebasket wieder schließen 
	tElem = document.querySelectorAll('.c-dp .overlay-bg,.cart-menu .overlay-bg, .c-dp .close-sidebar');
	for(i=0;i<tElem.length;i++)
	{
		tElem[i].addEventListener('click',function(e)
		{
			$('.cart-menu').removeClass('open');
			$('body').removeClass('sidebasket-open');
			if(!e) e = window.event;
			e.preventDefault();
			e.target.parentNode.parentNode.classList.remove('open');
			document.body.classList.remove('sidecart-open');
			
		});
	}
								$('.collapse-non-validate')
									.on('hidden.bs.collapse', function(e) {
										$(e.target)
											.addClass('hidden')
											.find('fieldset, .form-control')
											.attr('disabled', true);
										e.stopPropagation();
									})
									.on('show.bs.collapse', function(e) {
										$(e.target)
											.removeClass('hidden')
											.attr('disabled', false);
										e.stopPropagation();
									}).on('shown.bs.collapse', function(e) {
										$(e.target)
											.find('fieldset, .form-control')
											.filter(function (i, e) {
												return $(e).closest('.collapse-non-validate.collapse').hasClass('in');
											})
											.attr('disabled', false);
										e.stopPropagation();
									});
								$('.collapse-non-validate.collapse.in')
									.removeClass('hidden')
									.find('fieldset, .form-control')
									.attr('disabled', false);
								$('.collapse-non-validate.collapse:not(.in)')
									.addClass('hidden')
									.find('fieldset, .form-control')
									.attr('disabled', true);

								// temporarily save order-comment
								$('#comment').on('blur',function(ev) {
									ev.preventDefault();
									sessionStorage.setItem($("[name$=jtl_token]").val()+'_comment', $('#comment').val());
								});
								// restore order-comment
								if ($('#comment') && '' == $('#comment').val()) {
									var storageComment;
									if (storageComment = sessionStorage.getItem($("[name$=jtl_token]").val() + '_comment')) {
										$('#comment').val(storageComment);
									}
								}
								// clear the sessionStorage at logout
								$("a[href*='logout']").on('click', function(ev) {
									sessionStorage.clear();
									return true;
								});

								$('#complete-order-button').on('click', function () {
									var commentField = $('#comment'),
										commentFieldHidden = $('#comment-hidden');
									if (commentField && commentFieldHidden) {
										commentFieldHidden.val(commentField.val());
									}
									// remove order-comment from sessionStorage at order-finish
									removeFromSessionStorage($("[name$=jtl_token]").val() + '_comment');
								});

    $(document).on('click', '.footnote-vat a, .versand, .popup', function(e) {
        var url = e.currentTarget.href;
        url += (url.indexOf('?') === -1) ? '?isAjax=true' : '&isAjax=true';
        eModal.ajax({
            size: 'lg',
            url: url,
            title: typeof e.currentTarget.title !== 'undefined' ? e.currentTarget.title : '',
            keyboard: true,
            tabindex: -1
        });
        e.stopPropagation();
		e.preventDefault();
        return false;
    });


    $('.dropdown .dropdown-menu.keepopen').on('click touchstart', function(e) {
        e.stopPropagation();
    });
    /*
     * show subcategory on caret click
     */
	
    $('section.box-categories .panel-body li a').on('click', function(e) {
        if ($(e.target).hasClass("nav-toggle")) {
            $(e.target)
                .parent('a').toggleClass('open');
            return false;
        }
    });
	
    /*
     * show linkgroup on caret click
     */
    $('section.box-linkgroup .nav-panel li a').on('click', function(e) {
        if ($(e.target).hasClass("nav-toggle")) {
            $(e.delegateTarget)
                .parent('li')
                .find('> ul.nav').toggle();
            $(e.delegateTarget)
                .parent('li').toggleClass('open');
            return false;
        }
    });
	
	/*
	//Modal Lazy Loading!
	$('body').on('shown.bs.modal', function (e) {
		window.setTimeout(function(){
			sImages.rewatch();
		},500);
	});
	*/
}

$(document).ready(function () {
	
	mainEventListener();

    /*if (typeof $.fn.jtl_search === 'undefined') {
        var productSearch = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('keyword'),
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            remote:         {
                url:      'io.php?io={"name":"suggestions", "params":["%QUERY"]}',
                wildcard: '%QUERY'
            }
        });

        $('input[name="qs"]').typeahead(
            {
                highlight: true
            },
            {
                name:      'product-search',
                display:   'keyword',
                source:    productSearch,
                templates: {
                    suggestion: function (e) {
                        return e.suggestion;
                    }
                }
            }
        );
    }

    var citySuggestion = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('keyword'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote:         {
            url:      'io.php?io={"name":"getCitiesByZip", "params":["%QUERY", "' + $(this).closest('fieldset').find('.country-input').val() + '", "' + $(this).closest('fieldset').find('.postcode_input').val() + '"]}',
            wildcard: '%QUERY'
        },
        dataType: "json"
    });
    $('.city_input').on('focusin', function () {
        citySuggestion.remote.url = 'io.php?io={"name":"getCitiesByZip", "params":["%QUERY", "' + $(this).closest('fieldset').find('.country-input').val() + '", "' + $(this).closest('fieldset').find('.postcode_input').val() + '"]}';
    });
    $('.postcode_input').on('change', function () {
        citySuggestion.remote.url = 'io.php?io={"name":"getCitiesByZip", "params":["%QUERY", "' + $(this).closest('fieldset').find('.country-input').val() + '", "' + $(this).val() + '"]}';
    });
    $('.country-input').on('change', function () {
        citySuggestion.remote.url = 'io.php?io={"name":"getCitiesByZip", "params":["%QUERY", "' + $(this).val() + '", "' + $(this).closest('fieldset').find('.postcode_input').val() + '"]}';
    });

    $('.city_input').typeahead(
        {
            hint: true,
            minLength: 0
        },
        {
			limit:  50,
            name:   'cities',
            source: citySuggestion
        }
    );*/

	/*
    $('.btn-offcanvas').on('click', function() {
        $('body').click();
    });
	*/
    if ("ontouchstart" in document.documentElement) {
        $('.variations .swatches .variation').on('mouseover', function() {
            $(this).trigger('click');
        });
    }
    
    /*
     * activate category parents of active child
     
    var child = $('section.box-categories .nav-panel li.active');
    if (child.length > 0) {
        //$(child).parents('.nav-panel li').addClass('active');
        $(child).parents('.nav-panel li').each(function(i, item) {
           $(item).find('ul.nav').show();
        });
    }
     */


    /*
     * Banner
     */
	 /*
    var bannerLink = $('.banner > a');
    bannerLink.popover({
        placement: 'auto bottom',
        html:      true,
        trigger:   'hover',
        container: 'body',
        content:   function () {
            return $(this).children('.area-desc').html()
        }
    });

    bannerLink.on('mouseenter',function () {
        $(this).animate({
            borderWidth: 10,
            opacity:     0
        }, 900, function () {
            $(this).css({opacity: 1, borderWidth: 0});
        });
    });

    $('.banner').on('mouseenter',function () {
        $(this).children('a').animate({
            borderWidth: 10,
            opacity:     0
        }, 900, function () {
            $(this).css({opacity: 1, borderWidth: 0});
        });
    });

    $('.banner > a[href=""]').on('click', function () {
        return false;
    });

    /*
     * account download collapse
     *//*
    $('#account a[data-toggle="collapse"]').on('click', function() {
        $('i', this).toggleClass("fa-chevron-up fa-chevron-down");
    });

    /*
     * alert actions
     */
    $('.alert .close').on('click', function (){
        $(this).parent().fadeOut(1000);
    });

    $('.alert').each(function(){
        if ($(this).data('fade-out') > 0) {
            $(this).fadeOut($(this).data('fade-out'));
        }
    });

    /*
     * set bootstrap viewport
     */
	 /*
    (function($, document, window, viewport){ 
        var $body = $('body');

        $(window).on('resize',
            viewport.changed(function() {
                $body.attr('data-viewport', viewport.current());
                lazyLoadMenu(viewport);
            })
        );
        $body.attr('data-viewport', viewport.current());
        $body.attr('data-touchcapable', isTouchCapable() ? 'true' : 'false');
    })(jQuery, document, window, ResponsiveBootstrapToolkit);
	*/    /**
     * provide the possibility of removing the shop-credit in
     * the "Versandart/Zahlungsart"-step/mask
     */
    $("#using-shop-credit").on('click', function() {
        // remove the shop-credit from the basket
        // by loading it with POST-var "dropPos"
        $.ajax({
            url    : 'warenkorb.php',
            method : 'POST',
            data   : {dropPos : 'assetToUse'}
        }).done(function(data) {
            $('input[name="Versandart"]:checked', '#checkout-shipping-payment').trigger('change');
        })
    });

    //lazyLoadMenu($('body').attr('data-viewport'));
    //categoryMenu();
    //regionsToState();
    //compatibility();
    addValidationListener();
	
    initWow();
	snackys();
});
