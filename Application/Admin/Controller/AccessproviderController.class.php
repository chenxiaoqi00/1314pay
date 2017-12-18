<?php
// +----------------------------------------------------------------------
// | hicms | 商户管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenj 
// +----------------------------------------------------------------------
namespace Admin\Controller;
class AccessproviderController extends AdminController {
    /* 商户结算*/
	public function index() {
		
		$list = $this->lists('Accessprovider');
		
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		
		$this->assign('list', $list);
		$this->assign('title',$title?$title:'接入信息');
		$this->assign('meta_title', '接入信息');
		$this->display();
	}
	
	public function add() {
		if (IS_POST) {
			$model = D('Accessprovider');
			$res = $model->update();
			if ($res) {
				$this->success('新增成功',U('index'));
			}else {
				$this->error($model->getError());
			}
		}else {
			$this->assign('meta_title', '新增');
			$this->display('edit');
		}
	}
	
	public function edit() {
		if (IS_POST) {
			$model = D('Accessprovider');
			$res = $model->update();
			if ($res) {
				$this->success('编辑成功',U('index'));
			}else {
				$this->error($model->getError());
			}
		}else {
			$id = I('get.id/d');
			$info = D('Accessprovider')->find($id);
			$this->assign('info',$info);
			$this->assign('meta_title', '编辑');
			$this->display('edit');
		}
	}
}
