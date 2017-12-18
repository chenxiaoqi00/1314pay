<?php

namespace Api\Controller;

class ReceiveController extends HibaseController {
	private $userid = null;
	private $userkey = null;
	private $bankcode = null;
	
	private $order = null;
	private $channelid = null;
	
	// 网银支付返回
	public function bank_51ka() {
		$this->getuserid();
		$signStr='mercid='.$this->userid.'&code='.I('get.code').'&myorderno='.I('get.myorderno').'&orderamount='.I('get.orderamount').'&orderno='.I('get.orderno').'&ordertime='.I('get.ordertime').'&signtype='.I('get.signtype').'&version='.I('get.version').'&notifytype='.I('get.notifytype').'&bankseqno='.I('get.bankseqno').'&merckey='.$this->userkey;
		$rsign=strtolower(md5($signStr));
		
		if (I('get.sign') == $rsign) {
			echo '支付成功';
			if (I('get.code') == 1) {
				$ob=$this->updateOrderlist(I('get.orderno'),I('get.orderamount')); 
			}
			
		}else {
			echo '支付失败';
		}
		
	}
	
	// 财付通支付返回
	public function bank_tenpay() {
		$access = M('Accessprovider')->where(array('accessType'=>I('get.pid')))->find();
		$signStr= sprintf("partner=%s&ordernumber=%s&orderstatus=%s&paymoney=%s%s", $access['accessid'],I('get.ordernumber'), I('get.orderstatus'), I('get.paymoney'),  $access['accesskey']);
		$rsign=md5($signStr);
	
		if (I('get.sign') == $rsign) {
			echo '支付成功';
			$ob=$this->updateOrderlist(I('get.ordernumber'),I('get.paymoney'));
		}else {
			echo '支付失败';
		}
	
	}
	
	// QQ支付返回
	public function bank_qqpay() {
		
		$signStr= sprintf("partner=%s&ordernumber=%s&orderstatus=%s&paymoney=%s%s", '17471', I('get.ordernumber'), I('get.orderstatus'), I('get.paymoney'), '7ddf71934218628eb21d236373f211a1');
		$rsign=md5($signStr);
		
		if (I('get.sign') == $rsign) {
			
			echo '支付成功';
			
			$ob=$this->updateOrderlist(I('get.ordernumber'),I('get.paymoney'));
			
			
		}else {
			echo '支付失败';
		}
	
	}
	// 充值卡支付
	public function card_51ka() {
		$data = I('get.');
		$key = $this->getuserid();
		$rsign=strtolower(md5('mercid='.$this->userid.'&code='.$data['code'].'&myorderno='.$data['myorderno'].'&money='.$data['money'].'&realamount='.$data['realamount'].'&orderno='.$data['orderno'].'&cardstatus='.$data['cardstatus'].'&merckey='.$this->userkey));
		
		if (I('get.sign') == $rsign) {
			echo '支付成功';
			if ($data['code'] == 1&& $data['cardstatus']==1) {
				$ob=$this->updateOrderlistforcard(I('get.orderno'),I('get.ordermoney'),I('get.realamount'),I('get.spread'));
			}
			
		}else {
			echo '支付失败';
		}
	
	}
	// 51支付宝支付
	public function alipay_51ka(){
		$data = I('get.');
		
		if(empty($data['state']) or empty($data['sign']) or empty($data['resign']))
		{
			echo '<result>0</result>';
			exit;
		}
		$access = M ( 'Accessprovider' )->where ( array (
				'accessType' => '51ka'
		) )->find ();
		if (!check_wap()) {
			$makeSign=strtoupper(md5('customerid='.$data['customerid'].'&sd51no='.$data['sd51no'].'&sdcustomno='.$data['sdcustomno'].'&key='.$access['accesskey']));
		}else {
			$makeSign=strtoupper(md5('customerid='.$data['customerid'].'&sd51no='.$data['sd51no'].'&sdcustomno='.$data['sdcustomno'].'&mark='.$data['mark'].'&key='.$access['accesskey']));
		}
		
		$makeReSign=strtoupper(md5('sign='.$makeSign.'&customerid='.$data['customerid'].'&ordermoney='.$data['ordermoney'].'&sd51no='.$data['sd51no'].'&state='.$data['state'].'&key='.$access['accesskey']));
		
		echo "<result>1</result>";
		
		if($data['sign']==$makeSign && $data['resign']==$makeReSign)
		{
			if($data['state']==='1')
			{
				echo '支付成功';
					
				$this->updateOrderlist($data['sdcustomno'],$data['ordermoney']);
			}else {
				echo '支付失败';
			}
		}else {
				echo '支付失败';
			}
	}
	
	// 51微信支付
	public function wxpay_51ka(){
		$data = I('get.');
		if(empty($data['state']) or empty($data['sign']) or empty($data['resign']))
		{
			echo '<result>0</result>';
			exit;
		}
		$access = M ( 'Accessprovider' )->where ( array (
				'accessType' => '51ka'
		) )->find ();
		
		$makeSign=strtoupper(md5('customerid='.$data['customerid'].'&sd51no='.$data['sd51no'].'&sdcustomno='.$data['sdcustomno'].'&mark='.$data['mark'].'&key='.$access['accesskey']));
		
	
		$makeReSign=strtoupper(md5('sign='.$makeSign.'&customerid='.$data['customerid'].'&ordermoney='.$data['ordermoney'].'&sd51no='.$data['sd51no'].'&state='.$data['state'].'&key='.$access['accesskey']));
	
		echo "<result>1</result>";
	
		if($data['sign']==$makeSign && $data['resign']==$makeReSign)
		{
			if($data['state']==='1')
			{
				echo '支付成功';
					
				$this->updateOrderlist($data['sdcustomno'],$data['ordermoney']);
			}else {
				echo '支付失败';
			}
		}else {
			echo '支付失败';
		}
	}
	
	// 充值卡支付返回
// 	public function card_51ka() {
// 		$data = I('get.');
// 		foreach ($data as $key => $value) {
// 			if ($value == '') {
// 				echo '参数信息错误';
// 				exit();
// 			}
// 		}
// 		$access = M('Accessprovider')->where(array('accessType'=>I('get.pid')))->find();
// 		$rsign=strtoupper(md5('customerid='.$access ['accessid'].'&sd51no='.$data['sd51no'].'&sdcustomno='.$data['sdcustomno'].'&mark='.$data['mark'].'&key='.$access['accesskey']));
	
// 		if (I('get.sign') == $rsign) {
// 			echo '支付成功';
// 			$ob=$this->updateOrderlistforcard(I('get.sdcustomno'),I('get.ordermoney'),I('get.cardnums'),I('get.ordermoneys'));
// 		}else {
// 			echo '支付失败';
// 		}
	
// 	}
	
	// 获取userid和userkey
	private function getuserid() {
		$has = M ( 'Accessprovider' )->where ( array (
				'accessType' => 'wxpay' 
		) )->find ();
		if ($has) {
			$this->userid = '10002067';
			$this->userkey = 'f3357d1a9af0105ecd30bb3c7c0c90fb6c91367fb4b1adc7';
		}
	}
	// 获取订单信息
	private function getOrder($orderid){
		$orderid = strlen($orderid)==20 ? substr($orderid,0,16) : $orderid;
		$order = M('Orders')->where(array('orderid'=>$orderid,'is_status'=>0,'quantity'=>array('neq',0)))->find();
		if ($order) {
			$this->order = $order;
		}else {
			$this->error('订单错误');
		}
		
	}
	// 更新订单
	private function updateOrderlist($orderid,$realmoney) {
		
		$this->getOrder($orderid);
		$res = M('Orderlist')->where(array('orderid'=>$orderid,'is_state'=>0,'channelid'=>array('neq',0),'payorderid'=>array('neq','')))->save(array('is_state'=>1,'realmoney'=>$realmoney));
			
 		if ($res) {
			$this->getChannelid($this->order['orderid']);
 			$this->updatePrice();
			$this->updateStatus();
 			$this->updateusermoney();
 		}
		
	}
	
	// 更新订单
	private function updateOrderlistforcard($orderid,$ordermoney,$ordermoneys,$payorderid) {
	
		$this->getOrder($orderid);
		$map = array(
				'orderid'=>$orderid,
				'money'=>$ordermoneys,
				'is_state'=>0,
				'channelid'=>array('neq',0),
		);
		
		if (!empty($payordrerid)) {
			$map['payorderid'] = $payorderid;
		}else{
			$map['payorderid'] = array('neq','');
		}
		$res = M('Orderlist')->where($map)->save(array('is_state'=>1,'realmoney'=>$ordermoneys));
		
		if ($res) {
			$this->getChannelid($this->order['orderid'],$payorderid);
			$this->updatePrice($payorderid);
			$this->updateStatus($payorderid);
			$this->updateusermoney($payorderid);
		}
		
	}
	
	// 保存orderlist价格
	private function updatePrice($payorderid=''){
			$map = array('orderid'=>$this->order['orderid'],'channelid'=>array('neq',''));
			if (!empty($payorderid)) {
				$map['payorderid'] = $payorderid;
			}else{
				$map['payorderid'] = array('neq','');
			}
			$res = M('Orderlist')->where($map)->select();
			foreach ($res as $key => $value) {
				$this->channelid =$value['channelid'];
				$price = $this->getPriceRate();
				M('Orderlist')->where(array('id'=>$value['id']))->save(array('price'=>$price['price'],'platformPrice'=>$price['platformPrice']));
			}
			
	}
	// 修改订单状态
	private function updateStatus($payorderid=''){
		$neworderid=strlen($this->order['orderid'])==20 ? substr($this->order['orderid'],0,16) : $this->order['orderid'];
		$res1 =D('Orderlist')->field('sum(realmoney*rates/100) as realmoney')->where(array('orderid'=>$neworderid))->select();
		$realmoney = number_format($res1[0]['realmoney'],2,'.','');
		$money = number_format($this->order['price']*$this->order['quantity'],2,'.','');
		if ($realmoney == 0) {
			$state = 0;  // 未付款
		}elseif ($realmoney < $money) {
			$state = 2; // 部分付款
		}else {
			$state = 1;
		}
		$data = array(
				'is_status'=>$state,
				'channelid'=>$this->channelid == $this->order['channelid']? $this->channelid :'99999',
				'platformPrice' =>channel($this->channelid,'platformPrice'),
				'updatetime'=>date('Y-m-d H:i:s'),
		);
		$res = M('Orders')->where(array('orderid'=>$this->order['orderid']))->save($data);
	}
	
	// 更新usermoney表
	private function updateusermoney($payorderid=''){
		$map = array('orderid'=>$this->order['orderid'],'is_state'=>1,'channelid'=>array('neq',''));
		if (!empty($payorderid)) {
			$map['payorderid'] = $payorderid;
		}else{
			$map['payorderid'] = array('neq','');
		}
		$res = D('Orderlist')->where($map)->field('sum(realmoney*price) as income,sum(realmoney)')->select();
		$usermoney = M('Usermoney')->where(array('userid'=>$this->order['userid']))->find();
		
		if (!$usermoney) {
			M('Usermoney')->add(array('userid'=>$this->order['userid']));
		}
		$data = array(
				'unpaid' => $usermoney['unpaid'] + $res[0]['income'],
		);
		$add = M('Usermoney')->where(array('userid'=>$this->order['userid']))->save($data);
		
		if (!$add) {
			$this->error('用户结算统计错误');
		}
		M('Orderlist')->where($map)->save(array('is_pay'=>1));
		
	}
	
	// 获取价格
	private function getPriceRate(){
		//get userprice
		$order = $this->order;
		$userprice=M('Userprice')->where(array('userid'=>$order['userid'],'channelid'=>$order['channelid']))->find();
		if($userprice['price'] != 0){
			$data['price'] = $userprice['price'];
		}else {
			$data['price'] = channel($this->channelid,'price');
		}
		//get platformPrice
		$data['platformPrice']=channel($this->channelid,'platformprice');
		return $data;
	}
	
	//获取支付渠道ID
	private function getChannelid($orderid,$payorderid){
		$map['channelid'] =array('neq','');
		$map['orderid']=$orderid;
		if (!empty($payorderid)) {
			$map['payorderid'] = $payorderid;
		}
		$this->channelid = M('Orderlist')->where($map)->getField('channelid');
	}
}