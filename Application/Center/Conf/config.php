<?php
return array(
	//模板相关配置
    'TMPL_PARSE_STRING' => array(
        '__IMG__'      => __ROOT__.'/Public/Center/images',
        '__CSS__'      => __ROOT__.'/Public/Center/css',
        '__JS__'       => __ROOT__.'/Public/Center/js',
        '__BASE_JS__'  => __ROOT__.'/Public/statics/js',
        '__BASE_CSS__' => __ROOT__.'/Public/statics/css',
        '__BASE_IMG__' => __ROOT__.'/Public/statics/img',
    ),

    //扩展配置
    'LOAD_EXT_CONFIG'=>'person_auth',
    
    // 自定义标签
    'TAGLIB_PRE_LOAD' => 'Common\\TagLib\\Center,Common\\TagLib\\Hi',

    //会员中心 SESSION 和 COOKIE 配置
    'SESSION_PREFIX' => 'tyb_center', //session前缀
    'COOKIE_PREFIX'  => 'tyb_center', // Cookie前缀 避免冲突

    //表单令牌
    'TOKEN_ON'    => false,  // 是否开启令牌验证 默认关闭
    'TOKEN_NAME'  => '__hash__', // 令牌验证的表单隐藏字段名称，默认为__hash__
    'TOKEN_TYPE'  => 'md5',  //令牌哈希验证规则 默认为MD5
    'TOKEN_RESET' => true,  //令牌验证出错后是否重置令牌 默认为true

    /* 图片上传相关配置 */
    'PICTURE_UPLOAD' => array(
        'mimes'    => '', //允许上传的文件MiMe类型
        //'maxSize'  => 2*1024*1024, //上传的文件大小限制 (0-不做限制)
        //'exts'     => 'jpg,gif,png,jpeg', //允许上传的文件后缀
        'autoSub'  => true, //自动子目录保存文件
        'subName'  => array('date', 'Y-m-d'), //子目录创建方式，[0]-函数名，[1]-参数，多个参数使用数组
        'rootPath' => './Uploads/U/img/', //保存根路径
        'savePath' => '', //保存路径
        'saveName' => array('uniqid', ''), //上传文件命名规则，[0]-函数名，[1]-参数，多个参数使用数组
        'saveExt'  => '', //文件保存后缀，空则使用原后缀
        'replace'  => false, //存在同名是否覆盖
        'hash'     => true, //是否生成hash编码
        'callback' => false, //检测文件是否存在回调函数，如果存在返回文件信息数组
    ), //图片上传相关配置（文件上传类配置）
    
	/* 文件上传相关配置 */
	'FILE_UPLOAD' => array(
			'mimes'    => '', //允许上传的文件MiMe类型
			'maxSize'  => 500*1024, //上传的文件大小限制 (0-不做限制)
			'exts'     => 'txt', //允许上传的文件后缀
			'autoSub'  => true, //自动子目录保存文件
			'subName'  => array('date', 'Y-m-d'), //子目录创建方式，[0]-函数名，[1]-参数，多个参数使用数组
			'rootPath' => './Uploads/U/file/', //保存根路径
			'savePath' => '', //保存路径
			'saveName' => array('uniqid', ''), //上传文件命名规则，[0]-函数名，[1]-参数，多个参数使用数组
			'saveExt'  => '', //文件保存后缀，空则使用原后缀
			'replace'  => false, //存在同名是否覆盖
			'hash'     => true, //是否生成hash编码
			'callback' => false, //检测文件是否存在回调函数，如果存在返回文件信息数组
	), //图片上传相关配置（文件上传类配置）

);