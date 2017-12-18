<?php
// +----------------------------------------------------------------------
// | hicms | 联动控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class LinkageController extends AdminController {
    /**
     * 联动列表
     */
    public function index(){
        $model = D('Linkage');
        $pid = (int)I('get.pid/d', 0);
        $sort = $pid ? 'value asc' : 'id asc';
        $type = I('type/d') ? I('type/d') : 1;
        // 查询条件
        $map = array();
        // 类别
        if(!$pid){
            $map['type'] = $type;
        }
        $map['status'] = array('gt', -1);
        $map['pid'] = $pid;
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        $list = $model->where($map)->order($sort)->select();
        foreach ($list as $key => $value) {
            if($value['pid']){
                $list[$key]['url'] = 'javascript:;';
            }else{
                $list[$key]['url'] = U('index',array('pid'=>$value['id'], 'type'=>$type));
            }
        }
        /*赋值*/
        $this->assign('list', $list);
        $this->assign('pid', $pid);
        $this->assign('LinkageType',linkage(1));
        $this->assign('type',$type);
        $this->meta_title = '联动管理';
        $this->display();
    }

    /**
     * 添加联动
     */
    public function add(){
        $model = D('Linkage');
        if(IS_POST){
            $data = $model->create();
            if($data){
                $id = $model->add();
                if($id){
                    $this->success('联动菜单添加成功', Cookie('__forward__'));
                } else {
                    $this->error('联动菜单添加失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            $pid = I('get.pid/d', 0);
            if(!empty($pid)){
                $value = $model->where('pid='.$pid)->order('value desc')->getFieldByPid($pid,'value');
            }
            $this->meta_title = '添加联动菜单';
            $this->assign('info', array('pid' => $pid, 'value' => $value + 1, 'type'=>I('get.type/d')));
            $this->display('edit');
        }
    }

    /**
     * 编辑联动
     */
    public function edit($id = 0){
        $model = D('Linkage');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $data['pid'] ? linkage($data['pid'], true): linkage($data['name'], true);
                    $this->success('联动菜单编辑成功', Cookie('__forward__'));
                } else {
                    $this->error('联动菜单编辑失败');
                }

            } else {
                $this->error($model->getError());
            }
        } else {
            $info = $model->find($id);
            if(false === $info){
                $this->error('获取配置信息错误');
            }
            $this->assign('info', $info);
            $this->meta_title = '编辑联动菜单';
            $this->display();
        }
    }

    /**
     * 删除联动
     */
    public function del(){
        $ids = array_filter(array_unique((array)I('ids',0)));
        if (empty($ids)) {
            $this->error('请选择要操作的联动菜单!');
        }
        $model = M('Linkage');
        $map = array('id' => array('in', $ids) );
        /*是否有子联动*/
        $where = array('pid' => array('in', $ids));
        $child = $model-> where($where)-> select();
        if($child){
            $this->error('请先删除联动子菜单');
        }
        if( $model-> where($map)-> delete()){
            $this->success('联动菜单删除成功');
        } else {
            $this->error('联动菜单删除失败！');
        }
    }

     /**
     * 联动排序
     */
    public function config(){
        if (IS_POST){
            $ids    = I('post.value');
            foreach ($ids as $key=>$value){
                $res = M('linkage')->where(array('id'=>$key))->setField('value', $value);
            }
            if($res!== false){
                $this->success('排序成功！');
            }else{
                $this->error('排序失败！');
            }
        }else{
            $this->error('非法请求！');
        }
    }

}