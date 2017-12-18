<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;
use Think\Controller;

/**
 * 空模块，主要用于显示404页面，请不要删除
 */
class EmptyController extends Controller{
    
 public function _empty($name){
            //把所有城市的操作解析到city方法
            $shorturl = substr($_SERVER['REQUEST_URI'],1,-5);
            $map['shorturl'] = $shorturl;
            $userkey =  M('users')->where($map)->getField("userkey");
            if($userkey){
                $url = 'http://' . $_SERVER ['HTTP_HOST'] . '/links/' . $userkey;
                $this->redirect($url);
            }else{
                header( " HTTP/1.0  404  Not Found" );
                $this->assign("server", 'http://' . $_SERVER ['HTTP_HOST']);
                $this->display( 'Public/404' );
            }
        }
        
}
