$(document).ready(function () {
    $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    });
    //页面初始的时候计算价钱
    $(".total").text(($(".good-price").text()*($("input[name=quantity]").val())).toFixed(2));  
    count();
});

	//改变商品分类
function getgoodcate(that){ 
	var linkid=$(that).children('option:selected').val();
	if(linkid){
      	 $.get("/getcategory/"+linkid,
           	 function(result){
           		 if(result.status==1){
           			 var goodlist = '';
           			$.each(result.data,function(index,data){
           				goodlist += "<option value="+data['linkid']+">"+data['goodname']+"</option>"
           			}) 
           			 var _goodlist = "<option value=''>==请选择商品==</option>"+goodlist;
           			$("select[name='goodlist']").html("");
           			$("select[name='goodlist']").html(_goodlist);
           			$("input[name=couponcode]").parent().hide();
           		 }else{
           			layer.msg(result.info);
           		 }
           	 });
      	 
    	 $(".good-price").text("0.00");
			 $(".unit-price").text("0.00");
			 $(".total").text("0.00");
			 $(".inventory").text("");
   	}else{
   		$("select[name='goodlist']").html("");
			$("select[name='goodlist']").html("<option value=''>==请选择商品==</option>");
   		 $(".good-price").text("0.00");
			 $(".unit-price").text("0.00");
			 $(".total").text("0.00");
			 $(".inventory").text("");
   	}
}
//改变商品
function getgoodlist(that){
	var linkid=$(that).children('option:selected').val();
	if(linkid){
   	 $.get("/getgood/"+linkid,
        	 function(result){
        		 if(result.status==1){
        			 $(".inventory").text("库存量:"+result.count);
        		      //如果原先购买量超过改变购买量
        	         var inventory =  parseInt($(".inventory").text().split(":")[1]);
        	         var quantity = parseInt($(".quantity").val());
        	         if(quantity>inventory){
        	 		   	$(".quantity").val(inventory);
        	 		    $(".num").text(inventory)
        	 	      }
        	         
        			 $(".good-price").text(result.price);
        			 $(".unit-price").text(result.price);
        	         var total = result.price*($("input[name=quantity]").val());
        	         $(".total").text(total);
        	         count();
        	         $("input[name=goodlinkid]").val(linkid);
        	         if(result.is_coupon == 1){
        	        	 $("input[name=couponcode]").parent().show();
        	         }else{
        	        	 $("input[name=couponcode]").parent().hide();
        	         }
        		 }else{
           			layer.msg(result.info);
           		 }
        	 });
	}else{
		 $(".good-price").text("0.00");
		 $(".unit-price").text("0.00");
		 $(".total").text("0.00");
		 count();
		 $(".inventory").text("");
	}

}
//库存量输入框修改事件
$('input[name=quantity]').change(function(){
	var quantity = parseInt($(".quantity").val());
    var inventory =  parseInt($(".inventory").text().split(":")[1]);
    if(quantity<inventory){
	   	$(".quantity").val(quantity);
	   	inputCalculate(quantity);
    }else{
 	   layer.msg('数量不能大于库存数！', { icon: 5, time: 1500, anim: 6 },function(){
 		   $('input[name=quantity]').val(inventory);
 		  inputCalculate(inventory);
 	   });
    }
   if(quantity > 0){
    	$(".quantity").val(quantity);
    	inputCalculate(quantity)
    }else{
    	layer.msg('数量必须大于0！', { icon: 5, time: 1500, anim: 6 },function(){
    		$('input[name=quantity]').val(1);
    		inputCalculate(1);
    	});
    }
});
//改变购买数量
$(".quantity").on("input propertychange",function(){
    var num = $(this).val();
    inputCalculate(num)
})
//改变购买数量时计算价格
function inputCalculate(){
	var num = $('input[name=quantity]').val();
    var total = ($(".good-price").text())*num;
    $(".total").text(total);
    $("input[name=price]").val(total);
    count();
}

// 计算实付金额
function count(){
	var num = $('input[name=quantity]').val();
	var total = ($(".good-price").text())*num;
	var coupon = $('.coupon').text();
	$("input[name=price]").val(total-coupon);
	$(".paymoney").text(total-coupon);
}
// paytype
$('.payway-nav-li').click(function(){
	var data = $(this).attr('data');
	$('input[name=paytype]').val(data);
	$('.chongzhika').hide();
	if(data == 'chongzhika'){
		$('.chongzhika').show();
	}
	
});
// 支付方式切换
        $(document).ready(function () {
        	$('.i-checks').iCheck({
	            checkboxClass: 'icheckbox_square-green',
	            radioClass: 'iradio_square-green',
	        });
            // 支付方式
            var payway1 = [{
            	val: 'ICBC-NET',
            	pic: '__IMG__/blue/ICBC-NET.gif',
            	name: '中国工商银行'
            }, {
            	val: 'BOCO-NET',
            	pic: '__IMG__/blue/BOCO-NET.gif',
            	name: '中国交通银行'
            }, {
            	val: 'CEB-NET',
            	pic: '__IMG__/blue/CEB-NET.gif',
            	name: '中国光大银行'
            }, {
            	val: 'CMBC-NET',
            	pic: '__IMG__/blue/CMBC-NET.gif',
            	name: '中国民生银行'
            }, {
            	val: 'ABC-NET',
            	pic: '__IMG__/blue/ABC-NET.gif',
            	name: '中国农业银行'
            }, {
            	val: 'SPDB-NET',
            	pic: '__IMG__/blue/SPDB-NET.gif',
            	name: '中国上海浦东发展银行'
            }, {
            	val: 'CIB-NET',
            	pic: '__IMG__/blue/CIB-NET.gif',
            	name: '中国兴业银行'
            }, {
            	val: 'ECITIC-NET',
            	pic: '__IMG__/blue/ECITIC-NET.gif',
            	name: '中国中信银行'
            }, {
            	val: 'CCB-NET',
            	pic: '__IMG__/blue/CCB-NET.gif',
            	name: '中国建设银行'
            }, {
            	val: 'CBHB-NET',
            	pic: '__IMG__/blue/CBHB-NET.gif',
            	name: '中国渤海银行'
            }, {
            	val: 'PAB-NET',
            	pic: '__IMG__/blue/PAB-NET.gif',
            	name: '中国平安银行'
            }, {
            	val: 'HXB-NET',
            	pic: '__IMG__/blue/HXB-NET.gif',
            	name: '中国华夏银行'
            }, {
            	val: 'CMBCHINA-NET',
            	pic: '__IMG__/blue/CMBCHINA-NET.gif',
            	name: '中国招商银行'
            }, {
            	val: 'BOC-NET',
            	pic: '__IMG__/blue/BOC-NET.gif',
            	name: '中国人民银行'
            }, {
            	val: 'GDB-NET',
            	pic: '__IMG__/blue/GDB-NET.gif',
            	name: '中国广东发展银行'
            }, {
            	val: 'SDB-NET',
            	pic: '__IMG__/blue/SDB-NET.gif',
            	name: '中国深圳发展银行'
            }, {
            	val: 'BJRCB-NET',
            	pic: '__IMG__/blue/BJRCB-NET.gif',
            	name: '中国北京农村商业银行'
            }, {
            	val: 'POST-NET',
            	pic: '__IMG__/blue/POST-NET.gif',
            	name: '中国邮政储蓄所'
            }, {
            	val: 'NBCB-NET',
            	pic: '__IMG__/blue/NBCB-NET.gif',
            	name: '中国宁波银行'
            }, {
            	val: 'HKBEA-NET',
            	pic: '__IMG__/blue/HKBEA-NET.gif',
            	name: '中国东亚银行'
            }, {
            	val: 'BCCB-NET',
            	pic: '__IMG__/blue/BCCB-NET.gif',
            	name: '中国北京银行'
            }, {
            	val: 'NJCB-NET',
            	pic: '__IMG__/blue/NJCB-NET.gif',
            	name: '中国南京银行'
            }, {
            	val: 'SHRCB-NET',
            	pic: '__IMG__/blue/SHRCB-NET.gif',
            	name: '中国上海农村商业银行'
            }, {
            	val: 'SHB-NET',
            	pic: '__IMG__/blue/SHB-NET.gif',
            	name: '上海银行'
            }];
            var paywayHtml1 = ''
            $.each(payway1, function (index, item) {
            	paywayHtml1 += '<div class="cursor">';
            	paywayHtml1 += '<input name="pid" type="radio" value="' + item.val + '">';
            	paywayHtml1 += '<img src="' + item.pic + '" alt="' + name + '" align="absmiddle"></div>';
            })
            $("#tab-1 .table-responsive").append(paywayHtml1);

            var payway2 = eval({$pay});
            var paywayHtml2 = ''
            $.each(payway2, function (index, item) {
            	paywayHtml2 += '<div class="cursor bank-list-way">';
            	paywayHtml2 += '<input name="pid" type="radio" value="' + item.val + '">';
            	paywayHtml2 += '<img src="' + item.pic + '" alt="' + name + '" align="absmiddle"></div>';
            });
            paywayHtml2 += '<script type="text/javascript">';
            paywayHtml2 += 'getcardmoney()';
            	paywayHtml2 += '<';
            		paywayHtml2 +='/script>';
            $("#tab-2 .table-responsive").append(paywayHtml2);

            var paywayHtml3 = ''
            paywayHtml3 += '<div class="cursor">';
        	paywayHtml3 += '<input name="pid" type="radio" value="ALIPAY">';
        	paywayHtml3 += '<img src="__IMG__/blue/ALIPAY.gif" alt="支付宝支付" align="absmiddle"></div>';
            $("#tab-3 .table-responsive").append(paywayHtml3);

            var paywayHtml4 = ''
            paywayHtml4 += '<div class="cursor">';
        	paywayHtml4 += '<input name="pid" type="radio" value="WXPAY">';
        	paywayHtml4 += '<img src="__IMG__/blue/wxpay.jpg" alt="微信支付" align="absmiddle"></div>';
            $("#tab-4 .table-responsive").append(paywayHtml4);

            var paywayHtml5 = ''
            paywayHtml5 += '<div class="cursor">';
        	paywayHtml5 += '<input name="pid" type="radio" value="TENPAY">';
        	paywayHtml5 += '<img src="__IMG__/blue/TENPAY.gif" alt="财付通支付" align="absmiddle"></div>';
            $("#tab-5 .table-responsive").append(paywayHtml5);

			$(".tab-content .cursor").click(function () {
				$(this).find('input').attr('checked', true);
			})
        });
        // 订单提交
        $('.pay-content-submit').click(
        		function(){
        			// 提交验证
        			var is = yanzheng();
        			if(is == false){
        				return false;
        			}
        			if($('input[name=pid]').val() == ''){
        				alert('支付方式不能为空');
        			}
        			var data = $("form").serialize();
                	var url   = "/ajax/pay.html?"+data;
                		layer.open({
                		    type: 2,
                		    title: '订单支付',
                		    scrollbar: false,
                		    area: [ '45%', '85%'],
                		    skin: 'layui-layer-rim', //加上边框
                		    content: url,
                		});
        		}	
        );
        
   	 	//举报模态框
    	$(document).delegate('#complain', 'click', function() {
    		var userid = $("input[name='userid']").val();
    		var url = "/Home/Complain/index/userid/"+userid;
    		$.ajax({
    		    url:url,  
    		    type:"GET",   //请求方式 get 或者post  
    		    success:function(result){
    				 $("#complain-content").html("");
    				 $(".complain-title").html("");
    				 $("#complain-content").html(result.data);
    				 $(".complain-title").html("举报投诉") ; 
    				 $('#complain-modal').modal('show');
    		    }
    		});
    	});
    	// 添加充值卡
    	var select_card_quantity=function(){
    	    var quantity=$('[name=cardquantity]').val();
    		quantity=quantity-1;
    		$('.card_list_add').html('');
    		for(var i=1;i<=quantity;i++){
    			$('.card_list_add').append($('.card_list:first').clone());
    		}	
    	}
    	function getcardmoney(){
    		// 充值卡面额获取
       	 	$('.bank-list-way').click(function(){
       	 		var id = $(this).children('input[name=pid]').val();
       	 		var option='<option value="">请选择充值卡面额</option>';
       	 		$.post("{:U('ajax/getpayprice')}",{id:id},function(data){
       	            $('.cardvalue').each(function(){
       				    $(this).html(option+data);
       				});
       	 		});
       	 		
       	 });
    	}
   	 	
   	 // 表单提交验证
   	 function yanzheng(){
   		 // 产品分类
   		 if($('select[name=goodcate]').val() == ''){
   			alert('请选择商品分类！');
   			$('select[name=goodcate]').focus();
   			return false;
   		 }
   		// 选择产品
   		 if($('input[name=goodlinkid]').val() == ''){
   			alert('请选择具体商品！');
   			$('select[name=goodlist]').focus();
   			return false;
   		 }
   		// 产品数量
   		 if($('input[name=quantity]').val() <= 0){
   			alert('请选择产品数量！');
   			$('input[name=quantity]').focus();
   			return false;
   		 }
   		// 联系QQ
   		 if($('input[name=contact]').val() == ''){
   			alert('请填写联系信息！');
   			$('input[name=contact]').focus();
   			return false;
   		 }
   		 // 用户协议
   		if($('[name=isagree]').is(':checked')==false){
   		    alert('请阅读和同意用户协议，才能继续购买！');
   			$('[name=isagree]').focus();
   			return false;
   		}
   		// 支付方式
  		 if($('input[name=pid]').val() == ''||$('input[name=pid]').is(':checked')==false){
  			alert('请选择具体支付方式！');
  			$('.payway-nav-name').focus();
  			return false;
  		 }
   		// 充值卡修改
   		if($('input[name=paytype]').val()=="chongzhika"){
   			var cte = "";
   			var is = true;
   			var i=1;
   			$('.cardvalue').each(function(){
   				if($(this).val()==''){
   					cte=cte+"第"+i+"张卡 请选择充值卡面值!\n";
   					is = false;
   				}
   				i++;
   			});

   			var i=1;
   			$('.cardnum').each(function(){
   				if($(this).val()==''){
   					cte=cte+"第"+i+"张卡 请填写充值卡号!\n";
   					is = false;
   				}
   				i++;
   			});

   			var i=1;
   			$('.cardpwd').each(function(){
   				if($(this).val()==''){
   					cte=cte+"第"+i+"张卡 请填写充值卡密!\n";
   					is = false;
   				} 
   				i++;
   			});
   			if(cte != ''){
   				alert(cte);
   	   			return false;
   			}
   			
   		}
   	 }
  // 优惠券检查
   	 $('input[name=couponcode]').change(function(){
   		 var code = $(this).val();
   		 var linkid = $('input[name=goodlinkid]').val();
   		 if(code == ""){
   			 alert("请填写优惠券码");
   			 $(this).focus();
   			 return false;
   		 }
   		 if(linkid == ""){
   			alert('请选择具体商品！');
   			$('select[name=goodlist]').focus();
   			return false;
   		 }
   		 
   		$.post("{:U('ajax/checkcode')}",{code:code,linkid:linkid},function(data){
	            if(data.status != 1){
	            	alert(data.info);
	      			 $(this).focus();
	            }
	            if(data.status == 1){
	            	if(data.ctype == 1){
	            		$('.coupon').text(data.price);
	            		count();
	            	}
	            	if(data.ctype == 100){
	            		var total = $(".total").text();
	            		$('.coupon').text(data.price*total/100);
	            		count();
	            	}
	            	alert(data.info);
	            }
	 	});
   	 });
   	 // 用户合作协议
   	 $('.userread').click(function() {
    var title = $(this).data('title');
    var url   = $(this).data('url');
    layer.open({
        type: 2,
        title: title,
        scrollbar: false,
        area: [ '40%', '60%'],
        skin: 'layui-layer-rim', //加上边框
        content: url,
    });
});