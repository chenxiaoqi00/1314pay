<?php
// +----------------------------------------------------------------------
// | hicms | 公共控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Seller\Controller;
use Center\Controller\CenterBaseController;
use Libs\Tree;
class SellerBaseController extends CenterBaseController {
    /**
     * 继承会员中心公共控制器
     */
    protected function _initialize(){
        parent::_initialize();
        //非企业会员禁止访问
//         if($this->uinfo['modelid'] != 4){
//         	$this->error('未授权访问！');
//         }
        //获取当前用户关联的店铺信息
       /*  $shop = M('shop')->where(array('uid'=>UID))->find();
        $this->assign('shop', $shop);
        //店铺ID
        if(defined('SHOPID')) return ;
        define('SHOPID', $shop['shopid']);
        //未设置店铺信息则跳转
        if(!SHOPID && $this->checkPassAuth()){
            $this->error('请先完善店铺相关设置', U('shop/config'));
        }
        //店铺未审核或已禁用
        if(shop(SHOPID, 'status')!=1 && $this->checkPassAuth()){
            $this->error('您的店铺正在审核中,请耐心等待！');
        } */
        //SEO标题
        $this->assign('meta_title',D('Admin/Menu')->current('title').'-卖家中心');
        //边栏标题
        $this->assign('side_title','卖家中心');
    }
    
    /**
     * +----------------------------------------------------------------------
     * | 获取选择框树 建议只获取菜单|文章栏目|产品栏目等表
     * +----------------------------------------------------------------------
     * @author LaoHe
     * @DateTime 2017-3-31
     * @param string   $model 文章ID
     * @param string   $field 查询字段|默认为 id,pid,title 统一格式
     * @param array    $where 查询条件
     * @return $toTree  array 格式化后的数据
     */
    function getTree($model = CONTROLLER_NAME, $field = 'id,pid,title', $where = array()){
    	$toTree = array();
    	$res = D($model)->field($field)->where($where)->select();
    	// 获取所有菜单
    	$menus = Tree::toList($res);
    	foreach ($menus as $value) {
    		$toTree[$value['id']] = $value['title_display'];
    	}
    	return $toTree;
    }
    

    /*检测未设置及审核状态中的店铺访问权限*/
    protected function checkPassAuth(){
        //检测访问权限
        if(in_array_case(strtolower( CONTROLLER_NAME.'/'.ACTION_NAME ), C('NO_PASS_AUTH'))){
            return false;
        }
        return true;
    }
}
