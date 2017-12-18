$(function () {
	var scrollTop = $(window).scrollTop()
	onscroll = function () {
		scrollTop = $(window).scrollTop()
		if (scrollTop >= 800) {
			$('#box3>.container .computer>img').css('opacity','1')
		} else{
			$('#box3>.container .computer>img').css('opacity','0')
		}
	}
})