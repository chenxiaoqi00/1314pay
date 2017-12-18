<?php
// +----------------------------------------------------------------------
// | hicms | 商品首页
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
use Think\Controller;
class AccountController extends CenterBaseController {
    // 首页
	public function index(){
	    
	    $map['userid'] = UID;
	    $list = $this->lists('Payments',$map,'updatetime desc');
	    foreach ($list as $key => $value) {
	        $ptype = userinfo($value['userid'],'ptype');
	        if ($ptype == 1) {
	            $list[$key]['ptypetext'] = userinfo($value['userid'],'bank');
	        }else {
	            $list[$key]['ptypetext'] = get_ptype(userinfo($value['userid'],'ptype'));
	        }
	        $list[$key]['realmoney'] = $value['money']-$value['fee'];
	    }
	    $this->assign("accountList",$list);
	    $this->display();
    }
    
    //申请结算  applyMoney
    public function apply(){
        $map['userid'] = UID;
        $_unpaid = M("Usermoney")->where($map)->getField("unpaid");
        $unpaid = $_unpaid?$_unpaid:"0.00";
        
        if(IS_POST){
            $applyMoney = floatval(I("post.applyMoney"));
            if($applyMoney<10){
                $this->error("最低结算金额是：10 元,请重新修改结算金额");
            }else if($applyMoney>$unpaid){
                $this->error("申请结算的金额已经超出了您的余额,请修改");
            }else{
                $data['userid'] = UID;
                $data['isapply'] = 0;
                $data['poundage'] = 0;
                $data['applymoney'] = $applyMoney;
                $data['addtime'] = time();
                $is = M("account")->add($data);
                if($is){
                    $this->success("申请结算成功！");
                }else{
                    $this->error("申请结算失败！");
                }
            }
        }else{
        $_unpaid = M("Usermoney")->where($map)->getField("unpaid");
        $unpaid = $_unpaid?$_unpaid:"0.00";
        $this->assign("unpaid",$unpaid);
        $this->display();
    }
    
    }
}