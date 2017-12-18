<?php
namespace Home\Controller;

class OrdersController extends HomeController {
    
    public function index(){
        $this->assign('meta_title',"订单查询");
        if(IS_AJAX){
            $contact = trim(I("get.contact"));
            $orderid = trim(I("get.orderid"));
            $p = I("get.p")?I("get.p"):1;
            if($contact !== ""){
                $listRows = 10;
                $list =  D('Orders')->ordersByContact($contact,$p,$listRows);
                if($list){
                    $total = M('Orders')->where(array("contact"=>$contact))->count();
                    $this->getPage($total,$listRows);
                    $this->assign('list', $list);
                    $content = $this->fetch("contact");
                    $resoult=array("status"=>1,"data"=>$content);
                    $this->ajaxReturn($resoult);
                }else{
                    $this->error("查无此单！");
                }
            
            }else if($orderid !== ""){
                $orderList =  D('Orders')->ordersByOrderid($orderid);
                if($orderList){
                    $this->orderListToorder($orderList);
                    $content = $this->fetch("orderid");
                    $resoult=array("status"=>1,"data"=>$content);
                    $this->ajaxReturn($resoult);
                }else{
                    $this->error("查无此单！");
                }
              
            }
        }else{
            $this->display();
        }
    }
    
    public function getPage($total,$listRows){
        $listRows = 10;
        $page = new \Think\Page($total, $listRows, $REQUEST);
        if($total>$listRows){
            $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        }
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
    }
    
    
    // 用于支付完后的跳转路径
    public function order(){
    	if (!empty(I('get.orderno'))){
    		$orderno = I('get.orderno');
    	}
    	if (!empty(I('get.ordernumber'))){
    		$orderno = I('get.ordernumber');
    	}
    	if (!empty(I('get.sdcustomno'))){
    		$orderno = I('get.sdcustomno');
    	}
    	
        $orderid = empty($orderno) ? trim(I("get.orderid")):$orderno;
        $orderList =  D('Orders')->ordersByOrderid($orderid);
        if($orderList){
            $this->orderListToorder($orderList);
        } else{
            $this->error("查无此单！");
        }
        $this->assign('card',$this->getCardnum($orderid, $order['is_receive'],  $order['goodid'], $order['quantity']));
//         $this->assign('order', $order);
        $content = $this->fetch("orderid");
        $this->assign('content', $content);
        $this->display("index");
    }
    
    public function orderListToorder($orderList){
        $order['orderid'] =$orderList[0]['orderid'];
        $order['money'] =$orderList[0]['money'];
        $order['realmoney'] =$orderList[0]['realmoney'];
        $order['is_pay'] =$orderList[0]['is_pay'];
        $order['channelname'] =$orderList[0]['channelname'];
        $order['addtime'] =$orderList[0]['addtime'];
        $order['paytime'] =$orderList[0]['paytime'];
        $order['userid'] =$orderList[0]['userid'];
        $card = array();
        foreach($orderList as $k=>$v){
            $card[$k]['cardnum'] = $v['cardnum'];
            $card[$k]['cardpwd'] = $v['cardpwd'];
        }
        $order["now_time"] = date('y-m-d h:i:s',time());
        $this->assign('order', $order);
        $this->assign('card', $card);
        
    }
    
    
    
 	/**
 	 * 获取卡密
 	 * @param unknown $orderids
 	 */
    private function getCardnum($orderids,$recive,$goodid,$quantity){
    	if (empty($orderids)) {
    		return '';
    	}
    	// 已读取过卡
    	if ($recive == 1) {
    		
    		$map['orderid'] = $orderids;
    		
    		$cardid = M('Selllist')->where($map)->getField('cardid');
    		$goods = M('Goods')->where(array('id'=>array('in',$cardid)))->field('id,cardnum,cardpwd')->select();
    	}
    	// 未读取过卡
    	if ($recive == 0) {
    		$kucun = M('Goods')->where(array('goodid'=>$goodid,'is_state'=>0))->count();
    		if ($kucun<$quantity) {
    			$this->error('当前商品库存不组足，请联系客服');
    			exit();
    		}else {
    			$goods = M('Goods')->where(array('goodid'=>$goodid,'is_state'=>0))->field('id,cardnum,cardpwd')->limit($quantity)->select();
    			foreach ($goods as $key => $value) {
    				$cardid[] = $value['id'];
    				$data[] = array(
    						'orderid'=>$orderids,
    						'cardid'=>$value['id'],
    						'addtime'=>date("Y-m-d H:i:s")
    				);
    			}
    			$up = M('Goods')->where(array('id'=>array('in',$cardid)))->save(array('is_state'=>1,'updatetime'=>date("Y-m-d H:i:s")));
    			$inst = M('Selllist')->addAll($data);
    		}
    	}
    	return $goods;
    }
}
