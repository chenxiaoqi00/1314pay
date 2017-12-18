<?php
return array(
    /**
    * 公共权限配置
    * 每行一个,后台菜单添加对应的权限
    */
    'PUBLIC_PERSON_AUTH' => array(
    	'order/index',         //订单管理
    	'comment/index',       //评论管理
    	'address/index',       //收货地址
        'address/add',         //添加地址
        'address/edit',        //修改地址
        'address/doadd',       //地址添加保存
        'address/doedit',      //地址修改保存
        'address/delete',      //地址删除
        'address/setDefault',  //默认地址
        'upload/webUploader',  //百度上传
        'upload/getPicture',   //百度上传图像回调
        'upload/avatar',       //头像上传
        'upload/ueditor',      //百度编辑器
        // 个人中心
    	'index/userInfo',       // 商户信息
    //	'index/userSafe',       // 安全设置
    	'index/index',         //首页
    	'index/info',          //个人信息
    	'index/password',      //密码修改
    	'index/avatar',        //上传头像
    	// 商品管理
    	'goods/index',         // 商品列表
    	'goods/add',           // 添加商品
    	'goods/edit',          // 编辑商品
    	
    	// 卡密管理
    	'card/index',         // 商品列表
    	'card/add',           // 添加商品
        'card/edit',           // 添加商品
    	
    	// 分类管理
    	'category/index',      // 分类列表
    	'category/add',        // 添加分类
    	'category/edit',       // 编辑分类
    	
        //交易管理
        'trade/index',        // 我的支付链接
        'trade/channels',     // 支付方式管理
        'trade/analyforchannel', //交易渠道分析
        'trade/analyforuser',    //我的收益统计
        'trade/orders',           //订单交易记录
        'trade/invite',           //我的商户
        'trade/record',           //交易记录
        'buy/cardlist',           // 交易卡信息
        'buy/orderlist',          // 交易订单信息
        
        
        'coupon/index',   //管理优惠券
        'coupon/add',       //我的优惠券
        '/News/help',       //帮助中心
        '/News/notice',       //站点公告

        //结算
        'account/index',         //结算管理
        'account/apply',       //申请结算
        
        //投诉
        'complain/index',         //投诉管理
        
    	// 通用方法
    	'ajax/gatgoods',
    ),
);
