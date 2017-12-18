<?php
// +----------------------------------------------------------------------
// | hicms | 商户MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenjie
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model\RelationModel;
use Libs\Verify; //验证类库
class UsersModel extends RelationModel{
    // 关联内容表
    protected $_link=array(
        'Userinfo'=> array(
            'mapping_type' => self::HAS_ONE,
            'class_name'   => 'Userinfo',
            'foreign_key'  => 'userid',
        ),
    );

    /* 自动验证规则 */
    protected $_validate = array(
//用户名、手机或邮箱不能全为空
        array('username,tel,email','checkUser','用户名、手机或邮箱必须填写一个',self::MUST_VALIDATE,'callback',self::MODEL_BOTH),
        //用户名长度不合法
        array('username', 'checkUsername', '用户名格式只能为6-16位英文和数字！', self::VALUE_VALIDATE, 'callback'), //用户名禁止注册
        array('username', '', '用户名被占用！', self::VALUE_VALIDATE, 'unique'), //用户名被占用
        array('username', 'checkDenyMember', '用户名禁止注册', self::VALUE_VALIDATE, 'callback'), //用户名被占用
        // 验证手机号码
        array('tel', 'checkMobile', '手机格式不正确！', self::VALUE_VALIDATE, 'callback'), //手机格式不正确 TODO:
        array('tel', '', '手机号被占用！', self::VALUE_VALIDATE, 'unique'), //手机号被占用
        // 验证邮箱
        array('email', 'email', '邮箱格式不正确！', self::VALUE_VALIDATE), //邮箱格式不正确
        array('email', '6,32', '邮箱长度不正确！', self::VALUE_VALIDATE, 'length'), //邮箱长度不合法
        array('email', '', '邮箱被占用！', self::VALUE_VALIDATE, 'unique'), //邮箱被占用
        // 验证密码
        array('password', '6,16', '密码长度必须在6-16个字符之间！', self::MUST_VALIDATE, 'length', self::MODEL_INSERT), //密码长度不合法
        array('repassword','password','确认密码不正确', self::MUST_VALIDATE, 'confirm', self::MODEL_INSERT), // 验证确认密码是否和密码一致
    );

    // 自动完成
    protected $_auto = array(
        array('password', 'encrypt', self::MODEL_INSERT, 'callback'),
    	array('addtime', 'getDate', self::MODEL_INSERT, 'callback'),
    	array('userkey', 'userkey', self::MODEL_INSERT, 'callback'),
    	array('verifycode', 'getCode', self::MODEL_INSERT, 'callback'),
    	array('utype', 2, self::MODEL_INSERT),
    	array('is_state', 1, self::MODEL_INSERT),
    );
    
    // +----------------------------------------------------------------------
    // | 用户数据调用
    // +----------------------------------------------------------------------
    /**
     * 根据用户id获取用户名
     */
    public function getUserName($uid){
    	return $this->where(array('id'=>(int)$uid))->getField('username');
    }
    
    /**
     * 根据用户id获取Email
     */
    public function getEmail($uid){
    	return $this->where(array('id'=>(int)$uid))->getField('email');
    }
    
    /**
     * 根据用户id获取手机
     */
    public function getMobile($uid){
    	return $this->where(array('id'=>(int)$uid))->getField('tel');
    }
    
    /**
     * 验证用户密码
     * @param int $uid 用户id
     * @param string $password_in 密码
     * @return boolean 验证成功，false 验证失败
     */
    public function verifyPassword($uid, $password_in){
    	$password = $this->getFieldById($uid, 'password');
    	if(hi_md5($password_in, C('AUTH_KEY')) === $password){
    		return true;
    	}else{
    		return false;
    	}
    }
    


    /**
     * 新增或更新新闻资讯
     * @param array  $data 手动传入的数据
     * @return boolean fasle 失败 ， int  成功 返回完整的数据
     */
    public function update($data = null){
        /* 获取数据对象 */
        $data = $this->token(false)->create($data);
       
        if(empty($data)){
            return false;
        }
        $data['Userinfo']['realname'] = I('post.realname/s');
        /* 添加或更新 */
        if(empty($data['id'])){ //新增数据
            $done = $this->relation(true)->add($data);
            $data['id'] = $done;
            
            if($done){
                return true;
            } else {
                return false;
            }
        } else { //更新数据
            $status = $this->relation(true)->save($data);
           
            if(false === $status){
                return false;
            }
        }
        return true;
    }


// +----------------------------------------------------------------------
    // | 自动验证
    // +----------------------------------------------------------------------
    // 多字段验证 参数为数组
    // 检测注册用户选项：用户名|手机|邮箱必须填写一个选项
    public function checkUser($data){
        if(empty($data['username']) && empty($data['mobile']) && empty($data['email'])){
            return false;
        }else{
            return true;
        }
    }

    /**
     * 检测用户名
     * @param  string  $field  用户名
     * @return integer 错误编号
     */
    public function checkUsername($username){
        $verify = new Verify();
        return $verify::isUsername($username) ? true: false;
    }

    /**
     * 禁止注册用户名
     * @param  string  $field  用户名
     * @return integer 错误编号
     */
    public function checkDenyMember($username){
        return !in_array($username, explode('|',C('DENY_MEMBER'))) ?true:false;
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


    // +----------------------------------------------------------------------
    // | 自动完成
    // +----------------------------------------------------------------------
    /**
     * [系统加密]
     * @author LaoHe
     * @DateTime 2017-03-27
     * @param    [string]   $password
     * @return   [string]
     */
    public function encrypt($password){
        return md5(md5($password));
    }
	
    /**
     * [用户加密]
     * @author LaoHe
     * @DateTime 2017-03-27
     * @param    [string]   $userkey
     * @return   [string]
     */
    public function userkey(){
    	return strtoupper(substr(md5(date()),8,16));
    }
    /**
     * [获取时间]
     * @author LaoHe
     * @return   [string]
     */
    public function getDate(){
    	return date('Y-m-d H:i:s');
    }
    /**
     * [验证码]
     * @author LaoHe
     * @return   [string]
     */
    public function getCode(){
    	return hi_md5(NOW_TIME);
    }
    // +----------------------------------------------------------------------
    // | 模型通用操作
    // +----------------------------------------------------------------------
    /**
     * [快捷编辑对应模型操作]
     * 进行缓存及各种模型信息的处理
     * @author LaoHe
     * @DateTime 2017-05-27
     * @param    integer   $id
     * @return   boolean
     */
    public function quick($id){
        if($id == 1){
            $this->error = '不允许对超级管理员执行该操作!';
            return false;
        }
        return true;
    }



}