<?php
// +----------------------------------------------------------------------
// | hicms | 碎片管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class BlockController extends AdminController {
    /**
     * 碎片列表
     */
    public function index(){
        $list = $this->lists('block');
        echo block('bottome_nav');
        // 赋值
        $this->assign('list', $list);
        $this->meta_title = '碎片管理';
        $this->display();
    }

    /**
     * 添加碎片
     */
    public function add(){
        if(IS_POST){
            $model = D('Block');
            $data = $model->create ();
            if($data){
                $id = $model->add();
                if($id){
                    $this->success('添加碎片成功', U('index'));
                } else {
                    $this->error('添加碎片失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            //模板赋值
            $this->assign('BlockType',linkage('BLOCK'));
            $this->assign('info',array('type'=>2));
            $this->meta_title = '添加碎片';
            $this->display('edit');
        }
    }

    /**
     * 编辑碎片
     */
    public function edit($id = 0){
        $model = D('Block');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    //刷新缓存
                    block($data['id'], true);
                    $this->success('碎片编辑成功', U('index'));
                } else {
                    $this->error('碎片编辑失败');
                }

            } else {
                $this->error($model->getError());
            }
        } else {
            $info = array();
            /* 获取数据 */
            $info = $model->find($id);
            if(false === $info){
                $this->error('获取配置信息错误');
            }
            //模板赋值
            $this->assign('BlockType',linkage('BLOCK'));
            $this->assign('info', $info);
            $this->meta_title = '编辑碎片';
            $this->display();
        }
    }
}