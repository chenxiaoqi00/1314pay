<?php
return array(
	/**
    * 公共权限配置
    * 每行一个,后台菜单添加对应的权限
    */
    'PUBLIC_SELLER_AUTH' => array(
    	'index/index',      //店铺首页
        'shop/index',       //店铺信息
        'shop/config',      //店铺信息
        'shop/slide',       //幻灯片
        'shop/mobile',      //手机端
        'shop/config',      //店铺信息
        'shop/cert',        //资质证书
    	'product/index',    //产品首页
    	'product/add',   //发布产品
    	'product/edit',   //编辑产品
    	'product/setStatus',   //修改状态
    	'demo/index',
    	'demo/form',
    ),

    'NO_PASS_AUTH' => array(
        'index/index',      //店铺首页
        'shop/config',      //店铺设置
        'shop/cert',        //资质证书
        'demo/form',
    ),
);