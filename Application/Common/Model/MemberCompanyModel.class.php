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
use Libs\Verify; //验证类库
/**
 * 企业会员模型
 */
class MemberCompanyModel extends Model {
	/*//新增数据时允许写入的字段
    protected $insertFields = array('mobile,company');
    //编辑数据时允许写入的字段
    protected $updateFields = array('province,city,district,introduce,linkman,address,pattern');*/
    //自动验证
    protected $_validate = array(
        array('uid','checkID','非法提交!', self::MUST_VALIDATE, 'callback', self::MODEL_UPDATE),
    	/*// 验证手机号码
        array('mobile', 'checkMobile', '手机格式不正确！', self::MUST_VALIDATE, 'callback'), //手机格式不正确 TODO:
        array('mobile', '', '手机号被占用！', self::MUST_VALIDATE, 'unique'), //手机号被占用*/
        // 验证企业名称
        array('company', '6,32', '企业名称为6-32个字符', self::MUST_VALIDATE, 'length'),
        array('company', '', '企业名称已存在', self::MUST_VALIDATE, 'unique'), //企业名称被占用
        // 验证省市地区
        array('province','require','请选择所在省份',self::VALUE_VALIDATE),
        array('city','require','请选择城市！',self::VALUE_VALIDATE),
        array('district','checkArea','请选择县区！', self::VALUE_VALIDATE, 'callback'),
        //企业类型
        array('pattern','require','请选择企业类型',self::VALUE_VALIDATE),
        // 验证联系人
        array('linkman', '2,20', '联系人填写有误', self::VALUE_VALIDATE, 'length'),
        // 验证密码
        array('password', '6,20', '密码长度必须在6-20个字符之间！', self::MUST_VALIDATE, 'length', self::MODEL_INSERT), //密码长度不合法
        array('repassword','password','确认密码不正确', self::MUST_VALIDATE, 'confirm', self::MODEL_INSERT), // 验证确认密码是否和密码一致
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
     * 检测手机号码
     * @param  integer  $field  手机号码
     * @return integer 错误编号
     */
    public function checkMobile($mobile){
        $verify = new Verify();
        return $verify::isMobile($mobile) ? true: false;
    }

    /*检测省市地区*/
    public function checkArea($area){
        $province = I('post.province/d');
        if(empty($area)){
            if($province!=110000 xor $province!=120000 xor $province!=310000 xor $province!=500000){
                return true;
            }else{
                return false;
            }
        }else{
            return true;
        }
    }


}
