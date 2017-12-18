<?php
// +----------------------------------------------------------------------
// | hicms | 会员管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class MemberController extends AdminController {
    /**
     * 用户管理首页
     */
    public function index(){
        $map['status']  =   array('egt',0);
        $list = D('Member')->where($map)->order('id desc')->select();
        $this->assign('_list', $list);
        $this->meta_title = '用户信息';
        $this->display();
    }

    //添加用户
    public function add(){
        if(IS_POST){
            $model = D('Common/Member');
            $data = $model->create();
            if($data){
                if($model->add()){
                    $this->success('用户添加成功！', Cookie('__forward__'));
                } else {
                    $this->error('用户添加失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            $this->display();
        }
    }

    /*强制用户退出登录*/
    public function getout($id){
        $this->error('点错了！');
        $data['session_id'] = null;
        $map['id'] = $id;
        $data = D('Member')->find($id);
        /*if($done){
            $this->success('操作成功！');
        }*/
    }

    public function resetPass($id){
        if(!(int)$id) $this->error('参数错误!');
        if(in_array(C('USER_ADMINISTRATOR'), (array)$id)){
            $this->error("不允许对超级管理员执行重置密码操作!");
        }
        $password = genRandomString(6);
        $data['password'] = hi_md5($password, C('AUTH_KEY'));
        $done = D('Member')->updateMember($id, $data);
        if( $done !== false){
            $this->success('请复制密码 <b>'.$password.'</b>');
        }else{
            $this->error('密码重置失败');
        }
    }

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

}