<?php
// +----------------------------------------------------------------------
// | 模型相关函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
// 获取属性类型信息
function get_field_type($type=''){
    static $_type = array(
		'num'      => array('数字', 'int(11) UNSIGNED NOT NULL'),
		'price'    => array('价格', 'int(11) UNSIGNED NOT NULL'),
		'string'   => array('单行文本', 'varchar(128) NOT NULL'),
		'textarea' => array('多行文本', 'varchar(255) NOT NULL'),
		'array'    => array('数组', 'varchar(32) NOT NULL'),
		'password' => array('密码', 'char(32) NOT NULL'),
		'radio'    => array('单选按钮', 'tinyint(2) NOT NULL'),
		'checkbox' => array('复选框', 'tinyint(2) NOT NULL'),
		'select'   => array('下拉框', 'varchar(32) NOT NULL'),
		'icon'     => array('字体图标', 'varchar(16) NOT NULL'),
		'date'     => array('日期', 'int(10) UNSIGNED NOT NULL'),
		'datetime' => array('时间', 'int(10) UNSIGNED NOT NULL'),
		'picture'  => array('单张图片', 'int(11) UNSIGNED NOT NULL'),
		'pictures' => array('多张图片', 'varchar(32) NOT NULL'),
		'file'     => array('单个文件', 'varchar(32) NOT NULL'),
		'files'    => array('多个文件', 'varchar(32) NOT NULL'),
		'media'    => array('单个媒体', 'varchar(32) NOT NULL'),
		'medias'   => array('多个媒体', 'varchar(32) NOT NULL'),
		'ueditor'   => array('百度编辑器', 'text'),
		'switch'   => array('开关', 'tinyint(1) NOT NULL'),
    );
    return $type ? $_type[$type][0] : $_type;
}

/**
 * 获取指定模型所有字段
 * @param  integer $modelid 模型id
 * @param  string $field 返回的字段，默认返回全部，数组
 * @param  boolean $refresh 是否强制刷新
 * @return array()
 */
function fields($modelid, $field = null, $refresh = false) {
    if (empty($modelid)) {
        return false;
    }
    $key = 'MODEL_FIELDS_'.$modelid;
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
        $fields = M('ModelField')->where(array('modelid'=>$modelid))->select();
        if (empty($fields)) {
            S($key, 'false', 60);
            return false;
        } else {
        	foreach ($fields as $value) {
				$cache[$value['name']] = $value;
			}
            S($key, $cache, 3600*24);
        }
    }
    return is_null($field) ? $cache : $cache[$field];
}

/**
 * 获取模型数据
 * @param  integer  $catid 栏目id
 * @param  string   $field 返回的字段，默认返回全部，数组
 * @param  boolean  $refresh 是否强制刷新
 * @return array()
 */
function model($modelid, $field = null, $refresh = false) {
    if (empty($modelid)) {
        return false;
    }
    $key = 'MODEL_'.$modelid;
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
        $cache = M('Model')->field('id,title,name,tablename,tpl_list,tpl_show,tpl_publish')->find($modelid);
        if (empty($cache)) {
            S($key, 'false', 60);
            return false;
        } else {
            S($key, $cache);
        }
    }
    return is_null($field) ? $cache : $cache[$field];
}

/*获取表名称*/
function tablename($modelid){
    if (empty($modelid)) {
        return false;
    }
    /*$table = model($modelid, 'name');
    if(!$table){
        $tablename = model($modelid, 'tablename');
        $tablename = str2arr($tablename, '_');
        foreach ($tablename as $key) {
            $table .= ucfirst($key);
        }
    }*/
    return model($modelid, 'name');
}