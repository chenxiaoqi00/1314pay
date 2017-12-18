<?php
// +----------------------------------------------------------------------
// | hicms | 日志管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class LogController extends AdminController {
    // 后台管理操作日志
    public function index(){
        $uid = I('get.uid');
        $start_date = I('get.start_date');
        $end_date = I('get.end_date');
        $ip = ip2long(I('get.ip'));
        $status = I('get.status');
        $map = array();
        if (!empty($uid)) {
            $map['uid'] = array('eq', $uid);
        }
        if (!empty($start_date)) {
            $map['time'][] = array('egt',strtotime($start_date));
        }
        if (!empty($end_date)) {
            $map['time'][] = array('elt',24*60*60 + strtotime($end_date));
        }
        if (!empty($ip)) {
            $map['ip'] = array('eq', $ip);
        }
        // 状态
        if ($status != '') {
            $map['status'] = $status;
        }
        $list = $this->lists('LogAdmin',$map);
        $this->assign("list", $list);
        $this->display();
    }

    // 后台登陆日志
    public function login(){
        $start_date = I('get.start_date');
        $end_date = I('get.end_date');
        $ip = ip2long(I('get.ip'));
        $username = I('get.username');
        $status = I('get.status');
        $map = array();
        if (!empty($username)) {
            $map['username'] = array('eq', $username);
        }
        if (!empty($start_date)) {
            $map['time'][] = array('egt',strtotime($start_date));
        }
        if (!empty($end_date)) {
            $map['time'][] = array('elt',24*60*60 + strtotime($end_date));
        }
        if (!empty($ip)) {
            $map['ip'] = array('eq', $ip);
        }
        // 状态
        if ($status != '') {
            $map['status'] = $status;
        }
        $list = $this->lists('LogLogin',$map);
        $this->assign("list", $list);
        $this->display();
    }
	
    //用户日志
    public function loglists(){
    	$map = array();
    	// 关键词
    	if(isset($title)){
    		$map['title'] = array('like', '%'.(string)$title.'%');
    	}
    	// 开始时间
    	if ( isset($_GET['start_date']) ) {
    		$map['logtime'][] = array('egt',I('start_date'));
    	}
    	// 结束时间
    	if ( isset($_GET['end_date']) ) {
    		$map['logtime'][] = array('elt',I('end_date'));
    	}
    	// 用户名|手机|邮箱
    	if ( isset($_GET['username']) ) {
    		$verify = new \Libs\Verify();
    		if($verify::isMobile(I('username'))){
    			$map['userid'] = M('Users')->where(array('tel'=>array('like','%'.I('username').'%')))->getField('id');
    		}else if($verify::isEmail(I('username'))){
    			$map['userid'] = M('Users')->where(array('email'=>array('like','%'.I('username').'%')))->getField('id');
    		}else{
    			$map['userid'] = M('Users')->where(array('username'=>array('like','%'.I('username').'%')))->getField('id');
    		}
    	}
    	$list = $this->lists('Userlogs', $map, 'id desc');
    	foreach ($list as $key => $value) {
    		$list[$key]['username'] = M('Users')->where(array('id'=>$value['userid']))->getField('username');
    	}
    
    	// 记录当前列表页的cookie
    	Cookie('__forward__',$_SERVER['REQUEST_URI']);
    
    	$this->assign('list', $list);
    	$this->assign('title',$title?$title:'登录日志');
    	$this->assign('meta_title', $catid ? '登录日志 - '.category($catid, 'title') : '登录日志管理');
    	$this->display();
    }
}