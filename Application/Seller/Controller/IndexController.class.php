<?php
// +----------------------------------------------------------------------
// | hicms | 个人中心首页
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Seller\Controller;
use Think\Controller;
class IndexController extends SellerBaseController {
    public function index(){
        $this->display();
    }
}