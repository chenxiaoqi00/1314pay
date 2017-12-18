<?php
// +----------------------------------------------------------------------
// | hicms | 个人中心首页
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;

use Think\Controller;

class TradeController extends CenterBaseController {
	public function index() {
		// $linkid=M("users")->where(array("id"=>UID))->field("userkey")->find();
		$userlink = M ( "users" )->where ( array ("id" => UID) )->field("userkey, shorturl")->find();
	//	$payUrl = 'http://' . $_SERVER ['HTTP_HOST'] . '/Product/store/linkid/' . $linkid . ".html";
		$payUrl = 'http://' . $_SERVER ['HTTP_HOST'] . '/links/' . $userlink['userkey'] . ".html";
// 		$shortPayUrl = bdUrlAPI(1,$payUrl);
// 		$url='http://suo.im/api.php?url='.$payUrl;
// 		$shortPayUrl = file_get_contents($url);
		$shortPayUrl = 'http://'.$_SERVER['HTTP_HOST'].'/'.$userlink['shorturl'].'.html';
		$this->assign ( "shortPayUrl", $shortPayUrl);
		$this->assign ( "payUrl", $payUrl );
		$this->assign ( "qrUrl", qrcode($payUrl) );
		$this->display ();
	}
	public function channels() {
		$payList = array ();
		$payList = M ( "userprice" )->alias ( 'a' )->join ( "__CHANNELLIST__ b ON a.channelid=b.id", 'LEFT' )->field ( 'a.channelid id,a.price userprice,a.sortid,a.is_state,b.channelname,b.category,b.is_state state,b.price channelprice' )->order ( 'b.category desc,a.id desc' )->where ( array (
				"a.userid" => UID 
		) )->select ();
		foreach ( $payList as $k => $v ) {
			$price = $v ['userprice'] == '0' ? $v ['channelprice'] : $v ['userprice'];
			if ($v ['category'] == "0") {
				$rechargeableCard [$k] = $v;
				$rechargeableCard [$k] ['price'] = ($price * 100) . "%";
			} else {
				$otherPay [$k] = $v;
				$otherPay [$k] ['price'] = ($price * 100) . "%";
			}
		}
		$_rechargeableCard = array (
				"sortid" => $rechargeableCard [5] ['sortid'],
				"channelname" => "充值卡",
				"state" => 1 
		);
		array_push ( $otherPay, $_rechargeableCard );
		$this->assign ( "otherPay", $otherPay );
		$this->assign ( 'rechargeableCard', $rechargeableCard );
		$this->display ();
	}
	public function quick() {
		$channelid = I ( "POST.id" );
		$sortValue = I ( "POST.value" );
		if ($channelid) {
			$resoult = M ( "userprice" )->where ( array (
					"userid" => UID,
					"channelid" => $channelid 
			) )->setField ( "sortid", $sortValue );
		} else {
			$channelids = M ( "channellist" )->where ( array (
					"category" => 0 
			) )->field ( 'id' )->select ();
			$map ["channelid"] = array (
					"in",
					array_column ( $channelids, "id" ) 
			);
			$map ["userid"] = UID;
			$resoult = M ( "userprice" )->where ( $map )->setField ( "sortid", $sortValue );
		}
		
		if ($resoult) {
			$this->success ( "修改成功！" );
		} else {
			$this->error ( "修改失败！" );
		}
	}
	public function changeState() {
		$channelid = I ( "POST.id" );
		$state = I ( "POST.value" ) == "true" ? 1 : 0;
		$msg = I ( "POST.value" ) == "true" ? "打开" : "关闭";
		if ($channelid) {
			$resoult = M ( "userprice" )->where ( array (
					"userid" => UID,
					"channelid" => $channelid 
			) )->setField ( "is_state", $state );
		} else {
			$channelids = M ( "channellist" )->where ( array (
					"category" => 0 
			) )->field ( 'id' )->select ();
			$map ["channelid"] = array (
					"in",
					array_column ( $channelids, "id" ) 
			);
			$map ["userid"] = UID;
			$resoult = M ( "userprice" )->where ( $map )->setField ( "is_state", $state );
		}
		if ($resoult) {
			$this->success ( $msg . "成功！" );
		} else {
			$this->error ( $msg . "失败！" );
		}
	}
	public function invite() {
		$list = invite ();
		if (IS_AJAX) {
			$this->ajaxReturn ( $list );
		} else {
			// $this->assign("invite", $list);
			$this->display ( "invite" );
		}
	}
	// 渠道分析统计
	public function analyforchannel() {
		$start_time = I("get.start_time",date('Y-m-d'))?I("get.start_time",date('Y-m-d')):date("Y-m-d");
		$end_time = I("get.end_time",date('Y-m-d'))?I("get.end_time",date('Y-m-d')):date("Y-m-d");
		//$start_time = I ( "post.start_time", '2017-09-10' );
		//$end_time = I ( "post.end_time", '2017-09-18' );
		// 删选条件
		if ($start_time == $end_time) {
			$map ['addtime'] = array (
					'like',
					'%' . $start_time . '%' 
			);
		} else {
			$map ['addtime'] [] = array (
					'egt',
					$start_time 
			);
			$map ['addtime'] [] = array (
					'lt',
					date ( 'Y-m-d', strtotime ( $end_time ) + 3600 * 24 ) 
			);
		}
		$map ['userid'] = UID;
		
		$order = M ( 'Orders' )->where ( $map )->order ( 'addtime desc' )->select ();
		
		if ($order == null) {
			// 使用的渠道名称
			foreach ( channellist () as $key => $value ) {
				if (in_array($value['id'], array(27,24,20,19,17))) {
					$channelname [] = $value['channelname'];
				}else{
					if (!in_array('支付卡', $channelname)) {
						$channelname [] = '支付卡';
					}
				}
				$data [0] [] = 0;
				$data [1] [] = 0;
				$data [2] [] = 0;
				$data [3] [] = 0;
			}
		}else{
		foreach ( $order as $key => $value ) {
			foreach ( channellist () as $k => $v ) {
				if (!in_array($v['id'], array(17,19,20,24,27))) {
					$v['id'] = 1000;
				}
				if ($v ['id'] == $value ['channelid']) {
					// 订单总数
					$orders [$v ['id']] += 1;
					// 订单总金额
					$price [$v ['id']] += $value ['price'];
					if ($value ['is_status'] == 1) {
						// 成交订单数
						$succ [$v ['id']] += 1;
						// 成交金额
						$succprice [$v ['id']] += $value ['price'];
					} else {
						// 成交订单数
						$succ [$v ['id']] += 0;
						// 成交金额
						$succprice [$v ['id']] += 0;
					}
				}else {
					// 订单总数
					$orders [$v ['id']] += 0;
					// 订单总金额
					$price [$v ['id']] += 0;
					// 成交订单数
					$succ [$v ['id']] += 0;
					// 成交金额
					$succprice [$v ['id']] += 0;
				}
				// 支付通道
				if (! in_array ( $v ['id'], $channels )) {
					$channels [] = $v ['id'];
				}
			}
			
		}
		
		// 使用的渠道名称
		foreach ( $channels as $key => $value ) {
			$name = channel ( $value, 'channelname' );
			if (! empty ( $name )) {
				$channelname [] = $name;
			}
			if ($value == 1000) {
				$channelname [] = '支付卡';
			}
		}
		// 订单总数
		foreach ( $orders as $key => $value ) {
			$data [0] [] = $value;
		}
		// 成功订单总数
		foreach ( $succ as $key => $value ) {
			$data [1] [] = $value;
		}
		// 订单总金额
		foreach ( $price as $key => $value ) {
			$data [2] [] = $value;
		}
		// 成功订单总金额
		foreach ( $succprice as $key => $value ) {
			$data [3] [] = $value;
		}
		}
		//dump($data);
		$this->assign('start_time',$start_time);
		$this->assign('end_time',$end_time);
		$this->assign ( 'data', json_encode ( $data ) );
		$this->assign ( 'channels', json_encode ( $channelname ) );
		$this->display ();
	}
	
	// 订单分析
	public function orders() {
		
		$type = I ( "post.type/d",0 );
		$start = 0;
		$end = 10;
		switch ($type) {
			case 1:
				$map['addtime'][] = array('lt',date ( 'Y-m-d', strtotime('+1 day')));
				$map['addtime'][] = array('egt',date ( 'Y-m-d', strtotime('-15 day')));
				for ($i=0;$i<15;$i++){
					$date[] = date('Y-m-d',strtotime('-'.(14-$i).' day'));
				}
			break;
			case 2:
				$map['addtime'] = array('like',date('Y').'%');
				for ($i=1;$i<13;$i++){
					$date[] = $i;
				}
				$start = 5;
				$end = 2;
			break;
			default:
				$map['addtime'][] = array('lt',date ( 'Y-m-d', strtotime('+1 day')));
			  	$map['addtime'][] = array('egt',date ( 'Y-m-d', strtotime('-1 week')));
			  	for ($i=0;$i<7;$i++){
			  		$date[] = date('Y-m-d',strtotime('-'.(6-$i).' day'));
			  	}
			break;
		}
	
		$map ['userid'] = UID;
		$map['channelid'] = array('neq',0);
		$order = M ( 'Orders' )->where ( $map )->order ( 'addtime desc' )->select ();
		if ($order == null) {
			// 月份
			if ($type == 2) {
				foreach ($date as $key => $value) {
					$date[$key] = $value.'月';
				}
			}
			// 日期
			foreach ( $date as $key => $value ) {
				$data [0] [] = 0;
				$data [1] [] = 0;
				$data [2] [] = 0;
				$data [3] [] = 0;
			}
		}else{
		foreach ( $order as $key => $value ) {
			$time = substr($value['addtime'], $start,$end);
			foreach ($date as $k => $v) {
				if ($time == $v) {
					$orders[$time] += 1;
					$price[$time] += $value ['price'];
					if ($value ['is_status'] == 1) {
						// 成交订单数
						$succ [$time] += 1;
						// 成交金额
						$succprice [$time] += $value ['price'];
					} else {
						// 成交订单数
						$succ [$time] += 0;
						// 成交金额
						$succprice [$time] += 0;
					}
				}else{
					$orders[$v] += 0;
					$price[$v] += 0;
					// 成交订单数
					$succ [$v] += 0;
					// 成交金额
					$succprice [$v] += 0;
				}
				
			}
			
		}
		// 月份
		if ($type == 2) {
			foreach ($date as $key => $value) {
				$date[$key] = $value.'月';
			}
		}
		// 订单总数
		foreach ( $orders as $key => $value ) {
			$data [0] [] = $value;
		}
		
		// 成功订单总数
		foreach ( $succ as $key => $value ) {
			$data [1] [] = $value;
		}
		// 订单总金额
		foreach ( $price as $key => $value ) {
			$data [2] [] = $value;
		}
		// 成功订单总金额
		foreach ( $succprice as $key => $value ) {
			$data [3] [] = $value;
		}
		}
		//dump($data);
		$info['type']=$type;
		$this->assign('info',$info);
		$this->assign('type', array(0=>'近7天',1=>'近15天',2=>'近12月'));
		$this->assign ( 'data', json_encode ( $data ) );
		$this->assign ( 'date', json_encode ( $date ) );
		$this->display ();
	}
	
	// 用户收益统计
	public function analyforuser() {
 		$start_time = I("post.start_time",date('Y-m-d'))?I("post.start_time",date('Y-m-d')):date('Y-m-d');
 		$end_time = I("post.end_time",date('Y-m-d'))?I("post.end_time",date('Y-m-d')):date('Y-m-d');
		//$start_time = I ( "post.start_time", '2017-07-10' );
		//$end_time = I ( "post.end_time", '2017-09-18' );
		// 删选条件
		if ($start_time == $end_time) {
			$map ['addtime'] = array (
					'like',
					'%' . $start_time . '%'
			);
		} else {
			$map ['addtime'] [] = array (
					'egt',
					$start_time
			);
			$map ['addtime'] [] = array (
					'lt',
					date ( 'Y-m-d', strtotime ( $end_time ) + 3600 * 24 )
			);
		}
		$map['channelid'] = array('neq',0);
		$map ['userid'] = UID;
		// 未完成订单
		$map['is_status'] = 0;
		$unsuss = M("Orders")->where($map)->count();
		// 已完成订单
		$map['is_status'] = 1;
		$suss = M("Orders")->where($map)->count();
		
		$order = array(
				0=>array('value'=>$unsuss,'name'=>'未完成订单'),
				1=>array('value'=>$suss,'name'=>'已完成订单'),
		);
		// 收益查询
		$orderid = M("Orders")->where($map)->getField('orderid',true);
		if ($orderid) {
			$money = M("Orderlist")->where(array('orderid'=>array('in',$orderid),'is_pay'=>1))->field('sum(realmoney) as realmoney,sum(realmoney*price) as price')->find();
			$price = array(
					0=>array('value'=>$money['realmoney']-$money['price'],name=>"扣除金额"),
					1=>array('value'=>$money['price'],name=>"实际收益"),
			);
		}else{
			$price = array(
					0=>array('value'=>0,name=>"扣除金额"),
					1=>array('value'=>0,name=>"实际收益"),
			);
		}
		
		$this->assign('start_time',$start_time);
		$this->assign('end_time',$end_time);
		$this->assign('order',json_encode($order));
		$this->assign('price',json_encode($price));
		$this->display();
	}
	
	
	/*交易记录  */
	public function record(){
	    $map = array();
	    $map['userid'] = UID;
	    if (!empty(I('get.start_date'))) {
	        $map['addtime'][] = array('egt',I('get.start_date'));
	    }
	    if (!empty(I('get.end_date'))) {
	        $map['addtime'][] = array('elt',I('get.end_date').' 24:00:00');
	    }
	   if (!empty(I('get.title'))) {
        	$title = I('get.title');
        	$goodid = D('goodlist')->where(array('goodname'=>array('like','%'.$title.'%')))->getField('id',true);
        	if ($goodid) {
        		$where['goodid'] = array('in',$goodid);
        		$where['orderid'] = array('like','%'.$title.'%');
        		$where['_logic'] = 'or';
        		$map['_complex'] = $where;
        	}else {
        		$map['orderid'] = array('like','%'.$title.'%');
        	}
        }
	    /*是否已结算  */
		$is_ship = I('get.is_ship');
        if ((int)$is_ship >=0 && $is_ship!=="") {
        	$map['is_ship'] = $is_ship;
        	$this->assign('is_ship',$is_ship);
        }
	    /*是否已付款  */
	    $is_status = I('get.is_status');
	    if ((int)$is_status >=0 && $is_status!=="") {
	        $map['is_status'] = $is_status;
	        $this->assign('is_status',$is_status);
	    }
	    $list = $this->lists('Orders',$map,'addtime desc');
// 	    dump($list);
	    $this->assign('list',$list);
	  $this->display();
	}
	
	// 删除交易记录
/* 	public function del() {
	    $this->delete("orders");
	} */
}
