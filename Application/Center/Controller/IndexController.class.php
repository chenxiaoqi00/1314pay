<?php
// +----------------------------------------------------------------------
// | hicms | 个人中心首页
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
use Think\Controller;
class IndexController extends CenterBaseController {
    public function index(){
    	// 已结算订单
        $info['over'] = M('Orders')->where(array('userid'=>UID,'is_status'=>1,'is_ship'=>1))->count();
        // 未结算订单
        $info['unover'] = M('Orders')->where(array('userid'=>UID,'is_status'=>1,'is_ship'=>0))->count();
        // 今日成交单数
        $info['today'] = M('Orders')->where(array('userid'=>UID,'is_status'=>1,'addtime'=>array('like','%'.date('Y-m-d').'%')))->count();
        // 总共成交订单
        $info['totel'] = $info['unover']+$info['over'];
        
        // 今日收入
        $info['money'] = count_money(get_pay_orders(UID,array('is_status'=>array('in','1,2'),'addtime'=>array('like','%'.date('Y-m-d').'%'))));
        
        $last = M('Payments')->where(array('userid'=>UID))->find();
        // 结算金额
        $money = M('Usermoney')->where(array('userid'=>UID))->field('paid,unpaid')->find();
        
        // 上次结算时间
        $info['paytime'] = M('Payments')->where(array('userid'=>UID,'is_state'=>1))->order('updatetime')->limit(1)->getField('updatetime');

        //未处理投诉订单数
        $_complain = M('complain')->where(array('userid'=>UID,'is_state'=>0))->select();
        foreach ($_complain as $k=>$v){
            $complain['freezemoney'] +=$v['fee']+$v['money']*$v['price'];
        }
        $complain['freezemoney'] =  $complain['freezemoney']? $complain['freezemoney']:0;
        $complain['num'] = sizeof($_complain);
        $this->assign('last',$last);
        $this->assign('money',$money);
        $this->assign('info',$info);
        $this->assign('complain',$complain);
    	$this->display();
    }

    /* 修改信息 */
    public function userinfo(){
        if(IS_POST){
            
            $model = D('Users');
            $data = $model->create();
            //更新
            if($data){
                if($model->update()!== false){
                    S('USERS_'.UID, NULL);  //清除缓存
                    S('USERINFO_'.UID, NULL);  //清除缓存
                    $this->success('商户信息修改成功！');
                } else {
                    $this->error($model->getError());
                }
            } else {
                $this->error($model->getError());
            }
        }else{
   			$info = D('Users')->relation(true)->find(UID);
   			$is_getgood = array(1=>'是',0=>'否');
   			$this->assign("theme",C('VIEWS'));
   			$this->assign('is_getgood',$is_getgood);
   			$this->assign('send_mail',array(1=>'是',2=>'否'));
   			$this->assign('is_invent',array(1=>'实际库存数量',2=>'显示库存范围'));
   			$this->assign('is_paytype',array(1=>'网银支付',2=>'充值卡支付'));
   		//	$this->assign('ptype',array(1=>'银行转账',2=>'支付宝转账',3=>'财付通转账'));
   			$this->assign('ptype',array(1=>'银行转账',2=>'支付宝转账'));
   			$this->assign('bank',linkage('bank_type'));
   			$this->assign('info',$info);
   			$this->assign('server', 'http://'.$_SERVER['HTTP_HOST']);
   			$this->display();
        }
    }

    /* 修改密码 */
    public function password(){
        if(IS_POST){
            $model = D('Common/Users');
            //获取参数
            $oldpassword = I('post.oldpassword');
            empty($oldpassword) && $this->error('请输入原密码');
            $password = I('post.newpassword');
            empty($password) && $this->error('请输入新密码');
            $repassword = I('post.confirmpassword');
            empty($repassword) && $this->error('请输入确认密码');
            //判断新旧密码
            /*if(!preg_match('/^[a-z]\w{5,15}$/i',$password)){
                $this->error("请输入6-16位字母和数字混合密码");
            }*/
            if($password !== $repassword){
                $this->error('您输入的新密码与确认密码不一致');
            }
            if(!$model->verifyPassword(UID, $oldpassword)) {
                $this->error('输入的旧密码不正确！');
            }
            if (!$model->autoCheckToken($_POST)){
                $this->error('表单令牌错误！');
            }
            //更新
//             $data['password'] = hi_md5($password, C('AUTH_KEY'));
            $data['password'] = h318_md5($password);
            $done = $model->updateMember(UID, $data);
            if( $done !== false){
                D('Common/Users')->logout();
                session('[destroy]');
                $this->success('密码修改成功,请重新登陆！',U('center/public/login'));
            }else{
                $this->error('密码修改失败');
            }
        }else{
            $this->display();
        }
    }

    /*修改头像*/
    public function avatar(){
        $this->assign('avatar', avatar(UID));
        $this->display();
    }
    
    /* 判断是否填写收款信息 */
    public function collectionInformation(){
//         $info = M("userinfo")->where(array("userid"=>UID))->field("ptype,realname,bank,card,addr,alipay,tenpay")->find();
        $info = userinfo(UID);
//         dump($info);
        switch ($info['ptype'])
        {
            case 1:
                if($info['realname']=='' || $info['card']==''){
                    $this->error("您还未完善收款信息，资金将无法到账，是否前去补齐？");
                }
            break;
            case 2:
                if($info['realname']=='' || $info['alipay']==''){
                    $this->error("您还未完善收款信息，资金将无法到账，是否前去补齐？");
                }
           break;
           case 3:
               if($info['realname']=='' || $info['tenpay']==''){
                   $this->error("您还未完善收款信息，资金将无法到账，是否前去补齐？");
               }
           break;
           default:
               $this->error("您还未完善收款信息，资金将无法到账，是否前去补齐？");
            
        }
    }
    
}
