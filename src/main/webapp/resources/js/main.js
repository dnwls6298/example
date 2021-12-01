
$(".toggle-click").click(function() {
	$(this).toggleClass('open');
	$(".right_hidden_inner").toggleClass('on');
});

$("header .mobile .mo_buger").on("click",function(){
	$("header .mobile").addClass("view");
});

$("header .menuSide .close").on("click",function(){
	$("header .mobile").removeClass("view");
});


$('#categoryAll').click(function () {  
if($(".categoryAll_abs").css("display") == "none"){   
	$('.categoryAll_abs').show();  
	$("#categoryAll").addClass("view");
} else {  
	$('.categoryAll_abs').hide(); 
	$("#categoryAll").removeClass("view");
}  
}); 



var swiper01 = new Swiper('.swiper01', {
	slidesPerView: 'auto',
	centeredSlides: true,
	loop: true,
	spaceBetween: 15,
	pagination: {
		el: '.swiper-pagination1',
		clickable: true,
	},
	navigation: {
		nextEl: '.swiper-button-next-main',
		prevEl: '.swiper-button-prev-main',
	},
	autoplay: {
		delay: 10000,
		disableOnInteraction: false,
	},
	speed: 1000,
});


var main_W = jQuery(".swiper01").width();
if (main_W <= 922) {
	$('.swiper01 .swiper-button-next-main').css('right', '30px');
	$('.swiper01 .swiper-button-prev-main').css('left', '30px');
} else {
	var w_change = (main_W - 922) / 2;
	$('.swiper01 .swiper-button-next-main').css('right', 30 + w_change + 'px');
	$('.swiper01 .swiper-button-prev-main').css('left', 30 + w_change + 'px');
}

$(window).resize(function() {
	var main_W = jQuery(".swiper01").width();
	if (main_W <= 922) {
		$('.swiper01 .swiper-button-next-main').css('right', '30px');
		$('.swiper01 .swiper-button-prev-main').css('left', '30px');
	} else {
		var w_change = (main_W - 922) / 2;
		$('.swiper01 .swiper-button-next-main').css('right', 30 + w_change + 'px');
		$('.swiper01 .swiper-button-prev-main').css('left', 30 + w_change + 'px');
	}
});


var swiper = new Swiper(".proslide01", {
	slidesPerView: 1,
	spaceBetween: 28,
	loop: true,
	navigation: {
		nextEl: '.swiper-button-next',
		prevEl: '.swiper-button-prev',
	},
	breakpoints: {
		"@0.00": {
			slidesPerView: 2,
			spaceBetween: 20,
		},
		"@0.75": {
			slidesPerView: 2,
			spaceBetween: 20,
		},
		"@1.00": {
			slidesPerView: 3,
			spaceBetween: 20,
		},
		"@1.50": {
			slidesPerView: 4,
			spaceBetween: 28,
		},
	},
});



$(".itemlist_wrap .tab_btn p").click(function() {
	var i01 = $(this).index();
	$(".itemlist_wrap .tab_btn p").removeClass("active");
	$(this).addClass("active");
	$(".itemlist_wrap .tab_con").removeClass("active");
	$(".itemlist_wrap .tab_con").eq(i01).addClass("active");
});



$(document).ready(function() {

	$(".js-tab-view12 .tab a").click(function(e) {
		$(".js-tab-view12 .tab a").removeClass('on');
		$(this).addClass('on');

		$(".js-tab-view12 ul[class*='mainTabGoodsList']").hide();
		$(".js-tab-view12 .mainTabGoodsList" + $(this).data('key')).show();
	});

	$('.thumbnail').on('click', '.btn-add-wish12', function() {

		alert("로그인하셔야 본 서비스를 이용하실 수 있습니다.");
		document.location.href = "../member/login.php";
		return false;
	});


	$('.thumbnail').on('click', '.btn-add-cart12', function() {
		if ($(this).data('mode') == 'cartIn') {
			var params = {
				page: 'goods',
				type: 'goods',
				goodsNo: $(this).data('goods-no')
			};

			$.ajax({
				method: "POST",
				cache: false,
				url: "../goods/layer_option.php",
				data: params,
				success: function(data) {

					$('#optionViewLayer').empty().append(data);
					$('#optionViewLayer').find('>div').center();
				},
				error: function(data) {
					alert(data.message);

				}
			});
		}

	});

	$('.layer-cartaddconfirm').click(function() {
		location.href = '../order/cart.php';
	});

	$('.layer-wishaddconfirm').click(function() {
		location.href = '../mypage/wish_list.php';
	});
});

$(window).scroll(function() {
	var sct = $(window).scrollTop();
	if (sct >= 150) {
		$(".btnTop").css('display', 'inline-block');
	}
	if (sct < 150) {
		$(".btnTop").css('display', 'none');
	}

	if (sct > 60) {
		$("#header").addClass('on');
	}
	if (sct < 60) {
		$("#header").removeClass('on');
	}
});


$(document).ready(function() {
	$(".btnTop").click(function() {
		$("html,body").animate({
			scrollTop: 0
		}, 800);
	});
});


