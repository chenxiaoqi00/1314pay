<?php
// +----------------------------------------------------------------------
// | hicms | 商户管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenj 
// +----------------------------------------------------------------------
namespace Admin\Controller;
class RecycleController extends AdminController {
    /* 商户列表*/
	public function business() {
	    $map['status'] = -1;
		$list = $this->lists('Users', $map, 'id desc',true,true,true);
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->assign('list', $list);
		$this->assign('meta_title', '回收站-商户信息');
		$this->display();
	}
	

}
