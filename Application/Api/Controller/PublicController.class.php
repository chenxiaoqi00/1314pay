<?php
namespace Api\Controller;
use Think\Controller;
class PublicController extends Controller {
	protected function _initialize(){
	    /* 读取数据库中的配置 */
	    $config =   S('DB_CONFIG_DATA');
	    if(!$config){
	        $config = D('Admin/Config')->lists();
	        S('DB_CONFIG_DATA',$config);
	    }
	    C($config); //添加配置
	}
    /* 验证码 */
    public function verify(){
    	ob_clean();
        verify();
    }
}