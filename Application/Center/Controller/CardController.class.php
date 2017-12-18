<?php
// +----------------------------------------------------------------------
// | hicms | 商品首页
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
use Think\Controller;
class CardController extends CenterBaseController {
    // 首页
	public function index(){
		$map['userid'] = UID;
		// 分类
		$catid = I('get.catid/d');
		if (!empty($catid)){
			$map['goodid'] = $catid;
		}
		
		$is_state = I('get.is_state');
		if ((int)$is_state >=0 && $is_state!==""){
		    $map['is_state'] = $is_state;
		}
		
		$title = I('get.title/s');
		if(!empty($title)){
			$map['cardnum'] = array('like','%'.$title.'%');
		}
		
		$list = $this->lists('Goods',$map,'id desc');
		
		$this->assign('cate',M('Goodlist')->where(array('userid'=>UID))->field('id,goodname')->select());
		$this->assign('list',$list);
		$this->assign('catid',$catid);
		$this->display();
    }
    // 新增
    public function add() {
    	if(IS_POST){
    		$model = D('Goods');
    		$data = $model->create();
    		//更新
    		if($data){
    			if($model->update()!== false){
    				$this->success('卡密添加成功！',U("card/index"));
    			} else {
    				$this->error($model->getError());
    			}
    		} else {
    			$this->error($model->getError());
    		} 
    	}
    	
    	$this->assign('is_deff',array(1=>'否',0=>'是'));
    	$this->assign('upload',array(1=>'txt文件导入',0=>'输入框输入'));
    	$this->display('edit');
    }
    
    // 删除
    public function del() {
        $this->delete("Goods");
    }
    
}
