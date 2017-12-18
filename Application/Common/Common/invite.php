<?php

    function invite($userid=''){
        $_userid = $userid ? $userid : UID;
        $list_id_array = M("invite")->where(array("userid"=>$_userid))->getField("inviteid",true);
        $list_id = array_unique($list_id_array);
//         foreach($list_id as $k=>$v){
//             $string_list_id +=  $v
//         }
        $month = I("get.date")?I("get.date"):'';
        $mFristAndLast = mFristAndLast('',$month);
        $fristAndLaetArray =  explode(',',$mFristAndLast); 
        if(!empty($list_id)){
            $sql ="SELECT username,pay,userid,price,platformPrice,money,realmoney FROM hi_users c LEFT JOIN( 
            SELECT count(*) as pay,userid,sum(realmoney*b.price) as price,sum(realmoney*(b.platformPrice-b.price)) as platformPrice ,is_pay,sum(money) as money, sum(realmoney) as realmoney 
            from (hi_orders a LEFT JOIN hi_orderlist b on a.orderid=b.orderid) where b.is_pay=1 AND a.addtime BETWEEN '".$fristAndLaetArray[0]."' AND '".$fristAndLaetArray[1]."' GROUP BY userid )d ON c.id=d.userid WHERE c.id in (".implode(",", $list_id).") 
            ORDER BY d.realmoney desc";
            $Model = M();
            $userLists = $Model->query($sql);
            foreach($userLists as $k=>$v){
                $userLists[$k]['month'] = $month? $month:date('n');
                $userLists[$k]['paid'] = D('usermoney')->where(array("userid"=>$v['userid']))->getField("paid");
                $userLists[$k]['price'] =  round($v['price'],2);
                $userLists[$k]['platformprice'] =  round($v['platformprice'],2);
            }
        }
        return $userLists;
        
        
//         foreach($list_id as $k=>$v){
//             $list[$k]['username']=M('users')->where(array("id"=>$v))->getField("username");
//             $map['userid']=$v;
//             $orderid = D('Orders')->where($map)->getField('orderid',true);
//             if($orderid){
//                 $where['orderid'] = array('in',$orderid);
//                 $where['is_pay'] = 1;
//                 $order = D('Orderlist')->where($where)->field('price,money,realmoney,platformprice,orderid')->select();
//                 $list[$k]['money'] = count_money($order);
//             }else{
//                 $list[$k]['money']['money'] = 0;
//             }
    
//             $list[$k]['month'] = $month? $month:date('n');
//             //  dump($list[$k]['month']);
//             $emonth = getEmonth($list[$k]['month']);
//             $list[$k]['settle'] = M("invite")->where(array("userid"=>$_userid,"inviteid"=>$v))->getField($emonth);
//             $list[$k]['inviteid'] = $v;
//             $list[$k]['userid'] = $_userid;
//         }
//         return $list;
    }
    
    //获取指定月份的时间戳
    function mFristAndLast($y = "", $m = ""){
         if ($y == "") $y = date("Y");
	    if ($m == "") $m = date("m");
	    $m = sprintf("%02d", intval($m));
	    $y = str_pad(intval($y), 4, "0", STR_PAD_RIGHT);
	    $m>12 || $m<1 ? $m=1 : $m=$m;
	    $firstday = strtotime($y . $m . "01000000");
	    $firstdaystr = date("Y-m-01", $firstday);
	    $lastday = date('Y-m-d 23:59:59', strtotime("$firstdaystr +1 month -1 day"));
        return $firstdaystr.','.$lastday;
    }
     
    function getEmonth($num){
        $E_Month = array(1 => "Jan",2 => "Feb",3 => "Mar",4 => "Apr",
            5 => "May",6 => "Jun",7 => "Jul",8 => "Aug",9 => "Sep",10 => "Oct",11 => "Nov",12 => "Dec");
        return $E_Month[$num];
    }
    


