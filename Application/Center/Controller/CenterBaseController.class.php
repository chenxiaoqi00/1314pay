<?php
// +----------------------------------------------------------------------
// | hicms | 会员中心 | 公共基础控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
use Think\Controller;
use Admin\Model\AuthRuleModel;
use Admin\Model\AuthGroupModel;
use Libs\Tree;
class CenterBaseController extends Controller {
    /**
     * 会员中心控制器初始化
     */
    protected function _initialize(){
        // 获取当前用户ID
       if(defined('UID')) return ;
        define('UID',is_login());
        if( !UID ){// 还没登录 跳转到登录页面
            $this->error('登陆已过期,请重新登陆!', U('center/public/login'));
        }else{
            $map["id"]=UID;
            $member = D('Common/Users')->where($map)->field("username")->find();
            $this->assign('username', $member["username"]);
        }
        /* 读取数据库中的配置 */
        $config =   S('DB_CONFIG_DATA');
        if(!$config){
            $config =   D('Admin/Config')->lists();
            S('DB_CONFIG_DATA',$config);
        }
        C($config); //添加配置

        // 检测系统权限
       $access =   $this->accessControl();
/*         if ( false === $access ) {
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
        }  */
        //模板赋值
        $this->assign('__MENU__', $this->getMenus());
//         dump($this->getMenus());
//         $this->assign('uinfo',session('user_auth'));
        //SEO标题
        $this->assign('meta_title',D('Admin/Menu')->current('title').'-会员中心');
        $this->assign('side_title','会员中心');
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

    // +----------------------------------------------------------------------
    // | 权限相关
    // +----------------------------------------------------------------------
    /* 普通会员公共权限配置,如有VIP会员级别,个别权限在后台进行授权
    *  会员中心公共权限 center_auth.php
    *  卖家中心公共权限 seller_auth.php
    *  未配置方法将进行权限限制
    **/
    protected function public_auth(){
        return MODULE_NAME == 'Seller'? C('PUBLIC_SELLER_AUTH') : C('PUBLIC_PERSON_AUTH');
    }

    /**
     * 权限检测
     * @param string  $rule    检测的规则
     * @param string  $mode    check模式
     * @return boolean
     */
    final protected function checkRule($rule, $type=AuthRuleModel::RULE_URL, $mode='url'){
        static $Auth = null;
        if (!$Auth) {
            $Auth = new \Think\Auth();
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
        $allow = $this->public_auth();
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
     * 获取控制器菜单数组,二级菜单元素位于一级菜单的'_child'元素中
     */
    final public function getMenus($controller=CONTROLLER_NAME){
//         $menus = session( MODULE_NAME.'_MENU_'.$controller);
        if(empty($menus)){
            // 获取主菜单
            $where = array();
            $where['pid']     = 0;
            $where['status']  = 1;
            $where['is_hide'] = 0;
            $where['module']  = MODULE_NAME;
            $menus['main']  =   M('Menu')->where($where)->order('sort desc')->field('id,title,icon,url')->select();

            $menus['submenu'] =   array(); //设置子节点
            
         /*    foreach ($menus['main'] as $key => $item) {
                // 判断主菜单权限
                if(!in_array_case( $item['url'], $this->public_auth()) || !$this->checkMemberModelAuth($item['url'])){
                    if ( !$this->checkRule(strtolower(MODULE_NAME.'/'.$item['url']),AuthRuleModel::RULE_MAIN,null) ) {
                        unset($menus['main'][$key]);
                        continue;//继续循环
                    }
                }
                if(strtolower(CONTROLLER_NAME.'/'.ACTION_NAME)  == strtolower($item['url'])){
                    $menus['main'][$key]['class']='selected';
                }
            } */

            // 查找当前子菜单
            $pid = M('Menu')->where("pid !=0 AND module='".MODULE_NAME."' AND url like '%{$controller}/".ACTION_NAME."%'")->find();
            if($pid){
                // 查找当前主菜单
                $nav =  M('Menu')->find($pid['pid']);
                if($nav['pid']){
                    $nav = M('Menu')->find($nav['pid']);
                }
                //获取父级节点
                $location = Tree::getParents(D('Admin/Menu')->allmenu(MODULE_NAME), $pid['id']);
                foreach ($menus['main'] as $key => $item) {
                    // 获取当前主菜单的子菜单项
                    if($item['id'] == $nav['id']){
                        $menus['main'][$key]['class']='selected';
                        //生成child树
                        $groups = M('Menu')->where(array('group'=>array('neq',''),'pid' =>$item['id']))->distinct(true)->getField("group",true);
//                         dump($groups);
                        //获取二级分类的合法url
                        $where          =   array();
                        $where['pid']   =   $item['id'];
                        $where['is_hide']  =   0;
                        $second_urls = M('Menu')->where($where)->order('sort desc')->getField('id,url');
                        //if(!IS_ROOT){
                        // 检测菜单权限
                        $to_check_urls = array();
                        foreach ($second_urls as $key=>$to_check_url) {
                            if( stripos($to_check_url,MODULE_NAME)!==0 ){
                                $rule = MODULE_NAME.'/'.$to_check_url;
                            }else{
                                $rule = $to_check_url;
                            }
                            //权限过滤
                            if(in_array_case( $to_check_url, $this->public_auth()) || $this->checkRule($rule, AuthRuleModel::RULE_URL,null)){
                                $to_check_urls[] = $to_check_url;
                            }
                        }
                        //}
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
//                             dump($menuList);
//                             exit;
                            foreach ($menuList as $keys => $value) {
                                //父菜单高亮
                                if($location[1]['id'] == $value['id']){
                                    $menuList[$keys]['class'] = 'option-active';
                                }
                            }
                            $menus['submenu'][$k]['group'] = $g;
                            $menus['submenu'][$k]['icon'] = $this->getIcon($k);
                            if($g == $location[1]['group']){
                                $menus['submenu'][$k]['class'] = 'selected';
                            }
                            $menus['submenu'][$k]['child'] = list_to_tree($menuList, 'id', 'pid', 'operater', $item['id']);
                        }
                    }
                }
            }
//             dump($menus);
//             exit;
//             session( MODULE_NAME.'_MENU_'.$controller, $menus);
        }
        return $menus;
    }

   public function getIcon($k = null){
       $icon = "";
       switch ($k)
       {
           case 0:
               $icon = "fa-user";//账户
               break;
           case 1:
               $icon = "fa-briefcase";//商品
               break;
           case 2:
               $icon = "fa-chain";//链接
               break;
           case 3:
               $icon = "fa-bar-chart-o";//数据
               break;
           case 4:
               $icon = "fa-cny";//交易
               break;
           case 5:
               $icon = "fa-calculator";//结算
               break;
           case 6:
               $icon = "fa-phone";
               break;
           case 7:
               $icon = "fa-newspaper-o";//优惠券
               break;
           default:
               $icon = "fa-home";
       }
       return $icon;
    }
    
    
    
    
    final public function getMenuss($controller=CONTROLLER_NAME){
        //$menus = session( MODULE_NAME.'_MENU_'.$controller);
        if(empty($menus)){
            // 获取主菜单
            $where = array();
            $where['pid']     = 0;
            $where['status']  = 1;
            $where['is_hide'] = 0;
            $where['module']  = MODULE_NAME;
            $menus['main']  =   M('Menu')->where($where)->order('sort desc')->field('id,title,icon,url')->select();
            $menus['submenu'] =   array(); //设置子节点
            foreach ($menus['main'] as $key => $item) {
                // 判断主菜单权限
                if(!in_array_case( $item['url'], $this->public_auth()) || !$this->checkMemberModelAuth($item['url'])){
                    if ( !$this->checkRule(strtolower(MODULE_NAME.'/'.$item['url']),AuthRuleModel::RULE_MAIN,null) ) {
                        unset($menus['main'][$key]);
                        continue;//继续循环
                    }
                }
                if(strtolower(CONTROLLER_NAME.'/'.ACTION_NAME)  == strtolower($item['url'])){
                    $menus['main'][$key]['class']='current';
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
                $location = Tree::getParents(D('Admin/Menu')->allmenu(MODULE_NAME), $pid['id']);
                foreach ($menus['main'] as $key => $item) {
                    // 获取当前主菜单的子菜单项
                    if($item['id'] == $nav['id']){
                        $menus['main'][$key]['class']='current';
                        //生成child树
                        $groups = M('Menu')->where(array('group'=>array('neq',''),'pid' =>$item['id']))->distinct(true)->getField("group",true);
                        //获取二级分类的合法url
                        $where          =   array();
                        $where['pid']   =   $item['id'];
                        $where['is_hide']  =   0;
                        $second_urls = M('Menu')->where($where)->order('sort desc')->getField('id,url');
                        //if(!IS_ROOT){
                        // 检测菜单权限
                        $to_check_urls = array();
                        foreach ($second_urls as $key=>$to_check_url) {
                            if( stripos($to_check_url,MODULE_NAME)!==0 ){
                                $rule = MODULE_NAME.'/'.$to_check_url;
                            }else{
                                $rule = $to_check_url;
                            }
                            //权限过滤
                            if(in_array_case( $to_check_url, $this->public_auth()) || $this->checkRule($rule, AuthRuleModel::RULE_URL,null)){
                                $to_check_urls[] = $to_check_url;
                            }
                        }
                        //}
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
                                    $menuList[$keys]['class'] = 'current';
                                }
                            }
                            $menus['submenu'][$k]['group'] = $g;
                            if($g == $location[1]['group']){
                                $menus['submenu'][$k]['class'] = 'current';
                            }
                            $menus['submenu'][$k]['child'] = list_to_tree($menuList, 'id', 'pid', 'operater', $item['id']);
                        }
                    }
                }
            }
            //session( MODULE_NAME.'_MENU_'.$controller, $menus);
        }
        return $menus;
    }
    // +----------------------------------------------------------------------
    // | 会用中心公共通用操作 | 删除 | 添加 | 编辑 | 状态
    // +----------------------------------------------------------------------
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
    	$id    = array_unique((array)I('id',0));
    	$id    = is_array($id) ? implode(',',$id) : $id;
    	//如存在id字段，则加入该条件
    	$fields = M($model)->getDbFields();
    	if(in_array('id',$fields) && !empty($id)){
    		$where = array_merge( array('id' => array('in', $id )) ,(array)$where );
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
    	$data    =  array('is_state' => 0);
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
    	$data    =  array('is_state' => 1);
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
     * 条目假删除
     * @param string $model 模型名称,供D函数使用的参数
     * @param array  $where 查询时的where()方法的参数
     * @param array  $msg   执行正确和错误的消息 array('success'=>'','error'=>'', 'url'=>'','ajax'=>false)
     *                     url为跳转页面,ajax是否ajax方式(数字则为倒数计时秒数)
     *
     */
    protected function del ( $model , $where = array() , $msg = array( 'success'=>'删除成功！', 'error'=>'删除失败！')) {
    	$data['status']         =   -1;
    	$this->editRow(   $model , $data, $where, $msg);
    }

    /**
     * 设置一条或者多条数据的状态
     */
    public function setStatus($model=CONTROLLER_NAME){
        
        $ids = array_filter(array_unique((array)I('ids',0)));
        if (empty($ids)) {
            $this->error('请选择要操作的数据!');
        }
//     	$ids    =   I('request.ids');
    	$status =   I('request.status');
//     	if(empty($ids)){
//     		$this->error('请选择要操作的数据');
//     	}
    	//不允许对管理员操作
    	if($model == 'Member'){
    		if( in_array(C('ADMINISTRATOR_USER'), $ids)){
    			$this->error("不允许对超级管理员执行该操作!");
    		}
    	}

    	$map['id'] = array('in',$ids);
    	switch ($status){
    		case -1 :
    			$this->del($model, $map, array('success'=>'删除成功','error'=>'删除失败'));
    			break;
    		case 0  :
    			$this->forbid($model, $map, array('success'=>'下架成功','error'=>'下架失败'));
    			break;
    		case 1  :
    			$this->resume($model, $map, array('success'=>'上架成功','error'=>'上架失败'));
    			break;
    		default :
    			$this->error('参数错误');
    			break;
    	}
    }

    /**
     * 通用添加操作
     */
    public function doadd($model=CONTROLLER_NAME){
        if(IS_AJAX){
            $model = D($model);
            $data = $model->create();
            if($data){
                $id = $model->add();
                if($id){
                    $this->success('添加成功');
                } else {
                    $this->error('添加失败');
                }
            } else {
                $this->error($model->getError());
            }
        }else{
            $this->error('非法操作！');
        }
    }

    /**
     * 通用添加操作
     */
    public function doedit($model=CONTROLLER_NAME){
        if(IS_AJAX){
            $model = D($model);
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $this->success('修改成功',U('index'));
                } else {
                    $this->error('修改失败');
                }
            } else {
                $this->error($model->getError());
            }
        }else{
            $this->error('非法操作！');
        }
    }

    /**
     * 通用删除操作
     */
    public function delete($model=CONTROLLER_NAME){
        $ids = array_filter(array_unique((array)I('ids',0)));
        if (empty($ids)) {
            $this->error('请选择要操作的数据!');
        }

        //获取主键
        $model = D($model);
        $pk = $model->getPk();
        //条件
        $map = array( $pk => array('in', $ids));
        $dodel = $model->where($map)->delete();
        if($dodel){
            $this->success('删除成功！');
        } else {
            $this->error('删除失败！');
        }
    }


    // +----------------------------------------------------------------------
    // | 公共方法及函数
    // +----------------------------------------------------------------------
    /**
     * 对验证过的token进行复原
     * @param type $data 数据
     */
    protected function tokenReset($data = array()) {
        if (empty($data)) {
            $data = $_POST;
        }
        //TOKEN_NAME
        $tokenName = C('TOKEN_NAME');
        if (empty($data[$tokenName])) {
            return false;
        }
        list($tokenKey, $tokenValue) = explode('_', $data[$tokenName]);
        //如果验证失败，重现对TOKEN进行复原生效
        $_SESSION[$tokenName][$tokenKey] = $tokenValue;
        return true;
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

    protected function checkMemberModelAuth($url){
        $modelid = M('Menu')->where(array('module'=>MODULE_NAME, 'url'=>$url))->getField('modelid');
        return  $modelid ==0 || $modelid == get_member_modelid(UID) ? true : false;
    }
    
    // 获取支付链接
    public function getPayUrl($action=null,$linkid = null) {
        //        $payUrl = 'http://'.$_SERVER['HTTP_HOST'].'/Product/goodlist/linkid/'.$linkid.".html";
        $action = I("get.action");
        $linkid = I("get.linkid");
        $payUrl = 'http://'.$_SERVER['HTTP_HOST'].'/'.$action.'/'.$linkid.".html";
//         $payUrl = 'http://www.1314fk.com/'.$action.'/'.$linkid.".html";
        $url='http://suo.im/api.php?url='.$payUrl;
        $shortPayUrl = file_get_contents($url);
        $data["payUrl"]=$payUrl;
        $data['shortPayUrl']=$shortPayUrl;
        
        $data['qrUrl']=qrcode($payUrl);
        
        $this->ajaxReturn($data);
    }
    

}
