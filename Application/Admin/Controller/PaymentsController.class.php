<?php
// +----------------------------------------------------------------------
// | hicms | 商户管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenj 
// +----------------------------------------------------------------------
namespace Admin\Controller;
class PaymentsController extends AdminController {
    /* 商户结算*/
	public function index() {
		
		// 用户名|手机|邮箱
		if ( isset($_GET['username']) ) {
			$verify = new \Libs\Verify();
			if($verify::isMobile(I('username'))){
				$map1['tel'] = array('like','%'.I('username').'%');
			}else if($verify::isEmail(I('username'))){
				$map1['email'] = array('like','%'.I('username').'%');
			}else{
				$map1['username'] = array('like','%'.I('username').'%');
			}
			$uid = M('Users')->where($map1)->getField('id',true);
			if (!empty($uid)) {
				$map['userid'] = array('in',$uid);
			}
		}
		if (!empty(I('get.start_date'))) {
		    $map['updatetime'][] = array('egt',I('get.start_date'));
		    $this->assign("start_date",I('get.start_date'));
		}
		if (!empty(I('get.end_date'))) {
		    $map['updatetime'][] = array('elt',I('get.end_date').' 24:00:00');
		    $this->assign("end_date",I('get.end_date'));
		}
		
		if(empty(I('get.start_date')) && empty(I('get.end_date')) && empty(I('get.userid')) && empty(I('get.is_state')) && empty(I('get.username'))){
		    $map['updatetime']= array('like',date("Y-m-d")."%");
		    $this->assign("start_date",date("Y-m-d"));
		    $this->assign("end_date",date("Y-m-d"));
		}
		
		
		if (!empty(I('get.userid'))) {
			$map['userid'] = I('get.userid');
		}
		//dump($map);
		
		$list = $this->lists('Payments',$map,'updatetime desc');
		foreach ($list as $key => $value) {
			$ptype = userinfo($value['userid'],'ptype');
			if ($ptype == 1) {
				$list[$key]['ptypetext'] = userinfo($value['userid'],'bank');
			}else {
				$list[$key]['ptypetext'] = get_ptype(userinfo($value['userid'],'ptype'));
			}
			$list[$key]['realmoney'] = $value['money']-$value['fee'];
		}
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		
		$this->assign('list', $list);
		$this->assign('title',$title?$title:'结算记录');
		$this->assign('meta_title', '结算记录');
		$this->display();
	}
	
	public function changeDate(){
	    $list = M('Payments')->select();
	    foreach ($list as $k=>$v){
	        $date = date('Y-m-d H:i:s', $v['updatetime']);
	        M('Payments')->where(array('id'=>$v['id']))->setField("updatetime",$date);
	        dump($date);
	    }
	}
}
