<?php
// +----------------------------------------------------------------------
// | 栏目相关函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
use Libs\Tree;
/**
 * 获取指定栏目信息
 * @param integer $catid 栏目id
 * @param type $field 返回的字段，默认返回全部，数组
 * @param type $refresh 是否强制刷新
 * @return boolean
 */
function category($catid, $field = null, $refresh = false) {
    if (empty($catid)) {
        return false;
    }
    $key = 'CATEGORY_'.$catid;
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
        $cache = M('Category')->find($catid);
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
 * 获取所有栏目数组
 * @param integer $catid 栏目id
 * @param type $refresh 是否强制刷新
 * @return boolean
 */
function categorys($refresh=false){
    //强制刷新缓存
    if ($refresh) {
        S('CATEGORYS', null);
    }
    $cache = S('CATEGORYS');
    if ($cache === 'false') {
        return false;
    }
    if (empty($cache)) {
        //读取数据
        $cache = M('Category')->where('status = 1')->field('id,pid,title,name,child,arrchildid,arrparentid,letter')->order('sort desc, id asc')->select();
        if (empty($cache)) {
            S('CATEGORYS', 'false', 60);
            return false;
        } else {
            S('CATEGORYS', $cache);
        }
    }
    return $cache;
    //return empty($catid) ? $cache : Tree::getSameCate($cache, $catid);
}

/**
 * 当前栏目导航
 * @param  integer $catid 当前栏目ID
 * @param  boolean $html 是否带HTML连接导航
 * @return array
 */
function breadcrumb($catid, $html = true){
    $parents = Tree::getParents(categorys(), $catid);
    if($html){
        // HTML
        $breadcrumb = '<ol class="breadcrumb">';
        $breadcrumb.= '<li><i class="fa fa-map-marker"></i></li>';
        $breadcrumb.= '<li><a class="link-effect" href="'.U('index/index').'">后台首页</a></li>';
        foreach ($parents as $v) {
            $breadcrumb.= '<li><a class="link-effect" href="'.U($value["url"]).'">'.$value["title"].'</a></li>';
        }
        $breadcrumb.= '</ol>';
    }else{
        foreach ($parents as $v) {
            $breadcrumb.= $v["title"].' &gt; ';
        }
    }
    return $breadcrumb;
}

/*获取同级栏目*/
function get_same_categorys($catid){
    return Tree::getSameCate(categorys(), $catid);
}

/*获取子栏目*/
function get_child_categorys($catid){
    return Tree::getChildCate(categorys(), $catid);
}

/**
 * 获取指定栏目信息
 * @param integer $catid 栏目id
 * @param type $field 返回的字段，默认返回全部，数组
 * @param type $refresh 是否强制刷新
 * @return boolean
 */
function channel($catid, $field = null, $refresh = false) {
	if (empty($catid)) {
		return false;
	}
	$key = 'CHANNEL_'.$catid;
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
		$cache = M('Channellist')->find($catid);
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
 * 获取所有栏目数组
 * @param integer $catid 栏目id
 * @param type $refresh 是否强制刷新
 * @return boolean
 */
function channellist($refresh=false){
	//强制刷新缓存
	if ($refresh) {
		S('CHANNELS', null);
	}
	$cache = S('CHANNELS');
	if ($cache === 'false') {
		return false;
	}
	if (empty($cache)) {
		//读取数据
		$cache = M('Channellist')->where(array('is_state'=>1))->order('id asc')->select();
		if (empty($cache)) {
			S('CHANNELS', 'false', 60);
			return false;
		} else {
			S('CHANNELS', $cache);
		}
	}
	return $cache;
	//return empty($catid) ? $cache : Tree::getSameCate($cache, $catid);
}

/**
 * 获取指定栏目信息
 * @param integer $catid 栏目id
 * @param type $field 返回的字段，默认返回全部，数组
 * @param type $refresh 是否强制刷新
 * @return boolean
 */
function pay($catid, $field = null, $refresh = false) {
	if (empty($catid)) {
		return false;
	}
	$key = 'PAY_'.$catid;
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
		$cache = M('Pay')->where(array('payid'=>$catid))->find();
		if (empty($cache)) {
			S($key, 'false', 60);
			return false;
		} else {
			S($key, $cache);
		}
  	}
	return is_null($field) ? $cache : $cache[$field];
}