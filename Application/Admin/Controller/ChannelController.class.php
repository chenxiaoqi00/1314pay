<?php
// +----------------------------------------------------------------------
// | hicms | 商户管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenj 
// +----------------------------------------------------------------------
namespace Admin\Controller;
class ChannelController extends AdminController {
    /* 商户结算*/
	public function index() {
		$map['status'] = array('egt',0);
		$list = $this->lists('Channellist',$map,'payid  desc');
		
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		
		$this->assign('list', $list);
		$this->assign('title',$title?$title:'接入信息');
		$this->assign('meta_title', '接入信息');
		$this->display();
	}
	
	public function add() {
		if (IS_POST) {
			$model = D('Channellist');
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
			$model = D('Channellist');
			$res = $model->update();
			if ($res) {
				$this->success('编辑成功',U('index'));
			}else {
				$this->error($model->getError());
			}
		}else {
			$id = I('get.id/d');
			$info = D('Channellist')->find($id);
			$this->assign('info',$info);
			$this->assign('meta_title', '编辑');
			$this->display('edit');
		}
	}
	
	public function changestate() {
	    $channelid= I("POST.id");
	    $state = I("POST.value")=="true" ? 1 : 0;
	    $msg = I("POST.value")=="true" ? "打开" : "关闭";
	    $resoult= M("channellist")->where(array("id"=>$channelid))->setField("is_state",$state);
	    if($resoult){
	        $this->success($msg."成功！");
	    }else{
	        $this->error($msg."失败！");
	    }
	    // 更新缓存
	    channellist(true);
	}
}
