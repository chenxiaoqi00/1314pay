<?php
// +----------------------------------------------------------------------
// | 模块相关函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
/**
 * 获取所有模块数据
 * @param integer $key  模块ID
 * @param type $refresh 是否强制刷新
 * @return boolean
 */
function modules($key=false, $refresh=false){
    //强制刷新缓存
    if ($refresh) {
        S('MODULES', null);
    }
    $cache = S('MODULES');
    if ($cache === 'false') {
        return false;
    }
    if (empty($cache)) {
        //读取数据
        $cache = M('Module')->where('status = 1')->order('sort desc, id asc')->getField('id,title,name,isauth');
        if (empty($cache)) {
            S('MODULES', 'false', 60);
            return false;
        } else {
            S('MODULES', $cache);
        }
    }
    return empty($key) ? $cache : $cache[$key];
}

/**
 * 获取模块信息
 * @param  integer $module 模块ID
 * @param  string  $module 模块名
 * @param  string  $field  要获取的字段名
 * @return string          模块信息
 */
function module($module='admin', $field = null, $refresh = false) {
    $module = strtolower($module);
    if (empty($module)) {
        return false;
    }
    if(is_numeric($module)){
        /*$cache = modules($module);
        return is_null($field) ? $cache : $cache[$field];
        exit();*/
        $module = M('Module')->getFieldByid($module,'name');
    }
    $key = 'MODULE_'.$module;
    //强制刷新缓存
    if ($refresh) {
        S($key, NULL);
    }
    $cache = S($key);
    if ($cache === 'false') {
        return false;
    }
    if (empty($cache)) {
        $cache = M('Module')->where(array('name' => $module, 'status'=>1))->find();
        if (empty($cache)) {
            S($key, 'false', 60);
            return false;
        } else {
            S($key, $cache);
        }
    }
    return is_null($field) ? $cache : $cache[$field];
}