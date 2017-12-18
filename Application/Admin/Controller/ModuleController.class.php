<?php
// +----------------------------------------------------------------------
// | hicms | 模块管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class ModuleController extends AdminController {
    // 项目模块列表
    public function index(){
        $title= trim(I('get.title/s'));
        $map = array();
        if(isset($title)){
            $map['title'] = array('like', '%'.(string)$title.'%');
        }
        $list = $this->lists('Module',$map,'sort asc, id desc');
        $this->assign('list', $list);
        $this->assign('title',$title?$title:'模块名称');
        $this->display();
    }

    // 添加模块
    public function add(){
        if(IS_POST){
            $model = D('Module');
            $data = $model->create();
            if($data){
                $id = $model->add();
                if($id){
                    $this->success('模块添加成功', U('index'));
                } else {
                    $this->error('模块添加失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            $this->assign('info',null);
            $this->meta_title = '新增模块';
            $this->display('edit');
        }
    }

    // 编辑
    public function edit($id = 0){
        if(IS_POST){
            $model = D('Module');
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $this->success('模块编辑成功', U('index'));
                } else {
                    $this->error('模块编辑失败');
                }

            } else {
                $this->error($model->getError());
            }
        } else {
            $info = array();
            $info = D('Module')->find($id);
            if(false === $info){
                $this->error('获取配置信息错误');
            }
            $this->assign('info', $info);
            $this->meta_title = '编辑模块';
            $this->display();
        }
    }



}