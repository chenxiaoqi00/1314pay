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
class DemoController extends SellerBaseController {
    public function form(){
    	if(IS_POST){
    		$post = I('post.');
            dump($post);
    		if(empty($post['text'])){
    			$this->error('请输入文本框！');
    		}
    		if(empty($post['radio'])){
    			$this->error('请选择单选框！');
    		}
    		if(empty($post['checkbox'])){
    			$this->error('请选择多选框！');
    		}
    		if(empty($post['select'])){
    			$this->error('请选择下拉框！');
    		}
            $this->success('表单正确！');
    	}else{
        	$this->display();
        }
    }
}