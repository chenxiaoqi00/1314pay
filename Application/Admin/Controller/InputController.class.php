<?php
// +----------------------------------------------------------------------
// | hicms | 商户管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenj 
// +----------------------------------------------------------------------
namespace Admin\Controller;
class InputController extends AdminController {
    /* 接入信息*/
	public function index(){
		$list = $this->islists();
		foreach ($list as $key => $value) {
			$list[$key]['ptype'] = $this->get_ptype($value['Userinfo']['ptype']);
		}
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		
		$this->assign('list', $list);
		$this->assign('title',$title?$title:'接入信息');
		$this->assign('meta_title', $catid ? '商户管理 - '.category($catid, 'title') : '接入信息');
		$this->display();
	}
	
	/*文章列表*/
	public function islists($utype = null){
		$IP= trim(I('get.ip/s'));
		$map = array();
		
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
	public function edit($id){
		if(IS_POST){
			$done = D('Userinfo')->update();
			if(!$done){
				$this->error(D('Userinfo')->getError());
			}else{
				$this->success('编辑成功', Cookie('__forward__'));
			}
		}else{
			
			$ptype = linkage('pay_type');
			$banktype = linkage('bank_type');
			$info = D('Userinfo')->where(array('userid'=>$id))->find();
			$info['username'] = getUsersName($id);
			
			$this->assign('info',$info);
			$this->assign('ptype',$ptype);
			$this->assign('bank',$banktype);
			//获取左边菜单
			$this->display('edit');
		}
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
	
	public function delinfo($model = 'Userinfo') {
		$don = $this->del($model);
	}
	
	
}
