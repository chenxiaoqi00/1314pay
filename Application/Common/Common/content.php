<?php
// +----------------------------------------------------------------------
// | 内容相关函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
/**
 * 获取所有菜单
 * @param  integer $id    分类ID
 * @param  string  $field 要获取的字段名
 * @return string         缓存的栏目
 */
function menu($id=0 ,$module = 'admin'){
    static $list;
    if(empty($list)){
        //$list = F($module.'Menu', '', DATA_PATH.'/Menu/');
    }
    if(!$list){
        $menu = D('Menu')->where('status = 1')->field('id,title,pid,sort')->order('sort asc')->select();
        //$list = list_to_tree($menu);
        //F($module.'Menu', $list, DATA_PATH.'/Menu/'); //更新缓存
    }
    return $menu;
}

/**
 * 获取对应模块菜单
 * @param string  $module  模块名
 * @param boolean $refresh 是否强制刷新
 * @return boolean
 */
function menus($module='admin', $refresh=false){
    $module = strtolower($module);
    $key = 'MENUS_'.$module;
    //强制刷新缓存
    if ($refresh) {
        S($key, null);
    }
    $cache = S($key);
    if ($cache === 'false') {
        return false;
    }
    if (empty($cache)) {
        //读取数据
        $cache = M('Menu')->where(array('status'=>1, 'module'=>$module))->select();
        if (empty($cache)) {
            S($key, 'false', 60);
            return false;
        } else {
            S($key, $cache);
        }
    }
    return $cache;
}


/**
 * gbk转拼音
 * @param $txt
 */
function gbk_to_pinyin($txt) {
    $l = strlen($txt);
    $i = 0;
    $pyarr = array();
    $py = array();
    $filename = APP_PATH.'Common/Data/gb-pinyin.table';
    $fp = fopen($filename, 'r');
    while (!feof($fp)) {
        $p = explode("-", fgets($fp, 32));
        $pyarr[intval($p[1])] = trim($p[0]);
    }
    fclose($fp);
    ksort($pyarr);
    while ($i < $l) {
        $tmp = ord($txt[$i]);
        if ($tmp >= 128) {
            $asc = abs($tmp * 256 + ord($txt[$i + 1]) - 65536);
            $i = $i + 1;
        } else
            $asc = $tmp;
        $py[] = asc_to_pinyin($asc, $pyarr);
        $i++;
    }
    return $py;
}

/**
 * Ascii转拼音
 * @param $asc
 * @param $pyarr
 */
function asc_to_pinyin($asc, &$pyarr) {
    if ($asc < 128)
        return chr($asc);
    elseif (isset($pyarr[$asc]))
        return $pyarr[$asc];
    else {
        foreach ($pyarr as $id => $p) {
            if ($id >= $asc)
                return $p;
        }
    }
}



/**
 * 加密指定api操作参数|用此函数主要是因为部分模型标题含有特殊字符，导致不能传参
 * @param integer $contentid 内容ID
 * @param integer $modelid   模型id
 * @param string  $title     标题名称
 * @param integer $thumb     缩略图
 * @return string
 */
function api_entoken($contentid, $modelid, $title=null, $thumb=0, $extend=null){
    return hi_encrypt($contentid.'##'.$modelid.'##'.$title.'##'.$thumb.'##'.$extend);
}

/**
 * 解密指定api操作参数
 * @param  string  $token 要解密的字符串 （必须是api_entoken方法加密的字符串）
 * @return array()
 */
function api_detoken($token){
    $data = str2arr(hi_decrypt($token),'##');
    $key = array('contentid', 'modelid', 'title', 'thumb', 'extend');
    return array_combine($key, $data);
}