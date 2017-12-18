<?php
// +----------------------------------------------------------------------
// | hicms | 商户MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenjie
// +----------------------------------------------------------------------
namespace Center\Model;
use Libs\Verify; //验证类库
use Think\Model\RelationModel;
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
    	array('id','number','非法提交!', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
		//用户名、手机或邮箱不能全为空
        array('username,tel,email','checkUser','用户名、手机或邮箱必须填写一个',self::VALUE_VALIDATE,'callback',self::MODEL_BOTH),
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
        // 验证支付方式
        array('ptype',array(1,2,3),'支付方式有误！',self::MUST_VALIDATE,'in'),// 支付类型范围
    	array('ptype', 'require', '支付方式不能为空', self::MUST_VALIDATE, 'regex'),// 支付方式是不能为空
    
    	array('bank','checkBank','银行名称有误！',self::VALUE_VALIDATE,'callback'),// 支付类型范围
    	array('idcard', '18', '身份证长度不正确！', self::VALUE_VALIDATE, 'length'), //邮箱长度不合法
    );

    // 自动完成
    protected $_auto = array(
    	array('addtime', 'getDate', self::MODEL_INSERT, 'callback'),
    	array('verifycode', 'getCode', self::MODEL_INSERT, 'callback'),
    	array('utype', 2, self::MODEL_INSERT),
    	array('is_state', 1, self::MODEL_INSERT),
    );
    /* 删除前置操作*/
    protected function _before_delete($options){
    		$info = $this->where($options['where'])->field('id')->getField('id',true);
    		$uid = array_unique($info);
    		if (UID != $uid[0] || count($uid) != 1) {
    			return false;
    		}
    }
    /* 更新前置操作*/
    protected function _before_update($data, $options){
    		$info = $this->where($options['where'])->field('id')->getField('id',true);
    		$uid = array_unique($info);
    		if (UID != $uid[0] || count($uid) != 1) {
    			return false;
    		}
    }
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
        $is_account = (int)M("userinfo")->where(array("userid"=>I("post.id")))->getField("is_account");
        if($is_account == 1){  //判断转账信息是否允许修改
            $userInfo = array(
                'realname' => I('post.realname/s'),
                'idcard' => I('post.idcard/s'),
                'ptype' => I('post.ptype/d'),
                'bank' => I('post.ptype/d') == 1 ? I('post.bank/s') : '',
                'card' => I('post.ptype/d') == 1 ? I('post.card/s') : '',
                'addr' => I('post.ptype/d') == 1 ? I('post.addr/s') : '',
                'alipay' => I('post.ptype/d') == 2 ? I('post.alipay/s') : '',
                'tenpay' => I('post.ptype/d') == 3 ? I('post.tenpay/s') : '',
            );
            $data['Userinfo'] = $userInfo;
            switch ($userInfo['ptype'])
            {
                case 1:
                    if(trim($userInfo['bank'])!="" && trim($userInfo['card'])!="" && trim($userInfo['addr'])!="" && trim($userInfo['realname'])!=""){
                        $data['Userinfo']['is_account'] = 0;
                    }
                    break;
                case 2:
                    if(trim($userInfo['realname'])!="" && trim($userInfo['alipay'])!=""){
                        $data['Userinfo']['is_account'] = 0;
                    }
                    break;
                case 3:
                    if(trim($userInfo['realname'])!="" && trim($userInfo['tenpay'])!=""){
                        $data['Userinfo']['is_account'] = 0;
                    }
                    break;
            }
        }
   
       $status = $this->relation(true)->save($data);
       if(false === $status){
           return false;
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
	 * 验证银行名称
	 * @param unknown $field
	 */
    public function checkBank($field){
    	if (I('post.ptype') == 1) {
    		if (empty($field)) {
    			return false;
    		}
    	}
    	return true;
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