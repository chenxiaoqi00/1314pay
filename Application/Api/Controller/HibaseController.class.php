<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Api\Controller;
use Think\Controller;
class HibaseController extends Controller {
	/* 空操作，用于输出404页面 */
	/*public function _empty(){
		$this->redirect('Index/index');
	}*/
    protected function _initialize(){
        /* 读取数据库中的配置 */
        $config =   S('DB_CONFIG_DATA');
        if(!$config){
            $config =   D('Admin/Config')->lists();
            S('DB_CONFIG_DATA',$config);
        }
        C($config); //添加配置
    }


}