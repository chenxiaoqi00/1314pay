<?php
// +----------------------------------------------------------------------
// | hicms | 权限管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Admin\Model\AuthRuleModel;
use Admin\Model\AuthGroupModel;
/**
 * 权限管理控制器
 */
class AuthController extends AdminController{
    /**
     * 后台节点配置的url作为规则存入auth_rule
     * 执行新节点的插入,已有节点的更新,无效规则的删除三项任务
     */
    public function updateRules($module){
        //需要新增的节点必然位于$nodes
        $nodes    = $this->returnNodes(false, $module);
        $AuthRule = M('AuthRule');
        $map      = array('module'=>$module,'type'=>array('in','1,2'));//status全部取出,以进行更新
        //需要更新和删除的节点必然位于$rules
        $rules    = $AuthRule->where($map)->order('name')->select();

        //构建insert数据
        $data     = array();//保存需要插入和更新的新节点
        foreach ($nodes as $value){
            $temp['name']   = $value['url'];
            $temp['title']  = $value['title'];
            $temp['module'] = $module;
            if($value['pid'] >0){
                $temp['type'] = AuthRuleModel::RULE_URL;
            }else{
                $temp['type'] = AuthRuleModel::RULE_MAIN;
            }
            $temp['pid'] = $value['pid'];
            $temp['mid'] = $value['id'];
            $temp['status']   = 1;
            $data[strtolower($temp['name'].$temp['module'].$temp['type'])] = $temp;//去除重复项
        }

        $update = array();//保存需要更新的节点
        $ids    = array();//保存需要删除的节点的id
        foreach ($rules as $index=>$rule){
            $key = strtolower($rule['name'].$rule['module'].$rule['type']);
            if ( isset($data[$key]) ) {//如果数据库中的规则与配置的节点匹配,说明是需要更新的节点
                $data[$key]['id'] = $rule['id'];//为需要更新的节点补充id值
                $update[] = $data[$key];
                unset($data[$key]);
                unset($rules[$index]);
                unset($rule['condition']);
                $diff[$rule['id']]=$rule;
            }elseif($rule['status']==1){
                $ids[] = $rule['id'];
            }
        }
        if ( count($update) ) {
            foreach ($update as $k=>$row){
                if ( $row!=$diff[$row['id']] ) {
                    $AuthRule->where(array('id'=>$row['id']))->save($row);
                }
            }
        }
        if ( count($ids) ) {
            $AuthRule->where( array( 'id'=>array('IN',implode(',',$ids)) ) )->save(array('status'=>-1));
            //删除规则是否需要从每个用户组的访问授权表中移除该规则?
        }
        if( count($data) ){
            $AuthRule->addAll(array_values($data));
        }
        if ( $AuthRule->getDbError() ) {
            trace('['.__METHOD__.']:'.$AuthRule->getDbError());
            return false;
        }else{
            return true;
        }
    }


    /**
     * 权限管理首页
     */
    public function index(){
        //模块查询
        $title= trim(I('get.title/s'));
        $type = I('type/d');
        $type = $type? $type : 1;
        $map['module'] = module($type,'name');
        if(isset($title)){
            $map['title'] = array('like', '%'.(string)$title.'%');
        }
        //列表
        $list = $this->lists('AuthGroup',$map,'id asc');
        $list = int_to_string($list);
        $this->assign( '_list', $list );
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        //权限分类
        $AuthType = D('Module')->where('isauth = 1')->getField('id,title,name');
        $this->assign('AuthType',$AuthType);
        $this->assign('type',$type);
        $this->assign('title',$title?$title:'角色组名称');
        $this->display();
    }

    /**
     * 创建管理员用户组
     */
    public function createGroup(){
        //模块信息
        $type = I('type/d');
        $type = $type? $type : 1;
        $module = module($type,'name');
        //赋值
        if ( empty($this->auth_group) ) {
            $this->assign('auth_group',array('title'=>null,'id'=>null,'description'=>null,'rules'=>null,'module'=>$module));//排除notice信息
        }
        //模块权限列表
        $moduleArr = $this->authmodule();
        foreach ($moduleArr as $key => $value) {
            $AuthModule[$value['name']] = $value['title'];
        }
        $this->assign('AuthModule',$AuthModule);
        //info
        $info = array();
        $info['module'] = $module;
        $this->assign('info',$info);
        $this->meta_title = '新增用户组';
        $this->display('editGroup');
    }

    /**
     * 编辑管理员用户组
     */
    public function editGroup(){
        $auth_group = M('AuthGroup')->where( array('type'=>AuthGroupModel::TYPE_ADMIN) )
                                    ->find( (int)$_GET['id'] );
        $this->assign('info',$auth_group);
        //模块权限列表
        $moduleArr = $this->authmodule();
        foreach ($moduleArr as $key => $value) {
            $AuthModule[$value['name']] = $value['title'];
        }
        $this->assign('AuthModule',$AuthModule);
        $this->meta_title = '编辑用户组';
        $this->display();
    }


    /**
     * +----------------------------------------------------------------------
     * | 访问授权页面
     * +----------------------------------------------------------------------
     * @author LaoHe
     * @DateTime 2017-03-15
     */
    public function access(){

        //模块查询
        $type = I('type/d');
        $type = $type? $type : 1;
        $module = module($type,'name');
        $groupID = I('group_id/d');

        $this->updateRules($module);
        $auth_group = M('AuthGroup')->where( array('status'=>array('egt','0'),'module'=>$module,'type'=>AuthGroupModel::TYPE_ADMIN))->getfield('id,id,title,rules');
        $this->assign('this_group', $auth_group[(int)$_GET['group_id']]);
        // AUTH
        $auth=D('AuthRule')->order('pid asc')->where(array('module'=>$module))->select();
        foreach($auth as $k=>$v){
            $auth[$k]['id']=$v['id'];
            $auth[$k]['pid']=$v['pid'];
            $auth[$k]['name']=$v['title']?$v['title'].'-'.$v['name']:$v['name'];
            $auth[$k]['checked']=D('AuthGroup')->isrules($groupID,$v['id']);
        }
        $this->assign('json', json_encode($auth));
        $this->display();
    }

    /**
     * 管理员用户组数据写入/更新
     */
    public function writeGroup(){
        if(isset($_POST['rules'])){
            $rules = array_filter(str2arr($_POST['rules']));
            sort($rules);
            $_POST['rules']  = implode( ',' , array_unique($rules));
        }else{
            if($_POST['isrule'] && !$_POST['rules']){
                $_POST['rules'] = '';
            }
        }
        //$_POST['module'] =  'admin';
        if($_POST['isrule'] && !$_POST['rules']){
            $_POST['rules'] = '';
        }
        $_POST['type']   =  AuthGroupModel::TYPE_ADMIN;
        $AuthGroup       =  D('AuthGroup');
        $data = $AuthGroup->create();
        if ( $data ) {
            if ( empty($data['id']) ) {
                $r = $AuthGroup->add();
            }else{
                $r = $AuthGroup->save();
            }
            if($r===false){
                $this->error($AuthGroup->getError());
            } else{
                $this->success('权限更新成功!', Cookie('__forward__'));
            }
        }else{
            $this->error($AuthGroup->getError());
        }
    }

    /**
     * 用户组授权用户列表
     */
    public function user($group_id){
        if(empty($group_id)){
            $this->error('参数错误');
        }
        //模块查询
        $type = I('type/d');
        $type = $type? $type : 1;
        $module = module($type,'name');
        //查询
        $auth_group = M('AuthGroup')->where( array('status'=>array('egt','0'),'module'=>$module,'type'=>AuthGroupModel::TYPE_ADMIN) )
            ->getfield('id,id,title,rules');
        $prefix   = C('DB_PREFIX');
        $l_table  = $prefix.(AuthGroupModel::MEMBER);
        $r_table  = $prefix.(AuthGroupModel::AUTH_GROUP_ACCESS);
        $model    = M()->table( $l_table.' m' )->join ( $r_table.' a ON m.id=a.uid' );
        //$_REQUEST = array();
        $list = $this->lists($model,array('a.group_id'=>$group_id,'m.status'=>array('egt',0)),'m.id asc','m.id,m.username,m.mobile,m.last_time,m.last_ip,m.logins,m.modelid,m.status');
        //$list = $this->lists('UcenterMember',$map,'id asc');
        int_to_string($list);
        $this->assign( '_list', $list );
        $this->assign('auth_group', $auth_group);
        $this->assign('this_group', $auth_group[(int)$_GET['group_id']]);
        $this->meta_title = '成员授权';
        $this->display();
    }

    /**
     * 将分类添加到用户组的编辑页面
     */
    public function category(){
        $groupID = I('group_id/d');
        $auth_group     =   M('AuthGroup')->where( array('status'=>array('egt','0'),'module'=>'admin','type'=>AuthGroupModel::TYPE_ADMIN) )
            ->getfield('id,id,title,rules');
        $category = D('category')->field('id,pid,title')->order('pid asc')->select();
        foreach($category as $k=>$v){
            $category[$k]['id']=$v['id'];
            $category[$k]['pid']=$v['pid'];
            $category[$k]['name']=$v['title'];
            $category[$k]['checked'] = D('AuthGroup')->iscate($groupID, $v['id']);
        }

        $authed_group   =   AuthGroupModel::getCategoryOfGroup(I('group_id'));
        $this->assign('authed_group',   implode(',',(array)$authed_group));
        $this->assign('group_list',     $group_list);
        $this->assign('auth_group',     $auth_group);
        $this->assign('this_group',     $auth_group[(int)$_GET['group_id']]);
        $this->meta_title = '分类授权';
        $this->assign('json', json_encode($category));
        $this->display();
    }

    /**
     * 将用户添加到用户组的编辑页面
     */
    public function group(){
        $uid            =   I('uid');
        $groups    =   D('AuthGroup')->getGroups();
        //会员组
        $auth_groups = array();
        foreach ($groups as $key => $value) {
            //$auth_groups[$value['module']][]=$value;
            $auth_groups[$value['module']][] = $value;;
            //$auth_groups['_list'][]=$value;
        }
        //dump($auth_groups);
        $user_groups    =   AuthGroupModel::getUserGroup($uid);
        $ids = array();
        foreach ($user_groups as $value){
            $ids[]      =   $value['group_id'];
        }
        $username       =   D('UcenterMember')->where('id ='.$uid)->getField('username');
        $this->assign('username', $username);
        $this->assign('auth_groups',$auth_groups);
        $this->assign('user_groups',implode(',',$ids));
        $this->meta_title = '用户组授权';
        $this->display();
    }

    /**
     * 将用户添加到用户组,入参uid,group_id
     */
    public function addToGroup(){
        $uid = I('uid');
        $gid = I('group_id');
        if( empty($uid) ){
            $this->error('参数有误');
        }
        //判断ID是否为数字或数组
        $array = str2arr($uid);
        if(is_array($array)){
            foreach ($array as $value){
                if(!(int)($value)){
                    $this->error('添加的会员有误');
                }
            }
        }

        $AuthGroup = D('AuthGroup');
        if(is_numeric($uid)){
            if ( is_administrator($uid) ) {
                $this->error('该用户为超级管理员');
            }
            if( !M('Member')->where(array('id'=>$uid))->find() ){
                $this->error('用户不存在');
            }
        }

        if( $gid && !$AuthGroup->checkGroupId($gid)){
            $this->error($AuthGroup->error);
        }
        if ( $AuthGroup->addToGroup($uid,$gid) ){
            $this->success('用户添加成功');
        }else{
            $this->error($AuthGroup->getError());
        }
    }

    /**
     * 将用户从用户组中移除  入参:uid,group_id
     */
    public function removeFromGroup(){
        $uid = I('uid');
        $gid = I('group_id');
        if( $uid==UID ){
            $this->error('不允许解除自身授权');
        }
        if( empty($uid) || empty($gid) ){
            $this->error('参数有误');
        }
        $AuthGroup = D('AuthGroup');
        if( !$AuthGroup->find($gid)){
            $this->error('用户组不存在');
        }
        if ( $AuthGroup->removeFromGroup($uid,$gid) ){
            $this->success('用户移除成功');
        }else{
            $this->error('用户移除失败');
        }
    }

    /**
     * 将分类添加到用户组  入参:cid,group_id
     */
    public function addToCategory(){
        $cid = I('cid');
        $gid = I('group_id');
        //dump(I('post.'));
        if( empty($gid) ){
            $this->error('参数有误');
        }
        $AuthGroup = D('AuthGroup');
        if( !$AuthGroup->find($gid)){
            $this->error('用户组不存在');
        }
        if( $cid && !$AuthGroup->checkCategoryId($cid)){
            $this->error($AuthGroup->error);
        }
        if ( $AuthGroup->addToCategory($gid,$cid) ){
            $this->success('文章分类授权成功！');
        }else{
            $this->error('文章分类授权失败');
        }
    }

    /**
     * 将模型添加到用户组  入参:mid,group_id
     */
    public function addToModel(){
        $mid = I('id');
        $gid = I('get.group_id');
        if( empty($gid) ){
            $this->error('参数有误');
        }
        $AuthGroup = D('AuthGroup');
        if( !$AuthGroup->find($gid)){
            $this->error('用户组不存在');
        }
        if( $mid && !$AuthGroup->checkModelId($mid)){
            $this->error($AuthGroup->error);
        }
        if ( $AuthGroup->addToModel($gid,$mid) ){
            $this->success('操作成功');
        }else{
            $this->error('操作失败');
        }
    }



}
