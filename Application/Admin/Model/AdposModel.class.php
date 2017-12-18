<?php
// +----------------------------------------------------------------------
// | hicms | 广告位 MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model;
class AdposModel extends Model{
	/* 自动验证 */
    protected $_validate = array(
        array('title', 'require', '广告位名称不能为空', self::MUST_VALIDATE),
        array('width', 'require', '请输入广告位的宽度', self::MUST_VALIDATE),
        array('height', 'require', '请输入广告位的高度', self::MUST_VALIDATE),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('type', 1, self::MODEL_INSERT),
        array('status', 1, self::MODEL_INSERT),
    );

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