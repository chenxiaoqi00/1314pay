<?php

namespace Api\Controller;

use Org\Net\Http;
use Org\Net\HttpClient;

class PayController extends HibaseController {
	private $userid = null;
	private $userkey = null;
	private $bankcode = null;
	
	// 网银支付
	public function bank_51ka() {
		$is = M ( 'Orderlist' )->where ( array (
				'orderid' => I ( 'get.orderid' ),
				'money' => I ( 'get.price' ) 
		) )->find ();
		if (! $is) {
			$this->error ( '订单或价格信息错误' );
		}
		if (empty ( I ( 'get.pid' ) )) {
			$this->error ( '银行卡不能为空' );
		}
		$this->getuserid ();
		if (check_wap()) {
			$businesstype = 'wappay';
		}else {
			$businesstype = 'directpay';
		}
		$data = array (
				'nodeAuthorizationURL' => 'https://interface.lcardy.com/Online_Banking_interface',
				'businesstype' => $businesstype,
				'version' => "V2.0",
				'signtype' => "MD5",
				'mercId' => $this->userid,
				'Orderno' => I ( 'get.orderid' ),
				'PAmount' => I ( 'get.price' ),
				'BaCode' => $this->getbankcode ( I ( 'get.pid' ) ),
				'ExInf' => "business",
				'TraCur' => "CNY",
				'ProName' => "business",
				'Cdit' => "business",
				'Deion' => "business",
				'mercip' => "127.0.0.1",
				'productnum' => "1",
				'ordertime' => date ( 'Y-m-d H:i:s' ),
				'MeUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Api/Receive/bank_51ka.html',
				'pageUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Home/Orders/order.html' 
		);
		// 'pageUrl'=>'http://www.318pay.com/pay/51ka_bank/return_url.php'
		
		$signStr = 'mercid=' . $data ['mercId'] . '&orderno=' . $data ['Orderno'] . '&ordertime=' . $data ['ordertime'] . '&pamount=' . $data ['PAmount'] . '&meurl=' . $data ['MeUrl'] . '&pageurl=' . $data ['pageUrl'] . '&bacode=' . $data ['BaCode'] . '&tracur=' . $data ['TraCur'] . '&proname=' . $data ['ProName'] . '&mercip=' . $data ['mercip'] . '&businesstype=' . $data ['businesstype'] . '&version=' . $data ['version'] . '&signtype=' . $data ['signtype'] . '&merckey=' . $this->userkey;
		$data ['sign'] = strtolower ( md5 ( $signStr ) );
		// dump($data);
		$this->assign ( 'data', $data );
		$this->display ( 'pay' );
	}
	
	// 支付宝支付（蓝汛）
	// public function bank_alipay() {
	// $is = M ( 'Orderlist' )->where ( array (
	// 'orderid' => I ( 'get.orderid' ),
	// 'money' => I ( 'get.price' )
	// ) )->find ();
	// if (! $is) {
	// $this->error ( '订单或价格信息错误' );
	// }
	// if (empty ( I ( 'get.pid' ) )) {
	// $this->error ( '' );
	// }
	// $this->getuserid ();
	// if (isset ( $_SERVER ['HTTP_X_WAP_PROFILE'] )) {
	// $BaCode = 'ALIPAYWAPPAY';
	// } else {
	// $BaCode = 'ALIPAY';
	// }
	
	// $data = array (
	// 'nodeAuthorizationURL' => 'https://interface.lcardy.com/Online_Banking_interface',
	// 'mercId' => $this->userid,
	// 'Orderno' => I ( 'get.orderid' ),
	// 'PAmount' => I ( 'get.price' ),
	// 'BaCode' => $BaCode,
	// 'ExInf' => "business",
	// 'TraCur' => "CNY",
	// 'ProName' => "business",
	// 'Cdit' => "business",
	// 'Deion' => "business",
	// 'mercip' => "127.0.0.1",
	// 'productnum' => "1",
	// 'ordertime' => date ( 'Y-m-d H:i:s' ),
	// 'businesstype' => "directpay",
	// 'version' => "V2.0",
	// 'signtype' => "MD5",
	// 'MeUrl' => U ( 'receive/bank_51ka' ),
	// 'pageUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Home/Orders/order.html'
	// );
	
	// $signStr = 'mercid=' . $data ['mercId'] . '&orderno=' . $data ['Orderno'] . '&ordertime=' . $data ['ordertime'] . '&pamount=' . $data ['PAmount'] . '&meurl=' . $data ['MeUrl'] . '&pageurl=' . $data ['pageUrl'] . '&bacode=' . $data ['BaCode'] . '&tracur=' . $data ['TraCur'] . '&proname=' . $data ['ProName'] . '&mercip=' . $data ['mercip'] . '&businesstype=' . $data ['businesstype'] . '&version=' . $data ['version'] . '&signtype=' . $data ['signtype'] . '&merckey=' . $this->userkey;
	// $data ['sign'] = strtolower ( md5 ( $signStr ) );
	
	// $this->assign ( 'data', $data );
	// $this->display ( 'pay' );
	// }
	/* 51支付支付宝 */
	public function bank_alipay() {
		$is = M ( 'Orderlist' )->where ( array (
				'orderid' => I ( 'get.orderid' ),
				'money' => I ( 'get.price' ) 
		) )->find ();
		if (! $is) {
			$this->error ( '订单或价格信息错误' );
		}
		if (empty ( I ( 'get.pid' ) )) {
			$this->error ( '' );
		}
		$access = M ( 'Accessprovider' )->where ( array (
				'accessType' => '51ka' 
		) )->find ();
		if (check_wap()) {
			$pc = 52;
			$faceno = 'zap';
			$PostUrl='http://www.51card.cn/gateway/alipay/wap-alipay.asp';
		} else {
			$pc = 34;
			$faceno='zfb';
			$PostUrl='http://www.51card.cn/gateway/alipay/alipay.asp';
		}
		
		$data = array (
				'apiurl' => $PostUrl,
				'superid' => '100000',
				'customerid' => $access['accessid'],
				'key' => $access['accesskey'],
				'sdcustomno' => I ( 'get.orderid' ),
				'ordermoney' => I ( 'get.price' ),
				'cardno' => $pc,
				'faceno' => $faceno,
				'remarks' => 'remarks',
				'mark' => 'mark',
				'endip' => $_SERVER ['REMOTE_ADDR'],
				'endcustomer' => I ( 'get.orderid' ),
				
				'noticeurl' => 'http://'.$_SERVER['HTTP_HOST'].'/api/receive/alipay_51ka.html' ,
				'backurl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Home/Orders/order.html',
		);
		
		$md5str="customerid=".$data['customerid']."&sdcustomno=".$data['sdcustomno']."&ordermoney=".$data['ordermoney']."&cardno=".$data['cardno']."&faceno=".$data['faceno']."&noticeurl=".$data['noticeurl']."&endcustomer=".$data['endcustomer']."&endip=".$data['endip']."&remarks=".$data['remarks']."&mark=".$data['mark']."&key=".$data['key'];

		$data['sign']=strtoupper(md5($md5str));
		
		$this->assign ( 'data', $data );
		$this->display ( 'pay51' );
	}
	// 蓝汛微信支付
// 	public function bank_wxpay() {
// 		$is = M ( 'Orderlist' )->where ( array (
// 				'orderid' => I ( 'get.orderid' ),
// 				'money' => I ( 'get.price' ) 
// 		) )->find ();
// 		if (! $is) {
// 			$this->error ( '订单或价格信息错误' );
// 		}
// 		if (empty ( I ( 'get.pid' ) )) {
// 			$this->error ( '' );
// 		}
// 		$this->getuserid ();
// 		$data = array (
// 				'nodeAuthorizationURL' => 'https://interface.lcardy.com/Online_Banking_interface',
// 				'mercId' => $this->userid,
// 				'Orderno' => I ( 'get.orderid' ),
// 				'PAmount' => I ( 'get.price' ),
// 				'BaCode' => 'WEIXINPAY',
// 				'ExInf' => "business",
// 				'TraCur' => "CNY",
// 				'ProName' => "business",
// 				'Cdit' => "business",
// 				'Deion' => "business",
// 				'mercip' => "127.0.0.1",
// 				'productnum' => "1",
// 				'ordertime' => date ( 'Y-m-d H:i:s' ),
// 				'businesstype' => "directpay",
// 				'version' => "V2.0",
// 				'signtype' => "MD5",
// 				'MeUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Api/Receive/bank_51ka.html',
// 				'pageUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Home/Orders/order.html' 
// 		);
		
// 		$signStr = 'mercid=' . $data ['mercId'] . '&orderno=' . $data ['Orderno'] . '&ordertime=' . $data ['ordertime'] . '&pamount=' . $data ['PAmount'] . '&meurl=' . $data ['MeUrl'] . '&pageurl=' . $data ['pageUrl'] . '&bacode=' . $data ['BaCode'] . '&tracur=' . $data ['TraCur'] . '&proname=' . $data ['ProName'] . '&mercip=' . $data ['mercip'] . '&businesstype=' . $data ['businesstype'] . '&version=' . $data ['version'] . '&signtype=' . $data ['signtype'] . '&merckey=' . $this->userkey;
// 		$data ['sign'] = strtolower ( md5 ( $signStr ) );
		
// 		$this->assign ( 'data', $data );
// 		$this->display ( 'pay' );
// 	}

	// 51支付微信支付
	public function bank_wxpay() {
		$is = M ( 'Orderlist' )->where ( array (
				'orderid' => I ( 'get.orderid' ),
				'money' => I ( 'get.price' )
		) )->find ();
		if (! $is) {
			$this->error ( '订单或价格信息错误' );
		}
		if (empty ( I ( 'get.pid' ) )) {
			$this->error ( '' );
		}
		$access = M ( 'Accessprovider' )->where ( array (
				'accessType' => '51ka' 
		) )->find ();
		$data = array (
				'apiurl' => 'http://www.51card.cn/gateway/weixinpay/weixinpay.asp',
				'superid' => '100000',
				'customerid' => $access['accessid'],
				'key' => $access['accesskey'],
				'sdcustomno' => I ( 'get.orderid' ),
				'orderAmount' => (int)(I ( 'get.price' )*100),
				'cardno' => '32',
				'mark' => 'mark',
				
				'noticeurl' => 'http://'.$_SERVER['HTTP_HOST'].'/api/receive/wxpay_51ka.html',
				'backurl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Home/Orders/order.html'
		);
		
		//$md5str="customerid=".$data['customerid']."&sdcustomno=".$data['sdcustomno']."&orderAmount=".$data['orderAmount']."&cardno=".$data['cardno']."&noticeurl=".$data['noticeurl']."&backurl=".$data['backurl'].$data['key'];
		$md5str="customerid={$data['customerid']}&sdcustomno={$data['sdcustomno']}&orderAmount={$data['orderAmount']}&cardno={$data['cardno']}&noticeurl={$data['noticeurl']}&backurl={$data['backurl']}{$data['key']}";
		$data ['sign'] = strtoupper ( md5 ( $md5str ) );
		
		$this->assign ( 'data', $data );
		$this->display ( 'pay51wx' );
	}
	// 财付通支付
// 	public function bank_tenpay() {
// 		$is = M ( 'Orderlist' )->where ( array (
// 				'orderid' => I ( 'get.orderid' ),
// 				'money' => I ( 'get.price' ) 
// 		) )->find ();
// 		if (! $is) {
// 			$this->error ( '订单或价格信息错误' );
// 		}
// 		if (empty ( I ( 'get.pid' ) )) {
// 			$this->error ( '' );
// 		}
// 		$access = M ( 'Accessprovider' )->where ( array (
// 				'accessType' => I ( 'get.pid' ) 
// 		) )->find ();
		
// 		$data = array (
// 				'apiurl' => 'https://tzyee.com/Pay.aspx',
// 				'partner' => $access ['accessid'],
// 				'key' => $access ['accesskey'],
// 				'ordernumber' => I ( 'get.orderid' ),
// 				'banktype' => 'TENPAY',
// 				'attach' => '',
// 				'paymoney' => I ( 'get.price' ),
				
// 				'callbackurl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Api/Receive/bank_tenpay.html',
// 				'hrefbackurl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Home/Orders/order.html?sdcustomno=' . I ( 'get.orderid' ) 
// 		);
		
// 		$signSource = sprintf ( "partner=%s&banktype=%s&paymoney=%s&ordernumber=%s&callbackurl=%s%s", $data ['partner'], $data ['banktype'], $data ['paymoney'], $data ['ordernumber'], $data ['callbackurl'], $data ['key'] );
// 		$data ['sign'] = md5 ( $signSource );
		
// 		$postUrl = $data ['apiurl'] . "?banktype=" . $data ['banktype'];
// 		$postUrl .= "&partner=" . $data ['partner'];
// 		$postUrl .= "&paymoney=" . $data ['paymoney'];
// 		$postUrl .= "&ordernumber=" . $data ['ordernumber'];
// 		$postUrl .= "&callbackurl=" . $data ['callbackurl'];
// 		$postUrl .= "&hrefbackurl=" . $data ['hrefbackurl'];
// 		$postUrl .= "&attach=" . $data ['attach'];
// 		$postUrl .= "&sign=" . $data ['sign'];
		
// 		header ( "location:$postUrl" );
// 	}
	// 蓝汛财付通支付
	public function bank_tenpay() {
		$is = M ( 'Orderlist' )->where ( array (
				'orderid' => I ( 'get.orderid' ),
				'money' => I ( 'get.price' )
		) )->find ();
		if (! $is) {
			$this->error ( '订单或价格信息错误' );
		}
		if (empty ( I ( 'get.pid' ) )) {
			$this->error ( '银行卡不能为空' );
		}
		$this->getuserid ();
		if(check_wap()){
			$businesstype = "wappay";
		}else{
			$businesstype = 'directpay';
		}
		$data = array (
				'nodeAuthorizationURL' => 'https://interface.lcardy.com/Online_Banking_interface',
				'businesstype' => $businesstype,
				'version' => "V2.0",
				'signtype' => "MD5",
				'mercId' => $this->userid,
				'Orderno' => I ( 'get.orderid' ),
				'PAmount' => I ( 'get.price' ),
				'BaCode' => 'TENPAY',
				'ExInf' => "business",
				'TraCur' => "CNY",
				'ProName' => 'business',
				'Cdit' => "business",
				'Deion' => "business",
				'mercip' => $_SERVER['REMOTE_ADDR'],
				'productnum' => "1",
				'ordertime' => date ( 'YmdHis' ),
				'MeUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Api/Receive/bank_51ka.html',
				'pageUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Home/Orders/order.html'
		);
		// 'pageUrl'=>'http://www.318pay.com/pay/51ka_bank/return_url.php'
		
		$signStr = 'mercid=' . $data ['mercId'] . '&orderno=' . $data ['Orderno'] . '&ordertime=' . $data ['ordertime'] . '&pamount=' . $data ['PAmount'] . '&meurl=' . $data ['MeUrl'] . '&pageurl=' . $data ['pageUrl'] . '&bacode=' . $data ['BaCode'] . '&tracur=' . $data ['TraCur'] . '&proname=' . $data ['ProName'] . '&mercip=' . $data ['mercip'] . '&businesstype=' . $data ['businesstype'] . '&version=' . $data ['version'] . '&signtype=' . $data ['signtype'] . '&merckey=' . $this->userkey;
		$data ['sign'] = strtolower ( md5 ( $signStr ) );
		
		$this->assign ( 'data', $data );
		$this->display ( 'pay' );
	}
	
	// 蓝汛QQ支付
	public function bank_qqpay() {
		$is = M ( 'Orderlist' )->where ( array (
				'orderid' => I ( 'get.orderid' ),
				'money' => I ( 'get.price' )
		) )->find ();
		if (! $is) {
			$this->error ( '订单或价格信息错误' );
		}
		if (empty ( I ( 'get.pid' ) )) {
			$this->error ( '银行卡不能为空' );
		}
		$this->getuserid ();
		if(check_wap()){
			$businesstype = "wappay";
			$bacode = 'QQWAPPAY';
		}else{
			$businesstype = 'directpay';
			$bacode = 'QQPAY';
		}
		$data = array (
				'nodeAuthorizationURL' => 'https://interface.lcardy.com/Online_Banking_interface',
				'businesstype' => $businesstype,
				'version' => "V2.0",
				'signtype' => "MD5",
				'mercId' => $this->userid,
				'Orderno' => I ( 'get.orderid' ),
				'PAmount' => I ( 'get.price' ),
				'BaCode' => $bacode,
				'ExInf' => "business",
				'TraCur' => "CNY",
				'ProName' => 'business',
				'Cdit' => "business",
				'Deion' => "business",
				'mercip' => $_SERVER['REMOTE_ADDR'],
				'productnum' => "1",
				'ordertime' => date ( 'YmdHis' ),
				'MeUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Api/Receive/bank_51ka.html',
				'pageUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Home/Orders/order.html'
		);
		// 'pageUrl'=>'http://www.318pay.com/pay/51ka_bank/return_url.php'
	
		$signStr = 'mercid=' . $data ['mercId'] . '&orderno=' . $data ['Orderno'] . '&ordertime=' . $data ['ordertime'] . '&pamount=' . $data ['PAmount'] . '&meurl=' . $data ['MeUrl'] . '&pageurl=' . $data ['pageUrl'] . '&bacode=' . $data ['BaCode'] . '&tracur=' . $data ['TraCur'] . '&proname=' . $data ['ProName'] . '&mercip=' . $data ['mercip'] . '&businesstype=' . $data ['businesstype'] . '&version=' . $data ['version'] . '&signtype=' . $data ['signtype'] . '&merckey=' . $this->userkey;
		$data ['sign'] = strtolower ( md5 ( $signStr ) );
		
		$this->assign ( 'data', $data );
		$this->display ( 'pay' );
	}
	
	// QQ支付
// 	public function bank_qqpay() {
// 		$is = M ( 'Orderlist' )->where ( array (
// 				'orderid' => I ( 'get.orderid' ),
// 				'money' => I ( 'get.price' ) 
// 		) )->find ();
// 		if (! $is) {
// 			$this->error ( '订单或价格信息错误' );
// 		}
// 		if (empty ( I ( 'get.pid' ) )) {
// 			$this->error ( '' );
// 		}
// 		if ((strpos ( $_SERVER ['HTTP_USER_AGENT'], 'Mobile' ) !== false && strpos ( $_SERVER ['HTTP_USER_AGENT'], 'iPad' ) === false) || strpos ( $_SERVER ['HTTP_USER_AGENT'], 'Android' ) !== false || strpos ( $_SERVER ['HTTP_USER_AGENT'], 'Silk/' ) !== false || strpos ( $_SERVER ['HTTP_USER_AGENT'], 'Kindle' ) !== false || strpos ( $_SERVER ['HTTP_USER_AGENT'], 'BlackBerry' ) !== false || strpos ( $_SERVER ['HTTP_USER_AGENT'], 'Opera Mini' ) !== false || strpos ( $_SERVER ['HTTP_USER_AGENT'], 'Opera Mobi' ) !== false) {
// 			$banktype = 'QQWAP';
// 		} else {
// 			$banktype = 'QQ';
// 		}
		
// 		$data = array (
// 				'apiurl' => 'http://pay.xtcpay.cn/PayBank.aspx',
// 				'partner' => '17471',
// 				'key' => '7ddf71934218628eb21d236373f211a1',
// 				'ordernumber' => I ( 'get.orderid' ),
// 				'banktype' => $banktype,
// 				'attach' => I ( 'get.payorderid' ),
// 				'paymoney' => I ( 'get.price' ),
				
// 				'callbackurl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Api/Receive/bank_qqpay.html',
// 				'hrefbackurl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Home/Orders/order.html' 
// 		);
		
// 		$signSource = sprintf ( "partner=%s&banktype=%s&paymoney=%s&ordernumber=%s&callbackurl=%s%s", $data ['partner'], $data ['banktype'], $data ['paymoney'], $data ['ordernumber'], $data ['callbackurl'], $data ['key'] );
// 		$data ['sign'] = md5 ( $signSource );
		
// 		$postUrl = $data ['apiurl'] . "?banktype=" . $data ['banktype'];
// 		$postUrl .= "&partner=" . $data ['partner'];
// 		$postUrl .= "&paymoney=" . $data ['paymoney'];
// 		$postUrl .= "&ordernumber=" . $data ['ordernumber'];
// 		$postUrl .= "&callbackurl=" . $data ['callbackurl'];
// 		$postUrl .= "&hrefbackurl=" . $data ['hrefbackurl'];
// 		$postUrl .= "&attach=" . $data ['attach'];
// 		$postUrl .= "&sign=" . $data ['sign'];
		
// 		header ( "location:$postUrl" );
// 	}
	
	// 蓝汛支付卡支付
	public function card_51ka() {
		$is = M ( 'Orderlist' )->where ( array (
				'orderid' => I ( 'get.orderid' ) 
		) )->find ();
		if (! $is) {
			$this->error ( '订单或价格信息错误' );
		}
		if (empty ( I ( 'get.pid' ) )) {
			$this->error ( '' );
		}
		$this->getuserid ();
		$moneys = str2arr ( I ( 'get.cardvalue/s' ), ',' );
		$cardno = str2arr ( I ( 'get.cardnum/s' ), ',' );
		$cardpwd = str2arr ( I ( 'get.cardpwd/s' ), ',' );
		$payorderid = str2arr ( I ( 'get.payorderids/s' ), ',' );
		foreach ( $moneys as $key => $value ) {
			$data = array (
					'url' => 'https://interface.lcardy.com/Merchant_Proxy_Interface',
					'mercId' => $this->userid,
					'order' => I ( 'get.orderid' ),
					'encoder' => pay ( channel(I ( 'get.pid' ),'payid'), 'encode' ),
					'cardno' => $cardno [$key],
					'cardpwd' => $cardpwd [$key],
					'spread' => $payorderid[$key],
					'userregtime' => date ( 'Y-m-d H:i:s' ),
					'money' => $value,
					'MeUrl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Api/Receive/card_51ka.html' 
			);
			
			$signStr = 'mercid=' . $data ['mercId'] . '&order=' . $data ['order'] . '&encoder=' . $data ['encoder'] . '&money=' . $data ['money'] . '&cardno=' . $data ['cardno'] . '&cardpwd=' . $data ['cardpwd'] . '&meurl=' . $data ['MeUrl'] . '&merckey=' . $this->userkey;
			$data ['sign'] = strtolower ( md5 ( $signStr ) );
			
			$url = $data ['url'] . '?mercid=' . $data ['mercId'];
			$url .= '&order=' . $data ['order'];
			$url .= '&encoder=' . $data ['encoder'];
			$url .= '&money=' . $data ['money'];
			$url .= '&cardno=' . $data ['cardno'];
			$url .= '&cardpwd=' . $data ['cardpwd'];
			$url .= '&userregtime=' . $data ['userregtime'];
			$url .= '&meurl=' . $data ['MeUrl'];
			$url .= '&spread=' . $data ['spread'];
			$url .= '&sign=' . $data ['sign'];
			$url .= '&markid=LcardY';
			
			$url = str_replace ( '　', ' ', $url ); // 替换全角空格为半角
			$url = str_replace ( ' ', '%', $url ); // 替换连续的空格为一个
			$handle = fopen($url, 'r');
    		while(!feof($handle)){
        		$output = fgets($handle);
    		}
    		fclose($handle);
		}
// 			fclose($handle);
// 			$ch = curl_init ();
// 			curl_setopt ( $ch, CURLOPT_URL, $url );
// 			curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, 1 );
// 			curl_setopt ( $ch, CURLOPT_HEADER, 0 );
// 			curl_setopt ( $ch, CURLOPT_TIMEOUT, 120 );
// 			curl_setopt ( $ch, CURLOPT_SSL_VERIFYPEER, false );
// 			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false); //不验证证书
// 			$output = curl_exec ( $ch );
// 			dump(curl_error($ch));
// 			dump($output);
// 			curl_close ( $ch );
			if ($output) {
				$output = mb_convert_encoding($output, "UTF-8", "GBK");
				$output = str2arr($output, '&');
				
				if ($output[0] == 'sucode=1') {
					$this->success ( '提交成功', U ( 'Home/orders/order', array (
						'orderno' => $data ['order'] 
					) ) );	
				}elseif ($output[0] == 'sucode=2'){
					//echo '错误';
					$str = substr($output[1],10);
					$this->error($str);
				}
				
			} else {
				//echo '支付失败';
				$this->error ( '提交失败', U ( 'Home/orders/order', array (
						'orderno' => $data ['order'] 
					) ));
			}
		
	}
	// public function demo(){
	// $this->getuserid ();
	// $backgroundMerUrl = 'https://interface.lcardy.com/Merchant_Proxy_Interface';
	// $mercid =$this->userid; #在商家后台获得商户ID
	// $merckey =$this->userkey; #商户密钥merckey在商户后台中获取。
	// $order =I ( 'get.orderid' ); #商户订单号,在商户系统中保持唯一
	// $encoder =pay ( I ( 'get.pid' ), 'encode' ); #产品编码（具体参数详见开发文档附件）
	// $cardno =I ( 'get.cardnum/s' ); #充值卡卡号
	// $cardpwd =I ( 'get.cardpwd/s' ); #充值卡卡密
	// $money =I('get.cardvalue'); #卡面值
	// $spread =''; #商户自定义数，商户扩展信息，返回时原样返回据
	// $userregtime ='2014-05-06-12:23:02'; #用户提交时间 如： 2014-05-01 16:00:00
	// $meurl ='http://' . $_SERVER ['HTTP_HOST'] . '/Api/Receive/card_51ka.html' ; #售卡成功后，接口网关向该网址发送成功通知
	// //$meurl =$meurl.$_SERVER["SERVER_PORT"].'/callBack.php'; #售卡成功后，接口网关向该网址发送成功通知
	// $sign =''; #签名数据（32位小写的组合加密验证串）
	
	// $signStr ='mercid='.$mercid; #=======================MD5组合源串========================#
	// $signStr =$signStr.'&order='.$order; #接口采用md5加密对请求数据验证，验证失败将不予处理。 #
	// $signStr =$signStr.'&encoder='.$encoder; #组合源串如下： #
	// $signStr =$signStr.'&money='.$money; # mercid={}&order={}&encoder={}&money={}&cardno={} #
	// $signStr =$signStr.'&cardno='.$cardno; # &cardpwd={}&meurl={}&merckey={} #
	// $signStr =$signStr.'&cardpwd='.$cardpwd; #组合源串在加密时必须转换为小写，商户具体的参数数值代替{}，#
	// $signStr =$signStr.'&meurl='.$meurl; #注意要保证参数循序的正确性，其中merckey在商户后台中获取。 #
	// $signStr =$signStr.'&merckey='.$merckey; #merckey为通信密钥，通信密钥在商户后台获取（通信密钥获 #
	// #取方法：登录商户后台?账户设置?API接口?获取通信密钥）。 #
	// $sign =md5($signStr); #==========================================================#
	
	// $parames ="?"; #========================接口提交示例========================#
	// $parames =$parames.'mercid='.$mercid; # http://www.xxx.com/Merchant_Proxy_Interface?MercId= #
	// $parames =$parames.'&order='.$order; # 10001000&Order=2342345234111&Money=100&cardNo=5465465435& #
	// $parames =$parames.'&encoder='.$encoder; # MarkId=qqqqq&MeUrl=http://returndata.xxx.com/returndata #
	// $parames =$parames.'&money='.$money; # &spread=GmanPay&Encoder=SNDACARD&cardPwd=435435325432 #
	// $parames =$parames.'&cardno='.$cardno; # &sign=7a86cbf81a8f874de0c1496c9e04aa56 #
	// $parames =$parames.'&cardpwd='.$cardpwd; #示例中：www.xxx.com为接口网关地址（网关地址请联系商务获取） #
	// $parames =$parames.'&userregtime='.$userregtime; #MeUrl必须填写，而且是http://开头的绝对网络地址，否则充值成功#
	// $parames =$parames.'&meurl='.$meurl; #后，您将得不到状态地址。 #
	// $parames =$parames.'&spread='.$spread; #http://returndata.xxx.com/returndata是您用于接收充值报告的回#
	// $parames =$parames.'&sign='.$sign; #调地址，当用户通过接口充值成功后，接口网关自动调用这个地址。#
	// $parames =$parames.'&markid=LcardY'; #------------------------------------------------------------#
	// $SendUrl =$backgroundMerUrl.$parames;
	// dump($SendUrl);
	// $http = new HttpClient();
	// $result = $http::quickGet($SendUrl);#------------------------------------------------------------#
	// //$result =HttpClient::quickGet($SendUrl); #============================================================#
	// #$result =file_get_contents($SendUrl);
	// dump($result);
	// if($result){
	// $sucode =GetQueryString("sucode",$result,"&"); #[sucode]确认代码：1代表成功，2代表失败
	// $returnmsg =GetQueryString("returnmsg",$result,"&"); #[returnmsg]卡处理失败的中文提示，成功为ok
	// $errorcodes =GetQueryString("errorcodes",$result,"&"); #[errorcodes]卡的错误代码，详细请看开发文档的附件
	// if($sucode=="1"){
	// #提交卡成功，输出ok
	// echo "ok";
	// }
	// else{
	// if($errorcodes=="13")
	// {
	// #MD5数据验证不正确
	// echo "Error Sign";
	// }
	// else
	// {
	// echo $returnmsg;
	// }
	// }
	// }
	// }
	// 51支付卡支付
	// public function card_51ka() {
	// $is = M ( 'Orderlist' )->where ( array (
	// 'orderid' => I ( 'get.orderid' )
	// ) )->sum ( 'money' );
	// if (! $is) {
	// $this->error ( '订单或价格信息错误' );
	// }
	// if (empty ( I ( 'get.pid' ) )) {
	// $this->error ( '' );
	// }
	// $access = M ( 'Accessprovider' )->where ( array (
	// 'accessType' => I ( 'get.pid' )
	// ) )->find ();
	// $gateway = channel ( I ( 'get.pid' ), 'gateway' );
	// $data = array (
	// 'apiurl' => 'http://www.51card.cn/gateway/zfgateway.asp',
	// 'superid' => '100000',
	// 'userMoney' => '',
	// 'customerid' => $access ['accessid'],
	// 'key' => $access ['accesskey'],
	// 'sdcustomno' => I ( 'get.orderid' ),
	// 'cardvalue' => I ( 'get.cardvalue' ),
	// 'ordermoneys' => I ( 'get.cardvalue' ),
	// 'ordermoney' => I ( 'get.price' ),
	// 'remarks' => I ( 'get.payorderid' ),
	// 'mark' => I ( 'get.cartnum' ),
	// 'remoteip' => $_SERVER ['REMOTE_ADDR'],
	
	// 'noticeurl' => 'http://' . $_SERVER ['HTTP_HOST'] . '/Api/Receive/card_51ka.html'
	// )
	// ;
	// if (strpos ( $cardvalues, '' )) {
	// $data ['cardnums'] = I ( 'get.cardnums' );
	// $data ['cardpwds'] = I ( 'get.cardpwd' );
	
	// $cardvalues = explode ( ',', $data ['cardvalue'] );
	
	// foreach ( $cardvalues as $key => $value ) {
	// if ($facenos != '') {
	// $facenos .= ',';
	// }
	// if ($cardnos != '') {
	// $cardnos .= ',';
	// }
	// $facenos .= $gateway . $this->getFaceNo ( $value );
	// $cardnos .= $gateway;
	// $ordermoney += $value;
	// }
	
	// $signSource = strtoupper ( md5 ( 'customerid=' . $data ['customerid'] . '&sdcustomno=' . $data ['sdcustomno'] . '&noticeurl=' . $data ['noticeurl'] . '&mark=' . $data ['mark'] . '&key=' . $data ['key'] ) );
	// $data ['sign'] = $signSource;
	// $data ['ordermoney'] = $ordermoney;
	// $data ['cardnos'] = $cardnos;
	// $data ['facenos'] = $facenos;
	// }else {
	// $faceno=$gateway.$this->getFaceNo($data['cardvalue']);
	
	// $signSource = strtoupper ( md5 ( 'customerid=' . $data ['customerid'] . '&sdcustomno=' . $data ['sdcustomno'] . '&noticeurl=' . $data ['noticeurl'] . '&mark=' . $data ['mark'] . '&key=' . $data ['key'] ) );
	// $data ['sign'] = $signSource;
	// $data ['facenos'] = $faceno;
	// $data['cardnum'] =I('get.cardnum');
	// $data['cardpass'] = I('get.cardpwd');
	// $data['cardno'] = $gateway;
	// }
	
	// $postUrl = $data['apiurl'];
	// unset($data['apiurl']);
	// unset($data['key']);
	// $curlPost = $data;
	// $ch = curl_init();//初始化curl
	// curl_setopt($ch, CURLOPT_URL,$postUrl);//抓取指定网页
	// curl_setopt($ch, CURLOPT_HEADER, 0);//设置header
	// curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//要求结果为字符串且输出到屏幕上
	// curl_setopt($ch, CURLOPT_POST, 1);//post提交方式
	// curl_setopt($ch, CURLOPT_POSTFIELDS, $curlPost);
	// $data = curl_exec($ch);//运行curl
	// curl_close($ch);
	// }
	
	// 获取userid和userkey
	private function getuserid($accessType = 'wxpay') {
		$has = M ( 'Accessprovider' )->where ( array (
				'accessType' => $accessType 
		) )->find ();
		if ($has && $accessType = 'wxpay') {
			$this->userid = '10002067';
			$this->userkey = 'f3357d1a9af0105ecd30bb3c7c0c90fb6c91367fb4b1adc7';
		} else {
			$this->userid = $has ['accessid'];
			$this->userkey = $has ['accesskey'];
		}
	}
	
	// 获取银行编码
	private function getbankcode($bankid) {
		$bankcode = "";
		
		if ($bankid == 'ICBC-NET')
			$bankcode = "ICBCNET";
		if ($bankid == 'CMBCHINA-NET')
			$bankcode = "CMBCHINANET";
		if ($bankid == 'ABC-NET')
			$bankcode = "ABCNET";
		if ($bankid == 'CCB-NET')
			$bankcode = "CCBNET";
		if ($bankid == 'BCCB-NET')
			$bankcode = "BCCBNET";
		if ($bankid == 'BOCO-NET')
			$bankcode = "BOCONET";
		if ($bankid == 'CIB-NET')
			$bankcode = "CIBNET";
		if ($bankid == 'NJCB-NET')
			$bankcode = "NJCBNET";
		if ($bankid == 'CMBC-NET')
			$bankcode = "CMBCNET";
		if ($bankid == 'CEB-NET')
			$bankcode = "CEBNET";
		if ($bankid == 'BOC-NET')
			$bankcode = "BOCNET";
		if ($bankid == 'PAB-NET')
			$bankcode = "PABNET";
		if ($bankid == 'CBHB-NET')
			$bankcode = "CBHBNET";
		if ($bankid == 'HKBEA-NET')
			$bankcode = "HKBEANET";
		if ($bankid == 'NBCB-NET')
			$bankcode = "NBCBNET";
		if ($bankid == 'ECITIC-NET')
			$bankcode = "ECITICNET";
		if ($bankid == 'SDB-NET')
			$bankcode = "SDBNET";
		if ($bankid == 'GDB-NET')
			$bankcode = "GDBNET";
		if ($bankid == 'SHB-NET')
			$bankcode = "BOSNET";
		if ($bankid == 'SPDB-NET')
			$bankcode = "SPDBNET";
		if ($bankid == 'POST-NET')
			$bankcode = "POSTNET";
		if ($bankid == 'BJRCB-NET')
			$bankcode = "BJRCBNET";
		if ($bankid == 'HXB-NET')
			$bankcode = "HXBNET";
		if ($bankid == 'CZ-NET')
			$bankcode = "CZCBNET";
		if ($bankid == 'HZBANK-NET')
			$bankcode = "HCCBNET";
		
		return $bankcode;
	}
	// 发送POST
	private function send_post($url, $post_data) {
		$postdata = http_build_query ( $post_data );
		$options = array (
				'http' => array (
						'method' => 'POST',
						'header' => 'Content-type:application/x-www-form-urlencoded',
						'content' => $postdata,
						'timeout' => 15 * 60 
				) 
		); // 超时时间（单位:s）
		
		$context = stream_context_create ( $options );
		$result = file_get_contents ( $url, false, $context );
		
		return $result;
	}
	// 支付失败页面
	public function cardpay() {
		$this->display ();
	}
	
}