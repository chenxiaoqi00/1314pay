<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Common\Model;
use Think\Model;

class BaseModel extends Model {
    // +----------------------------------------------------------------------
    // | 自动完成
    // +----------------------------------------------------------------------
    /* 删除前置操作*/
    protected function _before_delete($options){
    	if (MODULE_NAME != 'Admin') {
    		$info = $this->where($options['where'])->getField('uid',true);
    		$uid = array_unique($info);
    		if (UID != $uid[0] || count($uid) != 1) {
    			return false;
    		}
    	}
    }
    /* 更新前置操作*/
    protected function _before_update($data, $options){
    	if (MODULE_NAME != 'Admin') {
    		$info = $this->where($options['where'])->getField('uid',true);
    		$uid = array_unique($info);
    		if (UID != $uid[0] || count($uid) != 1) {
    			return false;
    		}
    	}
    }
    // +----------------------------------------------------------------------
    // | 模型通用操作
    // +----------------------------------------------------------------------
    /**
     * [快捷编辑对应模型操作]
     * 进行缓存及各种模型相关动作的处理
     * @author LaoHe
     * @DateTime 2017-05-27
     * @param    integer   $id
     * @return   boolean
     */
    public function quick($id){
    	return true;
    }
    
    /**
     * [删除对应模型操作]
     * 进行缓存及各种模型相关动作的处理
     * @author LaoHe
     * @DateTime 2017-07-11
     * @param    array()   $ids
     * @return   boolean
     */
    public function del($ids){
    	return true;
    }
    
    /**
     * SWICH 开关值
     * @return 1:0
     */
    public function getSwitch($data,$field){
    	$data == 'true' ? 1 : 0;
    	return $data;
    }
    
    /**
     * 创建时间不写则取当前时间
     * @return int 时间戳
     */
    protected function getInputTime($field){
    	return $field ? strtotime($field):NOW_TIME;
    }
}
