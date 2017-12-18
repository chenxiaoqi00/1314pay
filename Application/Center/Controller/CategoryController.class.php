<?php
// +----------------------------------------------------------------------
// | hicms | 商品分类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
use Think\Controller;
class CategoryController extends CenterBaseController {
    // 列表页
	public function index(){
		$map = array();
		if (!empty(I('get.title/s'))) {
			$map['catename'] = array('like',I('get.title/s'));
		}
		$map['userid'] = UID;
		$list = $this->lists('Goodcate',$map,'sortid asc');
/* 		foreach ($list as $k=>$v){
		     $list[$k]['payUrl']='http://'.$_SERVER['HTTP_HOST'].'/Product/goodcate/linkid/'. $list[$k]['linkid'].".html"; 
		     $list[$k]['shotPayUrl'] = bdUrlAPI(1,$list[$k]['payUrl']); 
		} */
		$this->assign('list',$list);
        $this->display();
    }
    // 添加
    public function add(){
    	if (IS_POST) {
    		$model = D('Goodcate');
    		$res = $model->update();
    		if ($res) {
    			$this->success('新增成功',U('index'));
    		}else {
    			$this->error($model->getError());
    		}
    	}else{
    		$this->assign("theme",C('VIEWS'));
    	    $this->assign("title","添加分类");
    		$this->display('edit');
    	}
    	
    }
    // 编辑
    public function edit() {
    	if (IS_POST) {
    		$model = D('Goodcate');
    		$res = $model->update();
    		if ($res) {
    			$this->success('编辑成功',U('index'));
    		}else {
    			$this->error($model->getError());
    		}
    	}
    	$id = I('get.id/d');
    	if (empty($id)) {
    		$this->error('参数错误');
    	}
    	$map['userid'] = UID;
    	$info = M('Goodcate')->where($map)->find($id);
    	$this->assign('info',$info);
    	$this->assign("theme",C('VIEWS'));
    	$this->assign("title","编辑分类");
    	$this->display();
    }
    
    // 删除
    public function del() {
        $ids = array_filter(array_unique((array)I('ids',0)));
        $map['cateid'] = array('in', $ids);
        $goodList = M("goodlist")->where($map)->select();
        if($goodList){
            $this->error('请先删除分类地下商品!');
        }
         
        $this->delete("Goodcate");
    }
}