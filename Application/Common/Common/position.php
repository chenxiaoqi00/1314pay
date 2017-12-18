<?php
// +----------------------------------------------------------------------
// | 推荐位相关函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------

/**
 * 获取指定模型所有字段
 * @param  integer  $modelid 模型id
 * @param  string   $field 返回的字段，默认返回全部，数组
 * @param  boolean  $refresh 是否强制刷新
 * @return array()
 */
function position($posid, $refresh=false){
    //强制刷新缓存
    if ($refresh) {
        S('POSITION', null);
    }
    $cache = S('POSITION');
    if ($cache === 'false') {
        return false;
    }
    if (empty($cache)) {
        //读取数据
        $positions = M('Position')->where('status = 1')->field('status,sort',true)->order('sort desc')->select();
        if (empty($positions)) {
            S('POSITION', 'false', 60);
            return false;
        } else {
            foreach ($positions as $value) {
                $cache[$value['id']] = $value;
            }
            S('POSITION', $cache);
        }
    }
    return empty($posid) ? $cache : $cache[$posid];
}