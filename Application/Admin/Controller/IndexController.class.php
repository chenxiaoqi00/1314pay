<?php
// +----------------------------------------------------------------------
// | hicms | 首页
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Libs\Tree;
class IndexController extends AdminController {
	/*首页框架*/
    public function index(){
    	$user = D('Member')->find(UID);
    	$complain_count = M("complain")->where(array("is_state"=>0))->count();
    	$this->assign('complain_count',$complain_count);
    	$this->assign('sys_info',$this->_GET_SYS_INFO());
        $this->display();
    }

    /*首页*/
    public function home(){
    	$this->assign('sys_info',$this->_GET_SYS_INFO());
    	$this->display();
    }

    /**
     * 获取服务器信息
     */
	private function _GET_SYS_INFO(){
    	$sys_info['os']             = PHP_OS;
		$sys_info['zlib']           = function_exists('gzclose') ? 'YES' : 'NO';//zlib
		$sys_info['safe_mode']      = (boolean) ini_get('safe_mode') ? 'YES' : 'NO';//safe_mode = Off
		$sys_info['timezone']       = function_exists("date_default_timezone_get") ? date_default_timezone_get() : "no_timezone";
		$sys_info['curl']			= function_exists('curl_init') ? 'YES' : 'NO';
		$sys_info['web_server']     = $_SERVER['SERVER_SOFTWARE'];
		$sys_info['phpv']           = phpversion();
		$sys_info['ip'] 			= GetHostByName($_SERVER['SERVER_NAME']);
		$sys_info['fileupload']     = @ini_get('file_uploads') ? ini_get('upload_max_filesize') :'unknown';
		$sys_info['max_ex_time'] 	= @ini_get("max_execution_time").'s'; //脚本最大执行时间
		$sys_info['set_time_limit'] = function_exists("set_time_limit") ? true : false;
		$sys_info['domain'] 		= $_SERVER['HTTP_HOST'];
		$sys_info['memory_limit']   = ini_get('memory_limit');

		$sys_info['appname']   	    = C('APPNAME');
		$sys_info['bulid']   	    = C('BUILD');
        $sys_info['version']   	    = C('VERSION');

		$sys_info['mysql_version']  = mysql_get_client_info();
		if(function_exists("gd_info")){
			$gd = gd_info();
			$sys_info['gdinfo'] 	= $gd['GD Version'];
		}else {
			$sys_info['gdinfo'] 	= "未知";
		}
		return $sys_info;
    }
}