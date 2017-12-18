<?php
return array(
	//'配置项'=>'配置值'
    //会员中心 SESSION 和 COOKIE 配置
    'SESSION_PREFIX' => 'tyb_center', //session前缀
    'COOKIE_PREFIX'  => 'tyb_center', // Cookie前缀 避免冲突

    'URL_ROUTER_ON'   => true, //开启路由
    
    'URL_ROUTE_RULES'=>array(
        'category/:linkid'               => 'Home/Product/goodcate',
        'product/:linkid'               => 'Home/Product/goodlist',
        'links/:linkid'               => 'Home/Product/store',
        'getgood/:linkid'               => 'Home/Product/getgood',
        'getcategory/:linkid'               => 'Home/Product/getgoodlist',
        'afterPayment/:orderid'               => 'Home/Product/afterPayment',
    ),
    
    // 配置邮件发送服务器
    'MAIL_HOST' =>'smtp.163.com',//smtp服务器的名称
    'MAIL_SMTPAUTH' =>TRUE, //启用smtp认证
    'MAIL_USERNAME' =>'18069131930@163.com',//你的邮箱名
    'MAIL_FROM' =>'18069131930@163.com',//发件人地址
    'MAIL_FROMNAME'=>'318支付',//发件人姓名
    'MAIL_PASSWORD' =>'afeng0823',//邮箱密码   afeng0823   aaa456258
    'MAIL_CHARSET' =>'utf-8',//设置邮件编码
    'MAIL_ISHTML' =>TRUE, // 是否HTML格式邮件
    
);
