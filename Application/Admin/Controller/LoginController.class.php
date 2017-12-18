<?php
// +----------------------------------------------------------------------
// | hicms | 登陆 | 注销
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Think\Controller;
class LoginController extends Controller {
    protected function _initialize(){
        /* 读取数据库中的配置 */
        $config =   S('DB_CONFIG_DATA');
        if(!$config){
            $config = D('Admin/Config')->lists();
            S('DB_CONFIG_DATA',$config);
        }
        C($config); //添加配置
    }

	public function index(){
		if(IS_POST){
            // 错误次数超过5次，限制登录
//             $deny = S('ADMIN_LOGIN_DENY_'.get_client_ip(1));
//             if($deny['logins'] == C('LOGIN_FAILED_TIMES')){
//                 $this->error("登录失败次数超过5次<br>".round((3600 -(time() - $deny['time']))/60)."分后可再次登录！");
//             }
			//用户名和密码为空判断
			$username = I('post.username')?I('post.username'):$this->error("请输入用户名或者邮箱或者手机号码");
			$password = I('post.password')?I('post.password'):$this->error("请输入密码");
            // 检测验证码
            if(!check_verify(I('post.verify'))){
                $this->error('验证码输入错误！');
            }
			//实例化用户表
			$UCmodel = D('Common/Member');
			//登陆用户
			$uid = $UCmodel->login($username,$password,9);
			if(0 < $uid){ //会员中心登录成功
				//会员表登陆
				//$member = D('Common/MemberPerson');
                // 登陆日志
                $this->log($username, $password, 1);
                //登录用户
                if($UCmodel->loginUID($uid)){ //登录用户
                    //跳转到后台首页
                    $this->success('登录成功！', U('Index/index'));
                } else {
                    $this->error($UCmodel->getError());
                }
            } else { //登录失败
                switch($uid) {
                    case -1: $error = '用户不存在或被禁用！'; break; //系统级别禁用
                    case -2: $error = '密码错误！'; break;
                    default: $error = '未知错误！'; break; // 0-接口参数错误（调试阶段使用）
                }
                // 登陆错误日志
                $this->log($username, $password, 0, $error);
                $this->error($error);
            }
		}else{
			$this->display();
		}
	}


	/* 退出登录 */
    public function out(){
        if(is_login()){
            D('Common/Member')->logout();
            session('[destroy]');
            $this->success('退出成功！', U('index'));
        } else {
            $this->redirect('login');
        }
    }

    /**
     * 登陆日志
     * @param type $username 登陆方式:用户名|手机|邮箱
     * @param type $password 密码
     * @param type $status
     */
    private function log($username, $password, $status = 0, $code='登陆成功!') {
        $verify = new \Libs\Verify();
        if($verify::isUsername($username)){
            $logtype = '用户名';
        }else if($verify::isMobile($username)){
            $logtype = '手机';
        }else if($verify::isEmail($username)){
            $logtype = '邮箱';
        }else{
            $logtype = '用户名';
        }
        if(empty($status)){
            $this->login_deny();
        }else{
            S('ADMIN_LOGIN_DENY_'.get_client_ip(1), null);
        }
        //登录日志
        D('Admin/LogLogin')->log(array(
            "username" => $username,
            "status"   => $status,
            "password" => $status ? '******' : $password,
            "logtype"  => $logtype,
            "code"     => $code,
        ));
    }

    // 限制登录
    function login_deny(){
        $ip = get_client_ip(1);
        $deny = S('ADMIN_LOGIN_DENY_'.$ip);
        if($deny){
            if( $deny['logins'] < 5 ){
                $deny['logins'] = $deny['logins'] + 1;
                $deny['time'] = time();
                S('ADMIN_LOGIN_DENY_'.$ip, $deny, 3600);
            }
        }else{
            $deny['logins'] = 1;
            $deny['time']  = time();
            // 缓存一个小时
            S('ADMIN_LOGIN_DENY_'.$ip, $deny, 3600);
        }
    }


}