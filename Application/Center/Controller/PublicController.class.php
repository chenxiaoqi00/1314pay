<?php
// +----------------------------------------------------------------------
// | hicms | 通用控制器 | 注册 | 登陆 | 注销
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
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

    // +----------------------------------------------------------------------
    // | 会员登陆
    // +----------------------------------------------------------------------
    public function login($username = '', $password = '', $redirect = false){
        if(IS_POST){
            // 错误次数超过5次，限制登录
//             $deny = S('LOGIN_DENY_'.get_client_ip(1));
//             if($deny['logins'] == C('LOGIN_FAILED_TIMES')){
//                 $this->error("登录失败次数超过5次<br>".round((3600 -(time() - $deny['time']))/60)."分后可再次登录！");
//             }
            //用户名和密码为空判断
            $username = I('post.username')?I('post.username'):$this->error("请输入用户名或者邮箱或者手机号码");
            $password = I('post.password')?I('post.password'):$this->error("请输入密码");
            // 检测验证码
            if(!check_verify(I('post.verify'))&&!$redirect){
                $this->error('验证码输入错误！');
            }
            //实例化用户表
            $UCmodel = D('Common/Users');
            //登陆用户
            $uid = $UCmodel->login($username,$password,9);
            if(0 < $uid){ //会员中心登录成功
                // 登陆日志
                $this->log($username, $password, 1);
                //跳转到后台首页
                $this->success('登录成功！', $this->jumpurl());
                
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

    // +----------------------------------------------------------------------
    // | 退出登录
    // +----------------------------------------------------------------------
    public function out(){
        if(is_login()){
            D('Common/Users')->logout();
            session('[destroy]');
            $this->success('退出成功！', U('login'));
        } else {
            $this->error('退出失败！');
//             $this->redirect('login');
        }
    }

    // +----------------------------------------------------------------------
    // | 会员注册
    // +----------------------------------------------------------------------
    public function register(){
        
        if(IS_POST){
            $data = I('post.');
            // 检测验证码
            if(!check_verify(I('post.verify'))){
             $this->error('验证码输入错误！');
             }
            C('TOKEN_ON',false);
            $UcenterModel = D('Common/Users');
            $ucdata = $UcenterModel->token(false)->create();
            if($ucdata){
                   $inviteId = $UcenterModel->relation(true)->add($ucdata);//增加商户信息
                    if($inviteId){
                      $UcenterModel ->where(array("id"=>$inviteId))->setField("shorturl",$inviteId);//用于短路径
                      $this->addRegisterAttach($UcenterModel,$inviteId); //添加特约商户和渠道分成信息
                      M('Userinfo')->add(array('userid'=>$inviteId));
                      $this->success('会员注册成功！',  $this->login($data['username'],$data['password'],true));
                   } else {
                        $this->error('会员注册失败,请稍候重试！');
                    } 
                
            } else {
                $this->error($UcenterModel->getError());
            }
        } else {
            $this->display();
        }
    }
    
    //添加商户的分成信息,添加特约商户
    public function addRegisterAttach($UcenterModel,$inviteId){
        $userprice = array();
        //添加商户的分成信息
        $payList = M("channellist")->field("id,channelname,price,is_state")->select();
        foreach ($payList as $k=>$v){
            $userprice[$k]["userid"]=$inviteId;
            $userprice[$k]["channelid"]=$v["id"];
         //   $userprice[$k]["price"]=$v["price"];
            $userprice[$k]["price"]=0; //默认设置为0，为0的时候去读channellist表
            $userprice[$k]["is_state"]=$v["is_state"];
            //平台支付通道1是开启，0是关闭
        }
        M("userprice")->addAll($userprice);
        //添加特约商户
        $inviteCode = trim(I('post.inviteCode/s'));
        if($inviteCode){
         //   $UcenterModel->addInvite($inviteCode,$inviteId);
            $map['invite_code']=$inviteCode;
            $user = $UcenterModel->where($map)->field("id,is_invite")->find();
            //特约商户结算表添加数据
            $invite = array("Jan"=>0,"Feb"=>0,"Mar"=>0,"Apr"=>0,"May"=>0,"Jun"=>0,"Jul"=>0,"Aug"=>0,"Sep"=>0,"Oct"=>0,"Nov"=>0,"Dec"=>0);
            $invite['inviteid'] = $inviteId;
            $invite['userid'] = $user['id'];
            $add_invite = M('invite')->add($invite);
            if($user['is_invite']==0){
                $UcenterModel->where(array("id"=>$user['id']))->setField('is_invite', 1);
            }
        }
    }
    
    
    
    /**
     * 验证手机号的唯一性用于validataform
     */
    public function checkUniqueMobile(){
        $tel = I('post.param');
        //实例化用户表
        $UCmodel = D('Common/Users');
        $user = $UCmodel->checkUniqueMobile($tel);
        if($user){
            $this->error('手机号被占用！');
        }else{
            $this->ajaxReturn(array('status'=>'y','info'=>'该手机可以使用！'));
        }

    }

    /**
     * 验证邮箱号的唯一性用于validataform
     */
    public function checkUniqueEmail(){
        $email = I('post.param');
        //实例化用户表
        $UCmodel = D('Common/Users');
        $user = $UCmodel->checkUniqueEmail($email);
        if($user){
            $this->error('邮箱号被占用！');
        }else{
            $this->ajaxReturn(array('status'=>'y','info'=>'该邮箱可以使用！'));
        }
    
    }
    /**
     * 验证手机号的唯一性用于validataform
     */
    public function checkUniqueUsername(){
       $username = I('post.param');
        //实例化用户表
        $UCmodel = D('Common/Users');
        
        if($UCmodel->checkUniqueUsername($username)){
            $this->error($this->showRegError(-3));
        }else if(!$UCmodel->checkUsername($username)){
            $this->error('用户名格式只能为6-16位英文和数字！');
        }else if(!$UCmodel->checkDenyMember($username)){
            $this->error('用户名禁止注册！');
        }else{
             $this->ajaxReturn(array('status'=>'y','info'=>'该用户名可以使用！'));
        }
    }
    /**
     * 验证验证码用于validataform
     */
    public function checkVerifyValid(){
        $verify = I('post.param');
        if(!check_verify($verify)){
            $this->error('验证码输入错误！');
        }else{
             $this->ajaxReturn(array('status'=>'y','info'=>'验证码输入正确！'));
        }
    }
    
    /**
     * 验证邀请码用于validataform
     */
    public function checkInviteCode(){
        $inviteCode = trim(I('post.param/s'));
        //实例化用户表
        $UCmodel = D('Common/Users');
        if(!$UCmodel->checkInviteCode($inviteCode)){
            $this->error('未找到邀请码为'.$inviteCode."的商户");
        }else{
             $this->ajaxReturn(array('status'=>'y','info'=>'邀请码正确！'));
        }
    }
    // +----------------------------------------------------------------------
    // | 公共相关函数
    // +----------------------------------------------------------------------
    /**
     * 获取用户注册错误信息
     * @param  integer $code 错误编码
     * @return string        错误信息
     */
    private function showRegError($code = 0){
        switch ($code) {
            case -1:  $error = '用户名长度必须在16个字符以内！'; break;
            case -2:  $error = '用户名被禁止注册！'; break;
            case -3:  $error = '用户名被占用！'; break;
            case -4:  $error = '密码长度必须在6-30个字符之间！'; break;
            case -5:  $error = '邮箱格式不正确！'; break;
            case -6:  $error = '邮箱长度必须在1-32个字符之间！'; break;
            case -7:  $error = '邮箱被禁止注册！'; break;
            case -8:  $error = '邮箱被占用！'; break;
            case -9:  $error = '手机格式不正确！'; break;
            case -10: $error = '手机被禁止注册！'; break;
            case -11: $error = '手机号被占用！'; break;
            default:  $error = '未知错误';
        }
        return $error;
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
            S('LOGIN_DENY_'.get_client_ip(1), null);
        }
        //登录日志
        D('Admin/LogLogin')->log(array(
            "username" => $username,
            "status"   => $status,
            "password" => $status ? '******' : $password,
            "logtype"  => $logtype,
            "code"     => $code,
            "module"   => MODULE_NAME,
        ));
    }

    //限制登录
    private function login_deny(){
        $ip = get_client_ip(1);
        $deny = S('LOGIN_DENY_'.$ip);
        if($deny){
            if( $deny['logins'] < 5 ){
                $deny['logins'] = $deny['logins'] + 1;
                $deny['time'] = time();
                S('LOGIN_DENY_'.$ip, $deny, 3600);
            }
        }else{
            $deny['logins'] = 1;
            $deny['time']  = time();
            // 缓存一个小时
            S('LOGIN_DENY_'.$ip, $deny, 3600);
        }
    }

    //不同会员模型页面跳转
    private function jumpurl(){
        $user = session('user_auth');
        if($user['modelid'] == 4 ){
            $url = U("Center/Index/index");
        }else{
            $url = U("Center/Index/index");
        }
        return $url;
    }
}