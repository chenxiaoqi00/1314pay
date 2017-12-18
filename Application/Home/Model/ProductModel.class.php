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
class ProductModel extends Model{
 
    public function goodcate($linkid){
        $list = array();
        $list =M("goodcate")->alias('a')
        ->join("__GOODLIST__ b ON a.id=b.cateid",'LEFT')
        ->field('a.id cateid,a.catename,a.theme,a.linkid catelinkid,a.sitename,a.siteurl,a.qq,b.id goodid,b.is_state,b.linkid,b.goodname,b.price')
        ->order('b.sortid asc,b.id desc')
        ->where(array("a.linkid"=>$linkid,"b.is_state"=>1))
        ->select();
        return $list;
    }

    public function goodlist($linkid){
        $list = array();
        $list =M("goodlist")->alias('a')
        ->join("__GOODCATE__ b ON a.cateid=b.id",'LEFT')
        ->join("__GOODS__ c ON a.id=c.goodid",'LEFT')
        ->field('a.id cateid,a.goodname,a.theme,a.linkid,a.price,b.id goodid,b.linkid catelinkid,b.catename,b.sitename,b.siteurl,b.qq,c.id,a.is_coupon,a.is_discount')
        ->order('a.sortid asc,a.id desc')
        ->where(array("a.linkid"=>$linkid,"a.is_state"=>1,"c.is_state"=>0))
        ->select();
        return $list;
    }
    
    public function goodlistById($goodid){
        $list = array();
        $list =M("goodlist")->alias('a')
        ->join("__GOODCATE__ b ON a.cateid=b.id",'LEFT')
        ->join("__GOODS__ c ON a.id=c.goodid",'LEFT')
        ->field('a.goodname,a.linkid,a.theme,a.price,b.linkid catelinkid,b.catename,b.catename,b.sitename,b.siteurl,c.id,a.is_coupon,a.is_discount')
        ->order('a.sortid asc,a.id desc')
        ->where(array("a.id"=>$goodid,"a.is_state"=>1,"c.is_state"=>0))
        ->select();
        return $list;
    }
    
    public function getgood($linkid){
        $list = array();
        $list =M("goodlist")->alias('a')
        ->join("__GOODS__ b ON a.id=b.goodid",'LEFT')
        ->field('a.goodname,a.is_invent,a.userid,a.theme,a.price,b.id,a.is_coupon,a.is_discount')
        ->order('a.sortid asc,a.id desc')
        ->where(array("a.linkid"=>$linkid,"b.is_state"=>0))
        ->select();
        return $list;
    }
    
    public function getgoodlist($linkid){
        $list = array();
        $list =M("goodcate")->alias('a')
        ->join("__GOODLIST__ b ON a.id=b.cateid",'LEFT')
        ->field('a.linkid catelinkid,a.theme,b.goodname,b.linkid,b.is_state')
        ->order('b.sortid asc,b.id desc')
        ->where(array("a.linkid"=>$linkid,"b.is_state"=>1))
        ->select();
        return $list;
    }
    
    public function store($linkid){
        $list = array();
        $list =M("users")->alias('a')
        ->join("__GOODCATE__ b ON a.id=b.userid",'LEFT')
        ->field('a.theme,b.catename,b.linkid')
        ->order('b.sortid asc ,b.id desc')
        ->where(array("a.userkey"=>$linkid))
        ->select();
        return $list;
    }

}