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
class PageModel extends Model{
    /* 自动验证规则 */
    protected $_validate = array(
        array('catid', 'number', '非法提交', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
        // 标题
        array('title', 'require', '文章标题不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('title', '1,80', '标题长度不能超过80个字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
        array('title','','标题已经存在', self::MUST_VALIDATE,'unique', self::MODEL_BOTH),
        // 正文内容
        array('content','require','文章内容不能为空', self::MUST_VALIDATE,'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('updatetime', NOW_TIME, self::MODEL_BOTH),
    );

}