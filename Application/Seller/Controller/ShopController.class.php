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
class ShopController extends SellerBaseController {
    /*初始*/
    protected function _initialize(){
        parent::_initialize();
        $shopmenu = array('config'=>'店铺设置', 'cert'=>'资质认证', 'slide'=>'幻灯片设置', 'theme'=>'店铺主题', 'mobile'=>'手机店铺');
        $this->assign('shopmenu', $shopmenu);
    }

    /*店铺首页*/
    public function index(){
        $this->display();
    }

    /*店铺设置*/
    public function config(){
    	$model =  D('Shop');
    	if(IS_POST){
    		$data = $model->create();
	        if(empty($data)){
	            $this->error($model->getError());
	        }
	        if(empty($data['shopid'])){ //新增数据
                if($model->add()){
                    $this->success('店铺设置成功');
                } else {
                    $this->error('店铺设置失败');
                }
	        }else{
	        	if($model->save()!== false){
                    $this->success('店铺设置成功');
                } else {
                    $this->error('店铺设置失败');
                }
	        }
    	}else{
    		$this->display();
    	}
    }

    /*资质证书*/
    public function cert(){
        $this->display();
    }

    /*幻灯片设置*/
    public function slide(){
        echo '幻灯片设置';
    }

    /*幻灯片设置*/
    public function theme(){
        echo '店铺主题';
    }

    /*手机店铺*/
    public function mobile(){
        echo '手机店铺';
    }
}