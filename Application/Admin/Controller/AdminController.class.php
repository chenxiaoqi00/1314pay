<?php
// +----------------------------------------------------------------------
// | hicms | 公共控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Think\Controller;
use Admin\Model\AuthRuleModel;
use Admin\Model\AuthGroupModel;
use Libs\Tree;
class AdminController extends Controller {
    /**
     * 后台控制器初始化
     */
    protected function _initialize(){
        // 获取当前用户ID
        if(defined('UID')) return ;
        define('UID',is_login());
        if( !UID ){// 还没登录 跳转到登录页面
            //$this->redirect('login/index');
            $this->error('登陆已过期,请重新登陆!', U('login/index'));
        }
        /* 读取数据库中的配置 */
        $config =   S('DB_CONFIG_DATA');
        if(!$config){
            $config =   D('Admin/Config')->lists();
            S('DB_CONFIG_DATA',$config);
        }
        C($config); //添加配置
        // 是否是超级管理员
        define('IS_ROOT',   is_administrator());
        if(!IS_ROOT && C('ADMIN_ALLOW_IP')){
            // 检查IP地址访问
            if(!in_array(get_client_ip(),explode(',',C('ADMIN_ALLOW_IP')))){
                $this->error('403:禁止访问');
            }
        }
        // 检测系统权限
        if(!IS_ROOT){
            $access =   $this->accessControl();
            if ( false === $access ) {
                $this->error('403:禁止访问');
            }elseif(null === $access ){
                //检测访问权限
                $rule  = strtolower(MODULE_NAME.'/'.CONTROLLER_NAME.'/'.ACTION_NAME);
                if ( !$this->checkRule($rule,array('in','1,2')) ){
                    $this->error('未授权访问!');
                }else{
                    // 检测分类及内容有关的各项动态权限
                    $dynamic    =   $this->checkDynamic();
                    if( false === $dynamic ){
                        $this->error('未授权访问!');
                    }
                }
            }
        }
        //面包屑导航
        $this->assign('breadcrumb',D('Menu')->breadcrumb());
        //菜单
        $this->assign('__MENU__', $this->getMenus());
        //SEO标题
        $this->assign('meta_title',D('Menu')->current('title'));
    }

    /**
     * 权限检测
     * @param string  $rule    检测的规则
     * @param string  $mode    check模式
     * @return boolean
     */
    final protected function checkRule($rule, $type=AuthRuleModel::RULE_URL, $mode='url'){
        static $Auth    =   null;
        if (!$Auth) {
            $Auth       =   new \Think\Auth();
        }
        if(!$Auth->check($rule,UID,$type,$mode)){
            return false;
        }
        return true;
    }

    /**
     * 检测是否是需要动态判断的权限
     * @return boolean|null
     *      返回true则表示当前访问有权限
     *      返回false则表示当前访问无权限
     *      返回null，则表示权限不明
     *
     */
    protected function checkDynamic(){}

    /**
     * action访问控制,在 **登陆成功** 后执行的第一项权限检测任务
     *
     * @return boolean|null  返回值必须使用 `===` 进行判断
     *
     *   返回 **false**, 不允许任何人访问(超管除外)
     *   返回 **true**, 允许任何管理员访问,无需执行节点权限检测
     *   返回 **null**, 需要继续执行节点权限检测决定是否允许访问
     */
    final protected function accessControl(){
        $allow = C('ALLOW_VISIT');
        $deny  = C('DENY_VISIT');
        $check = strtolower(CONTROLLER_NAME.'/'.ACTION_NAME);
        if ( !empty($deny)  && in_array_case($check,$deny) ) {
            return false;//非超管禁止访问deny中的方法
        }
        if ( !empty($allow) && in_array_case($check,$allow) ) {
            return true;
        }
        return null;//需要检测节点权限
    }

    /**
     * 对数据表中的单行或多行记录执行修改 GET参数id为数字或逗号分隔的数字
     *
     * @param string $model 模型名称,供M函数使用的参数
     * @param array  $data  修改的数据
     * @param array  $where 查询时的where()方法的参数
     * @param array  $msg   执行正确和错误的消息 array('success'=>'','error'=>'', 'url'=>'','ajax'=>false)
     *                     url为跳转页面,ajax是否ajax方式(数字则为倒数计时秒数)
     *
     */
    final protected function editRow ( $model ,$data, $where , $msg ){
        $id    = array_unique((array)I('ids',0));
        $id    = is_array($id) ? implode(',',$id) : $id;
        //如存在id字段，则加入该条件
        $fields = M($model)->getDbFields();
        if(in_array('id',$fields) && !empty($id)){
            $where = array_merge( array('id' => array('in', $id )) ,(array)$where );
        }else{
           return $this->error($msg['error'],$msg['url'],$msg['ajax']);
        }

        $msg   = array_merge( array( 'success'=>'操作成功！', 'error'=>'操作失败！', 'url'=>'' ,'ajax'=>IS_AJAX) , (array)$msg );
        if( M($model)->where($where)->save($data)!==false ) {
            $this->success($msg['success'],$msg['url'],$msg['ajax']);
        }else{
            $this->error($msg['error'],$msg['url'],$msg['ajax']);
        }
    }

    /**
     * 禁用条目
     * @param string $model 模型名称,供D函数使用的参数
     * @param array  $where 查询时的 where()方法的参数
     * @param array  $msg   执行正确和错误的消息,可以设置四个元素 array('success'=>'','error'=>'', 'url'=>'','ajax'=>false)
     *                     url为跳转页面,ajax是否ajax方式(数字则为倒数计时秒数)
     *
     */
    protected function forbid ( $model , $where = array() , $msg = array( 'success'=>'状态禁用成功！', 'error'=>'状态禁用失败！')){
        $data    =  array('status' => 0);
        $this->editRow( $model , $data, $where, $msg);
    }

    /**
     * 恢复条目
     * @param string $model 模型名称,供D函数使用的参数
     * @param array  $where 查询时的where()方法的参数
     * @param array  $msg   执行正确和错误的消息 array('success'=>'','error'=>'', 'url'=>'','ajax'=>false)
     *                     url为跳转页面,ajax是否ajax方式(数字则为倒数计时秒数)
     *
     */
    protected function resume (  $model , $where = array() , $msg = array( 'success'=>'状态恢复成功！', 'error'=>'状态恢复失败！')){
        $data    =  array('status' => 1);
        $this->editRow(   $model , $data, $where, $msg);
    }

    /**
     * 还原条目
     * @param string $model 模型名称,供D函数使用的参数
     * @param array  $where 查询时的where()方法的参数
     * @param array  $msg   执行正确和错误的消息 array('success'=>'','error'=>'', 'url'=>'','ajax'=>false)
     *                     url为跳转页面,ajax是否ajax方式(数字则为倒数计时秒数)
     */
    protected function restore (  $model , $where = array() , $msg = array( 'success'=>'状态还原成功！', 'error'=>'状态还原失败！')){
        $data    = array('status' => 1);
        $where   = array_merge(array('status' => -1),$where);
        $this->editRow(   $model , $data, $where, $msg);
    }

    /**
     * 条目假删除/逻辑删除
     * @param string $model 模型名称,供D函数使用的参数
     * @param array  $where 查询时的where()方法的参数
     * @param array  $msg   执行正确和错误的消息 array('success'=>'','error'=>'', 'url'=>'','ajax'=>false)
     *                     url为跳转页面,ajax是否ajax方式(数字则为倒数计时秒数)
     *
     */
    protected function delete ( $model , $where = array() , $msg = array( 'success'=>'删除成功！', 'error'=>'删除失败！')) {
        $data['status'] = -1;
        $this->editRow(   $model , $data, $where, $msg);
    }

    /**
     * 设置一条或者多条数据的状态
     */
    public function setStatus($model=CONTROLLER_NAME){

        $ids    =   I('request.ids');
        $status =   I('request.status/d');
        $model = I('request.model')?I('request.model'):CONTROLLER_NAME;
        $pk = M($model)->getPk();
        if(empty($ids)){
            $this->error('请选择要操作的数据');
        }
        //不允许对管理员操作
        if($model == 'Member'){
            if( in_array(C('ADMINISTRATOR_USER'), $ids)){
                $this->error("不允许对超级管理员执行该操作!");
            }
        }

        $map[$pk] = array('in',$ids);
        switch ($status){
            case -1 :
                $this->delete($model, $map, array('success'=>'删除成功','error'=>'删除失败'));//逻辑删除
                break;
            case 0  :
                $this->forbid($model, $map, array('success'=>'禁用成功','error'=>'禁用失败'));
                break;
            case 1  :
                $this->resume($model, $map, array('success'=>'启用成功','error'=>'启用失败'));
                break;
            default :
                $this->error('参数错误');
                break;
        }
    }

    /*快速编辑*/
    public function quick(){
        $field = I('post.field');
        $value = I('post.value');
        $type  = I('post.type');
        $id    = I('post.id');
        $model = I('post.model') ? I('post.model'): CONTROLLER_NAME;
        //提示
        $code = '操作成功！';
        //传递参数不为空
        if(!$field || !isset($value) || !$id){
            $this->error('缺少参数');
        }

        //排序
        if($field == 'sort' && !is_numeric($value)){
            $this->error('排序只能为数字！');
        }
        //状态
        if($field == 'status'){
            $code = show_status($value).'成功！';
        }

        //快速编辑 类型
        switch ($type) {
            // 快捷开关赋值
            case 'switch':
                $value = $value == 'true' ? 1 : 0;
                $code = show_status($value).'成功！';
                break;
            default: $code = '操作成功！';
        }

        //实例化模型
        $model = D($model);
        //对应模型操作
        $quick = $model->quick($id);
        if(!$quick){
            $this->error($model->getError());
        }
        //获取主键
        $pk = $model->getPk();
        //更新
        $done = $model->where(array($pk=>$id))->setField($field,$value);
        if($done){
            $this->success($code);
        }else{
            $this->error('操作失败！');
        }
    }


    /**
     * 机械删除操作
     */
    public function del($model=CONTROLLER_NAME){
        $model = I('request.model')?I('request.model'):CONTROLLER_NAME;
        $ids = array_filter(array_unique((array)I('ids',0)));
        if (empty($ids)) {
            $this->error('请选择要操作的数据!');
        }
        //获取主键
        $model = D($model);
        $pk = $model->getPk();
        //对应模型操作
//         $del = $model->del($ids);
//         if(!$del){
//             $this->error($model->getError());
//         }
        //不允许对超级管理员操作
        /*if($model == 'Member' && in_array(C('ADMINISTRATOR_USER'), $ids)){
            $this->error("不允许对管理员执行删除操作!");
        }else if($model == 'AuthMember' && $ids==1){
            $this->error("不允许对平台管理员执行删除操作!");
        }*/
        //条件
        $map = array( $pk => array('in', $ids));
        $done = $model->where($map)->delete();
        if($done){
            //配置文件清除缓存
            if( CONTROLLER_NAME == 'Config'){
                S('DB_CONFIG_DATA',null);
            }
            $this->success('删除成功！');
        } else {
            $this->error('删除失败！');
        }
    }

    /**
     * 设置一条或者多条排序
     */
    public function setSort($model=CONTROLLER_NAME){
        $sort = I('request.sort');
        foreach ($sort as $key=>$value){
            $res = D($model)->where(array('id'=>$key))->setField('sort', $value);
        }
        if($res!== false){
            $this->success('排序成功！');
        }else{
            $this->error('排序失败！');
        }
    }


    /**
     * 获取控制器菜单数组,二级菜单元素位于一级菜单的'_child'元素中
     */
    final public function getMenus($controller=CONTROLLER_NAME){
//         $menus = session('ADMIN_MENU_.'.$controller.'_'.ACTION_NAME);
        if(empty($menus)){
            // 获取主菜单
            $where['pid']     = 0;
            $where['status']  = 1;
            $where['is_hide'] = 0;
            $where['module']  = 'admin';
            $menus['main']  =   M('Menu')->where($where)->order('sort asc')->field('id,title,icon,url')->select();
            $menus['submenu'] =   array(); //设置子节点
            
            foreach ($menus['main'] as $key => $item) {
                // 判断主菜单权限
                if ( !IS_ROOT && !$this->checkRule(strtolower(MODULE_NAME.'/'.$item['url']),AuthRuleModel::RULE_MAIN,null) ) {
                    unset($menus['main'][$key]);
                    continue;//继续循环
                }
                if(strtolower($controller.'/'.ACTION_NAME)  == strtolower($item['url'])){
                    $menus['main'][$key]['class']='active';
                }
            }
            // 查找当前子菜单
            $pid = M('Menu')->where("pid !=0 AND module='".MODULE_NAME."' AND url like '%{$controller}/".ACTION_NAME."%'")->find();
            if($pid){
                // 查找当前主菜单
                $nav =  M('Menu')->find($pid['pid']);
                if($nav['pid']){
                    $nav = M('Menu')->find($nav['pid']);
                }
                //获取父级节点
                $location = Tree::getParents(D('Menu')->allmenu(), $pid['id']);
                foreach ($menus['main'] as $key => $item) {
                    // 获取当前主菜单的子菜单项
                    if($item['id'] == $nav['id']){
                        $menus['main'][$key]['class']='active';
                        //生成child树
                        $groups = M('Menu')->where(array('group'=>array('neq',''),'pid' =>$item['id']))->distinct(true)->getField("group",true);
                        //获取二级分类的合法url
                        $where          =   array();
                        $where['pid']   =   $item['id'];
                        $where['is_hide']  =   0;
                        $second_urls = M('Menu')->where($where)->getField('id,url');
                        if(!IS_ROOT){
                            // 检测菜单权限
                            $to_check_urls = array();
                            foreach ($second_urls as $key=>$to_check_url) {
                                if( stripos($to_check_url,MODULE_NAME)!==0 ){
                                    $rule = MODULE_NAME.'/'.$to_check_url;
                                }else{
                                    $rule = $to_check_url;
                                }
                                if($this->checkRule($rule, AuthRuleModel::RULE_URL,null))
                                    $to_check_urls[] = $to_check_url;
                            }
                        }
                        // 按照分组生成子菜单树
                        foreach ($groups as $k => $g) {
                            $map = array('group'=>$g);
                            if(isset($to_check_urls)){
                                if(empty($to_check_urls)){
                                    // 没有任何权限
                                    continue;
                                }else{
                                    $map['url'] = array('in', $to_check_urls);
                                }
                            }
                            $map['pid']     =   $item['id'];
                            $map['is_hide']    =   0;

                            $menuList = M('Menu')->where($map)->field('id,pid,icon,title,url,tip')->order('sort asc')->select();
                            foreach ($menuList as $keys => $value) {
                                //父菜单高亮
                                if($location[1]['id'] == $value['id']){
                                    $menuList[$keys]['class'] = 'active';
                                }
                            }
                            $menus['submenu'][$k]['group'] = $g;
                            if($g == $location[1]['group']){
                                $menus['submenu'][$k]['class'] = 'active';
                            }
                            $menus['submenu'][$k]['child'] = list_to_tree($menuList, 'id', 'pid', 'operater', $item['id']);
                        }
                    }
                }
            }
            session('ADMIN_MENU_.'.$controller.'_'.ACTION_NAME,$menus);
        }
        return $menus;
    }

    /**
     * 返回后台节点数据
     * @param boolean $tree    是否返回多维数组结构(生成菜单时用到),为false返回一维数组(生成权限节点时用到)
     * @retrun array
     *
     * 注意,返回的主菜单节点数组中有'controller'元素,以供区分子节点和主节点
     *
     */
    final protected function returnNodes($tree = true, $module = 'admin'){
        static $tree_nodes = array();
        if ( $tree && !empty($tree_nodes[(int)$tree]) ) {
            return $tree_nodes[$tree];
        }
        $map['module'] = $module;
        $Module = ucfirst($module);

        if((int)$tree){
            $list = M('Menu')->field('id,pid,title,url,tip,is_hide')->where($map)->order('sort asc')->select();
            foreach ($list as $key => $value) {
                if( stripos($value['url'], $Module)!==0 ){
                    $list[$key]['url'] = $Module.'/'.$value['url'];
                }
            }
            $nodes = list_to_tree($list,$pk='id',$pid='pid',$child='operator',$root=0);
            foreach ($nodes as $key => $value) {
                if(!empty($value['operator'])){
                    $nodes[$key]['child'] = $value['operator'];
                    unset($nodes[$key]['operator']);
                }
            }
        }else{
            $nodes = M('Menu')->field('id,title,url,tip,pid')->where($map)->order('sort asc')->select();
            foreach ($nodes as $key => $value) {
                if( stripos($value['url'], $Module)!==0 ){
                    $nodes[$key]['url'] =  $Module.'/'.$value['url'];
                }
            }
        }
        $tree_nodes[(int)$tree]   = $nodes;
        return $nodes;
    }

     /**
     * 通用分页列表数据集获取方法
     *
     *  可以通过url参数传递where条件,例如:  index.html?name=asdfasdfasdfddds
     *  可以通过url空值排序字段和方式,例如: index.html?_field=id&_order=asc
     *  可以通过url参数r指定每页数据条数,例如: index.html?r=5
     *
     * @param sting|Model  $model   模型名或模型实例
     * @param array        $where   where查询条件(优先级: $where>$_REQUEST>模型设定)
     * @param array|string $order   排序条件,传入null时使用sql默认排序或模型属性(优先级最高);
     *                              请求参数中如果指定了_order和_field则据此排序(优先级第二);
     *                              否则使用$order参数(如果$order参数,且模型也没有设定过order,则取主键降序);
     *
     * @param boolean      $field   单表模型用不到该参数,要用在多表join时为field()方法指定参数
     * @param type      $field   单表模型用不到该参数,要用在多表join时为field()方法指定参数
     * @return array|false
     * 返回数据集
     */
    function lists ($model,$where=array(),$order='',$field=true,$type=false,$relation=false){
        $options = array();
        $REQUEST = (array)I('');
        if($type){
            if(is_string($model)){
                $model  =   D($model);
            }
        }else{
            if(is_string($model)){
                $model  =   M($model);
            }
        }
        $OPT        =   new \ReflectionProperty($model,'options');
        $OPT->setAccessible(true);
        $pk         =   $model->getPk();
        if($order===null){
        // order置空
        }else if ( isset($REQUEST['_order']) && isset($REQUEST['_field']) && in_array(strtolower($REQUEST['_order']),array('desc','asc')) ) {
            $options['order'] = '`'.$REQUEST['_field'].'` '.$REQUEST['_order'];
        }elseif( $order==='' && empty($options['order']) && !empty($pk) ){
            $options['order'] = $pk.' desc';
        }elseif($order){
            $options['order'] = $order;
        }
        unset($REQUEST['_order'],$REQUEST['_field']);

        if(empty($where)){
            $where  =   array('status'=>array('egt',0));
        }
        if( !empty($where)){
            $options['where']   =   $where;
        }
        $options      =   array_merge( (array)$OPT->getValue($model), $options );
        $total        =   $model->where($options['where'])->count();

        if( isset($REQUEST['r']) ){
            $listRows = (int)$REQUEST['r'];
        }else{
            $listRows = C('LIST_ADMIN_ROWS') > 0 ? C('LIST_ADMIN_ROWS') : 10;
        }
        $page = new \Think\Page($total, $listRows, $REQUEST);
        if($total>$listRows){
            $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        }
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        $this->assign('_total',$total);
        $options['limit'] = $page->firstRow.','.$page->listRows;

        $model->setProperty('options',$options);
        if($relation && $type){
            return $model->relation(true)->field($field)->select();
        }else{
            return $model->field($field)->select();
        }
    }

    /**
     * +----------------------------------------------------------------------
     * | 获取Auth模块
     * +----------------------------------------------------------------------
     * @author LaoHe
     * @DateTime 2016-12-12
     * @return   [$list]     [权限控制模块]
     */
    function authmodule(){
        $list = M('Module')->field('id,title,name')->where('isauth = 1')->order('sort asc')->select();
        return $list;
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

    /**
     * +----------------------------------------------------------------------
     * | 成功及错误跳转的快捷方法|后台操作日志添加
     * +----------------------------------------------------------------------
     * 操作错误跳转的快捷方法
     * @access protected
     * @param string $message 错误信息
     * @param string $jumpUrl 页面跳转地址
     * @param mixed $ajax 是否为Ajax方式 当数字时指定跳转时间
     * @return void
     */
    final public function error($message = '', $jumpUrl = '', $ajax = false) {
        // 错误操作日志
        D('Admin/LogAdmin')->log($message, 0);
        parent::error($message, $jumpUrl, $ajax);
    }

    /**
     * 操作成功跳转的快捷方法
     * @access protected
     * @param string $message 提示信息
     * @param string $jumpUrl 页面跳转地址
     * @param mixed $ajax 是否为Ajax方式 当数字时指定跳转时间
     * @return void
     */
    final public function success($message = '', $jumpUrl = '', $ajax = false) {
        // 成功操作日志
        D('Admin/LogAdmin')->log($message, 1);
        parent::success($message, $jumpUrl, $ajax);
    }

}
