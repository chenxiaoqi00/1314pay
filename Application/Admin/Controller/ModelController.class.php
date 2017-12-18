<?php
// +----------------------------------------------------------------------
// | hicms | 模型管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Think\Db;
use Libs\Database;
class ModelController extends AdminController {
    /**
     * 模型列表
     */
    public function index(){
        $map['status'] = array('gt', -1);
        $map['type'] = I('type/d') ? I('type/d') : 1;
        $list = $this->lists('Model', $map, 'sort asc');
        //记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        // 赋值
        $this->assign('ModelType', linkage('MODEL'));
        $this->assign('type', $map['type']);
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 添加模型
     */
    public function add(){
        $model = D('Model');
        if(IS_POST){
            $data = $model->create ();
            if($data){
                $id = $model->add();
                if($id){
                    $this->success('添加模型成功', U('index'));
                } else {
                    $this->error('添加模型失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            //模板赋值
            //dump(viewPath('./Tpl/Admin/Public/', 2, '*'));
            $this->assign('info', array('type'=>I('get.type/d')));
            $this->assign('tpl_show',viewPath('./Tpl/Home/list/', 2, 'list*'));
            $this->assign('tpl_list',viewPath('./Tpl/Home/show/', 2, 'show*'));
            $this->assign('tpl_publish',viewPath('./Tpl/Admin/Public/', 2, '*'));
            $this->meta_title = '添加模型';
            $this->display('edit');
        }
    }

    /**
     * 编辑模型
     */
    public function edit($id = 0){
        $model = D('Model');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $this->success('模型编辑成功', U('index'));
                } else {
                    $this->error('模型编辑失败');
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
            $this->assign('info', $info);
            $this->meta_title = '编辑模型';
            $this->display();
        }
    }

    // 生成模型
    public function build(){
        $model = D('Model');
        if(IS_POST){
            $table = I('post.table');
            empty($table) && $this->error('请选择要生成的数据表！');
            $res = $model->build();
            if($res){
                $this->success('生成模型成功！', U('index'));
            }else{
                $this->error(D('Model')->getError());
            }
        }else{
            //获取所有的数据表
            $tables = $model->getTables();
            foreach ($tables as $key => $value) {
                $table[$value] = $value;
            }
            $this->assign('tables', $table);
            $this->assign('info', array('type'=>I('get.type/d')));
            $this->meta_title = '生成模型';
            $this->display();
        }
    }



    /**
     * 字段列表
     */
    public function fields(){
        $map['status'] = array('gt', -1);
        $map['modelid'] = I('model/d') ? I('model/d') : 1;
        $list = M('ModelField')->where($map)->field('id,title,name,type,status,isposition,sort')->select();
        //记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        // 赋值
        $this->assign('type', $map['type']);
        $this->assign('list', $list);
        $this->assign('model', $map['modelid']);
        $this->display();
    }

    /**
     * 编辑字段
     */
    public function field($id = 0){
        $model = D('ModelField');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $this->success('字段编辑成功', U('index'));
                } else {
                    $this->error('字段编辑失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            $info = array();
            if($id){
                /* 获取数据 */
                $info = $model->find($id);
                if(false === $info){
                    $this->error('获取字段信息错误');
                }
            }else{
                $info['isshow'] = 1;
                $info['modelid'] = I('get.model/d');
            }

            //模板赋值
            $this->assign('isshow', array('不显示','始终显示','新增显示','编辑显示'));
            $this->assign('fieldType', get_field_type());
            $this->assign('info', $info);
            $this->meta_title = '编辑字段';
            $this->display();
        }
    }

    /**
     * 更新字段
     */
    public function update(){
        $res = D('ModelField')->update();
        if(!$res){
            $this->error(D('ModelField')->getError());
        }else{
            $this->success($res['id']?'更新成功':'新增成功', Cookie('__forward__'));
        }
    }


}