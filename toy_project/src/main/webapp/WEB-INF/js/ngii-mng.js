$(function() {
	// bind a click event to the 'skip' link
	$(".nav-skip").click(function(event){

		// strip the leading hash and declare
		// the content we're skipping to
		var skipTo="#"+this.href.split('#')[1];

		// Setting 'tabindex' to -1 takes an element out of normal 
		// tab flow but allows it to be focused via javascript
		$(skipTo).attr('tabindex', -1).on('blur focusout', function () {

			// when focus leaves this element, 
			// remove the tabindex attribute
			$(this).removeAttr('tabindex');

		}).focus(); // focus on the content container
	});
		
	// Datepicker
	$(".datepicker").datepicker({
        showOn: 'button',
        buttonText: "",
        dateFormat: 'yy-mm-dd'
    }).next(".ui-datepicker-trigger").addClass("fa fa-calendar");
	
	
	// Layer Popup
	$('.layer-popup .close, .dim').click(function() {		
		$('html').removeClass('fix-layout');
		$('.layer-popup').hide();
		$('.dim').fadeOut();
	});
	$('.show-layer').click(function(e){				
		e.preventDefault();
		
		$('.dim').remove();
		$('html').addClass('fix-layout');	

		var activeLayer = $(this).attr('aria-edit-div');
		var left = ($(window).width() - $('#' + activeLayer).width()) / 2;
		var top = ($(window).height() - $('#' + activeLayer).height()) / 2;

		$('#' + activeLayer).css({'left': left,'top': top}).show().after('<div class="dim"></div>');
		$('.dim').fadeTo('slow',0.8);
	});	
	
	// Nav
	$('.drop-down').click(function(e){				
		e.preventDefault();
		if ($(this).hasClass('current')) {
			$(this).removeClass('current');
			$('.nav-depth2').slideUp(300);
		} else {
			$('.nav-depth1 a').removeClass('current');
			$(this).addClass('current');
			$('.nav-depth2').slideDown(300);
		}
	});
	
	// Input Focus for Login
	$('.user-login input[type="text"], .user-login input[type="password"]').focus(function(){	
		var focusInput = $(this).attr('id');
		$('label[for^="'+ focusInput + '"]' ).find('.fa').css('color', '#3c8dbc');
	});
	$('.user-login input[type="text"], .user-login input[type="password"]').blur(function(){	
		var focusInput = $(this).attr('id');
		$('label[for^="'+ focusInput + '"]' ).find('.fa').css('color', '#777');
	});
	
	
	// pagination
	$('.pagination ul button').on('click',function(){
		$(this).parent().addClass('current').siblings().removeClass('current');
	});
	
});
// Datepicker
$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	showMonthAfterYear: true,
	yearSuffix: '년'
});

// Back To Top
$(window).scroll(function() {
	if ($(this).scrollTop() > 100) {
		$('#top').fadeIn(300);
	} else {
		$('#top').fadeOut(300);
	}
});
$(window).load(function () {
    $('#top').click(function () {
        $('html, body').animate({
            scrollTop: 0
        }, 200);
        return false;
    });
});