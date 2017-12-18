<?php
// +----------------------------------------------------------------------
// | 商品相关函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------

/**
 * 获取订单信息
 * @param integer $orderid 栏目id
 * @param type $field 返回的字段，默认返回全部，数组
 * @param type $refresh 是否强制刷新
 * @return boolean
 */
function order($orderid, $field = null, $refresh = false) {
	if (empty($orderid)) {
		return false;
	}
	$key = 'ORDER_'.$orderid;
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
		$cache = M('Orders')->where(array('orderid'=>$orderid))->find();
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
 * 获取订单列表信息
 * @param integer $orderid 栏目id
 * @param type $field 返回的字段，默认返回全部，数组
 * @param type $refresh 是否强制刷新
 * @return boolean
 */
function orderlist($orderid, $field = null, $refresh = false) {
	if (empty($orderid)) {
		return false;
	}
	$key = 'ORDERLIST_'.$orderid;
	//强制刷新缓存
	if ($refresh) {
		S($key, NULL);
	}
	$cache = S($key);
	if ($cache === 'false') {
		return false;
	}
// 	if (empty($cache)) {
		//读取数据
		$cache = M('Orderlist')->where(array('orderid'=>$orderid))->find();
		if (empty($cache)) {
			S($key, 'false', 60);
			return false;
		} else {
			S($key, $cache);
		}
// 	}
	return is_null($field) ? $cache : $cache[$field];
}

/**
 * 获取单个用户订单号
 * @param unknown $userid 用户ID
 * @param string $where 搜索条件
 * @return number 返回数据
 */
function get_all_orders($userid,$where=''){
	$where['userid'] = $userid;
	$orderid = D('Orders')->where($where)->getField('orderid',true);
	return $orderid;
}

/**
 * 获取单个用户已支付订单信息
 * @param unknown $userid 用户ID
 * @param string $where 搜索条件
 * @return number 返回数据
 */
function get_pay_orders($userid,$where='',$field=''){
	$orderid = get_all_orders($userid,$where);
	if (!empty($orderid)) {
		$map['orderid'] = array('in',$orderid);
		$map['is_pay'] = 1;
		$order = D('Orderlist')->where($map)->field('price,money,realmoney,platformprice,orderid')->select();
		return $field?$order[$field]:$order;
	}
}

function count_money($order){
	foreach ($order as $key => $value) {
		$sum['money'] += $value['money'];
		$sum['realmoney'] += $value['realmoney'];
		$sum['price'] += $value['realmoney']*$value['price'];
		$sum['platformprice'] += $value['realmoney']*($value['platformprice']-$value['price']);
	}
	return $sum?$sum:0;
}

/**
 * 邮件发送函数
 */
// function sendMail($to, $title, $content) {
     
//     Vendor('PHPMailer.PHPMailerAutoload');
//     $mail = new \Org\Util\PHPMailer(true); //实例化
//     $mail->IsSMTP(); // 启用SMTP
//     $mail->Host=C('MAIL_HOST'); //smtp服务器的名称（这里以QQ邮箱为例）
//     $mail->SMTPAuth = C('MAIL_SMTPAUTH'); //启用smtp认证
//     $mail->Username = C('MAIL_USERNAME'); //你的邮箱名
//     $mail->Password = C('MAIL_PASSWORD') ; //邮箱密码
//     $mail->From = C('MAIL_FROM'); //发件人地址（也就是你的邮箱地址）
//     $mail->FromName = C('MAIL_FROMNAME'); //发件人姓名
//     $mail->AddAddress($to,"尊敬的客户");
//     $mail->WordWrap = 50; //设置每行字符长度
//     $mail->IsHTML(C('MAIL_ISHTML')); // 是否HTML格式邮件
//     $mail->CharSet=C('MAIL_CHARSET'); //设置邮件编码
//     $mail->Subject =$title; //邮件主题
//     $mail->Body = $content; //邮件内容
//     $mail->AltBody = "这是一个纯文本的身体在非营利的HTML电子邮件客户端"; //邮件正文不支持HTML的备用显示
//     return($mail->Send());
// }

/* 系统邮件发送函数
* @param string $to 接收邮件者邮箱
* @param string $name 接收邮件者名称
* @param string $subject 邮件主题
* @param string $body 邮件内容
* @param string $attachment 附件列表
*/
function send_mail($to = '', $subject = '', $body = '', $name = '', $attachment = null)
{
    return sendEmail($to, $subject, $body);
}

/**
 * 发送邮件
 * @param  string $address 需要发送的邮箱地址 发送给多个地址需要写成数组形式
 * @param  string $subject 标题
 * @param  string $content 内容
 * @return boolean       是否成功
 */
function sendEmail($address,$subject,$content){
	//邮件服务器相关配置
	//域名邮箱的服务器地址
	$email_smtp        ='smtp.163.com';
	//smtp登录的账号
	$email_username    ='18069131930@163.com';
	//smtp登录的密码
	$email_password    ='afeng0823';
	//设置发件人邮箱地址 这里填入上述提到的“发件人邮箱”
// 	$email_from_name   =C('MAIL_FROMNAME');
	$email_from_name   ="1314发卡平台";
	//加密方式 "ssl" or "tls"
	$email_smtp_secure ="ssl";
	//设置ssl连接smtp服务器的远程服务器端口号 可选465或587
	$email_port        ='465';

	//实例化PHPMailer
	$phpmailer = new \Libs\PHPMailer\PHPMailer();
	// 设置PHPMailer使用SMTP服务器发送Email
	$phpmailer->IsSMTP();
	// 设置设置smtp_secure
	$phpmailer->SMTPSecure=$email_smtp_secure;
	// 设置port
	$phpmailer->Port=$email_port;
	// 设置为html格式
	$phpmailer->IsHTML(true);
	// 设置邮件的字符编码'
	$phpmailer->CharSet='UTF-8';
	// 设置SMTP服务器。
	$phpmailer->Host=$email_smtp;
	// 设置为"需要验证"
	$phpmailer->SMTPAuth=true;
	// 设置用户名
	$phpmailer->Username=$email_username;
	// 设置密码
	$phpmailer->Password=$email_password;
	// 设置邮件头的From字段。
	$phpmailer->From=$email_username;
	// 设置发件人名字
	$phpmailer->FromName=$email_from_name;
	// 添加收件人地址，可以多次使用来添加多个收件人
	if(is_array($address)){
		foreach($address as $addressv){
			$phpmailer->AddAddress($addressv);
		}
	}else{
		$phpmailer->AddAddress($address);
	}
	// 设置邮件标题
	$phpmailer->Subject=$subject;
	// 设置邮件正文
	$phpmailer->Body=$content;
	// 发送邮件。
	if(!$phpmailer->Send()) {
		$phpmailererror=$phpmailer->ErrorInfo;
		return array("error"=>1,"message"=>$phpmailererror);
	}else{
		return array("error"=>0);
	}
}
/**
 * 发送邮件
 * @param  string $address 需要发送的邮箱地址 发送给多个地址需要写成数组形式
 * @param  string $subject 标题
 * @param  string $content 内容
 * @return boolean       是否成功
 */
// function send_mail_local($address,$subject,$content){
//     $email_smtp=C('EMAIL_SMTP');
//     $email_username=C('EMAIL_USERNAME');
//     $email_port=C('EMAIL_PORT');
//     $email_password=C('EMAIL_PASSWORD');
//     $email_from_name=C('EMAIL_FROM_NAME');

//     if(empty($email_smtp) || empty($email_username) || empty($email_password) || empty($email_from_name)){

//         return array("error"=>1,"message"=>'邮箱配置不完整');
//     }
//     require_once './ThinkPHP/Library/Org/Nx/PHPMailer.class.php';
//     require_once './ThinkPHP/Library/Org/Nx/smtp.class.php';
//     $phpmailer=new \PHPMailer();
//     // 设置PHPMailer使用SMTP服务器发送Email
//     $phpmailer->IsSMTP();
//     // 设置为html格式
//     $phpmailer->IsHTML(true);
//     // 设置邮件的字符编码'
//     $phpmailer->CharSet='UTF-8';
//     // 设置SMTP服务器。
//     $phpmailer->Host=$email_smtp;
//     // 设置为"需要验证"
//     $phpmailer->SMTPAuth=true;
//     // 设置用户名
//     $phpmailer->Username=$email_username;
//     // SMTP服务器的端口号
//     $phpmailer->Port = $email_port;
//     // 设置密码
//     $phpmailer->Password=$email_password;
//     // 设置邮件头的From字段。
//     $phpmailer->From=$email_username;
//     // 设置发件人名字
//     $phpmailer->FromName=$email_from_name;
//     // 添加收件人地址，可以多次使用来添加多个收件人
//     if(is_array($address)){
//         foreach($address as $addressv){
//             $phpmailer->AddAddress($addressv);
//         }
//     }else{
//         $phpmailer->AddAddress($address);
//     }
//     // 设置邮件标题
//     $phpmailer->Subject=$subject;
//     // 设置邮件正文
//     $phpmailer->Body=$content;
//     // 发送邮件。
//     if(!$phpmailer->Send()) {
//         $phpmailererror=$phpmailer->ErrorInfo;
//         return array("error"=>1,"message"=>$phpmailererror);
//     }else{
//         return array("error"=>0);
//     }
    
// }
