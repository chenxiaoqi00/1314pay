<?php
// +----------------------------------------------------------------------
// | hicms | 商户管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenj 
// +----------------------------------------------------------------------
namespace Admin\Controller;
class BusinessController extends AdminController {
    /* 商户列表*/
	public function index() {
		$list = $this->islists();
		foreach ($list as $key => $value) {
			$list[$key]['is_state_text'] = $this->get_status($value['is_state']);
			$list[$key]['ctypetext'] = $this->get_ctype_status($value['ctype']);
		}
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->assign('list', $list);
		$this->assign('title',$title?$title:'商户管理');
		$this->assign('meta_title', $catid ? '商户管理 - '.category($catid, 'title') : '商户信息');
		$this->display();
	}
	/* 代理商信息*/
	public function agent(){
		$list = $this->islists(2);
		foreach ($list as $key => $value) {
			$list[$key]['is_state_text'] = $this->get_status($value['is_state']);
			$list[$key]['ctypetext'] = $this->get_ctype_status($value['ctype']);
		}
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		
		$this->assign('list', $list);
		$this->assign('title',$title?$title:'代理商信息');
		$this->assign('meta_title', $catid ? '商户管理 - '.category($catid, 'title') : '代理商信息');
		$this->display('index');
	}
	
	
	/*文章列表*/
	public function islists($utype = null){
		$IP= trim(I('get.ip/s'));
		$map = array();
		
		$map['status'] = array('EGT',0);
		
		if(isset($utype)){
			$map['utype'] = $utype;
		}
		if(isset($_GET['ip'])){
			$map['logip'] = $IP;
		}
		
		// 状态
		if(isset($_GET['is_state'])){
			$map['is_state'] = I('is_state');
			$status = $map['is_state'];
		}else{
			$status = null;
			$map['is_state'] = array('in', '0,1,2');
		}
		// 付款方式
		if(isset($_GET['ctype'])){
			$map['ctype'] = I('ctype');
		}
		
		//特约商户
		if ( isset($_GET['is_invite']) ) {
		    
		    $map['is_invite']  = 1; //array('exp',"IS NOT NULL AND invite_id !=''");
		}
		// 用户名|手机|邮箱
		if ( isset($_GET['username']) ) {
			$verify = new \Libs\Verify();
			if($verify::isMobile(I('username'))){
				$map['tel'] = array('like','%'.I('username').'%');
			}else if($verify::isEmail(I('username'))){
				$map['email'] = array('like','%'.I('username').'%');
			}else{
				$map['username'] = array('like','%'.I('username').'%');
			}
		}
		
		$list = $this->lists('Users', $map, 'id desc',true,true,true);
		
		return $list;
	}
	
	
	/*添加*/
	public function add(){
		if(IS_POST){
			$done = D('Users')->update();
			if(!$done){
				$this->error(D('Users')->getError());
			}else{
				$this->success('新增成功', Cookie('__forward__'));
			}
		}else{
			
			$ctype = linkage('settlement_method');
			$this->assign('ctype',$ctype);
			$this->assign('is_state',$is_state);
			//获取左边菜单
			$this->display('edit');
		}
	}
	
	/*添加*/
	public function edit($id){
		if(IS_POST){
			$done = D('Users')->update();
			if(!$done){
				$this->error(D('Users')->getError());
			}else{
				$this->success('新增成功', Cookie('__forward__'));
			}
		}else{
			
			$ctype = linkage('settlement_method');
			$info = D('Users')->find($id);
			
			$this->assign('info',$info);
			$this->assign('ctype',$ctype);
			//获取左边菜单
			$this->display('edit');
		}
	}
	
	
	private function get_status($status) {
		$text = '';
		switch ($status) {
			case 1:
				$text = '<font color="green">已审核</font>';
				break;
			case 2:
				$text = '<font color="red">未审核</font>';
				break;
			case 0:
				$text = '<font color="grey">已冻结</font>';
				break;
			default:
				$text = '<font color="green">已审核</font>';
			break;
		}
		
		return $text;
	}
	
	private function get_ctype_status($status) {
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
	
	private function get_ptype($status) {
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
	
	public function delinfo($model = 'Users') {
		$don = $this->del($model);
	}
	
	public function userPayChannel($userid) {
	    $userid = I("get.userid");
 	   /*  dump($userid); */
	 /*    exit; */
	    $payList =M("userprice")->alias('a')
        ->join("__CHANNELLIST__ b ON a.channelid=b.id",'LEFT')
        ->field('a.channelid,a.id,a.userid,a.price userprice,a.is_state,b.channelname,b.price channelprice')
        ->order('channelid asc')
        ->where(array("a.userid"=>$userid))
        ->select();
	    foreach($payList as $k=>$v){
	        $payList[$k]['price'] = $v['userprice'] =='0'?$v['channelprice']:$v['userprice'];
	    }
	    $this->assign("paylist",$payList);
	    $_payList=$this->fetch("paylist");
	    $this->ajaxReturn($_payList); 
	}
	
	public function quick(){
	    $id= I("POST.id");
	    $data= I("POST.value");
	    $field = I("POST.field");
	    $resoult= M("userprice")->where(array("id"=>$id))->setField($field,$data);
	    if($resoult){
	        $this->success("修改成功！");
	    }else{
	        $this->error("修改失败！");
	    }
	}
	
	public function changeState(){
	    $id= I("POST.id");
	    $field = I("POST.field");
	    $data = I("POST.value")=="true" ? 0 : 1;
	    $msg = I("POST.value")=="true" ? "打开" : "关闭";
	       $resoult= M("userprice")->where(array("id"=>$id))->setField($field,$data);
	    if($resoult){
	        $this->success($msg."成功！");
	    }else{
	        $this->error($msg."失败！");
	    }
	}
	//查看特约商户
	public function getInvite(){
	    $userid = I("get.userid");
	    $list = invite($userid);
	    $this->assign("invite",$list);
	    $invite=$this->fetch("invite");
	    $this->ajaxReturn($invite);
	}
	
	//特约商户结算
	public function changeinvite(){
	    $useid = I("get.userid");  //特约商户的ID
	    $inviteid = I("post.id"); // 需要修改的商户的ID
	    $map['useid'] = $useid;
	    $map['inviteid'] = $inviteid;
	    $v = I("post.value")=="true"?1:0;
	    $mounth = I("get.date")?I("get.date"):date("n");
	    $_mounth =  getEmonth($mounth);
	    $resoult = M('invite')->where($map)-> setField($_mounth,$v);
	    if($resoult){
	        $v?$this->success("结算成功！"):$this->success("取消结算成功！");
	    }else{
	        $this->error("结算失败！");
	    }
	}
	
	//允许商户修改转账信息
	public function changeAccount(){
	    $map['userid'] =I("post.id");
	    
	    $type = I("post.value"); 
	    if($type == "false"){
	        $is = M("userinfo")->where($map)->setField("is_account",0);
	        $msg = "禁止商户修改转账信息";
	    }else{
	        $is = M("userinfo")->where($map)->setField("is_account",1);
	        $msg = "允许商户修改转账信息";
	    }
	    if($is){
	        $this->success($msg);
	    }else{
	        $this->error("开启或关闭失败,请联系技术");
	    }
	}
	
	//后台登录前台用户后台
	public function centerLogin(){
	    $username = I("post.username");
	    $password = I("post.password");
	    $user = M("users")->where(array("username"=>$username))->find();
	    if(is_array($user) && $user['status']){
	        if($password === $user['password']){
	            //记录登录SESSION和COOKIES
	            $auth = array(
	                'uid'       => $user['id'],
	                'last_time' => $user['last_time'],
	                'last_ip'   => $user['last_ip'],
	                'utype'   => $user['utype'],
	            );
	            $_SESSION['tyb_center']['user_auth'] = $auth;  //添加center模块的session前缀
	            $_SESSION['tyb_center']['user_auth_sign'] = data_auth_sign($auth);
// 	            session('user_auth', $auth);
// 	            session('user_auth_sign', data_auth_sign($auth));
	            $this->success("登录成功！",U("Center/Index/index"));
	        }else{
	            $this->error("登录失败！");
	        }
	    }else{
	        $this->error("登录失败！");
	    }
	}
	
	public function mFristAndLast($y = "", $m = ""){
	    $m = 5;
	    if ($y == "") $y = date("Y");
	    if ($m == "") $m = date("m");
	    $m = sprintf("%02d", intval($m));
	    $y = str_pad(intval($y), 4, "0", STR_PAD_RIGHT);
	    $m>12 || $m<1 ? $m=1 : $m=$m;
	    $firstday = strtotime($y . $m . "01000000");
	    $firstdaystr = date("Y-m-01", $firstday);
	    $lastday = date('Y-m-d 23:59:59', strtotime("$firstdaystr +1 month -1 day"));
	    dump($firstdaystr);
	    dump($lastday);
	}
	
}
