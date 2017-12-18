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
class CronModel extends Model {
   /* 自动验证规则 */
    protected $_validate = array(
        array('id', 'number', '非法提交', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
        array('title', 'require', '任务名称不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('title','','任务名称已经存在', self::MUST_VALIDATE,'unique', self::MODEL_BOTH),
        array('cron', 'require', '任务不能为空', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        array('cron', 'unique', '任务不能重复', self::VALUE_VALIDATE, 'unique', self::MODEL_BOTH),
        array('cron', 'checkCron', '任务文件不存在', self::MUST_VALIDATE, 'callback', self::MODEL_BOTH),
    );

    // 自动完成规则
    protected $_auto = array (
        array('config', 'json_encode', self::MODEL_BOTH, 'function'),
        array('config', null, self::MODEL_BOTH, 'ignore'),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
        array('runtime', 'strtotime', self::MODEL_BOTH, 'function'),
    );

    /**
     * 检测任务文件是否存在。
     * @param  integer  $cron  文件名
     * @return boolean
     */
    public function checkCron($data){
        return file_exists_case(COMMON_PATH.'Cron/'.$data.'.php') ? true: false;
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