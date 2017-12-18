<?php
// +----------------------------------------------------------------------
// | hicms | 日志管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class TagsController extends AdminController {
    // 后台管理操作日志
    public function index(){
        $title= trim(I('get.title/s'));
        $map = array();
        if(isset($title)){
            $map['tag'] = array('like', '%'.(string)$title.'%');
        }
        $list = $this->lists('Tags',$map,'sort asc, id desc');
        $this->assign("list", $list);
        $this->assign('title',$title?$title:'Tags标签');
        $this->display();
    }

    // 编辑
    public function edit($id = 0){
        $model = D('Tags');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $this->success('Tag标签编辑成功', U('index'));
                } else {
                    $this->error('Tag标签编辑失败');
                }

            } else {
                $this->error($model->getError());
            }
        } else {
            $info = array();
            $info = $model->find($id);
            if(false === $info){
                $this->error('获取配置信息错误');
            }
            $this->assign('info', $info);
            $this->display();
        }
    }

    //删除tags
    public function del() {
        $model = D('Tags');
        if (IS_POST) {
            $tagid = $_POST['tagid'];
            if (is_array($tagid)) {
                foreach ($tagid as $tid) {
                    $info = $model->where(array('tagid' => $tid))->find();
                    if (!empty($info)) {
                        if ($model->delete() !== false) {
                            M('TagsData')->where(array('tag' => $info['tag']))->delete();
                        }
                    }
                }
                $this->success("删除成功！");
            } else {
                $this->error("参数错误！");
            }
        } else {
            $tagid = I('get.tagid', 0, 'intval');
            $info = $model->where(array('tagid' => $tagid))->find();
            if (empty($info)) {
                $this->error("该Tags不存在！");
            }
            if ($model->delete() !== false) {
                M('TagsData')->where(array('tag' => $info['tag']))->delete();
                $this->success('删除成功！');
            } else {
                $this->error('删除失败！');
            }
        }
    }

}