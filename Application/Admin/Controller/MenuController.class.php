<?php
// +----------------------------------------------------------------------
// | hicms | 菜单管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;
class MenuController extends AdminController {
    public function index(){
        $pid  = I('get.pid/d',0);
        $title= trim(I('get.title'));
        $type = I('type/d')? I('type/d') : 1;
        //模块查询
        $map = array();
        $map['module'] = module($type,'name');
        if($title){
            $map['title'] = array('like',"%{$title}%");
        }else{
            $map['pid'] = $pid;
        }
        //所有菜单
        $all_menu   =   M('Menu')->getField('id,title');
        //记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        //列表
        $list = M("Menu")->where($map)->field('tip,is_dev',true)->order('sort asc,id asc')->select();
        if($list) {
            foreach($list as &$key){
                if($key['pid']){
                    $key['parents'] = $all_menu[$key['pid']];
                }
            }
        }
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        //权限分类
        $AuthType = D('Module')->where('isauth = 1')->getField('id,title,name');
        //模板赋值
        $this->assign('list',$list);
        $this->assign('AuthType',$AuthType);
        $this->assign('type',$type);
        $this->assign('pid',$pid);
        $this->assign('title',$title?$title:'菜单名称');
        $this->display();
    }

    /**
     * 新增菜单
     */
    public function add(){
        $model = D('Menu');
        if(IS_POST){
            $data = $model->create();
            if($data){
                $id = $model->add();
                if($id){
                    session('ADMIN_MENU_LIST',null);
                    $this->success('菜单添加成功', Cookie('__forward__'));
                } else {
                    $this->error('菜单添加失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            //模块信息
            $type = I('type/d');
            $type = $type? $type : 1;
            $module = module($type,'name');
            // 菜单树
            $tree = $this->getTree(CONTROLLER_NAME, 'id,pid,title', array('module'=>$module));
            //模块权限
            $moduleArr = $this->authmodule();
            foreach ($moduleArr as $key => $value) {
                $AuthModule[$value['name']] = $value['title'];
            }
            $info = array();
            //模板赋值
            $this->assign('radioType',array('普通菜单','权限控制'));
            $this->assign('info',array('pid'=>I('pid'),'module'=>$module));
            $this->assign('AuthModule',$AuthModule);
            //会员模型ID
            $this->assign('modelid', array('全部')+ D('Model')->models(3));
            $this->assign('Menus', $tree);
            $this->display('edit');
        }
    }

    /**
     * 编辑配置
     */
    public function edit($id = 0){
        $model = D('Menu');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    session('ADMIN_MENU_LIST',null);
                    menus($data['module'], true);
                    $this->success('菜单更新成功', Cookie('__forward__'));
                } else {
                    $this->error('菜单更新失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            if(!(int)$id) $this->error('参数错误!');
            $info = array();
            /* 获取数据 */
            $info = $model->field(true)->find($id);
            if(false === $info){
                $this->error('获取后台菜单信息错误');
            }
            //模块信息
            $type = I('type/d');
            $type = $type? $type : 1;
            $module = module($type,'name');
            // 菜单树
            $tree = $this->getTree(CONTROLLER_NAME, 'id,pid,title', array('module'=>$info['module']));
            //模块权限列表
            $moduleArr = $this->authmodule();
            foreach ($moduleArr as $key => $value) {
                $AuthModule[$value['name']] = $value['title'];
            }
            //模板赋值
            $this->assign('info', $info);
            $this->assign('AuthModule',$AuthModule);
            $this->assign('Menus', $tree);
            $this->assign('radioType',array('普通菜单','权限控制'));
            //会员模型ID
            $this->assign('modelid', array('全部')+ D('Model')->models(3));
            $this->meta_title = '编辑后台菜单';
            $this->display();
        }
    }


}