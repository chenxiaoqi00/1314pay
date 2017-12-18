<?php
// +----------------------------------------------------------------------
// | hicms | 个人信息管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class MyController extends AdminController {
    /* 修改密码 */
    public function password(){
        if(IS_POST){
            $model = D('Common/Member');
            //获取参数
            $oldpassword = I('post.oldpassword');
            empty($oldpassword) && $this->error('请输入原密码');
            $password = I('post.password');
            empty($password) && $this->error('请输入新密码');
            $repassword = I('post.repassword');
            empty($repassword) && $this->error('请输入确认密码');
            //判断新旧密码
            /*if(!preg_match('/^[a-z]\w{5,15}$/i',$password)){
                $this->error("请输入6-16位字母和数字混合密码");
            }*/
            if($password !== $repassword){
                $this->error('您输入的新密码与确认密码不一致');
            }
            if(!$model->verifyPassword(UID, $oldpassword)) {
                $this->error('输入的旧密码不正确！');
            }
            //更新
            $data['password'] = hi_md5($password, C('AUTH_KEY'));
            $done = $model->updateMember(UID, $data);
            if( $done !== false){
                D('Common/Member')->logout();
                session('[destroy]');
                $this->success('密码修改成功,请重新登陆！');
            }else{
                $this->error('密码修改失败');
            }
        }else{
            $this->display();
        }
    }

    /* 修改个人信息 */
    public function info(){
        if(IS_POST){
            $model = D('Common/Member');
            //验证密码
            empty(I('password')) && $this->error('请输入用户密码');
            if(!$model->verifyPassword(UID, I('password'))) {
                $this->error('输入的用户密码不正确！');
            }
            $data = $model->create();
            //更新
            if($data){
                if($model->save()!== false){
                    $this->success('个人信息修改成功！');
                } else {
                    $this->error('个人信息修改失败');
                }
            } else {
                $this->error($model->getError());
            }
        }else{
            $this->assign('info',D('Member')->field('id,username,mobile,email')->find(UID));
            $this->display();
        }
    }

    /*修改个人头像*/
    public function avatar(){
        //S('Avatar_'.UID, null);
        $this->assign('avatar', avatar(UID));
        $this->display();
    }

}