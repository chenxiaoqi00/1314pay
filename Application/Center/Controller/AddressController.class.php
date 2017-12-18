<?php
// +----------------------------------------------------------------------
// | hicms | 个人中心首页
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
use Think\Controller;
class AddressController extends CenterBaseController {
    /*收货地址*/
    public function index(){
        $list = D('Address')->where(array('uid'=>UID))->order('isdefault desc')->select();
        $this->assign('_list',$list);
        $this->display();
    }

     /**
     * 添加收货地址
     */
    public function add(){
        $this->assign('info',null);
        $this->assign('dourl',U('doadd'));
        $this->display('edit');
    }

    /*编辑地址*/
    public function edit(){
        $id = I('get.id/d');
        $model = D('Address');
        $info = $model->where(array('uid'=>UID,'id'=>$id))->find();
        if(!$info){
            $this->error('该信息不存在或已经被禁用！');
        }
        $this->assign('info',$info);
        $this->assign('dourl',U('doedit'));
        $this->display('edit');
    }

    /*设置默认地址*/
    public function setDefault(){
        $id = I('get.id/d','','intval');
        $isdec = M('Address')->where(array('uid'=>UID, 'isdefault'=>1))->setDec('isdefault');
        $isinc = M('Address')->where(array('uid'=>UID, 'id'=>$id))->setInc('isdefault');
        if($isdec && $isinc){
            $this->success('地址设置成功！',U('index'));
        }else{
            $this->error('地址设置失败，请稍候再试！');
        }
    }

}