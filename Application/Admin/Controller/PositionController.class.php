<?php
// +----------------------------------------------------------------------
// | hicms | 推荐位管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class PositionController extends AdminController {
    /*推荐位列表*/
    public function index(){
        $map = array();
        $modelid = I('model/d') ? I('model/d') : 0;
        if(!empty($modelid)){
            $map['_string']="FIND_IN_SET('".$modelid."', modelid)";
        }
        $list = $this->lists('Position', $map, 'sort asc');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        // 模板赋值
        $this->assign('ModelType', M('Model')->where(array('id'=>array('neq',1), 'type'=>array('in','1,2')))->getField('id, title', true));
        $this->assign('model', $modelid);
        $this->assign('list', $list);
        $this->display();
    }

    /*添加推荐位*/
    public function add(){
        $model = D('Position');
        if(IS_POST){
            $data = $model->create();
            if($data){
                $id = $model->add();
                if($id){
                    $this->success('添加'.$data['title'].'成功', U('index'));
                } else {
                    $this->error('添加'.$data['title'].'失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            //模板赋值
            $this->assign('info', array('type'=>I('get.type/d'), 'model'=>'1,3'));
            $this->assign('model', M('Model')->where(array('type'=>array('in','1,2')))->getField('id, title', true));
            $this->meta_title = '添加推荐位';
            $this->display('edit');
        }
    }

    /*编辑推荐位*/
    public function edit($id = 0){
        $model = D('Position');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $this->success('编辑'.$data['title'].'成功', U('index'));
                } else {
                    $this->error('编辑'.$data['title'].'失败');
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
            $this->assign('model', M('Model')->where(array('type'=>array('in','1,2')))->getField('id, title', true));
            $this->meta_title = '编辑推荐位';
            $this->display();
        }
    }

    /*推荐信息列表*/
    public function content(){
        $model = M('PositionData');
        $map = array();
        $map['posid'] = I('get.id/d');
        //当前推荐位总数据
        $total = $model->where($map)->count();
        //当前推荐位最大存储数据量
        $pos = position($map['posid']);
        if($total > $pos['maxnum']){
            $r = $model->where($map)->order("sort DESC, id DESC")->limit($pos['maxnum'].", 100")->select();
            if ($r && $pos['maxnum']) {
                foreach ($r as $k => $v) {
                    //删除多余信息
                    $model->where(array('id' => $v['id'], 'posid' => $v['posid'], 'catid' => $v['catid']))->delete();
                    //更新文章推荐信息
                    D('Position')->updatapos($v['id'], $v['modelid']);
                }
            }
        }
        // 信息列表
        $list = $model->where($map)->select();
        foreach ($list as $k => $v) {
            //反序列化
            $list[$k]['data'] = unserialize($v['data']);
            //当前表名
            $table = tablename($v['modelid']);
            //当前信息URL地址
            $list[$k]['data']['url'] = M($table)->where(array("id" => $v['id']))->getField("url");
        }
        //记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        //模板赋值
        $this->assign('list', $list);
        $this->assign('meta_title', $pos['title'].'-信息列表');
        $this->display();
    }

    /*移除推荐信息*/
    public function remove(){
        $items = array_filter(array_unique((array)I('ids',0)));
        if (empty($items)) {
            $this->error('请选择要操作的数据!');
        }
        foreach ($items as $item) {
            //分割数组
            $_v = explode('-', $item);
            D('Position')->remove((int)$_v[0], (int) $_v[1], (int) $_v[2]);
        }
        $this->success("推荐位信息移除成功！");
    }


}