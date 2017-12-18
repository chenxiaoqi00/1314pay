<?php
// +----------------------------------------------------------------------
// | hicms | 个人中心首页
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Seller\Controller;
use Think\Controller;
class ProductController extends SellerBaseController {
    
	/* 产品首页*/
	public function index() {
		$list = $this->products();
	}
	
	/*产品列表*/
	public function products($status=null){
		$map = array('uid'=>UID);
		
		// 状态
		if(!empty($_POST['status'])){
			$map['status'] = I('status');
			$status = $map['status'];
		}else{
			if (!empty($status)) {
				$map['status'] = $status;
			}else {
				$status = null;
				$map['status'] = array('in', '1,2');
			}
		}
		// 栏目ID
		if(!empty($_POST['catid'])){
			$map['catid'] = I('post.catid/d');
		}
		// 关键词
		if(!empty($_POST['title'])){
			$map['title'] = array('like', '%'.I('post.title').'%');
		}
		// 开始时间
		if ( !empty($_POST['fprice']) ) {
			$map['price'][] = array('egt',I('post.fprice'));
		}
		// 结束时间
		if ( !empty($_POST['tprice']) ) {
			$map['price'][] = array('elt',I('post.tprice'));
		}
		
		$list = $this->lists('Product', $map, 'id desc', 'id,title,thumb,price,stock,sales,picture,inputtime');
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		// 栏目树
		$tree = $this->getTree('ProductCategory');
		// 模板赋值
		$this->assign('category', $tree);
		$this->assign('list', $list);

		$this->assign('title',$title?$title:'产品名称');
		
		$this->display('index');
	}
	
/*添加*/
    public function add($catid = null){
        if(IS_POST){
            $done = D('Product')->update();
            if(!$done){
                $this->error(D('Product')->getError());
            }else{
                $this->success('产品'.I('post.title').'发布成功', Cookie('__forward__'));
            }
        }else{
            $tree = $this->getTree('ProductCategory');
            // 赋值
            $this->assign('postion', linkage('POSTION_INDEX'));
            $this->assign('category', $tree);
            $this->display('edit');
        }
    }
    
    /* 编辑 */
    public function edit(){
    	$model = D('Product');
    	if(IS_POST){
    		$done = $model->update();
    		if(!$done){
    			$this->error($model->getError());
    		}else{
    			$this->success('产品'.I('post.title').'更新成功', Cookie('__forward__'));
    		}
    	}else{
    		$id = (int)I('get.id');
    		if(empty($id)){
    			$this->error('参数有误！');
    		}
    		$info = $model->field(true)->relation(true)->find($id);
    		if(!(is_array($info) || 1 !== $info['status'])){
    			$this->error = '产品被禁用或已删除！';
    		}
    
    		$tree = $this->getTree('ProductCategory');
    		$this->assign('info', $info);
    		$this->assign('category', $tree);
    		$this->display('edit');
    	}
    }
   
}