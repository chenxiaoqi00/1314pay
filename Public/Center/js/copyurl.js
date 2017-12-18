	$(function () {
	 	$(".copy").click(function(){
	 		var id = $(this).attr("data");
	 		var title = $(".title"+id).text(); 
	 		
	 		var cation = $(this).attr("action");
	 		var linkid = $(this).attr("linkid");
	 		var url = "getPayUrl/action/"+cation+"/linkid/"+linkid;
	 		
	 		
	 		$.get(url,function(resoult){
		 		$("a[name='pr_url']").text(resoult.payUrl);
		 		$("a[name='pr_url']").attr('href',resoult.payUrl);
		 		$("a[name='short_url']").text(resoult.shortPayUrl);
		 		$("a[name='short_url']").attr('href',resoult.shortPayUrl);
		 		$("img[name='qr']").attr('src',resoult.qrUrl);
		 		//获取二维码
	 		
	 		})
	 		
	 		
//	 		var copy_url = $(".pay-url"+id).text(); 
//	 		var shot_copy_url = $(".shot-pay-url"+id).text(); 
//	 		$("a[name='pr_url']").text(copy_url);
//	 		$("a[name='pr_url']").attr('href',copy_url);
//	 		$("a[name='short_url']").text(shot_copy_url);
//	 		$("a[name='short_url']").attr('href',shot_copy_url);
				layer.open({
        		    type: 1,
        		    title: title,
        		    scrollbar: false,
        		    area: [ '50%', '84%'],
        		    shade: 0,
        		    shadeClose:true,
        		    move: false,
        		    content: $("#copy-url")
        		});
		}) 
		
		var pr_content = $("a[name='pr_url']").text();
		copy("btn-copy",pr_content);
		
		var short_content = $("a[name='short_url']").text();
		copy("btn-sina",short_content)
		
		var store_pr_content = $("a[name='store_pr_url']").text();
		copy("btn-pr-store",store_pr_content)
		
		var store_short_content = $("a[name='store_short_url']").text();
		copy("btn-short-store",store_short_content)
		
		var invite_content = $("input[name='invite_num']").val();
		copy("btn-invite",invite_content)
		
	});
	
	$("#btn-sina").mousemove(function(){
			var copy_content = $("a[name='short_url']").text();
			copy("btn-sina",copy_content)
		});
	
	$("#btn-copy").mousemove(function(){
		var copy_content = $("a[name='pr_url']").text();
		copy("btn-copy",copy_content)
	});
	
	$("#btn-pr-store").mousemove(function(){
		var store_pr_content = $("a[name='store_pr_url']").text();
		copy("btn-pr-store",store_pr_content)
	});
	
	$("#btn-short-store").mousemove(function(){
		var store_short_content = $("a[name='store_short_url']").text();
		copy("btn-short-store",store_short_content)
	});
	
	$("#btn-invite").mousemove(function(){
		var invite_content = $("input[name='invite_num']").val();
		copy("btn-invite",invite_content)
	});
	
	function copy(btn_id,copy_content){
	var clip = new ZeroClipboard(document.getElementById(btn_id), {moviePath: "ZeroClipboard.swf"});  	
	clip.setText(copy_content);
	clip.on("copy", function(e) {
		layer.msg("复制成功！")
	//    e.clipboardData.setData("text/plain", "这里是用于复制的纯文本数据")
	}); 
	};
