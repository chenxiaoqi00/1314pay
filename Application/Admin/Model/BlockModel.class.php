<?php
// +----------------------------------------------------------------------
// | hicms | 碎片 MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model;
class BlockModel extends Model{
	/* 自动验证 */
    protected $_validate = array(
        array('title', 'require', '碎片名称不能为空', self::MUST_VALIDATE),
        array('content', 'checkContent', '任务文件不存在', self::MUST_VALIDATE, 'callback', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('content', 'contentValue', self::MODEL_BOTH,'callback'),
    );

    /**
     * 检测内容。
     * @param  integer  $cron  文件名
     * @return boolean
     */
    protected function checkContent($data){
    	$type = I('post.type/d');
    	$content = I('post.content/a');
        return isset($content[$type]) ? true: false;
    }

    protected function contentValue($field){
        $type = I('post.type/d');
        return $field ? $field[$type] : '';
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

}