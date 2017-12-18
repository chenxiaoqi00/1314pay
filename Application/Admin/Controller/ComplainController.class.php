<?php
// +----------------------------------------------------------------------
// | hicms | 日志管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class ComplainController extends AdminController {
    
    public function index(){
        $map = array();
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
       // 开始时间
        if ( $_GET['start_date'] ) {
            $map['addtime'][] = array('egt',I('start_date'));
        }
        // 结束时间
        if ( $_GET['end_date']) {
            $map['addtime'][] = array('elt',I('end_date').' 24:00:00');
        }
        // 举报原因
        if ( $_GET['reason']) {
            $map['reason'] = I('reason');
        }
        
        // 被投诉商家
        if ( $_GET['username'] ) {
            $userid =   M('users')->where(array("username"=>$_GET['username']))->getField("id");
            $map['userid'] =$userid;
        }
        $list = $this->lists('complain', $map, 'id desc');
        foreach($list as $k=>$v){
            $users = M("users")->where(array("id"=>$v['userid']))->field("username,tel,qq,email")->find();
            $list[$k]['username'] = $users['username'];
            $list[$k]['tel'] = $users['tel'];
            $list[$k]['qq'] = $users['qq'];
            $list[$k]['email'] = $users['email'];
            $list[$k]['is_status'] = M("orders")->where(array("orderid"=>$v['orderid']))->getField("is_status");
        }
        $this->assign("list",$list);
        $this->display();
    }
    
    public function changeState(){
        $id=I("get.id");
        M("complain")->where(array("id"=>$id))->setField("is_state",0);
    }

}