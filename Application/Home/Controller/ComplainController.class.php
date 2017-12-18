<?php
namespace Home\Controller;

class ComplainController extends HomeController {
   
    //投诉页面
    public function index(){
    /*    $userid=I("get.userid");
       $this->assign("userid",$userid);
       $content = $this->fetch("complain");
       $resoult=array("status"=>1,"data"=>$content);
       $this->ajaxReturn($resoult); */
        $this->display();
       
    }
    
    public function complaint(){
        $complainContent=I("POST.");
        $orderid = trim($complainContent['orderid']);
        $userid = trim($complainContent['userid']);
        if(!$orderid && !$userid){
            $this->error("请填写订单号！");
        }
        if($orderid){
          
            $isComplain = M('complain')->where(array("orderid"=>$orderid))->find();
            if($isComplain){
                $this->error("该订单已投诉，平台将尽快为您处理，请耐心等待！");
            }else{
                $orders = M("orders")->where(array("orderid"=>$orderid,"is_status"=>1))->find();
                if($orders){
                    $complainContent['userid']=$orders['userid'];
                    $complainContent['channelid']=$orders['channelid'];
                    $complainContent['ordertime']=$orders['addtime'];
                    $orderlist =  M("orderlist")->where(array("orderid"=>$orderid))->field("realmoney,price")->find();
                    $complainContent['fee'] = $orderlist['realmoney']*(1-$orderlist['price']);
                    $complainContent['money'] = $orderlist['realmoney'];
                    $complainContent['price'] = $orderlist['price'];
                }else{
                    $this->error("请填写正确的订购单号,如对商家进行投诉,则无需填写点单号");
                }
            }
            
        }else{
            $complainContent['userid']=$userid;
        }
        
        $complainContent['is_state'] = 0;
        $complainContent['addtime'] = date('Y-m-d H:i:s');
        $resoult=M("complain")->add($complainContent);
        $resoult? $this->success("投诉成功！"):$this->error("投诉失败！");
//         $this->ajaxReturn($resoult);
    }
}