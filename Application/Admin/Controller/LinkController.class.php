<?php
// +----------------------------------------------------------------------
// | hicms | 友情链接管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class LinkController extends AdminController {
    /**
     * 友情链接列表
     */
    public function index(){
        $map['status'] = array('gt', -1);
        $type = I('type/d') ? I('type/d') : 1;
        $list = $this->lists('Link', $map, 'sort asc');
        foreach ($list as $key => $value) {
            if($value['logo']){
                $list[$key]['show'] = '<span class="label label-primary">图片</span>';
            }else{
                $list[$key]['show'] = '<span class="label label-info">文字</span>';
            }
        }
        // 赋值
        $this->assign('LinkType',linkage('LINK'));
        $this->assign('type',$type);
        $this->assign('list', $list);
        $this->meta_title = '友情链接管理';
        $this->display();
    }

    /**
     * 添加友情链接
     */
    public function add(){
        if(IS_POST){
            $model = D('Link');
            $data = $model->create ();
            if($data){
                $id = $model->add();
                if($id){
                    //添加附件
                    addAttachment($data['logo'], $id, 0, 'link');
                    $this->success('添加友情链接成功', U('index'));
                } else {
                    $this->error('添加友情链接失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            //模板赋值
            $this->assign('showType',array('文字','图片'));
            $this->assign('info',array('show'=>1));
            $this->meta_title = '新增友情链接';
            $this->display('edit');
        }
    }

    /**
     * 编辑友情链接
     */
    public function edit($id = 0){
        $model = D('Link');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    //添加附件
                    addAttachment($data['logo'], $data['id'], 0, 'link');
                    $this->success('友情链接编辑成功', U('index'));
                } else {
                    $this->error('友情链接编辑失败');
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
            $info['show'] = $info['logo']?1:0;
            //模板赋值
            $this->assign('showType',array('文字','图片'));
            $this->assign('info', $info);
            $this->meta_title = '编辑友情链接';
            $this->display();
        }
    }
}