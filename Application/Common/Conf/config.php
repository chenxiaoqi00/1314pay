<?php
return array(
    
    'SHOW_PAGE_TRACE' => false,
    //扩展配置
    'LOAD_EXT_CONFIG'=>'upload,database,views',

	/* URL配置 */
    'URL_CASE_INSENSITIVE' => true, //默认false 表示URL区分大小写 true则表示不区分大小写
    'URL_MODEL'            => 3, //URL模式
    'VAR_URL_PARAMS'       => '', // PATHINFO URL参数变量
    'URL_PATHINFO_DEPR'    => '/', //PATHINFO URL分割符

	/* 模板相关配置 */
    'TMPL_PARSE_STRING' => array(
        '__IMG__'    => __ROOT__.'/Public/statics/images',
        '__CSS__'    => __ROOT__.'/Public/statics/css',
        '__JS__'     => __ROOT__.'/Public/statics/js',
    ),
	
	/* 全局过滤配置 */
	'DEFAULT_FILTER'  => 'trim,strip_tags,htmlspecialchars',//全局过滤函数
		
    // 自定义标签
    'TAGLIB_PRE_LOAD' => 'Common\\TagLib\\Hi',

    // 标签库标签
    'TAGLIB_BEGIN'=> '{',
    'TAGLIB_END'=> '}',

    /* 全局过滤配置 */
    'DEFAULT_FILTER' => '', //全局过滤函数

    //注册新命名空间
    'AUTOLOAD_NAMESPACE' => array(
        'Libs'    => COMMON_PATH.'Libs',
    ),
    
    //会员中心 SESSION 和 COOKIE 配置
//     'SESSION_PREFIX' => 'tyb_center', //session前缀
//     'COOKIE_PREFIX'  => 'tyb_center', // Cookie前缀 避免冲突

    /* URL配置 */
    'URL_CASE_INSENSITIVE' => true, //默认false 表示URL区分大小写 true则表示不区分大小写
    'URL_MODEL'            => 2, //URL模式
    'VAR_URL_PARAMS'       => '', // PATHINFO URL参数变量
    'URL_PATHINFO_DEPR'    => '/', //PATHINFO URL分割符
    // 默认模块
    'DEFAULT_MODULE'     => 'Home',
    'MODULE_DENY_LIST'   => array('Common'),
    'MODULE_ALLOW_LIST'  => array('Home','Api','U','Admin','Center','App'),
    /*//URL路由配置
    'URL_ROUTER_ON'  => true,
    'URL_ROUTE_RULES'=> array(
        '/^([a-zA-Z_!\d]+)$/' => 'Admin/index/index?url=:1',//后台路径修改
    ),*/
    //'SHOW_PAGE_TRACE' => true,
    //'TOKEN_ON'    => true,  // 是否开启令牌验证 默认关闭
    'TOKEN_NAME'  => '__hash__', // 令牌验证的表单隐藏字段名称，默认为__hash__
    'TOKEN_TYPE'  => 'md5',  //令牌哈希验证规则 默认为MD5
    'TOKEN_RESET' => true,  //令牌验证出错后是否重置令牌 默认为true

);