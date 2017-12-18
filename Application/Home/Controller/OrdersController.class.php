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
                $order =  D('Orders')->ordersByOrderid($orderid);
                if($order){
                    $order["now_time"] = date('y-m-d h:i:s',time());
                    $this->assign('order', $order);
                    $cards = $this->getCardnum($orderid, $order['is_receive'],  $order['goodid'], $order['quantity']);
                    $this->assign('card',$cards);
                    $content = $this->fetch("orderid");
                    $resoult=array("status"=>1,"data"=>$content);
                    $this->ajaxReturn($resoult);
                }else{
                    $this->error("查无此单！");
                }
              
            }
        }else{
            $this->assign('meta_title', "订单查询");
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
        if(!empty(I('get.contact'))){
            $p = I("get.p")?I("get.p"):1;
            $contact=I('get.contact');
            $listRows = 10;
            $list =  D('Orders')->ordersByContact($contact,$p,$listRows);
            if($list){
                $total = M('Orders')->where(array("contact"=>$contact))->count();
                $this->getPage($total,$listRows);
                $this->assign('list', $list);
                $content = $this->fetch("contact");
            }else{
                $this->error("查无此单！");
            }
        }else{
            if (!empty(I('get.orderno/s'))){
                $orderno = I('get.orderno/s');
            }
            if (!empty(I('get.ordernumber/s'))){
                $orderno = I('get.ordernumber/s');
            }
            if (!empty(I('get.sdcustomno/s'))){
                $orderno = I('get.sdcustomno/s');
            }
             
            $orderid = empty($orderno) ? trim(I("get.orderid")):$orderno;
            $order =  D('Orders')->ordersByOrderid($orderid);
            $order["now_time"] = date('y-m-d h:i:s',time());
            if ($order['quantity']<=0) {
            	$this->error('订单信息错误');
            }
            $cards = $this->getCardnum($orderid, $order['is_receive'],  $order['goodid'], $order['quantity']);
            $this->assign('card',$cards);
            $this->assign('order', $order);
            $content = $this->fetch("orderid");
        }
        $this->assign('meta_title', "订单查询");
        $this->assign('content', $content);
        $this->display("index");
    }
    
 	/**
 	 * 获取卡密
 	 * @param unknown $orderids
 	 */
    private function getCardnum($orderids,$recive,$goodid,$quantity){
    	if (empty($orderids)) {
    		return '';
    	}
    	$ispay = M('Orders')->where(array('orderid'=>$orderids,'is_status'=>1,'quantity'=>array('neq',0)))->find();
    	if (!$ispay) {
    		return '';
    	}
    	if ($quantity<1 || !is_numeric($quantity)) {
    		return '';
    	}
    	// 已读取过卡
    	if ($recive == 1) {
    		$map['orderid'] = $orderids;
    		$cardid = M('Selllist')->where($map)->getField('cardid',true);
    		if ($cardid) {
    			$goods = M('Goods')->where(array('id'=>array('in',$cardid)))->field('id,cardnum,cardpwd')->select();
    		}
    		
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
    			if ($inst) {
    				$map['orderid'] = $orderids;
    				M('Orders')->where($map)->save(array('is_receive'=>1));
    				//成功之后发送邮件
    				$this->sendMail($ispay,$goods);
    			}
    		}
    	}
    	return $goods;
    }
    
    public function sendMail($ispay,$goods){
        $user = users($ispay['userid']);
        $goodName = good($ispay['goodid'],'goodname');
        /*发送给商户的  */
        $useEmail=trim($user['email']);
        
        $goods_mail = $user['goods_mail'];//判断商户是否要发邮件
        
        if($useEmail){
          //  $goodHtml = "";
            foreach ($goods as $k=>$v){
                $goodHtml .= "卡号：". $v['cardnum']."<br/>卡密：".$v['cardpwd']."<br/>";
            }
            
            $title="[商户：".$user['username']."]恭喜您成功出售(".$ispay['quantity']."件)[".$goodName."]！";
            $content="尊敬的用户".$user['username'].",您托管销售的[".$goodName."]商品成功出售！<br/>".
            "出售数量：".$ispay['quantity']."<br/>商品信息：<br/>".$goodHtml.
            "订 单 号：".$ispay['orderid']." <br/>".
            "联系方式：".$user['qq'];
            send_mail($useEmail, $title, $content);
        }
        
        /*发给买者  */
        $payerEmail=trim($ispay['email']);
        if($payerEmail){
            $payerTitle = "1314发卡 恭喜您，[".$goodName."]购买成功！";
            $payerContent= "恭喜您！您的订单已经付款成功，以下是订单详情：<br/>".
            "交易订单号:".$ispay['orderid']."<br/>".
            "商品名称:".$goodName."<br/>".
            "商品数量:".$ispay['quantity']."<br/>".
            "商品单价:".$ispay['price']."<br/>".
            "支付结果:<a href=http://www.1314fk.com/Orders/order.html?orderid=".$ispay['orderid'].">http://www.1314fk.com/Orders/order.html?orderid=".$ispay['orderid']."<br/>".
            "(点击打开以上链接可查看到已成功付款的卡密信息)";
            send_mail($payerEmail, $payerTitle, $payerContent);
        }
   
    }
    
    
    /*判断输入的是订单号还是联系方式  */
    public function orderidOrContact(){
       $number = I('get.number');
       $list = D('Orders')->where(array("orderid"=>$number))->select();
       if($list){
           $this->ajaxReturn("orderid");
       }else{
           $this->ajaxReturn("contact");
       }
    }
}
