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
class GoodsController extends CenterBaseController {
    // 首页
	public function index(){
		$map['userid'] = UID;
		// 分类
		$catid = I('get.catid/d');
		if (!empty($catid)){
			$map['cateid'] = $catid;
		}
		
		$is_state = I('get.is_state');
		if ((int)$is_state >=0 && $is_state!==""){
		    $map['is_state'] = $is_state;
		}
		
		$title = I('get.title/s');
		if(!empty($title)){
			$map['goodname'] = array('like','%'.$title.'%');
		}
		
		$fprice = I('get.fprice/d');
		if(!empty($fprice)){
			$map['price'][] = array('egt',$fprice);
		}
		
		$eprice = I('get.eprice/d');
		if(!empty($eprice)){
			$map['price'][] = array('elt',$eprice);
		}
		
		$list = $this->lists('Goodlist',$map,'id desc');
		$goods = D('Goods');
		$goodCate = M('Goodcate')->where(array('userid'=>UID))->field('id,sortid,catename')->select();
		foreach ($list as $key => $value) {
			$list[$key]['sales'] = $goods->getNum(UID,$value['id'],1);
			$list[$key]['stacks'] = $goods->getNum(UID,$value['id'],0);
			foreach($goodCate as $k=>$v){
			    if($v['id']==$value['cateid']){
			        $list[$key]['goodCateName'] = $v['catename'];
			        $list[$key]['cateSortid'] = $v['sortid'];
			    }
			}
		}
		array_multisort(array_column($list,'cateSortid'),SORT_ASC,$list);
// 		dump($list);
		
		
		$this->assign('cate',$goodCate);
		$this->assign('list',$list);
		$this->assign('catid',$catid);
		$this->display();
    }
    // 新增
    public function add() {
    	if(IS_POST){
    		$model = D('Goodlist');
    		$data = $model->create();
    		//更新
    		if($data){
    			if($model->update()!== false){
//     				$this->success('商品添加成功！');
    			    $this->success('商品添加成功！',U('index'));
    			} else {
    				$this->error($model->getError());
    			}
    		} else {
    			$this->error($model->getError());
    		}
    	}
    	$this->assign("theme",C('VIEWS'));
    	$this->assign('is_api',array(1=>'在线充值',0=>'在线售卡'));
    	$this->assign('is_dispay',array(0=>'默认',1=>'网银',2=>'充值卡'));
    	$this->assign('is_coupon',array(1=>'是',0=>'否'));
    	$this->assign('is_email',array(1=>'是',0=>'否'));
    	$this->assign('cate',M('Goodcate')->where(array('userid'=>UID))->getField('id,catename'));
    	$this->display('edit');
    }
    
    // 编辑
    public function edit() {
    	if(IS_POST){
    		$model = D('Goodlist');
    		$data = $model->create();
    		//更新
    		if($data){
    			if($model->update()!== false){
//     				$this->success('商品编辑成功！');
    				$this->success('商品添加成功！',U('index'));
    			} else {
    				$this->error('商品编辑失败');
    			}
    		} else {
    			$this->error($model->getError());
    		}
    	}
    	$id = I('get.id/d');
    	if (!$id) {
    		$this->error('参数错误');
    	}
    	
    	$info = M('Goodlist')->where(array('userid'=>UID))->find($id);
    	if (!$info) {
    		$this->error('商品不存在');
    	}
//     	dump($info);
    	$this->assign("theme",C('VIEWS'));
    	$this->assign('info',$info);
    	$this->assign('is_dispay',array(0=>'默认',1=>'网银',2=>'充值卡'));
    	$this->assign('is_coupon',array(1=>'是',0=>'否'));
    	$this->assign('is_email',array(1=>'是',0=>'否'));
    	$this->assign('cate',M('Goodcate')->where(array('userid'=>UID))->getField('id,catename'));
    	$this->display('edit');
    }
    
    // 删除
    public function del() {
        $this->delete("Goodlist");
    }
    
    // 改变状态
    public function changeState() {
        $this->setStatus("Goodlist");
    }
    

    
}