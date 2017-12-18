<?php
// +----------------------------------------------------------------------
// | hicms | 商户管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenj 
// +----------------------------------------------------------------------
namespace Admin\Controller;
class UserMoneyController extends AdminController {
    /* 商户结算*/
	public function index() {
		$map['unpaid'] = array('neq',0);
		// 用户名|手机|邮箱
		if ( isset($_GET['username']) ) {
			$verify = new \Libs\Verify();
			if($verify::isMobile(I('username'))){
				$map1['tel'] = array('like','%'.I('username').'%');
			}else if($verify::isEmail(I('username'))){
				$map1['email'] = array('like','%'.I('username').'%');
			}else{
				$map1['username'] = array('like','%'.I('username').'%');
			}
			$uid = M('Users')->where($map1)->getField('id',true);
			if (!empty($uid)) {
				$map['userid'] = array('in',$uid);
			}
		}
		
		$list = $this->lists('Usermoney',$map,'unpaid desc');
		foreach ($list as $key => $value) {
			$ptype = userinfo($value['userid'],'ptype');
			if ($ptype == 1) {
				$list[$key]['ptypetext'] = userinfo($value['userid'],'bank');
			}else {
				$list[$key]['ptypetext'] = get_ptype(userinfo($value['userid'],'ptype'));
			}
			$list[$key]['ctypetext'] = get_ctype_status(userinfo($value['userid'],'ctype'));
			$list[$key]['allmoney'] = $value['paid']+$value['unpaid'];
			$isaccount = M("account")->where(array("userid"=>$value['userid'],"isapply"=>0))->select();
			if($isaccount){
			    $list[$key]['account'] =1;
			}else{
			    $list[$key]['account'] =0;
			}
		}
// 		dump($list);
		if ( isset($_GET['account']) ) {
		    foreach ($list as $k => $v){
		        if($v['account'] != $_GET['account']){
		            unset($list[$k]);
		        }
		    }
		}
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		
		$this->assign('list', $list);
		$this->assign('title',$title?$title:'商户结算');
		$this->assign('meta_title', '商户结算');
		$this->display();
	}
	
	//获取要结算的信息
	function account($userid=null){
	   $userid = I("get.userid");
	   $userinfo = $this->userinfo($userid);//商户信息
	   $transferinfo = $this->transferEveryDay($userid);//按天分的未结算的金额
	   $info['userinfo'] = $userinfo;
	   $info['transferinfo'] = $transferinfo;
	   $info['unpaid'] = M('usermoney')->where(array("userid"=>$userid))->getField("unpaid");//未未结算总额
	   $this->assign("info",$info);
	   $this->display("account");  
	    
	}
	
	
	//获取商家转账信息
	public function userinfo(){
	    $userid = I('get.userid');
	    $userinfo = M("userinfo")->where(array("userid"=>$userid))->field("ptype,realname,bank,card,addr,alipay,tenpay")->find();
	    $user = users($userid);
	    $info = array_merge($userinfo,$user);
	    return $info;
	}
	
	//获取每天的未结算订单
	public function transferEveryDay($userid=null){
	    $map['userid'] = $userid;
	    $map['is_ship'] = 0; //未结算
	    $map['is_status'] = 1; //已付款
	    $orders = array();
	    $orders = M("orders")->where($map)->field("orderid,addtime")->select();
	    $orderid = array_column($orders, 'orderid'); //未结算的订单号
	    //统计出未结算订单的时间
	    $_ordersAddtime = array_column($orders, 'addtime');
	    foreach($_ordersAddtime as $k=>$v){
	        $_ordersAddtime[$k]= explode(' ',$v)[0]; 
	    }
	    $ordersAddtime = array_unique($_ordersAddtime);
	    
	    foreach($ordersAddtime as $k=>$v){
	        $info[$k]['time'] = $v;
	        $info[$k]['map']=$v;
	        $where['orderid'] = array("in",$orderid);
	        $where['addtime'] = array('like', $v.'%');
	        //查询当天的订单
	        $orderList = M("orderlist")->where($where)->field("orderid,realmoney,price,addtime")->select();
	        $everydayOrderid = array_column($orderList, 'orderid');
	        foreach($orderList as $key=>$val){
	            $info[$k]['money'] +=  $val['realmoney']*$val['price'];
	        }
	        //更具每天的未结算订单号查询相应的投诉订单
	        $_map['is_state'] = 0; //未处理的投诉订单
	        $_map['orderid'] = array('in',$everydayOrderid);
	        $complain = M('complain')->where($_map)->select();
	        if($complain){
	            foreach($complain as $kk=>$vv){
	                $info[$k]['fee'] += $vv['fee'];  //总共的手续费
	                $info[$k]['complainmoney'] += $vv['money']; //投诉订单总额（商品价格相加）
	                $info[$k]['complainId'] .= $vv['id'].","; //投诉订单ID结算时候排除用,因为这边是在已支付的订单范围内统计投诉订单的所有会把未支付或者支付一半的投诉订单排除掉
	                $info[$k]['freezemoney'] += $vv['fee']+$vv['money']*$vv['price'];//冻结金额,因为手续费以后可能会手动改
	            }
	        }
	        $info[$k]['freezemoney'] = $info[$k]['freezemoney']?$info[$k]['freezemoney']:0;
	        $info[$k]['fee'] =  $info[$k]['fee']? $info[$k]['fee']:0; //手续费
	        $info[$k]['complainmoney'] = $info[$k]['complainmoney']?$info[$k]['complainmoney']:0;//投诉金额
	        $info[$k]['count'] = sizeof($complain);//投诉订单数
	        $info[$k]['accountmoney'] = $info[$k]['money'] - $info[$k]['complainmoney']; //实际可结算金额
	        $info[$k]['accountmoney'] = $info[$k]['accountmoney']<0?0:$info[$k]['accountmoney'];
	    }
	    return $info;

	}
	
	//获取当天的投诉订单 这边不包括未支付的和支付一半的投诉订单
	function ordersComplain(){
	    $complainId = I("get.complainId");
	    $complainIdArray = explode(',',substr($complainId,0,strlen($complainId)-1));
	    $map['id'] = array('in',$complainIdArray);
        $list = $this->lists('complain',$map,'addtime desc');
        foreach($list as $k=>$v){
            $list[$k]['unpaid'] = $v['money']*$v['price'];
            $list[$k]['freezemoney'] = $v['fee']+$list[$k]['unpaid'];
            
        }
        $this->assign('list',$list);
        $this->display('orderscomplain');
	}
	
	//结算当天未投诉订单
	public function accontEveryDay($userid=null){
	    $money = I("post.accountmoney");
	    $userid = I("post.userid");
	    $map["userid"] = $userid;
	    $map['addtime'] = array('like',I("post.addtime")."%");
	    //除去投诉订单
	    $complainId = I("post.complainId");
	    if($complainId){
	        $complainIdArray = explode(',',substr($complainId,0,strlen($complainId)-1));
	        $_where['id'] = array('in',$complainIdArray);
	        $complainOrderid = M('complain')->where($_where)->getField('orderid',true);
	        $map["orderid"] = array('not in',$complainOrderid);
	    }
	    $map['is_status'] = 1; //已付款的账单
	    $modelAccount = M("orders");
	    $modelAccount->startTrans();
	    $is =  M("orders")->where($map)->setField("is_ship",1); //修改是否已结算的信息
	    //增加结算记录
	     $addAccountRecord = $this->addAccountRecord($userid, $money);
	     
	    $changePaid = $this->changePaid($userid, $money);
	    
	    if($is && $addAccountRecord && $changePaid){
	        $modelAccount->commit();
	        $this->success("结算成功！");
	    }else{
	        $modelAccount->rollback();
	        $this->error("结算失败！");
	    }
	     
	}
	
	// 检查当天的正常订单是否已经全部结算完
	public function isaccont(){
	    $orderid = I("post.orderid");
	    $complain = M('complain')->where(array("orderid"=>$orderid))->find();
	    $time = explode(' ',$complain['ordertime'])[0];
	  //  dump("time:".$time);
	    //那天的未处理已支付投诉订单
	    $map['ordertime']=array('like',$time."%");
	    $map['userid'] = $complain['userid'];
	    
	    $map['is_state'] = 0; //还未处理的
	    $complains = M('complain')->where($map)->select();
	    //排除那些未支付完的或者没有支付订单（投诉商家）的投诉信息
	    foreach ($complains as $k=>$v){
	        if($v['orderid']){
	          $is_status = M('orders')->where(array("orderid"=>$v['orderid']))->getField("is_status");
	          if($is_status !=1 ){
	          unset($complains[$k]);
	           }
	        }else{
	            unset($complains[$k]);
	        }
	    }
	    $complainnum = sizeof($complains);
// 	   dump("complainnum:".$complainnum);
	    
	    //那天未处理的已支付订单
	    $where['addtime']=array('like',$time."%");
	    $where['userid'] = $complain['userid'];
	    $where['is_ship'] = 0; //未结算
	    $where['is_status'] = 1; //已付款的账单
	    $unpaidordernum = M('orders')->where($where)->count();
// 	   dump("unpaidordernum:".$unpaidordernum);
// 	   dump("userid:".$complain['userid']);
	    if($complainnum == $unpaidordernum ){
	        $this->success("正常订单已经结算掉");
	    }else{
	        $this->error("正常订单未结算掉");
	    }
	}
	// 结算投诉订单
	public function accontComplain(){
	    $money = I("post.money");
	    $orderid = I("post.orderid");
	    $userid = I("post.userid");
	    $modelAccount = M("orders");
	    $modelAccount->startTrans();
	    $is =  M("orders")->where(array("orderid"=>$orderid))->setField("is_ship",1); //修改是否已结算的信息
	    $isCompalin = M("complain")->where(array("orderid"=>$orderid))->setField(array("is_state"=>2,"refundtime"=>date('Y-m-d H:i:s')));//将投诉订单状态改为结算
	    //增加结算记录
	    $addAccountRecord = $this->addAccountRecord($userid, $money);
	    
	    //修改已结算和未结算的账单
	    $changePaid = $this->changePaid($userid, $money);
	  
	    
	    if($is && $isCompalin && $addAccountRecord && $changePaid){
	        $modelAccount->commit();
	        $this->success("结算成功！");
	    }else{
	        $modelAccount->rollback();
	        $this->error("结算失败！");
	    }
	}
	
	// 投诉订单退款
	public function refundComplain(){
	    $money = I("post.money");
	    $orderid = I("post.orderid");
	    $userid = I("post.userid");
	    $modelAccount = M("orders");
	    $modelAccount->startTrans();
	    $is =  M("orders")->where(array("orderid"=>$orderid))->setField(array("is_ship"=>2,"is_status"=>4)); //修改是否已结算的信息,将支付状态和结算状态都改为退款
	    $isCompalin = M("complain")->where(array("orderid"=>$orderid))->setField(array("is_state"=>1,"refundtime"=>date('Y-m-d H:i:s')));//将投诉订单状态改为退款

	    //修改已结算和未结算的账单
	//    $changePaid = $this->changePaid($userid, $money);
	    //未结算账要减去  
	    $where['userid']= $userid;
	    $unpaid = (M("usermoney")->where($where)->getField("unpaid"))-$money;
	    $isunpaid = M("usermoney")->where($where)->setField("unpaid",$unpaid);
	     
	     
	    if($is && $isCompalin && $isunpaid){
	        $modelAccount->commit();
	        $this->success("退款成功！");
	    }else{
	        $modelAccount->rollback();
	        $this->error("退款失败！");
	    }
	}
	
	//修改已结算和未结算的账单
	function changePaid($userid, $money){
	    
	    //未结算账要减去
	    $where['userid']= $userid;
	    $unpaid = (M("usermoney")->where($where)->getField("unpaid"))-$money;
	    $isunpaid = M("usermoney")->where($where)->setField("unpaid",$unpaid);
	     
	    //已经结算的账要加上
	    $paid = (M("usermoney")->where($where)->getField("paid"))+$money;
	    $ispaid = M("usermoney")->where($where)->setField("paid",$paid);
	    if($isunpaid && $ispaid){
	        return true;
	    }else{
	        return false;
	    }
	}
	
	//增加结算记录
	function addAccountRecord($userid, $money){
	    $data['userid']=$userid;
	    $data['money'] = $money;
	    $data['updatetime'] = date('Y-m-d H:i:s');
	    $data['addtime'] = date('Y-m-d H:i:s');
	    $data['is_state'] = 1;
	    $data['fee'] = 0;
	    return  M("payments")->add($data);//增加结算记录
	}
	


	
	//结算全部该商户的正常订单
	function accontAll($userid=null,$account=0){
	    $userid = I("get.userid");
	    $map["userid"] = $userid;
	    
	    $map['is_state'] = 0; //还未处理的投诉订单
	    $complain = M('complain')->where($map)->select();
	    $complainOrderid = array_column($complain, 'orderid'); //未结算的订单号数组
	    foreach ($complain as $k=>$v){
	        $freezemoney += $v['money']*$v['price']+$v['free'];
	    }
	   
	    
	    $unpaid = M("usermoney")->where(array("userid"=>$userid))->getfield("unpaid");
	    
	    $realAccount = $unpaid - $freezemoney;//真实可结算的全部金额
	    
	    $modelMoney = M("usermoney");
	    $modelMoney->startTrans();
	    
	    //增加结算记录
	    $addAccountRecord = $this->addAccountRecord($userid, $realAccount);
       
        //修改已结算和未结算的账单
	    $changePaid = $this->changePaid($userid, $realAccount);
        
	   
        //把今天之前的账单全部结算掉
        $where['userid'] =  $userid;
        $tomorrow = date("Y-m-d",strtotime("+1 day"));//明天的零点
        $where['addtime'] = array('lt',$tomorrow);
        $where['is_status'] = 1; //已付款
        $where["orderid"] = array('not in',$complainOrderid); //除去投诉的正常订单
        $isevery =  M("orders")->where($where)->setField("is_ship",1);
        if(!$isevery){
            $commit =false;
        }
        
        if($addAccountRecord && $changePaid &&  $commit){
            $modelMoney->commit();
            $this->success("结算成功！");
        }else{
            $modelMoney->rollback();
            $this->error("结算失败！");
        }
	 
	}
	


	//获取申请结算记录
	function getAccount($userid=null){
	    $map['userid'] = I("get.userid");
	    $map['isapply'] = 0;
	    $accountList = M("account")->where($map)->select();
	    foreach ($accountList as $k=> $v){
	        $accountList[$k]['addtime']=times($v['addtime']);
	    }
	    $this->ajaxReturn($accountList);
	}

	//结算申请
	function accontApply($aid=null){
	    $map["id"] = I("get.aid");
	    $modelAccount = M("account");
	    $modelAccount->startTrans();
	
	    $is = M("account")->where($map)->setField(array("isapply"=>1,"accounttime"=>time()));
	
	    $apply = M("account")->where($map)->field("applymoney,userid")->find();
	    $data['userid']= $apply['userid'];
	    $data['money'] = $apply['applymoney'];
	    $data['updatetime'] = date('Y-m-d H:i:s');
	    $data['addtime'] = date('Y-m-d H:i:s');
	    $data['is_state'] = 1;
	    $data['fee'] = 0;
	    $isadd =  M("payments")->add($data);
	    $unpaid = (M("usermoney")->where(array("userid"=>$apply['userid']))->getField("unpaid"))-$apply['applymoney'];
	    $isunpaid = M("usermoney")->where(array("userid"=>$apply['userid']))->setField("unpaid",$unpaid);
	
	    $paid = (M("usermoney")->where(array("userid"=>$apply['userid']))->getField("paid"))+$apply['applymoney'];
	    $ispaid = M("usermoney")->where(array("userid"=>$apply['userid']))->setField("paid",$paid);
	
	    if($is && $isadd && $isunpaid && $ispaid){
	        $modelAccount->commit();
	        $this->success("结算成功！");
	    }else{
	        $modelAccount->rollback();
	        $this->error("结算失败！");
	    }
	}
	
	
	
	
	function countAccount(){
	    $accountNum = M("account")->where(array("isapply"=>0))->group('userid')->count();
	    $_accountNum =   $accountNum ?  $accountNum:"0";
	    
	    $this->ajaxReturn($_accountNum);
	}
	


	
	
	//退款信息
	public function refundInfo($id=null){
	    
	    $map['id'] = I("get.id");
	    $map['is_status'] = 0;
	    $info = M("refund")
	    ->alias('a')
	    ->join('__ORDERLIST__ b ON a.orderid = b.orderid','left')
	    ->field('a.*,b.money,b.realmoney,b.price,b.platformPrice,b.addtime ordertime')
	    ->find();
	    $info['platmoney'] = ((float)$info['platformprice']-(float)$info['price'])*(float)$info['realmoney'];
	    $info['usermoney'] = (float)$info['price']*(float)$info['realmoney'];
	    $this->assign('info',$info);
	    $this->display('refund');
	    //  $this->ajaxReturn($orderslist);
	}

}
