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
	
	function account($userid=null){
	    $userid = I("get.userid");
	    $this->userinfo($userid);
	    
	    
	  $this->display("account");  
	    
	}
	
	
	//获取商家转账信息
	public function userinfo(){
	    $userid = I('get.userid');
	    $userinfo = M("userinfo")->where(array("userid"=>$userid))->field("ptype,realname,bank,card,addr,alipay,tenpay")->find();
	    $user = users($userid);
	    $info = array_merge($userinfo,$user);
	    if($info){
	        $this->ajaxReturn($info);
	    }else{
	        $this->ajaxReturn("");
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
	
	//全部结算
	function accontAll($userid=null,$account=0){
	    $map["userid"] = I("get.userid");
	    $map["isapply"] = 0;
	    $account = I("get.account");
	    
	    $modelMoney = M("usermoney");
	    $modelMoney->startTrans();
	    
        $apply = M("usermoney")->where(array("userid"=>$map["userid"]))->getfield("unpaid");
        //dump($apply);
        //增加结算记录
        $data['userid']= $map["userid"];
        $data['money'] = $apply;
        $data['updatetime'] = date('Y-m-d H:i:s');
        $data['addtime'] = date('Y-m-d H:i:s');
        $data['is_state'] = 1;
        $data['fee'] = 0;
        $isadd =  M("payments")->add($data);//增加结算记录
        
        $unpaid = (M("usermoney")->where(array("userid"=>$map["userid"]))->getField("unpaid"))-$apply;
        $isunpaid = M("usermoney")->where(array("userid"=>$map["userid"]))->setField("unpaid",$unpaid);
        
        $paid = (M("usermoney")->where(array("userid"=>$map["userid"]))->getField("paid"))+$apply;
        $ispaid = M("usermoney")->where(array("userid"=>$map["userid"]))->setField("paid",$paid);
        
        $commit = true;
        if($account == 1){   //申请结算的地方全部变结算完
            $is =  M("account")->where($map)->setField(array("isapply"=>1,"accounttime"=>time()));
            if(!$is){
                $commit =false;
            }
        }
	        
        //把今天之前的账单全部结算掉
        $where['userid'] =  I("get.userid");
        $tomorrow = date("Y-m-d",strtotime("+1 day"));//明天的零点
        $where['addtime'] = array('lt',$tomorrow);
        $where['is_status'] = 1; //已付款
        $isevery =  M("orders")->where($where)->setField("is_ship",1);
        if(!$isevery){
            $commit =false;
        }
        

        //如果有暂不结算的订单则将记录去掉
        $isUnpaymentid = M("unpayments")->where(array("userid"=>$userid,"is_state"=>0))->getField("id",true);
        if($isUnpaymentid){
            $map2['id']=array("in",$isUnpaymentid);
            $isUnpayment= M("unpayments")->where($map2)->setField("is_state",1);
            if(!$isUnpayment){
                $commit =false;
            }
        }
        
        if($isadd && $isunpaid && $ispaid && $commit){
            $modelMoney->commit();
            $this->success("结算成功！");
        }else{
            $modelMoney->rollback();
            $this->error("结算失败！");
        }
	 
	}
	
	function countAccount(){
	    $accountNum = M("account")->where(array("isapply"=>0))->group('userid')->count();
	    $_accountNum =   $accountNum ?  $accountNum:"0";
	    
	    $this->ajaxReturn($_accountNum);
	}
	
	//获取当天和昨天的未结算金额
	public function transferEveryDay(){
	    $userid = I("get.userid");
	    $day = date("Y-m-d",strtotime("-3 day")).",".date("Y-m-d")." 24:00:00";
	    $map['addtime'] = array('between',$day); //统计近三天的
	    $map['userid'] = $userid;
	    $map['is_ship'] = 0; //未结算
	    $map['is_status'] = 1; //已付款
	    $OrderId = array();
	    $OrderId = M("orders")->where($map)->getField("orderid",true);
	    
	    $beforebeforeYestoday = date("Y-m-d",strtotime("-3 day"));
	    $beforeYestoday = date("Y-m-d",strtotime("-2 day"));
	    $yestoday = date("Y-m-d",strtotime("-1 day"));
	    $today = date("Y-m-d");
	    $tomorrow = date("Y-m-d",strtotime("+1 day"));
	    
	    if(!empty($OrderId) || !$OrderId==null){
	        $where = array();
	        $where['orderid'] = array("in",$OrderId);
	        $orderList = M("orderlist")->where($where)->field("realmoney,price,addtime")->select();
	        foreach($orderList as $k=>$v){
	            if($v['addtime']>=$beforebeforeYestoday && $v['addtime']<$beforeYestoday){
	                $beforebeforeYestodayMoney += $v['realmoney']*$v['price']; //大前天的钱
	            }else if($v['addtime']>=$beforeYestoday && $v['addtime']<$yestoday){
	                $beforeYestodayMoney += $v['realmoney']*$v['price']; //前天的钱
	            }else if($v['addtime']>=$yestoday &&  $v['addtime']<$today){
	                $yestodayMoney += $v['realmoney']*$v['price']; //昨天的钱
	            }else if($v['addtime']>=$today &&  $v['addtime']<$tomorrow){
	                $todayMoney += $v['realmoney']*$v['price'];  //今天的钱
	            }
	    
	       }
	    }

        $info = array();
        $unPayments =  M("unpayments")->where(array("userid"=>$userid,"is_state"=>0))->select();
        $i=0;
        foreach($unPayments as $k=>$v){
            $info[$k]['time']=$v['ordertime'];
            $info[$k]['map']=$v['ordertime'];
            $info[$k]['money']=$v['money'];
            $i=$k;
        }
        
//         $info[$i+1]['time']="大前天";
//         $info[$i+1]['map']=$beforebeforeYestoday;
//         $info[$i+1]['money']=$beforebeforeYestodayMoney?$beforebeforeYestodayMoney:0;
        
//         $info[$i+3]['time']="前天";
//         $info[$i+3]['map']=$beforeYestoday;
//         $info[$i+3]['money']=$beforeYestodayMoney?$beforeYestodayMoney:0;
        
        $info[$i+1]['time']="昨天";
        $info[$i+1]['map']=$yestoday;
        $info[$i+1]['money']=$yestodayMoney?$yestodayMoney:0;
        
        $info[$i+2]['time']="今天";
        $info[$i+2]['map']=$today;
        $info[$i+2]['money']=$todayMoney?$todayMoney:0;
       // dump($info);
        //昨天的账单设成了暂不处理，为防止重复那就去掉其中一项
        foreach($info as $k=>$v){
            if($v['time']==$yestoday){
                unset($info[$i+1]);
            }
        }
        $this->ajaxReturn($info);
	}
	
	//结算一天的订单
	public function accontEveryDay($userid=null){
	    $money = I("post.money");
	    if($money == 0 || $money=='0' || $money==''){
	        $this->success("0元没什么好结算的！");
	    }
	    $userid = I("post.userid");
	    $map["userid"] = $userid;
	    $map['addtime'] = array('like',I("post.addtime")."%");
	  //  $map['addtime'] = array('between',I("post.addtime")); //当天的
	    $map['is_status'] = 1; //已付款的账单
	    $modelAccount = M("orders");
	    $modelAccount->startTrans();
	    $is =  M("orders")->where($map)->setField("is_ship",1); //修改是否已结算的信息
	    
	    //增加结算记录
	    $data['userid']=$userid;
	    $data['money'] = $money;
	    $data['updatetime'] = date('Y-m-d H:i:s');
	    $data['addtime'] = date('Y-m-d H:i:s');
	    $data['is_state'] = 1;
	    $data['fee'] = 0;
	    $isadd =  M("payments")->add($data);//增加结算记录
	    
	    
	    //如果有暂不结算的订单则将记录去掉
	     $commit =true;
	    $isUnpaymentid = M("unpayments")->where(array("userid"=>$userid,"ordertime"=>I("post.addtime"),"is_state"=>0))->getField("id");
    	if($isUnpaymentid){
    	   $isUnpayment = M("unpayments")->where(array("id"=>$isUnpaymentid))->setField("is_state",1);
    	   if(!$isUnpayment){
    	       $commit =false;
    	   }
    	}
	    
        //未结算账要减去
        $where['userid']= $userid;
	    $unpaid = (M("usermoney")->where($where)->getField("unpaid"))-$money;
	    $isunpaid = M("usermoney")->where($where)->setField("unpaid",$unpaid);
	    
	    //已经结算的账要加上
	    $paid = (M("usermoney")->where($where)->getField("paid"))+$money;
	    $ispaid = M("usermoney")->where($where)->setField("paid",$paid);
	  //  dump($is.$isadd.$isunpaid.$ispaid.$isUnpayment);
	    if($is && $isadd && $isunpaid && $ispaid && $commit){
	        $modelAccount->commit();
	        $this->success("结算成功！");
	    }else{
	        $modelAccount->rollback();
	        $this->error("结算失败！");
	    }
	    
	}
	
    //暂不结算那天的订单
	public function unaccontEveryDay($userid=null){
	    $money = I("post.money");
	    if($money == 0 || $money=='0' || $money==''){
	        $this->success("0元没什么好暂不结算的！");
	    }
	    $data['money'] = $money;
	    $data['userid'] = I("post.userid");
	    $data['ordertime'] = I("post.ordertime");
	    $data['addtime'] = date("Y-m-d h:i:s"); 
	    $data['is_state'] = 0;
	    $is = M("unpayments")->add($data);
	    if(is){
	        $this->success("暂存成功！");
	    }else{
	        $this->success("暂存失败！");
	    }
	}
	
	//显示每天的订单 
	public function ordersEveryDay($userid=null){
	   $map['addtime'] = array('like',I('post.addtime')."%");
	   $map['userid'] = I('post.userid');
	  // $map['is_status'] = 1;
	    $list = $this->lists('Orders',$map,'addtime desc');
	    $orderslist = array();
	    if($list){
	        $orderslist['status'] = 1;
	        $this->assign('list',$list);
	        $orderslist['data']=$this->fetch("orders");
	    }else{
	        $orderslist['status'] = 0;
	    }
	    $this->ajaxReturn($orderslist);
	}
}
