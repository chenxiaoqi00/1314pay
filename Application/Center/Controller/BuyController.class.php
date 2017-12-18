<?php
// +----------------------------------------------------------------------
// | hicms | 交易记录
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
use Think\Controller;
class BuyController extends CenterBaseController {
    // 统计出售卡信息
	public function cardlist() {
    	$this->display();
    }
    // 统计出售订单信息
    Public function orderlist() {
    	$map['userid'] = UID;
    	$list = $this->lists('Orders',$map,'addtime desc');
    	foreach ($list as $key => $value) {
    		// 获取商品名称
    		$list[$key]['goodname'] = good($value['goodid'],'goodname');
    		// 获取商品支付方式
    		$list[$key]['channelname'] = channel($value['channelid'],'channelname');
    	}
    	$this->assign('list',$list);
    	$this->display();
    }
}