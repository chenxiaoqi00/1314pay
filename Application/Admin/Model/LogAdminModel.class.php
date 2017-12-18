<?php
// +----------------------------------------------------------------------
// | hicms | 操作日志MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model;
class LogAdminModel extends Model{

    //array(填充字段,填充内容,[填充条件,附加规则])
    protected $_auto = array(
        array('time', 'time', 1, 'function'),
        array('ip', 'get_client_ip', 3, 'function'),
    );

    /**
     * [后台操作日志]
     * @author LaoHe
     * @DateTime 2017-04-11
     * @param    string     $message [描述信息]
     * @param    integer    $status  [状态：0失败 1成功]
     * @return   boolean             [description]
     */
    public function log($message, $status = 1) {
        if (IS_AJAX) {
            $mothed = 'Ajax';
        } else if (IS_POST) {
            $mothed = 'POST';
        }else{
            $mothed = 'GET';
        }
        $data = array(
            'uid' => is_login() ? : 0,
            'status' => $status,
            'info' => "提示：{$message}<br/>模块：" . MODULE_NAME . ",控制器：" . CONTROLLER_NAME . ",方法：" . ACTION_NAME . "<br/>请求方式：{$mothed}",
            'get' => $_SERVER['HTTP_REFERER'] ? $_SERVER['HTTP_REFERER'] : $_SERVER['REQUEST_URI'],
        );
        $this->create($data);
        return $this->add() !== false ? true : false;
    }

    /**
     * 删除一个月前的日志
     * @return boolean
     */
    public function deleteAMonthago() {
        $status = $this->where(array("time" => array("lt", time() - (86400 * 30))))->delete();
        return $status !== false ? true : false;
    }

}
