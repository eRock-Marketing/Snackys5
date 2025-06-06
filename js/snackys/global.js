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
}

function initWow()
{
	//Only initialize if Lib is loaded
	if(typeof WOW != "undefined")
		new WOW().init();
}

function categoryMenu(rootcategory) {
}

function compatibility() {
}

/*
function regionsToState() {
    var state = $('#state');
    if (state.length === 0) {
		return ;
    }
	
	var stateIsRequired = result.response.required;
	var data = result.response.states;

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
                            $('<option></option>').val(item.iso).html(item.name)
                                .attr('selected', item.iso == def || item.name == def ? 'selected' : false)
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
				if (stateIsRequired){
					state.parent().find('.state-optional').addClass('d-none');
				} else {
					state.parent().find('.state-optional').removeClass('d-none');
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
*/


function regionsToState(){
    $('.js-country-select').on('change', function() {

        var result = {};
        var io = $.evo.io();
        var country = $(this).find(':selected').val();
        country = (country !== null && country !== undefined) ? country : '';
        var connection_id = $(this).attr('id').toString().replace("-country","");

        io.call('getRegionsByCountry', [country], result, function (error, data) {
            if (error) {
                console.error(data);
            } else {
                var state_id = connection_id+'-state';
                var state = $('#'+state_id);
                var state_data = state.data();

                if (typeof(result.response) === 'undefined' || state.length === 0) {
                    return;
                }
                var title = state_data.defaultoption;
                var stateIsRequired = result.response.required;
                var data = result.response.states;
                var def = $('#'+state_id).val();
                if(typeof(data)!=='undefined'){
                    if (data !== null && data.length > 0) {
                        if (stateIsRequired){
                            var state = $('<select />').attr({ id: state_id, name: state.attr('name'), class: 'custom-select required state-input js-state-select', required: 'required'});
                        } else {
                            var state = $('<select />').attr({ id: state_id, name: state.attr('name'), class: 'state-input custom-select js-state-select'});
                        }

                        Object.keys(state_data).forEach(function(key,index) {
                            state.data(key,state_data[key]);
                        });

                        state.append('<option value="">' + title + '</option>');
                        $(data).each(function(idx, item) {
                            state.append(
                                $('<option></option>').val(item.iso).html(item.name)
                                    .attr('selected', item.iso == def || item.name == def ? 'selected' : false)
                            );
                        });
                        $('#'+state_id).replaceWith(state);
                    } else {
                        if (stateIsRequired) {
                            var state = $('<input />').attr({ type: 'text', id: state_id, name: state.attr('name'),  class: 'required form-control js-state-select', placeholder: title, required: 'required' });
                        } else {
                            var state = $('<input />').attr({ type: 'text', id: state_id, name: state.attr('name'),  class: 'form-control js-state-select', placeholder: title });
                        }
                        Object.keys(state_data).forEach(function(key,index) {
                            state.data(key,state_data[key]);
                        });
                        $('#'+state_id).replaceWith(state);
                    }
                    if (stateIsRequired){
                        state.parent().find('.state-optional').addClass('d-none');
                    } else {
                        state.parent().find('.state-optional').removeClass('d-none');
                    }
                }
            }
        });
        return false;
    }).trigger('change');
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
    });
}

function navigation()
{
}

function addValidationListener() {
    var forms      = $('form.jtl-validate'),
        inputs     = $('form.jtl-validate input, form.jtl-validate textarea').not('[type="radio"],[type="checkbox"]'),
        selects    = $('form.jtl-validate select'),
        checkables = $('form.jtl-validate input[type="radio"], form.jtl-validate input[type="checkbox"]'),
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
	return;
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
	tElem = document.getElementById('mob-nt');
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
	$('#goToNotification').on('click',function(e){
        e.preventDefault();
        e.stopPropagation();
		
		var $nav = ($('body').hasClass('mobile')) ? $('#shop-nav') : $('#cat-w'), fixedOffset = $nav.length > 0 ? $nav.outerHeight() : 0;
		if($('#article-tab-nav').length > 0)
		{
			$('#article-tab-nav a[href="#tab-availabilityNotification"]').tab('show');
			$([document.documentElement, document.body]).animate({
				scrollTop: $("#tab-availabilityNotification form").offset().top  - fixedOffset
			}, 300);
		}
		else
		{
			if(!$('#tab-availabilityNotification').hasClass('show'))
				$('#tab-availabilityNotification .panel-title').trigger('click');
			window.setTimeout(function(){
				$([document.documentElement, document.body]).animate({
					scrollTop: $("#tab-availabilityNotification form").offset().top  - fixedOffset
				}, 300);
			},300);
		}
	});
	
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
											//.addClass('hidden')
											.find('fieldset, .form-control')
											.attr('disabled', true);
										e.stopPropagation();
									})
									.on('show.bs.collapse', function(e) {
										$(e.target)
											//.removeClass('hidden')
											.attr('disabled', false);
										e.stopPropagation();
									}).on('shown.bs.collapse', function(e) {
										$(e.target)
											.find('fieldset, .form-control')
											.filter(function (i, e) {
												return $(e).closest('.collapse-non-validate.collapse').hasClass('show');
											})
											.attr('disabled', false);
										e.stopPropagation();
									});
								$('.collapse-non-validate.collapse.show')
									//.removeClass('hidden')
									.find('fieldset, .form-control')
									.attr('disabled', false);
								$('.collapse-non-validate.collapse:not(.show)')
									//.addClass('hidden')
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

}

// Add tab-dfuction to footer boxes
document.querySelectorAll('#footer-boxes .panel-heading').forEach(el => {
    el.setAttribute('tabindex', '0');
});

// Set Focus on basket
$(document).ready(function () {
    if ($('.cart-menu').hasClass('open')) {
        $('.c-dp .close-btn').focus();
    }
    
    $('.video-transcript').each(function() {
        let container = $(this);
        container.find('[data-toggle="collapse"]').on('click', function() {
            $(this).attr('aria-expanded', function(i, attr) {
                return attr === 'true' ? 'false' : 'true'
            });
            container.find('.collapse').collapse('toggle');
        }).on('focus', function() {
            $(this).parent('.video-transcript').toggleClass('focus');
        })
    });
    $('[data-video-transcript]').each(function() {
        let transcriptElement = $(this);
        
        transcriptElement.on('click', function (e) {
            e.preventDefault();
            let content = transcriptElement.data('video-transcript');
            if (content !== '') {
                let popup = window.open(
                    '',
                    'TranscriptWindow',
                    'width=600, height=400, scrollbars=yes'
                );
                $(popup.document.body).html(content);
            }
        });
    });

});

// Basket Tab-Loop
$(document).on('keydown', function (e) {
    if (!$('body').hasClass('sidebasket-open') && !$('.cart-menu').hasClass('open')) return;
      
    const $basket = $('.c-dp');
    if ($basket.length === 0) return;
  
    const $focusables = $basket.find(
      'a[href], area[href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), button:not([disabled]), [tabindex]:not([tabindex="-1"])'
    );
    if ($focusables.length === 0) return;
  
    const first = $focusables[0];
    const last = $focusables[$focusables.length - 1];
  
    if (e.key === 'Tab') {
      if (e.shiftKey && document.activeElement === first) {
        e.preventDefault();
        $(last).focus();
      } else if (!e.shiftKey && document.activeElement === last) {
        e.preventDefault();
        $(first).focus();
      }
    }
});

$(document).ready(function () {
	
	mainEventListener();

    if ("ontouchstart" in document.documentElement) {
        $('.variations .swatches .variation').on('mouseover', function() {
            $(this).trigger('click');
        });
    }
    
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

	/**
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

    addValidationListener();
	
    initWow();
	snackys();
});
