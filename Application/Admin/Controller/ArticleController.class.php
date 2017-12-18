<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Admin\Model\AuthGroupModel;
use Think\Page;
/**
 * 后台内容控制器
 */
class ArticleController extends AdminController {
    /* 保存允许访问的公共方法 */
    static protected $allow = array( 'draftbox','myArticle');
    private $catid   = null; //文档分类id
    private $modelid = 2;    //模型ID
    /**
     * 检测需要动态判断的文档类目有关的权限
     *
     * @return boolean|null
     *      返回true则表示当前访问有权限
     *      返回false则表示当前访问无权限
     *      返回null，则会进入checkRule根据节点授权判断权限
     *
     */
    protected function checkDynamic(){
        $cates = AuthGroupModel::getAuthCategories(UID);
        switch(strtolower(ACTION_NAME)){
            case 'index':   //文档列表
            case 'add':   // 新增
                $catid =  I('catid/d');
                break;
            case 'edit':    //编辑
            case 'update':  //更新
                $article_id  =  I('id/d');
                $catid =  M('Article')->where(array('id'=>$article_id))->getField('catid');
                break;
            case 'setstatus': //更改状态
            case 'permit':    //回收站
                $article_id  =  (array)I('ids');
                $catid =  M('Article')->where(array('id'=>array('in',$article_id)))->getField('catid',true);
                $catid =  array_unique($catid);
                break;
        }
        if(!$catid){
            return null;//不明
        }elseif( !is_array($catid) && in_array($catid,$cates) ) {
            return true;//有权限
        }elseif( is_array($catid) && $catid==array_intersect($catid,$cates) ){
            return true;//有权限
        }else{
            return false;//无权限
        }
    }

    // 显示左边菜单，进行权限控制
    protected function getMenu(){
        //获取动态分类
        $cate_auth  =   AuthGroupModel::getAuthCategories(UID); //获取当前用户所有的内容权限节点
        $cate_auth  =   $cate_auth == null ? array() : $cate_auth;
        $cate = M('Category')->where(array('status'=>1))->field('id,title,pid')->order('pid,sort')->select();
        //没有权限的分类则不显示
        if(!IS_ROOT){
            foreach ($cate as $key=>$value){
                if(!in_array($value['id'], $cate_auth)){
                    unset($cate[$key]);
                }
            }
        }
        $cate        = list_to_tree($cate);    //生成分类树
        //获取分类id
        $catid       = I('param.catid');
        $this->catid = $catid;
        //生成每个分类的url
        foreach ($cate as $key=>&$value){
            if(!empty($value['_child'])){
                foreach ($value['_child'] as $ka=>&$va){
                    if($va['id'] == $catid){
                        $value['active'] = true;
                        $va['active']    = true;
                    }
                    $va['url']   =   'article/index?catid='.$va['id'];
                    if(!empty($va['_child'])){
                        foreach ($va['_child'] as $k=>&$v){
                            $v['url']   =   'article/index?catid='.$v['id'];
                            $v['pid']   =   $va['id'];
                            // 所有父目录为激活状态
                            if($v['id'] == $catid){
                                $value['active'] = true;
                                $va['active']    = true;
                                $v['active']     = true;
                            }
                        }
                    }
                }
            }
        }
        $this->assign('nodes',$cate);
        $this->assign('catid', $this->catid);
        //获取回收站权限
        $this->assign('show_recycle', IS_ROOT || $this->checkRule('Admin/Article/recycle'));
    }

    /**
     * 分类文档列表页
     * @param integer $catid 分类id
     * @param integer $model_id 模型id
     * @param integer $position 推荐标志
     * @param integer $group_id 分组id
     */
    public function index($catid = null){
        //获取左边菜单
        $this->getMenu();
        if($catid===null){
            $catid = $this->catid;
        }
        $modelid = category($catid, 'modelid');
        $model = model($modelid, 'tablename');
        $modelid = $modelid ? $modelid :$this->modelid;
        //$model = $this->model;
        $this->assign('modelid', $modelid);
        if($modelid == 1){
            $this->page($catid);
        }else{
            $this->article($catid);
        }
    }

    /*单页*/
    public function page($catid){
        $model = D('Page');
        if(IS_POST){
            $data = $model->create();
            if(empty($data['catid'])){
                if($model->add()){
                    $this->success('更新'.$data['title'].'成功');
                }else{
                    $this->error('更新'.$data['title'].'失败');
                }
            }else{
                if($model->save()!== false){
                    $this->success('更新'.$data['title'].'成功');
                }else{
                    $this->error('更新'.$data['title'].'失败');
                }
            }
        }else{
            $this->assign('meta_title', $catid ? category($catid, 'title') : '');
            $info = $model->find($catid);
            $info['title'] = $info['title'] ? $info['title'] : category($catid, 'title');
            $this->assign('info',$info);
            $this->display('page');
        }
    }

    /*文章列表*/
    public function article($catid){
        $title= trim(I('get.title/s'));
        $map = array();
        // 状态
        if(isset($_GET['status'])){
            $map['status'] = I('status');
            $status = $map['status'];
        }else{
            $status = null;
            $map['status'] = array('in', '0,1,2');
        }
        // 栏目ID
        if($catid){
            $map['catid'] = $catid;
        }
        // 关键词
        if(isset($title)){
            $map['title'] = array('like', '%'.(string)$title.'%');
        }
        // 开始时间
        if ( isset($_GET['start_date']) ) {
            $map['inputtime'][] = array('egt',strtotime(I('start_date')));
        }
        // 结束时间
        if ( isset($_GET['end_date']) ) {
            $map['inputtime'][] = array('elt',24*60*60 + strtotime(I('end_date')));
        }
        // 用户名|手机|邮箱
        if ( isset($_GET['username']) ) {
            $verify = new \Libs\Verify();
            if($verify::isMobile(I('username'))){
                $map['uid'] = M('Member')->where(array('mobile'=>I('username')))->getField('id');
            }else if($verify::isEmail(I('username'))){
                $map['uid'] = M('Member')->where(array('email'=>I('email')))->getField('id');
            }else{
                $map['uid'] = M('Member')->where(array('username'=>I('username/s')))->getField('id');
            }
        }
        $list = $this->lists('Article', $map, 'status desc, sort desc, id desc', 'id,title,catid,inputtime,thumb,ispos,status,sort,uid');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        // 栏目树
        $tree = $this->getTree('Category');
        // 模板赋值
        $this->assign('category', $tree);
        $this->assign('list', $list);
        $this->assign('title',$title?$title:'文章标题');
        $this->assign('meta_title', $catid ? '文章管理 - '.category($catid, 'title') : '文章资讯管理');
        $this->display('article');
    }

    /*添加*/
    public function add($catid = null){
        if(IS_POST){
            $done = D('Article')->update();
            if(!$done){
                $this->error(D('Article')->getError());
            }else{
                $this->success('文章'.I('post.title').'发布成功', Cookie('__forward__'));
            }
        }else{
            //获取左边菜单
            $this->getMenu();
            if($catid===null){
                $catid = $this->catid;
            }
            $tree = $this->getTree('Category');
            // 赋值
            $this->assign('postion', linkage('POSTION_INDEX'));
            $this->assign('info',array('catid'=>$catid));
            $this->assign('category', $tree);
            $this->display('edit');
        }
    }

    /* 编辑 */
    public function edit(){
        $model = D('Article');
        if(IS_POST){
            $done = $model->update();
            if(!$done){
                $this->error($model->getError());
            }else{
                $this->success('文章'.I('post.title').'编辑成功', Cookie('__forward__'));
            }
        }else{
            $id = (int)I('get.id');
            if(empty($id)){
                $this->error('参数有误！');
            }
            $info = $model->field(true)->relation(true)->find($id);
            if(!(is_array($info) || 1 !== $info['status'])){
                $this->error = '文章被禁用或已删除！';
            }
            //获取左边菜单
            $this->getMenu();
            if($catid===null){
                $catid = $this->catid;
            }
            $tree = $this->getTree('Category');
            $this->assign('info', $info);
            $this->assign('category', $tree);
            $this->display('edit');
        }
    }

    // 检测标题是否存在
    public function unique($title){
        if(empty($title)){
            $this->error('请输入标题');
        }
        $do = D('Article')->where("title = '%s'", $title)->find();
        if($do){
            $this->error('标题已存在');
        }else{
            $this->success('标题可使用');
        }
    }

    /**
     * 移动文档
     */
    public function move() {
        $ids = I('ids');
        if(empty($ids)) {
            $this->error('请选择要移动的文档！');
        }
        $catid = I('get.catid');
        if(!$catid){
            $this->error('请选择栏目！');
        }
        $is = category($catid);
        if($is){
            $this->error('请选择子栏目！');
        }
        $map['id'] = array('in',$ids);
        $done = D('Article')-> where($map)->setField('catid',$catid);
        if($done){
            $this->success('操作成功！');
        }else{
            $this->error('操作失败，请稍候再试');
        }

    }


}