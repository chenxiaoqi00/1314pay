<?php
namespace Home\Controller;

class AjaxController extends HomeController {
	
	private $rate = 0;           //渠道优惠率
	private $paymoney = 0;       // 实付金额
	private $url = null;         // 接口连接地址
	
    public function pay(){
    	$data = I('get.');
    	// 获取渠道信息
    	$channel = $this->getchannelid();
    	// 添加订单信息
    	$order = $this->addorder($channel);
    	$this->assign('order',$order);
    	$this->assign('total',$order['quantity']*$order['price']);
    	$this->assign('paymoney',$this->paymoney == 0? $order['quantity']*$order['price']:$this->paymoney);
    	$this->assign('pid',$data['pid']);
    	if ($data['paytype'] == 'chongzhika') {
    		$img = pay(channel($data['pid'],'payid'),'imgurl');
    	}else {
    		$img = strtolower($data['pid']).'.png';
    	}
    	
    	$this->assign('img',$img);
    	$this->assign('url',$this->url);
        $this->display();
    }
    
    // 获取channelid accessType
    private function getchannelid(){
    	$data = I('get.');
    	$channelid = $data['pid'];
    	$channels = channellist();
    	if ($data['paytype'] == 'wangying' || $data['paytype'] == 'QQpay' || $data['paytype'] == 'zhifubao' || $data['paytype'] == 'wechat' || $data['paytype'] == 'caifutong') {
    		switch ($data['pid']) {
    			case 'ALIPAY':
    				$payid = 25;
    			break;
    			case 'TENPAY':
    				$payid = 26;
    			break;
    			case 'WXPAY':
    				$payid = 27;
    			break;
    			case 'QQPAY':
    				$payid = 28;
    			break;
    			default:
    				$payid = 24;
    			break;
    		}
    		// 获取channelid accessType
    		foreach($channels as $key=>$val){
    			if($val['payid']==$payid){
    				$channelid=$val['id'];
    				$accessType=$val['accesstype'];
    				break;
    			}
    		}
    		
    	}else {
    		$payid = channel($channelid,'payid');
    		$accessType = channel($channelid,'accessType');
    	}
    	
    	$channel['payid'] = $payid;
    	$channel['channelid'] = $channelid;
    	$channel['accessType'] = $accessType;
    	return $channel;
    }
    
    // 添加订单信息
    private function addorder($channel){
    	$data = I('get.');
    	// 查找产品信息
    	$good = M('Goodlist')->where(array('userid'=>$data['userid'],'linkid'=>$data['goodlinkid']))->find();
    	if (!$good) {
    		$this->error('产品信息错误！');
    	}
    	$quantity = I('get.quantity/d',0);
    	if (empty($quantity) || $quantity<1) {
    		$this->error('数量不能为空');
    	}
    	$discount = $this->discount($good['id'], $good['price'], $good['is_discount']);
    	$order = array(
    			'goodid'=>$good['id'],
    			'userid'=>$good['userid'],
    			'orderid'=>strtoupper(substr(hi_md5(NOW_TIME.$data['userid'].mt_rand(100000,999999)),8,16)),
    			'price'=>$discount['danjia'],
    			'quantity'=>$good['limit_quantity'] == 0 ?$quantity:$good['limit_quantity'],
    			'channelid'=>$channel['channelid'],
    			'contact'=>$data['contact'],
    			'addtime'=>date('Y-m-d H:i:s'),
    			'is_email'=>empty($data['is_email'])?0:$data['is_email'],
    			'email'=>$data['email'],
    			'cbprice' => $good['cbprice'],
    			'fromip' => $_SERVER["REMOTE_ADDR"].":".$_SERVER['REMOTE_PORT'],
    			'is_api' => $good['is_api'],
    			'api_username' => empty($data['api_username'])?0:$data['api_username'],
    			'is_discount_state'=>$discount['is_discount_state'],
    			'is_coupon_state'=>$discount['is_coupon_state'],
    	);
    	$find = M('Orders')->where(array('orderid'=>$order['orderid']))->find();
    	if (!$find) {
    		$orders = M('Orders')->add($order);
    	}else {
    		unset($order['orderid']);
    		$orders = M('Orders')->where(array('orderid'=>$data['orderid']))->save($order);
    		$order['orderid'] = $data['orderid'];
    	}
    	
    	
    	if (!$orders) {
    		$this->error('订单错误');
    	}
    	// 渠道优惠率赋值
    	$this->rate = $this->getrate($good['id'], $data['userid'], $good['cateid'], $channel['channelid']);
    	
    	$this->paymoney = number_format($order['price']*$order['quantity']/$this->rate*100-$discount['price'],2,'.','');
    	// 充值卡取整
    	if ($data['paytype'] == 'chongzhika') {
    		$this->paymoney = ceil($this->paymoney);
    	}
    	// 添加订单详情
    	$this->addorderlist($channel, $order, $discount);
    	
    	return $order;
    }
    // 添加订单详情
    private function addorderlist($channel,$orders,$discount){
    	$data = I('get.');
    	
    // 添加折扣付款信息
    	if ($discount['is_coupon_state'] == 1) {
    		$coupon = array(
    				'orderid'=>$orders['orderid'],
    				'money'=>$discount['price'],
    				'realmoney'=>$discount['price'],
    				'is_state'=>1,
    				'is_pay'=>1,
    				'rates'=>100,
    				'addtime'=>date('Y-m-d H:i:s'),
    		);
    		$find = M('Orderlist')->where(array('orderid'=>$orders['orderid'],'channelid'=>0))->find();
    		if (!$find) {
    			M('Orderlist')->add($coupon);
    		}else{
    			M('Orderlist')->where(array('orderid'=>$orders['orderid'],'channelid'=>0))->save($coupon);
    		}
    		
    		
    		
    	}
    	// 非充值卡支付
    	if ($data['paytype'] == 'wangying' || $data['paytype'] == 'QQpay' || $data['paytype'] == 'zhifubao' || $data['paytype'] == 'wechat' || $data['paytype'] == 'caifutong') {
    		$payorderid = $this->getOrderNum();
    		$orderlist = array(
    				'orderid'=>$orders['orderid'],
    				'payorderid'=>$payorderid,
    				'money'=>$this->paymoney,
    				'channelid'=>$channel['channelid'],
    				'rates'=>$this->rate,
    				'addtime'=>date('Y-m-d H:i:s'),
    		);
    		$findlist = M('Orderlist')->where(array('orderid'=>$orders['orderid'],'channelid'=>array('neq',0)))->find();
    		if (!$findlist) {
    			M('Orderlist')->add($orderlist);
    		}else {
    			M('Orderlist')->where(array('orderid'=>$orders['orderid'],'channelid'=>array('neq',0)))->save($orderlist);
    		}
    		
    		$url = U('Api/pay/bank_'.$channel['accessType'],array('accessType'=>$channel['accessType'],'price'=>$this->paymoney,'orderid'=>$orders['orderid'],'pid'=>$data['pid']));
    		$this->url = $url;
    		
    	}else {
    		if (count($data['cardvalue']) != count($data['cardnum']) || count($data['cardvalue']) != count($data['cardpwd']) || count($data['cardvalue']) ==0) {
    			$this->error('充值卡不正确');
    		}
    		$cardnums='';
    		$cardpwds='';
    		$cardvalues='';
    		$payorderids='';
    		if($accessType!='ofpay'){
    			foreach ($data['cardvalue'] as $key => $value) {
    				$payorderid=$this->getOrderNum();
    				$find = M('Orderlist')->where(array('orderid'=>$orders['orderid'],'cardnum'=>$data['cardnum'][$key]))->find();
    				if (!$find) {
    					$d = array(
    							'orderid'=>$orders['orderid'],
    							'payorderid'=>$payorderid,
    							'money'=>$value,
    							'rates'=>$this->rate,
    							'cardnum' =>$data['cardnum'][$key],
    							'cardpwd' =>$data['cardpwd'][$key],
    							'channelid' =>$channel['channelid'],
    							'addtime' =>date('Y-m-d H:i:s'),
    					);
    					$r = M('Orderlist')->add($d);
    					$cardnums=$cardnums!='' ? $cardnums.','.$data['cardnum'][$key] : $data['cardnum'][$key];
    					$cardpwds=$cardpwds!='' ? $cardpwds.','.$data['cardpwd'][$key] : $data['cardpwd'][$key];
    					$cardvalues=$cardvalues!='' ? $cardvalues.','.$value : $value;
    					$payorderids=$payorderids!='' ? $payorderids.','.$payorderid : $payorderid;
    				}
    			}
    			$url = U('Api/pay/card_51ka',array('price'=>$this->paymoney,'orderid'=>$orders['orderid'],'pid'=>$data['pid'],'cardvalue'=>$cardvalues,'cardnum'=>$cardnums,'cardpwd'=>$cardpwds,'payorderid'=>$payorderids));
    			
    		}
    		$this->url = $url;
    	}
    }
    
    // 打折
    private function discount($goodid,$price,$is_discount) {
    	$discount = $price;
    	$is_discount_state=0;
    	if ($is_discount == 1) {
    		$info = M('Gooddiscount')->where(array('goodid'=>$goodid))->order('dis_quantity DESC')->find();
    		if ($info) {
    			if($quantity>=$info['dis_quantity'] && $info['dis_quantity']>0){
			    	$discount=$info['dis_price'];
					$is_discount_state=1;
				}
    		}
    	}
    	$data['danjia'] = $discount;
    	$data['price'] = $this->coupon($dicount)['price'];
    	$data['is_discount_state'] = $is_discount_state;
    	$data['is_coupon_state'] = $this->coupon($dicount)['is_coupon_state'];
    	return $data;
    }
    
    // 优惠券
    private function coupon($price) {
    	$data = I('get.');
    	$coupon = $price;
    	$is_coupon_state=0;
    	if (!empty($data['couponcode'])) {
    		$info = M('Goodcoupon')->where(array('couponcode'=>$data['couponcode'],'is_state'=>0,'userid'=>$data['userid']))->find();
    		$cou = $this->checkcode($data['couponcode'], $data['goodlinkid']);
    		if ($cou['status'] == 1) {
    		$is_coupon_state=1;
    		if ($info) {
    			if ($info['ctype'] == 1) {
    				$coupon = $info['coupon'];
    			}else {
    				$coupon=$price*$info['coupon']/100;
    			}
    			// 修改优惠券状态
    			M('Goodcoupon')->where(array('userid'=>$data['userid'],'couponcode'=>$data['couponcode'],'is_state'=>0,))->setField('is_state',1);
    		}
    		}
    	}
    	$data['is_coupon_state'] = $is_coupon_state;
    	$data['price'] = $coupon;
    	return $data;
    }
    // 通道百分比
    private function getrate($goodid,$userid,$cateid,$channelid) {
    	$rate = M("Rates")->where(array('userid'=>$userid))->select();
    	foreach ($rate as $key => $val) {
    		if($goodid && $val['goodid']==$goodid && $val['channelid']==$channelid){
				return $val['rate'];
			}
			if($cateid && $val['cateid']==$cateid && $val['channelid']==$channelid){
				return $val['rate'];
			}
			if($val['goodid']==0 && $val['cateid']==0 && $val['channelid']==$channelid){
				return $val['rate'];
			}
    	}
    	
    	return 100;
    }
    
    // 获取支付卡面额
    public function getpayprice(){
    	if (!IS_AJAX) {
    		$this->error('错误请求');
    	}
    	$id = I('post.id/d');
    	if (!$id) {
    		$this->error('参数错误');
    	}
    	$payid = channel($id,'payid');
    	$price = str2arr(pay($payid,'payprice'), '|');
    	foreach ($price as $key => $value) {
    		$op .='<option value="'.$value.'">'.$value.'元面值</option>';
    	}
    	echo $op;
    }
    // 用户合作协议
    public function userread(){
    	$this->display();
    }
    
    // 检查优惠券
    public function checkcode($code,$linkid){
    	
    	$code = empty(I('post.code'))?$code:I('post.code');
    	$linkid = empty(I('post.linkid'))?$linkid:I('post.linkid');
    	// 对比商品信息
    	$good = M('Goodlist')->where(array('linkid'=>$linkid,'is_state'=>1,'is_coupon'=>1))->find();
    	if (!$good) {
    		$data = array(
    				'status'=>0,
    				'info'=>'商品信息错误',
    		);
    		$this->ajaxReturn($data);
    	}
    	// 查找优惠券
    	$coupon = M('Goodcoupon')->where(array('couponcode'=>$code,'is_state'=>0))->find();
    	if (!$coupon) {
    		$data = array(
    				'status'=>0,
    				'info'=>'优惠券不存在',
    		);
    		if(IS_AJAX){
    			$this->ajaxReturn($data);
    		}
    		return $data;
    	}
    	
    	if (date('Y-m-d',strtotime("-".$coupon['valid']." day")) > len($coupon['addtime'], 10,'')) {
    		$data = array(
    				'status'=>0,
    				'info'=>'优惠券已过期',
    		);
    		if(IS_AJAX){
    			$this->ajaxReturn($data);
    		}
    		return $data;
    	}
    	
    	// 比较优惠券是否属于商品
    	if (($coupon['cateid'] != 0 && $coupon['cateid'] != $good['cateid']) || $coupon['userid'] != $good['userid']) {
    		$data = array(
    				'status'=>0,
    				'info'=>'优惠券信息不正确',
    		);
    		if(IS_AJAX){
    			$this->ajaxReturn($data);
    		}
    		return $data;
    	}
    	
    	$data = array(
    			'status'=>1,
    			'info'=>'优惠券可使用',
    			'price'=>$coupon['coupon'],
    			'ctype'=>$coupon['ctype'],
    	);
    	if(IS_AJAX){
    			$this->ajaxReturn($data);
    		}
    		return $data;
    }
    
    //随机订单ID
    private function getOrderNum(){
    	$y=date('Y');
		$m=date('m');
		$d=date('d');
		$h=date('H');
		$i=date('i');
		$s=date('s');
		$r=mt_rand(100000,999999);
		return $y.$m.$d.$h.$i.$s.$r;
	}
	

}
