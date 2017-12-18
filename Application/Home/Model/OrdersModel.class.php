<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Home\Model;
use Think\Model;
class OrdersModel extends Model{
 

    public function ordersByContact($contact,$p,$listRows){
        $list = array();
        $map['a.contact'] = $contact;
        $map['a.orderid'] = $contact;
        $map['_logic'] = "OR";
        $list =$this->alias('a')
        ->join("__ORDERLIST__ b ON a.orderid=b.orderid",'LEFT')
        ->join("__CHANNELLIST__ c ON a.channelid=c.id",'LEFT')
        ->field('a.id,a.userid,a.orderid,a.contact,a.addtime,b.money,b.realmoney,c.channelname,a.updatetime')
        ->order('a.id desc')
        ->limit(($p-1)*$listRows.",".$listRows)
        ->where($map)
        ->select();
        return $list;
    }
    
    public function ordersByOrderid($orderid){
         $order =$this->alias('a')
        ->join("__ORDERLIST__ b ON a.orderid=b.orderid",'LEFT')
        ->join("__CHANNELLIST__ c ON a.channelid=c.id",'LEFT')
        ->field('a.orderid,a.userid,a.quantity,a.goodid,a.is_receive,a.is_status,a.contact,a.addtime,b.money,b.realmoney,c.channelname,b.returnmsg,b.is_pay,a.updatetime')
        ->where(array("a.orderid"=>$orderid))
        ->find();
         return $order;
    }


}