<?php
// +----------------------------------------------------------------------
// | hicms | 个人信息管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class OrdersController extends AdminController {

    //订单查询
    public function index(){
    	$map = array();
    	if (!empty(I('get.start_date'))) {
    		$map['addtime'][] = array('egt',I('get.start_date'));
    		$this->assign("start_date",I('get.start_date'));
    	}
    	if (!empty(I('get.end_date'))) {
    		$map['addtime'][] = array('elt',I('get.end_date').' 24:00:00');
    		$this->assign("end_date",I('get.end_date'));
    	}
    	if(empty(I('get.start_date')) && empty(I('get.end_date'))){
    	    $map['addtime'][] = array('like',date("Y-m-d")."%");
    	    $this->assign("start_date",date("Y-m-d"));
    	    $this->assign("end_date",date("Y-m-d"));
    	}
        if (!empty(I('get.title'))) {
        	$title = I('get.title');
        	$userid = D('Users')->where(array('username'=>array('like','%'.$title.'%')))->getField('id',true);
        	if ($userid) {
        		$where['userid'] = array('in',$userid);
        		$where['orderid'] = array('like','%'.$title.'%');
        		$where['_logic'] = 'or';
        		$map['_complex'] = $where;
        	}else {
        		$map['orderid'] = array('like','%'.$title.'%');
        	}
        }
		$is_ship = I('get.is_ship');
        if ((int)$is_ship >=0 && $is_ship!=="") {
        	$map['is_ship'] = $is_ship;
        	$this->assign('is_ship',$is_ship);
        }
        $is_status = I('get.is_status');
        if ((int)$is_status >=0 && $is_status!=="") {
        	$map['is_status'] = $is_status;
        	$this->assign('is_status',$is_status);
        }
        $channelid = I('get.channelid');
        if(!empty($channelid)){
        	switch ($channelid) {
        		case 999999:
        			$map['is_coupon_state']=1;  // 优惠券
        		break;
        		case 9999999:
        			$map['is_discount_state']=1;  // 批发优惠
        			break;
        		default:
        			$map['channelid'] = $channelid;
        		break;
        	}
        	$this->assign('channelid',$channelid);
        }
        $list = $this->lists('Orders',$map,'addtime desc');
        $this->assign('channels',channellist());
        $this->assign('list',$list);
        $this->display();
    }
    
    //商户分析
    public function useranalyse(){
        
        $username = I('get.title')?"AND username like '%".I('get.title')."%'":"";
        if( isset($REQUEST['r']) ){
            $listRows = (int)$REQUEST['r'];
        }else{
            $listRows = 10;
        }
        $totalSql = "SELECT count(*) as total from (SELECT count(*)  from (hi_orders a LEFT JOIN hi_orderlist b on  a.orderid=b.orderid)LEFT JOIN hi_users as c on a.userid=c.id
                    WHERE is_pay=1 ".$username."  GROUP BY userid) A"; 
        $Model = M();
        $total = $Model->query($totalSql);
        $page = new \Think\Page($total[0]['total'], $listRows,$REQUEST);
        if($total>$listRows){
            $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        }
        $show = $page->show();
        $sql = "SELECT count(*) as pay,username,userid,sum(realmoney*b.price) as price,sum(realmoney*(b.platformPrice-b.price)) as platformPrice ,is_pay,sum(money) as money, sum(realmoney) as realmoney
            from (hi_orders a LEFT JOIN hi_orderlist b on  a.orderid=b.orderid)LEFT JOIN hi_users as c on a.userid=c.id
            WHERE is_pay=1 ".$username." GROUP BY userid ORDER BY realmoney desc limit ".$page->firstRow.",".$page->listRows;
        $userLists = $Model->query($sql);
        foreach($userLists as $k=>$v){
            $userLists[$k]['orders'] = D('Orders')->where(array("userid"=>$v['userid']))->count();
            $userLists[$k]['unpayorders'] = $userLists[$k]['orders']-$v['pay'];
            $userLists[$k]['paid'] = D('usermoney')->where(array("userid"=>$v['userid']))->getField("paid");
            $userLists[$k]['price'] =  round($v['price'],2);
            $userLists[$k]['platformprice'] =  round($v['platformprice'],2);
        }
    	$this->assign('_page',$show);
    	$this->assign('list',$userLists);
        $this->display();
    }
    
    //通道分析
    public function channelanalyse(){
    	$map = array();
    	if (!empty(I('get.start_date'))) {
        	$map['addtime'][] = array('egt',I('get.start_date'));
        }
        if (!empty(I('get.end_date'))) {
        	$map['addtime'][] = array('elt',I('get.end_date').'24:00:00');
        }
        $channelid = I('get.channelid');
        if(!empty($channelid)){
        	switch ($channelid) {
        		case 999999:
        			$map['is_coupon_state']=1;  // 优惠券
        			break;
        		case 9999999:
        			$map['is_discount_state']=1;  // 批发优惠
        			break;
        		default:
        			$map['channelid'] = $channelid;
        			break;
        	}
        	$this->assign('channelid',$channelid);
        }
        if (!empty(I('get.title'))) {
        	$title = I('get.title');
        	$userid = D('Users')->where(array('username'=>array('like','%'.$title.'%')))->getField('id',true);
        	if ($userid) {
        		$map['userid'] = array('in',$userid);
        	}
        }
    	$userid = D('Orders')->where($map)->group('channelid')->field('userid')->select();
    	$total = count($userid);
    	if( isset($REQUEST['r']) ){
    		$listRows = (int)$REQUEST['r'];
    	}else{
    		$listRows = 10;
    	}
    	$page = new \Think\Page($total, $listRows,$REQUEST);
    	if($total>$listRows){
    		$page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
    	}
    	$show = $page->show();
    	$list = D('Orders')->where($map)->group('channelid')->limit($page->firstRow.','.$page->listRows)->select();
    	foreach ($list as $key => $value) {
    		$map['userid'] = $value['userid'];
    		$orderid = D('Orders')->where($map)->getField('orderid',true);
    		$where['orderid'] = array('in',$orderid);
    		$where['is_pay'] = 1;
    		$order = D('Orderlist')->where($where)->field('price,money,realmoney,platformprice,orderid')->select();
    		$list[$key]['username'] = users($value['userid'],'username');
    		$list[$key]['orders'] = count($orderid);
    		$list[$key]['pay'] = count($order);
    		$list[$key]['unpay'] = $list[$key]['orders']-$list[$key]['pay'];
    		$list[$key]['money'] = count_money($order);
    	}
    	$this->assign('channels',channellist());
    	$this->assign('_page',$show);
    	$this->assign('list',$list);
    	$this->display();
    }

    //24分析
    public function houranalyse(){
        $map = array();
        $count =array();
     /*    if (!empty(I('get.title'))) {
        	$title = I('get.title');
        	$userid = D('Users')->where(array('username'=>array('like','%'.$title.'%')))->getField('id',true);
        	if ($userid) {
        		$map['userid'] = array('in',$userid);
        	}
        } */
//         $second = 60*60;
//         if (!empty(I('get.date'))) {
//             $date = strtotime(I('get.date'));
//         }else{
//             $date = strtotime(date('Y-m-d', time()));
//         }
        if (!empty(I('get.date'))) {
        	$date = I('get.date');
        }else {
        	$date = date('Y-m-d');
        }
        
        for($i=0;$i<24;$i++){
//         	$map['addtime'] = null;
//         	$map['addtime'][] = array('egt',$date+($i+0)*$second);
//         	$map['addtime'][] = array('lt',$date+($i+1)*$second);
//         	$list[$i]['id'] = $i.':00~'.($i+1).':00';
//         	dump(times($date+($i+0)*$second));
//         	dump(times($date+($i+1)*$second));
			$map['addtime'] = array();
         	$j = $i+1;
        	if ($i<10){
        		if ($j<10) {
        			$map['addtime'][] = array('egt',$date.' 0'.$i.':00');
        			$map['addtime'][] = array('lt',$date.' 0'.$j.':00');
        			$list[$i]['id'] = '0'.$i.':00~0'.$j.':00';
        		}else {
        			$map['addtime'][] = array('egt',$date.' 0'.$i.':00');
        			$map['addtime'][] = array('lt',$date.' '.$j.':00');
        			$list[$i]['id'] = '0'.$i.':00~'.$j.':00';
        		}
        	}else {
        		$map['addtime'][] = array('egt',$date.' '.$i.':00');
        		$map['addtime'][] = array('lt',$date.' '.$j.':00');
        		$list[$i]['id'] = $i.':00~'.$j.':00';
        	} 
//         	$map = 'addtime like "%2016-08-12%" AND hour(addtime)='.$i;
// dump($map);
        	$orderid = D('Orders')->where($map)->getField('orderid',true);
			if (count($orderid) >=1){
				$where['orderid'] = array('in',$orderid);
				$where['is_pay'] = 1;
				$order = D('Orderlist')->where($where)->field('price,money,realmoney,platformprice,orderid')->select();
				$list[$i]['orders'] = D('Orders')->where($map)->count();
				$list[$i]['pay'] = count($order);
				$list[$i]['unpay'] = $list[$key]['orders']-$list[$key]['pay'];
				$list[$i]['money'] = count_money($order);
			}else {
				$list[$i]['orders'] = 0;
				$list[$i]['pay'] = 0;
				$list[$i]['unpay'] = 0;
				$list[$i]['money'] = 0;
			}
        	$count["orders"] += $list[$i]['orders'];
        	$count["pay"] += $list[$i]['pay'];
        	$count["unpay"] += $list[$i]['unpay'];
        	$count["money"]["money"] += $list[$i]['money']["money"];
        	$count["money"]["realmoney"] += $list[$i]['money']["realmoney"];
        	$count["money"]["price"] += $list[$i]['money']["price"];
        	$count["money"]["platformprice"] += $list[$i]['money']["platformprice"];
        }
        $this->assign("date",$date);
        $this->assign('count',$count);
    	$this->assign('list',$list);
    	$this->display();
    }
}
