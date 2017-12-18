<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model\RelationModel;

    class OrdersModel extends RelationModel{
       
       public  function getUserList($model,$map,$order='',$field='',$limit=10){
       
           $total=D($model)
           ->where($map)
           ->count();
           $page=new_page($total,$limit);
            
           $data = D($model)
           ->alias('a')
           ->join('__ORDERLIST__ b ON a.orderid = b.orderid','left')
           ->join('__GOODLIST__ c ON a.goodid = c.id','left')
           ->join('__USERS__ d ON a.userid = d.id','left')
           ->join('__CHANNELLIST__ e ON a.channelid = e.id','left')
           ->join('__BUYLIST__ f ON a.orderid = f.orderid','left')
           ->field('a.orderid,a.fromip,b.money,b.realmoney,b.price,b.platformPrice,c.goodname,d.username,e.channelname,f.contact,f.addtime')
           ->where($map)
           ->order($order)
           ->limit($page->firstRow.','.$page->listRows)
           ->select();
           if($total > $page->listRows){
               $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
           }
           $p =$page->show();
            
           //            $this->assign('page', $p? $p: '');
           $list['data'] = $data;
           $list['page'] = $p;
           return $list;
       
       }
       
       public  function getChannelList($model,$map,$order='',$field='',$limit=10){
           $total=D($model)
           ->where($map)
           ->count();
           $page=new_page($total,$limit);
       
           $data = D($model)
           ->alias('a')
           ->join('__ORDERLIST__ b ON a.orderid = b.orderid','left')
           ->join('__GOODLIST__ c ON a.goodid = c.id','left')
           ->join('__USERS__ d ON a.userid = d.id','left')
           ->join('__CHANNELLIST__ e ON a.channelid = e.id','left')
           ->join('__BUYLIST__ f ON a.orderid = f.orderid','left')
           ->field('a.orderid,a.fromip,b.money,b.realmoney,b.price,b.platformPrice,c.goodname,d.username,e.channelname,f.contact,f.addtime')
           ->where($map)
           ->order($order)
           ->limit($page->firstRow.','.$page->listRows)
           ->select();
           if($total > $page->listRows){
               $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
           }
           $p =$page->show();
       
           //            $this->assign('page', $p? $p: '');
           $list['data'] = $data;
           $list['page'] = $p;
           return $list;
            
       }
       
       public  function getHourlList($model,$map,$order='',$field='',$limit=10){
           $total=D($model)
           ->where($map)
           ->count();
           $page=new_page($total,$limit);
            
           $data = D($model)
           ->alias('a')
           ->join('__ORDERLIST__ b ON a.orderid = b.orderid','left')
           ->join('__GOODLIST__ c ON a.goodid = c.id','left')
           ->join('__USERS__ d ON a.userid = d.id','left')
           ->join('__CHANNELLIST__ e ON a.channelid = e.id','left')
           ->join('__BUYLIST__ f ON a.orderid = f.orderid','left')
           ->field('a.orderid,a.fromip,b.money,b.realmoney,b.price,b.platformPrice,c.goodname,d.username,e.channelname,f.contact,f.addtime')
           ->where($map)
           ->order($order)
           ->limit($page->firstRow.','.$page->listRows)
           ->select();
           if($total > $page->listRows){
               $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
           }
           $p =$page->show();
            
           //            $this->assign('page', $p? $p: '');
           $list['data'] = $data;
           $list['page'] = $p;
           return $list;
       
       }
    }