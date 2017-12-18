<?php
// +----------------------------------------------------------------------
// | 商品相关函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------

/**
 * 获取商品信息
 * @param integer $goodid 栏目id
 * @param type $field 返回的字段，默认返回全部，数组
 * @param type $refresh 是否强制刷新
 * @return boolean
 */
function good($goodid, $field = null, $refresh = false) {
	if (empty($goodid)) {
		return false;
	}
	$key = 'GOODS_'.$goodid;
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
		$cache = M('Goodlist')->find($goodid);
		if (empty($cache)) {
			S($key, 'false', 60);
			return false;
		} else {
			S($key, $cache);
		}
	}
	return is_null($field) ? $cache : $cache[$field];
}
