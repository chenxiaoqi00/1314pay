<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
class AjaxController extends CenterBaseController {
	/**
	 * 
	 * @param unknown $param
	 */
    public function gatgoods($type=0) {
    	$type = I('get.id');
    	if (empty($type)) {
    		$cate = M('Goodcate')->where(array('userid'=>UID))->select();
    		foreach ( $cate as $value ) {
    			$json[$value ['id']]['name'] = $value ['catename'];
    		}
    		$json = json_encode($json);
    	}else {
    		$cate = M('Goodlist')->where(array('userid'=>UID,'cateid'=>$type))->select();
    		foreach ( $cate as $value ) {
    			$json[$value ['id']]['name'] = $value['goodname'];
    		}
    		$json = json_encode($json);
    	}
    	echo $json;
    }
    
}