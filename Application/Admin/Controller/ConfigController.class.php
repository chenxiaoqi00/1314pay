<?php
// +----------------------------------------------------------------------
// | hicms | 系统配置
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;
class ConfigController extends AdminController {
    /**
     * 配置管理
     */
    public function index(){
        $title= trim(I('get.title/s'));
        /* 查询条件初始化 */
        $map = array();
        //$map  = array('status' => 1);
        if(isset($_GET['group'])){
            $map['group'] = I('group/d',0);
        }
        if(isset($title)){
            $where['title']  = array('like', '%'.(string)I('title').'%');
            $where['name']   = array('like', '%'.(string)I('title').'%');
            $where['_logic'] = 'OR';
            $map['_complex'] = $where;
        }
        $list = $this->lists('Config', $map,'sort,id asc');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        $this->assign('group',C('CONFIG_GROUP_LIST'));
        $this->assign('group_id',I('get.group',0));
        $this->assign('list', $list);
        $this->assign('title',$title?$title:'标题或标识名称');
        $this->meta_title = '配置管理';
        $this->display();
    }

    /**
     * 新增配置
     */
    public function add(){
        if(IS_POST){
            $Config = D('Config');
            $data = $Config->create();
            if($data){
                if($Config->add()){
                    S('DB_CONFIG_DATA',null);
                    $this->success('配置添加成功', U('index'));
                } else {
                    $this->error('配置添加失败');
                }
            } else {
                $this->error($Config->getError());
            }
        } else {
            $this->meta_title = '新增配置';
            $this->assign('info',null);
            $this->display('edit');
        }
    }

    /**
     * 编辑配置
     */
    public function edit($id = 0){
        if(IS_POST){
            $Config = D('Config');
            $data = $Config->create();
            if($data){
                if($Config->save()){
                    S('DB_CONFIG_DATA',null);
                    $this->success('配置更新成功', Cookie('__forward__'));
                } else {
                    $this->error('配置更新失败');
                }
            } else {
                $this->error($Config->getError());
            }
        } else {
            if(!(int)$id) $this->error('参数错误!');
            $info = array();
            /* 获取数据 */
            $info = M('Config')->field(true)->find($id);

            if(false === $info){
                $this->error('获取配置信息错误');
            }
            $this->assign('info', $info);
            $this->meta_title = '编辑配置';
            $this->display();
        }
    }

    /**
     * 批量保存配置
     */
    public function save($config){
        if($config && is_array($config)){
            $Config = M('Config');
            foreach ($config as $name => $value) {
                $map = array('name' => $name);
                $Config->where($map)->setField('value', $value);
            }
        }
        S('DB_CONFIG_DATA',null);
        $this->success('网站设置成功！');
    }

    // 获取某个标签的配置参数
    public function group() {
        $id     =   I('get.id',1);
        $type   =   C('CONFIG_GROUP_LIST');
        $list   =   M("Config")->where(array('status'=>1,'group'=>$id))->field('id,name,title,extra,value,remark,type')->order('sort')->select();
        if($list) {
            $this->assign('list',$list);
        }
        $this->assign('id',$id);
        $this->meta_title = $type[$id].'设置';
        $this->display();
    }

    /**
     * 配置排序
     */
    public function sort(){
        if(IS_GET){
            $ids = I('get.ids');

            //获取排序的数据
            $map = array('status'=>array('gt',-1));
            if(!empty($ids)){
                $map['id'] = array('in',$ids);
            }elseif(I('group')){
                $map['group']	=	I('group');
            }
            $list = M('Config')->where($map)->field('id,title')->order('sort asc,id asc')->select();

            $this->assign('list', $list);
            $this->meta_title = '配置排序';
            $this->display();
        }elseif (IS_POST){
            $ids = I('post.ids');
            $ids = explode(',', $ids);
            foreach ($ids as $key=>$value){
                $res = M('Config')->where(array('id'=>$value))->setField('sort', $key+1);
            }
            if($res !== false){
                $this->success('配置排序成功！',Cookie('__forward__'));
            }else{
                $this->error('配置排序失败！');
            }
        }else{
            $this->error('非法请求！');
        }
    }
}