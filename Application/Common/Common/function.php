<?php
// +----------------------------------------------------------------------
// | 公共函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
//加载函数
require_once(APP_PATH . '/Common/Common/module.php'); 	  //模块
require_once(APP_PATH . '/Common/Common/attachment.php'); //状态
require_once(APP_PATH . '/Common/Common/content.php');    //内容
require_once(APP_PATH . '/Common/Common/category.php');   //栏目
require_once(APP_PATH . '/Common/Common/public.php');     //公共
require_once(APP_PATH . '/Common/Common/member.php');     //用户
require_once(APP_PATH . '/Common/Common/status.php');     //状态
require_once(APP_PATH . '/Common/Common/model.php');      //模型
require_once(APP_PATH . '/Common/Common/position.php');   //推荐位
require_once(APP_PATH . '/Common/Common/goods.php');   //商品
require_once(APP_PATH . '/Common/Common/orders.php');   //订单
require_once(APP_PATH . '/Common/Common/invite.php');   //特约商户
require_once(APP_PATH . '/Common/Common/center.php');   //商户中心
/**
 * 系统非常规MD5加密方法
 * @param  string $str 要加密的字符串
 * @return string
 */
function hi_md5($str, $key = 'HiColor'){
	return '' === $str ? '' : md5(sha1($str) . $key);
}
/**
 * 系统非常规MD5加密方法
 * @param  string $str 要加密的字符串
 * @return string
 */
function h318_md5($str){
	return '' === $str ? '' : md5(md5($str));
}
/**
 * 系统加密方法
 * @param string $data 要加密的字符串
 * @param string $key  加密密钥
 * @param int $expire  过期时间 (单位:秒)
 * @return string
 */
function hi_encrypt($data, $key, $expire = 0) {
	$key  = md5($key);
	$data = base64_encode($data);
	$x    = 0;
	$len  = strlen($data);
	$l    = strlen($key);
	$char =  '';
	for ($i = 0; $i < $len; $i++) {
		if ($x == $l) $x=0;
		$char  .= substr($key, $x, 1);
		$x++;
	}
	$str = sprintf('%010d', $expire ? $expire + time() : 0);
	for ($i = 0; $i < $len; $i++) {
		$str .= chr(ord(substr($data,$i,1)) + (ord(substr($char,$i,1)))%256);
	}
	return str_replace('=', '', base64_encode($str));
}

/**
 * 系统解密方法
 * @param string $data 要解密的字符串 （必须是hi_encrypt方法加密的字符串）
 * @param string $key  加密密钥
 * @return string
 */
function hi_decrypt($data, $key){
	$key    = md5($key);
	$x      = 0;
	$data   = base64_decode($data);
	$expire = substr($data, 0, 10);
	$data   = substr($data, 10);
	if($expire > 0 && $expire < time()) {
		return '';
	}
	$len  = strlen($data);
	$l    = strlen($key);
	$char = $str = '';
	for ($i = 0; $i < $len; $i++) {
		if ($x == $l) $x = 0;
		$char  .= substr($key, $x, 1);
		$x++;
	}
	for ($i = 0; $i < $len; $i++) {
		if (ord(substr($data, $i, 1)) < ord(substr($char, $i, 1))) {
			$str .= chr((ord(substr($data, $i, 1)) + 256) - ord(substr($char, $i, 1)));
		}else{
			$str .= chr(ord(substr($data, $i, 1)) - ord(substr($char, $i, 1)));
		}
	}
	return base64_decode($str);
}

/**
 * 数据签名认证
 * @param  array  $data 被认证的数据
 * @return string       签名
 */
function data_auth_sign($data) {
    //数据类型检测
    if(!is_array($data)){
        $data = (array)$data;
    }
    ksort($data); //排序
    $code = http_build_query($data); //url编码并生成query字符串
    $sign = sha1($code); //生成签名
    return $sign;
}


/**
 * 把返回的数据集转换成Tree
 * @param array $list 要转换的数据集
 * @param string $pid parent标记字段
 * @param string $level level标记字段
 * @return array
 */
function list_to_tree($list, $pk='id', $pid = 'pid', $child = '_child', $root = 0) {
    // 创建Tree
    $tree = array();
    if(is_array($list)) {
        // 创建基于主键的数组引用
        $refer = array();
        foreach ($list as $key => $data) {
            $refer[$data[$pk]] =& $list[$key];
        }
        foreach ($list as $key => $data) {
            // 判断是否存在parent
            $parentId =  $data[$pid];
            if ($root == $parentId) {
                $tree[] =& $list[$key];
            }else{
                if (isset($refer[$parentId])) {
                    $parent =& $refer[$parentId];
                    $parent[$child][] =& $list[$key];
                }
            }
        }
    }
    return $tree;
}

/**
 * 产生一个指定长度的随机字符串,并返回给用户
 * @param type $len 产生字符串的长度
 * @return string 随机字符串
 */
function genRandomString($len = 6) {
    $chars = array(
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
        "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
        "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G",
        "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R",
        "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2",
        "3", "4", "5", "6", "7", "8", "9"
    );
    $charsLen = count($chars) - 1;
    // 将数组打乱
    shuffle($chars);
    $output = "";
    for ($i = 0; $i < $len; $i++) {
        $output .= $chars[mt_rand(0, $charsLen)];
    }
    return $output;
}

/**
 * 获取对应组的联动列表
 * @param type $name 联动配置标识
 * @param type $refresh 是否强制刷新
 * @return array
 */
function linkage($name, $refresh = false) {
    if (empty($name)) {
        return false;
    }
    if(is_numeric($name)){
        $name = M('Linkage')->getFieldByid($name,'name');
    }
    $key = 'LINKAGE_'.$name;
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
        $group_id = M('Linkage')->getFieldByName($name,'id');
        if(!$group_id){
            return false;
        }
        $cache = M('Linkage')-> where(array('pid' => $group_id))->order('value asc')->getField('value,title');
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
 * 返回联动菜单值列表
 * @param  integer  $id 属性值
 * @param  string   $group 关联标识
 * @return string
 */
function linkageName($id, $group='BLOCK') {
    if (empty($group)) {
        return false;
    }
    $cache = S('LINKAGE_'.$group);
    return $cache[$id];
}

/**
 * 获取碎片
 * @param type $name 联动配置标识
 * @param type $refresh 是否强制刷新
 * @return array
 */
function block($name, $refresh = false) {
    if (empty($name)) {
        return false;
    }
    if(is_numeric($name)){
        $name = M('Block')->getFieldByid($name,'name');
    }
    $key = 'BLOCK_'.$name;
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
        $cache = M('Block')->getFieldByName($name,'content');
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
 * 实例化page类
 * @param  integer  $count 总数
 * @param  integer  $limit 每页数量
 * @return subject       page类
 */
function new_page($count,$limit=10){
    return new \Think\Page($count,$limit);
}
/**
 * 状态值转中文
 * @param integer $is_status 支付状态
 * @param integer $is_ship 结算状态
 * @return string
 */
function get_pay_status($is_status){
	$str = '';
	switch ((int)$is_status) {
		case 0:
			$str = '<font color="gray">未付款</font>';
		break;
		case 1:
		    $str = '<font color="blue">已付款 </font>';
		break;
		case 3:
			$str = '<font color="red">部分付款</font>';
		break;
		case 4:
			$str = '<font color="red">已退款</font>';
		break;
		default:
			$str = '<font color="gray">未付款</font>';
		break;
	}
	return $str;
}

/**
 * 判断商家是否同意退款
 * @return string
 */
function get_agree_status($is_agree){
    $str = '';
    $id = (int)$is_agree;
    if($id == 0){
        $str = '<font color="gray">未处理</font>';
    }else if($id == 1){
      $str = '<font color="green">同意退款</font>';
    }else if($id == 2){
        $str = '<font color="red">拒绝退款</font>';
    }
    return $str;
}

/**
 * 判断平台对投诉订单的处理
 * @return string
 */
function get_compalin_status($is_state){
    $str = '';
    $id = (int)$is_state;
    if($id == 0){
        $str = '<font color="gray">未处理</font>';
    }else if($id == 1){
        $str = '<font color="red">退款</font>';
    }else if($id == 2){
        $str = '<font color="green">结算</font>';
    }
    return $str;
}

/**
 * 状态值转中文
 * @param integer $is_status 支付状态
 * @param integer $is_ship 结算状态
 * @return string
 */
function get_pay_ship($is_ship){
    $str = '';
    switch ((int)$is_ship) {
        case 0:
            $str = '<font color="gray">未结算</font>';
            break;
        case 1:
            $str = '<font color="green">已结算</font>';
            break;
        case 2:
            $str = '<font color="red">已退款</font>';
            break;
        default:
            $str = '<font color="gray">未结算</font>';
            break;
    }
    return $str;
}


/**
 * 获取金额
 * @param unknown $orderid
 * @param number $type 1:商户收入  2:平台收入
 */
function get_price($orderid,$type=1){
	$price = 0;
	if (orderlist($orderid,'realmoney') == 0) {
		return $price;
	}
	switch ($type) {
		case 1:
			$price = orderlist($orderid,'price')*orderlist($orderid,'realmoney');
		break;
		case 2:
			$price = (orderlist($orderid,'platformprice')-orderlist($orderid,'price'))*orderlist($orderid,'realmoney');
		break;
		default:
			$price = orderlist($orderid,'price')*orderlist($orderid,'realmoney');
		break;
	}
	
	return $price;
}

function get_ctype_status($status) {
	$text = '';
	switch ($status) {
		case 1:
			$text = '<font color="green">自动结算</font>';
			break;
		case 2:
			$text = '<font color="green">商户提现</font>';
			break;
		case 3:
			$text = '<font color="green">审核模式</font>';
			break;
		case 4:
			$text = '<font color="green">暂停结算</font>';
			break;
		case 5:
			$text = '<font color="green">贵宾会员</font>';
			break;
		case 6:
			$text = '<font color="green">超级会员</font>';
			break;
		default:
			$text = '<font color="green">自动结算</font>';
			break;
	}

	return $text;
}

function get_ptype($status) {
	$text = '';
	switch ($status) {
		case 1:
			$text = '<font color="green">银行转账</font>';
			break;
		case 2:
			$text = '<font color="green">支付宝转账</font>';
			break;
		case 3:
			$text = '<font color="green">财付通转账</font>';
			break;
		default:
			$text = '<font color="green">银行转账</font>';
			break;
	}

	return $text;
}

function get_payments_status($status) {
	$text = '';
	switch ($status) {
		case 1:
			$text = '<font color="blue">成功</font>';
			break;
		case 2:
			$text = '<font color="red">失败</font>';
			break;
		default:
			$text = '<font color="blue">成功</font>';
			break;
	}

	return $text;
}

//优惠券码
function getRandomString($len){
    $chars = array("A", "B", "C", "D", "E", "F", "G","H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R","S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2","3", "4", "5", "6", "7", "8", "9");
    $charsLen = count($chars) - 1;
    shuffle($chars);
    $output = "";
    for ($i=0; $i<$len; $i++){
        $output .= $chars[mt_rand(0, $charsLen)];
    }
    $output=substr(strtoupper(md5(md5(uniqid()).md5(microtime()).md5($output))),0,$len);
    return $output;
}

// 检查手机端
function check_wap(){
	// 先检查是否为wap代理，准确度高
	if(stristr($_SERVER['HTTP_VIA'],"wap")){
		return true;
	}
	// 检查浏览器是否接受 WML.
	elseif(strpos(strtoupper($_SERVER['HTTP_ACCEPT']),"VND.WAP.WML") > 0){
		return true;
	}
	//检查USER_AGENT
	elseif(preg_match('/(blackberry|configuration\/cldc|hp |hp-|htc |htc_|htc-|iemobile|kindle|midp|mmp|motorola|mobile|nokia|opera mini|opera |Googlebot-Mobile|YahooSeeker\/M1A1-R2D2|android|iphone|ipod|mobi|palm|palmos|pocket|portalmmm|ppc;|smartphone|sonyericsson|sqh|spv|symbian|treo|up.browser|up.link|vodafone|windows ce|xda |xda_)/i', $_SERVER['HTTP_USER_AGENT'])){
		return true;
	}
	else{
		return false;
	}
}

/**
 * 功能：生成二维码
 * @param string $qr_data   手机扫描后要跳转的网址
 * @param string $qr_level  默认纠错比例 分为L、M、Q、H四个等级，H代表最高纠错能力
 * @param string $qr_size   二维码图大小，1－10可选，数字越大图片尺寸越大
 * @param string $save_path 图片存储路径
 * @param string $save_prefix 图片名称前缀
 */
function createQRcode($save_path,$qr_data='PHP QR Code :)',$qr_level='L',$qr_size=4,$save_prefix='qrcode'){
    if(!isset($save_path)) return '';
    //设置生成png图片的路径
    $PNG_TEMP_DIR = & $save_path;
    //导入二维码核心程序
    vendor('PHPQRcode.class#phpqrcode');  //注意这里的大小写哦，不然会出现找不到类，PHPQRcode是文件夹名字，class#phpqrcode就代表class.phpqrcode.php文件名
    //检测并创建生成文件夹
    if (!file_exists($PNG_TEMP_DIR)){
        mkdir($PNG_TEMP_DIR);
    }
    $filename = $PNG_TEMP_DIR.'test.png';
    $errorCorrectionLevel = 'L';
    if (isset($qr_level) && in_array($qr_level, array('L','M','Q','H'))){
        $errorCorrectionLevel = & $qr_level;
    }
    $matrixPointSize = 4;
    if (isset($qr_size)){
        $matrixPointSize = & min(max((int)$qr_size, 1), 10);
    }
    if (isset($qr_data)) {
        if (trim($qr_data) == ''){
            die('data cannot be empty!');
        }
        //生成文件名 文件路径+图片名字前缀+md5(名称)+.png
        $filename = $PNG_TEMP_DIR.$save_prefix.md5($qr_data.'|'.$errorCorrectionLevel.'|'.$matrixPointSize).'.png';
        //开始生成
        QRcode::png($qr_data, $filename, $errorCorrectionLevel, $matrixPointSize, 2);
    } else {
        //默认生成
        QRcode::png('PHP QR Code :)', $filename, $errorCorrectionLevel, $matrixPointSize, 2);
    }
    
    if(file_exists($PNG_TEMP_DIR.basename($filename)))
        return basename($filename);
    else
        return FALSE;
}

//根据路径生成二维码
function qrcode($payUrl){
    $save_path = isset($_GET['save_path'])?$_GET['save_path']:__ROOT__.'Uploads/qrcode/';  //图片存储的绝对路径
    $web_path = isset($_GET['save_path'])?$_GET['web_path']:'/Uploads/qrcode/';        //图片在网页上显示的路径
    $qr_url = $payUrl?$payUrl:'http://www.1314fk.com/';
    $qr_level = isset($_GET['qr_level'])?$_GET['qr_level']:'H';
    $qr_size = isset($_GET['qr_size'])?$_GET['qr_size']:'6';
    $save_prefix = isset($_GET['save_prefix'])?$_GET['save_prefix']:'ZETA';
    if($filename = createQRcode($save_path,$qr_url,$qr_level,$qr_size,$save_prefix)){
        $pic = $web_path.$filename;
    }
    return $pic;
    /*   echo "<img src='".$pic."'>"; */
}