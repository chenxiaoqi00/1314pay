<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class AdController extends AdminController {
    /*广告位首页*/
    public function index(){
        $list = D('Adpos')->select();
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        $this->assign('list', $list);
        $this->meta_title = '广告位管理';
        $this->display('Ad/index');
    }

    /*广告列表*/
    public function postion(){
        //获取广告位
        $where['pos'] = I('get.id/d');
        $list = D('Ad')->where($where)->order('sort asc')->relation(true)->select();
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        $this->assign('pos', I('get.id/d'));
        $this->assign('list', $list);
        $this->meta_title = '广告管理 ('.$this->getpostion($where['pos']).')';
        $this->display();
    }

    /*添加广告位*/
    public function pos(){
        if(IS_POST){
            $model = D('Adpos');
            $data = $model->create();
            if($data){
                $id = $model->add();
                if($id){
                    //记录行为
                    $this->success('添加广告位成功', U('index'),Cookie('__forward__'));
                } else {
                    $this->error('添加广告位失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            $this->assign('tpl',$this->tpl());
            $this->assign('info',null);
            $this->meta_title = '添加广告位';
            $this->display('pos');
        }
    }

    /**
     * 编辑广告位
     */
    public function editpos($id = 0){
        if(IS_POST){
            $model = D('Adpos');
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $this->success('广告位编辑成功', U('index'),Cookie('__forward__'));
                } else {
                    $this->error('广告位编辑失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            $info = array();
            /* 获取数据 */
            $info = D('Adpos')->find($id);
            if(false === $info){
                $this->error('获取配置信息错误');
            }
            $pos = $this->tpl();
            $this->assign('tpl',$this->tpl());
            $this->assign('info', $info);
            $this->meta_title = '编辑广告位';
            $this->display('Ad/pos');
        }
    }

    /*添加广告*/
    public function add(){
        if(IS_POST){
            $model = D('Ad');
            $data = $model->create();
            if($data){
                $id = $model->add();
                if($id){
                    //添加附件
                    addAttachment($data['image'], $id, 0, 'ad');
                    $this->success('添加广告成功', U('postion',array('id'=>$data['pos'])));
                } else {
                    $this->error('添加广告失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            //获取广告位
            $map['id'] = I('get.pos/d');
            $this->assign('info', array('pos'=> $map['id'], 'enddate'=>strtotime(date("Y-m-d",strtotime("+3 month")))));
            $this->meta_title = '添加广告';
            $this->display('edit');
        }
    }

    /**
     * 编辑广告
     */
    public function edit($id = 0){
        $model = D('Ad');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    //添加附件
                    addAttachment($data['image'], $data['id'], 0, 'ad');
                    $this->success('广告编辑成功', U('postion',array('id'=>$data['pos'])),Cookie('__forward__'));
                } else {
                    $this->error('广告编辑失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            //获取广告位
            $info = $model->find($id);
            if(false === $info){
                $this->error('获取配置信息错误');
            }
            /* 获取数据 */
            $info['setting'] = obj2arr(json_decode($info['setting']));
            $this->assign('info', $info);
            $this->meta_title = '编辑广告';
            $this->display();
        }
    }

    /**
     * 获取模板路径
     * @return array 模板列表
     */
    public function tpl(){
        $tplDir = APP_PATH . MODULE_NAME . '/View/Ad/tpl/';
        if(!is_dir($tplDir)){
            return false;
        }
        $listFile=scandir($tplDir);
        if(is_array($listFile)){
            $list=array();
            foreach ($listFile as $key => $value) {
                if ($value != "." && $value != "..") {
                    $list[$key]['file']=$value;
                    $list[$key]['name']=substr($value, 0, -5);
                }
            }
        }
        return $list;
    }

    /*预览广告*/
    public function preview(){
        $map['id'] = I('get.id/d',0);
        $where['status'] = array('eq',1);
        $pos = D('Adpos')->where($map)->where($where)->field('tpl,width,height')->find();
        $list = D('Ad')->where('pos='.$map['id'])->order('sort asc')->where($where)->select();
        foreach ($list as $key => $value) {
            $setting = obj2arr(json_decode($value['setting']));
            $list[$key]['image'] = $setting['image'];
            $list[$key]['url'] = $setting['url'];
            $list[$key]['color'] = $setting['color'];
        }
        $tplDir = 'Ad/tpl/';
        $this->assign('pos',$pos);
        $this->assign('list',$list);
        $this->display($tplDir.$pos['tpl']);
    }

    /*广告生成快速缓存*/
    public function create(){
        $ids = array_unique(I('id'));
        if (empty($ids) ) {
            $this->error('请选择要操作的数据!');
        }
        foreach ($ids as $key=>$id){
            $map['id'] = $id;
            $where['status'] = array('eq',1);
            $pos = D('Adpos')->where($map)->where($where)->field('tpl,width,height')->find();
            $list = D('Ad')->where('pos='.$map['id'])->order('sort asc')->where($where)->select();
            foreach ($list as $key => $value) {
                $setting = obj2arr(json_decode($value['setting']));
                $list[$key]['image'] = $setting['image'];
                $list[$key]['url'] = $setting['url'];
                $list[$key]['color'] = $setting['color'];
            }
            $tplDir = 'Ad/tpl/';
            $this->assign('pos',$pos);
            $this->assign('list',$list);
            /*模板缓冲区*/
            ob_start();
            $this->display($tplDir.$pos['tpl']);
            $ad = ob_get_contents();
            ob_clean();
            F('AD_'.$id,$ad,DATA_PATH.'/AD/');
        }
        $this->success('广告生成成功！');
    }

    function getpostion($pos){
        return D('Adpos')->cache('postion_'.$pos)->where(array('id'=>$pos))->getField('title');
    }

}