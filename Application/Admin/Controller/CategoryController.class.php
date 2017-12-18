<?php
// +----------------------------------------------------------------------
// | hicms | 文章分类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Libs\Tree;
class CategoryController extends AdminController {
    public function index(){
        //$tree = Tree::getSameCate(allcategorys(), 10);
        //print_r(categorys(2));
        if(trim(I('title'))){
            $map['title'] = array('like',"%{$title}%");
        }
        if(I('pid')){
            $map['pid'] = I('get.pid/d');
        }else{
            $map['pid'] = 0;
        }
        $list = D('Category')->where($map)->order('sort desc, id asc')->select();
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        $this->assign('list',$list);
        $this->assign('pid',I('pid'));
        $this->display();
    }

    /* 编辑分类 */
    public function edit($id = null, $pid = 0){
        $model = D('Category');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $this->success('栏目修改成功！', Cookie('__forward__'));
                } else {
                    $this->error('栏目修改失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            $pid = I('get.pid', 0, 'intval');
            // 栏目树
            $tree = $this->getTree();
            /* 获取分类信息 */
            $this->assign('model', D('Model')->models());
            $this->assign('info',  D('Category')->find($id));
            $this->assign('category', $tree);
            $this->meta_title = '新增分类';
            $this->display('edit');
        }
    }

    /* 添加分类 */
    public function add($pid = 0){
        $model = D('Category');
        if(IS_POST){
            $data = $model->create();
            if($data){
                $id = $model->add();
                if($id){
                    $this->success('栏目添加成功', Cookie('__forward__'));
                } else {
                    $this->error('栏目添加失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            $pid = I('get.pid', 0, 'intval');
            // 文章类型
            // 栏目树
            $tree = $this->getTree();
            /* 获取分类信息 */
            $this->assign('info',array('pid'=>$pid));
            $this->assign('category', $tree);
            $this->assign('model', D('Model')->models());
            $this->meta_title = '新增分类';
            $this->display('edit');
        }
    }

    /**
     * 删除一个分类
     */
    public function del(){
        $cate_id = I('id');
        if(empty($cate_id)){
            $this->error('参数错误!');
        }
        //判断该分类下有没有子分类，有则不允许删除
        $child = M('Category')->where(array('pid'=>$cate_id))->field('id')->select();
        if(!empty($child)){
            $this->error('请先删除该分类下的子分类');
        }
        //删除该分类信息
        $res = M('Category')->delete($cate_id);
        if($res !== false){
            $this->success('删除分类成功！');
        }else{
            $this->error('删除分类失败！');
        }
    }

    public function dorepair(){
        // 刷新缓存
        categorys(true);
        $categorys = categorys();
        foreach ($categorys as $v) {
            $categorys[$v['id']] = $v;
        }
        $done = $this->repair($categorys);
        if($done){
            $this->success('栏目数据更新成功！');
        }else{
            $this->error('栏目数据更新失败！');
        }
    }

    /**
     * 修复栏目数据
     * @param type $categorys 需要修复的栏目数组
     * @return boolean
     */
    public function repair($categorys) {
        if (is_array($categorys)) {
            foreach ($categorys as $catid => $value) {
                //外部栏目无需修复
                /*if ($cat['type']) {
                    continue;
                }*/
                //获取父栏目ID列表
                $arrparentid = D("Category")->getArrparentid($catid);
                //获取子栏目ID列表
                $arrchildid = D("Category")->getArrchildid($catid);
                //检查所有父id 子栏目id 等相关数据是否正确，不正确更新
                $updata = array();
                $updata['arrparentid'] = $arrparentid;
                $updata['arrchildid'] = $arrchildid;
                $updata['child'] = $arrchildid ? 1:0;
                if ($categorys[$catid]['arrparentid'] != $arrparentid || $categorys[$catid]['arrchildid'] != $arrchildid) {
                    D("Category")->where(array('id' => $catid))->save($updata);
                }
                //获取栏目名称
                $catname = iconv('utf-8', 'gbk', $value['title']);
                //返回拼音
                $letters = gbk_to_pinyin($catname);
                $letter = strtolower(implode('', $letters));
                //更新数据
                if ($categorys[$catid]['letter'] != $letter) {
                    D("Category")->where(array('id' => $catid))->save(array('letter' => $letter));
                }
            }
        }
        //更新缓存
        category($catid, '', true);
        return true;
    }
}
