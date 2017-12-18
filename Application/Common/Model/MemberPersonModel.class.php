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

/**
 * 用户模型
 */

class MemberPersonModel extends Model {
    protected $_validate = array(
        array('uid','checkID','非法提交!', self::MUST_VALIDATE, 'callback', self::MODEL_UPDATE),
        array('nickname', '1,16', '昵称长度为1-16个字符', self::EXISTS_VALIDATE, 'length'),
        array('nickname', '', '昵称被占用', self::EXISTS_VALIDATE, 'unique', self::MODEL_UPDATE), //用户名被占用
    );

    // 自动完成
    protected $_auto = array(
        array('nickname', 'generate_nickname', self::MODEL_INSERT, 'callback'),
    );

    // +----------------------------------------------------------------------
    // | 验证函数
    // +----------------------------------------------------------------------
    /**
     * 检测当前ID|只为防止在线修改ID
     * @param  integer  $field  手机号码
     * @return integer 错误编号
     */
    public function checkID($uid){
        //是否为数字
        if(!($uid!==0 && is_numeric($uid))){
            return false;
        }
        if($this->where(array('uid'=>$uid))->getField('uid')!=UID){
            return false;
        }
        return true;
    }

    /**
     * [系统加密]
     * @author LaoHe
     * @DateTime 2017-06-20
     * @param    [string]   $password
     * @return   [string]
     */
    public function generate_nickname($nickname){
        $mobile = (string)(I('post.mobile'));
        $username = (string)(I('post.username/s'));
        return !$username && $mobile ? 'm'.$mobile : $username;
    }
}
