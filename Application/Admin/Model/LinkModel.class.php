<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model;
class LinkModel extends Model {
    protected $_validate = array(
        array('title', 'require', '网站名称不能为空', self::MUST_VALIDATE),
        array('url', 'url', '网站链接格式不正确', self::MUST_VALIDATE),
        array('logo', 'checkLogo', '图片展示方式必须上传logo', self::MUST_VALIDATE, 'callback', self::MODEL_BOTH),
    );
    protected $_auto = array(
        array('status', '1', self::MODEL_INSERT),
        array('time', NOW_TIME, self::MODEL_BOTH),
    );

    // +----------------------------------------------------------------------
    // | 自动验证相关函数
    // +----------------------------------------------------------------------
    /**
     * 栏目是否允许发布内容,如果为最低级栏目，允许发布。
     * @param  integer  $catid  栏目
     * @return boolean
     */
    public function checkLogo($data){
        return (I('post.show') && empty($data)) ? false: true;
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