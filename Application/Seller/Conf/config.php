<?php
return array(
	//模板相关配置
    'TMPL_PARSE_STRING' => array(
        '__IMG__'      => __ROOT__.'/Public/Center/images',
        '__CSS__'      => __ROOT__.'/Public/Center/css',
        '__JS__'       => __ROOT__.'/Public/Center/js',
        '__BASE_JS__'  => __ROOT__.'/Public/statics/js',
        '__BASE_CSS__' => __ROOT__.'/Public/statics/css',
    ),

    //扩展配置
    'LOAD_EXT_CONFIG'=>'seller_auth',

    //会员中心 SESSION 和 COOKIE 配置
    'SESSION_PREFIX' => 'tyb_center', //session前缀
    'COOKIE_PREFIX'  => 'tyb_center', // Cookie前缀 避免冲突

    //表单令牌
    'TOKEN_ON'    => true,  // 是否开启令牌验证 默认关闭
    'TOKEN_NAME'  => '__hash__', // 令牌验证的表单隐藏字段名称，默认为__hash__
    'TOKEN_TYPE'  => 'md5',  //令牌哈希验证规则 默认为MD5
    'TOKEN_RESET' => true,  //令牌验证出错后是否重置令牌 默认为true
);