<?php
namespace Center\Controller;

class ComplainController extends CenterBaseController {
   
    //投诉页面
    public function index(){
        $map['userid'] = UID;
        // 开始时间
        if ( $_GET['start_date'] ) {
            $map['addtime'][] = array('egt',I('start_date'));
        }
        // 结束时间
        if ( $_GET['end_date']) {
            $map['addtime'][] = array('elt',I('end_date').' 24:00:00');
        }
        
        // 商家状态
        $is_agree = I('get.is_agree');
        if((int)$is_agree >=0 && $is_agree!==""){
            $map['is_agree'] = $is_agree;
            $this->assign("is_agree",$is_agree);
        }
        // 平台状态
        $is_state = I('get.is_state');
        if((int)$is_state >=0 && $is_state!==""){
            $map['is_state'] = $is_state;
            $this->assign("is_state",$is_state);
        }
        
        // 举报原因
        if ( $_GET['reason']) {
            $map['reason'] = I('reason');
        }
        //订单号
        if ( $_GET['orderid'] ) {
            $map['orderid'] = I('orderid');
        }
        
        $complainOrders = M('complain')->where($map)->order('addtime desc')->select();
     //   dump($complainOrders);
        $this->assign("complainOrders",$complainOrders);
        $this->display();
    }
    
    //同意还是拒绝退款
    public function refund(){
        $isagree = I("post.isagree");
        $map['orderid'] = I("post.orderid");
        $is = M('complain')->where($map)->setField('is_agree',$isagree);
        if($is){
            $this->success("成功，我们将尽快为您处理");
        }else{
            $this->success("处理失败");
        }
    }
    
}