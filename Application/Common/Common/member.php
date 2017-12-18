<?php
// +----------------------------------------------------------------------
// | 会员相关函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
/**
 * 获取用户信息
 * @param integer $catid 用户id
 * @param string  $field 返回的字段，默认返回全部，数组
 * @param boolean $refresh 是否强制刷新
 * @return array()
 */
function user($uid, $field = null, $refresh = false) {
    if (empty($uid)) {
        return false;
    }
    $key = 'USER_'.$uid;
    //强制刷新缓存
    if ($refresh) {
        S($key, NULL);
    }
    $cache = S($key);
    if ($cache === 'false') {
        return false;
    }
    if (empty($cache)) {
        //读取数据
        $cache = M('Member')->field('username,mobile,email')->find($uid);
        if (empty($cache)) {
            S($key, 'false', 60);
            return false;
        } else {
            S($key, $cache);
        }
    }
    return is_null($field) ? $cache : $cache[$field];
}

/**
 * 检测用户是否登录
 * @return integer 0-未登录，大于0-当前登录用户ID
 */
function is_login(){
    $user = session('user_auth');
    if (empty($user)) {
        return 0;
    } else {
        return session('user_auth_sign') == data_auth_sign($user) ? $user['uid'] : 0;
    }
}

/**
 * 检测当前用户是否为管理员
 * @return boolean true-管理员，false-非管理员
 */
function is_administrator($uid = null){
    $uid = is_null($uid) ? is_login() : $uid;
    return $uid && (intval($uid) === C('USER_ADMINISTRATOR'));
}

/**
* 根据用户id判断用户角色
*/
function getGroupName($uid=0){
    $uid = is_null($uid) ? is_login() : $uid;
    $name=M()->table(C('DB_PREFIX').'auth_group a,'.C('DB_PREFIX').'auth_group_access b')->where('a.id=b.group_id and b.uid='.$uid.'')->getfield("a.title");
    return $name;
}

/**
 * 根据用户id获取用户组
 */
function getGroups($uid) {
    $uid=$uid?$uid:session('userinfo.uid');
    $groups_id = M()
        ->table(C('DB_PREFIX').'auth_group_access a')
        ->where("a.uid='$uid' and g.status='1'")
        ->join(C('DB_PREFIX')."auth_group g on a.group_id=g.id")
        ->getfield('id');
    return $groups_id=$groups_id?$groups_id:false;
}

function getUserName($uid=0){
    $uid = is_null($uid) ? is_login() : $uid;
    $field = D('Member')->cache('Member_'.$uid)->field('username,mobile')->find($uid);
    return $field['username'] ? $field['username'] : $field['mobile'];
}
/**
 * 获取用户名
 * @param number $uid
 * @return unknown
 */
function getUsersName($uid=0){
	$uid = is_null($uid) ? is_login() : $uid;
	$field = D('Users')->cache('Users_'.$uid)->field('username,tel')->find($uid);
	$field = D('Users')->where(array("id"=>$uid))->field('username,tel')->find($uid);
	return $field['username'] ? $field['username'] : $field['tel'];
}

/**
 * 获取用户信息
 * @param integer $catid 用户id
 * @param string  $field 返回的字段，默认返回全部，数组
 * @param boolean $refresh 是否强制刷新
 * @return array()
 */
function users($uid, $field = null, $refresh = false) {
	if (empty($uid)) {
		return false;
	}
	$key = 'USERS_'.$uid;
	//强制刷新缓存
	if ($refresh) {
		S($key, NULL);
	}
	$cache = S($key);
	if ($cache === 'false') {
		return false;
	}
	if (empty($cache)) {
		//读取数据
		$cache = M('Users')->find($uid);
		if (empty($cache)) {
			S($key, 'false', 60);
			return false;
		} else {
			S($key, $cache);
		}
	}
	return is_null($field) ? $cache : $cache[$field];
}

/**
 * 获取用户信息
 * @param integer $catid 用户id
 * @param string  $field 返回的字段，默认返回全部，数组
 * @param boolean $refresh 是否强制刷新
 * @return array()
 */
function userinfo($uid, $field = null, $refresh = false) {
	if (empty($uid)) {
		return false;
	}
	$key = 'USERINFO_'.$uid;
	//强制刷新缓存
	if ($refresh) {
		S($key, NULL);
	}
	$cache = S($key);
	if ($cache === 'false') {
		return false;
	}
	if (empty($cache)) {
		//读取数据
		$cache = M('Userinfo')->where(array('userid'=>$uid))->find();
		if (empty($cache)) {
			S($key, 'false', 60);
			return false;
		} else {
			S($key, $cache);
		}
	}
	return is_null($field) ? $cache : $cache[$field];
}

