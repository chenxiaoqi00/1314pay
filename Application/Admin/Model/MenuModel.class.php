<?php
// +----------------------------------------------------------------------
// | hicms | 菜单MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model;
use Libs\Tree;
/**
 * 菜单模型
 */
class MenuModel extends Model {
    protected $_validate = array(
        array('title','require','请填写菜单名称'),
        array('icon','require','请选择图标'),
        array('module','require','模块必须选择'),
        array('module','checkModule','模块必须与上级菜单一致', self::MUST_VALIDATE, 'callback'),
        array('url','require','链接地址必须填写'),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('title', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
        array('status', '1', self::MODEL_INSERT),
    );

    public function checkModule(){
    	$pid = I('post.pid');
    	$module = I('post.module');
    	if($pid){
    		$isModule = D('Menu')->where('id ='.$pid)->getField('module');
    		if($isModule != $module){
    			return false;
    		}
    	}
    }

    /**
     * 获取参数的所有父级分类
     * @param int $cid 分类id
     * @return array 参数分类和父类的信息集合
     */
    function allmenu($module = MODULE_NAME){
        //$list = $this->where(array('status'=>1, 'module'=>strtolower($module)))->select();
        $list = menus($module);
        return $list;
    }

    /**
     * 获取树形节点
     * @param int $id 需要隐藏的节点id
     * @param string $module 模型名
     * @return mixed
     */
    public static function getMenuTree($module = ''){
        $result = array();
        /*$where['status'] = array('eq',1);
        if ($module != '') {
            $where['module'] = $module;
        }*/
        // 获取所有菜单
        $menus = Tree::toList( D('Menu')->field('id,pid,title')->select());
        foreach ($menus as $menu) {
            $result[$menu['id']] = $menu['title_display'];
        }
        return $result;
    }

    /**
     * 获取参数的所有父级分类
     * @param int $cid 分类id
     * @return array 参数分类和父类的信息集合
     */
    public static function getParent($id){
        if(empty($id)){
            return false;
        }
        $cates  =   D('Menu')->field('id,title,pid,url')->order('sort')->select();
        $child  =   D('Menu')->field('id,title,pid,url')->find($id);; //获取参数分类的信息
        $pid    =   $child['pid'];
        $temp   =   array();
        $res[]  =   $child;
        while(true){
            foreach ($cates as $key=>$cate){
                if($cate['id'] == $pid){
                    $pid = $cate['pid'];
                    array_unshift($res, $cate); //将父分类插入到数组第一个元素前
                }
            }
            if($pid == 0){
                break;
            }
        }
        return $res;
    }

    public function breadcrumb(){
        // 当前模块
        $map['module'] = array('eq', MODULE_NAME);
        // 非顶级菜单
        $map['pid'] = array('neq', 0);
        // 当前URL的菜单ID
        $map['url'] = array('like',"%".CONTROLLER_NAME."/".ACTION_NAME."%");
        $curr_id = $this->where($map)->getField('id');
        // 所有父级集合
        is_array( $parents=$this->getParent($curr_id))? null: $parents = array();
        // HTML
        $breadcrumb = '<ol class="breadcrumb">';
        $breadcrumb.= '<li><i class="fa fa-map-marker"></i></li>';
        $breadcrumb.= '<li><a class="link-effect" href="'.U('index/index').'">后台首页</a></li>';
        foreach ($parents as $key => $value) {
            $breadcrumb.= '<li><a class="link-effect" href="'.U($value["url"]).'">'.$value["title"].'</a></li>';
        }
        $breadcrumb.= '</ol>';
        return $breadcrumb;
    }

    public function current($field = null){
        $map = array();
        $map['url'] = array('like',"%".CONTROLLER_NAME."/".ACTION_NAME."%");
        $curr = $this->where($map)->field('id,title,url')->find();
        return is_null($field) ? $curr : $curr[$field];
    }

    // +----------------------------------------------------------------------
    // | 模型通用操作
    // +----------------------------------------------------------------------
    /**
     * [快捷编辑对应模型操作]
     * 进行缓存及各种模型相关动作的处理
     * @author LaoHe
     * @DateTime 2017-05-27
     * @param    integer   $id
     * @return   boolean
     */
    public function quick($id){
        menus('admin', true);
        menus('center', true);
        menus('seller', true);
        return true;
    }

     /**
     * [删除对应模型操作]
     * 进行缓存及各种模型相关动作的处理
     * @author LaoHe
     * @DateTime 2017-07-11
     * @param    array()   $ids
     * @return   boolean
     */
    public function del($ids){
        menus('admin', true);
        menus('center', true);
        menus('seller', true);
        return true;
    }

}