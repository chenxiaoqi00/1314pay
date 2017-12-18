<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
namespace Common\Model;
use Think\Model\RelationModel;
use Libs\Verify; //验证类库
/**
 * 用户模型
 */
class UsersModel extends RelationModel {
    //新增字段
    /*protected $insertFields = array('username','mobile','email','password');
    //编辑字段
    protected $updateFields = array('username','mobile','email');*/
    //管理模型
    protected $_link=array(
        'Userinfo'=> array(
            'mapping_type'  => self::HAS_ONE,
            'class_name'    => 'Userinfo',
            'foreign_key'   => 'userid',
        ),
    );
    //自动验证
    //验证时间（可选）
    //self::MODEL_INSERT或者1新增数据时候验证
    //self::MODEL_UPDATE或者2编辑数据时候验证
    //self::MODEL_BOTH或者3全部情况下验证（默认）
    //self::MODEL_MODIFY
    protected $_validate = array(
        // 验证手机号码
        array('tel', 'checkMobile', '手机格式不正确！', self::VALUE_VALIDATE, 'callback'), //手机格式不正确 TODO:
        array('tel', '', '手机号被占用！', self::VALUE_VALIDATE, 'unique'), //手机号被占用
        //用户名、手机或邮箱不能全为空
        array('username,tel,email','checkUser','用户名、手机或邮箱必须填写一个',self::MUST_VALIDATE,'callback',self::MODEL_BOTH),
        //用户名长度不合法
        array('username', 'checkUsername', '用户名格式只能为6-16位英文和数字！', self::MUST_VALIDATE, 'callback'), //用户名禁止注册
        array('username', '', '用户名被占用！', self::MUST_VALIDATE, 'unique'), //用户名被占用
        array('username', 'checkDenyMember', '用户名禁止注册', self::MUST_VALIDATE, 'callback'), //用户名禁止注册
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
        array('password', 'encrypt', self::MODEL_BOTH, 'callback'),
        array('last_time', NOW_TIME, self::MODEL_INSERT),
        array('last_ip', 'get_client_ip', self::MODEL_INSERT, 'function', 1),
   //     array('status', 'getStatus', self::MODEL_INSERT, 'callback'),
        array('invite_code', 'creatInviteCode', self::MODEL_INSERT, 'callback'),
        array('userkey', 'userkey', self::MODEL_INSERT, 'callback'),
       array('addtime', 'getDate', self::MODEL_INSERT, 'callback'),
        array('status',1, self::MODEL_INSERT)
    );


    // +----------------------------------------------------------------------
    // | 用户注册|登录|注销等相关
    // +----------------------------------------------------------------------
    /**
     * 用户登录认证
     * @param  string  $username 用户名
     * @param  string  $password 用户密码
     * @param  integer $type     用户名类型 (1-用户名 | 2-邮箱 | 3-手机 | 9-ALL)
     * @return integer           登录成功-用户ID，登录失败-错误编号
     */
    public function login($username, $password, $type = 1){
        $map = array();
        switch ($type) {
            case 1:
                $map['username'] = $username;
                break;
            case 2:
                $map['email'] = $username;
                break;
            case 3:
                $map['tel'] = $username;
                break;
            case 9:
                $map['username'] = $username;
                $map['email'] = $username;
                $map['tel'] = $username;
                $map['_logic'] = 'OR';
                break;
            default:
                return 0; //参数错误
        }
        //获取用户数据
        $user = $this->where($map)->find();
        if(is_array($user) && $user['status']){
            //验证用户密码
            if(h318_md5($password) === $user['password']){
                //登录成功后修改登录相关信息
                $data['last_time'] = NOW_TIME;
                $data['last_ip'] = get_client_ip(1);
                $data['logins'] = array('exp', '`logins`+1');
                $data['session_id'] = session_id();
                $this->where(array('id'=>$user['id']))->save($data);
                //记录登录SESSION和COOKIES
                $auth = array(
                    'uid'       => $user['id'],
                    'last_time' => $user['last_time'],
                    'last_ip'   => $user['last_ip'],
                    'utype'   => $user['utype'],
                );
                session('user_auth', $auth);
                session('user_auth_sign', data_auth_sign($auth));
                //登录成功，返回用户ID
                return $user['id'];
            } else {
                return -2; //密码错误
            }
        } else {
            return -1; //用户不存在或被禁用
        }
    }

    /**
     * 注销当前用户
     * @return void
     */
    public function logout(){
        session('user_auth', null);
        session('user_auth_sign', null);
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
     * [获取时间]
     * @author LaoHe
     * @return   [string]
     */
    public function getDate(){
        return date('Y-m-d H:i:s');
    }

    /**
     * 验证用户密码
     * @param int $uid 用户id
     * @param string $password_in 密码
     * @return boolean 验证成功，false 验证失败
     */
    public function verifyPassword($uid, $password_in){
        $password = $this->getFieldById($uid, 'password');
        if(h318_md5($password_in) === $password){
            return true;
        }else{
            return false;
        }
    }

    // +----------------------------------------------------------------------
    // | 用户信息更新
    // +----------------------------------------------------------------------
    /**
     * 更新用户信息
     * @param int $uid 用户id
     * @param array $data 修改的字段数组
     * @return boolean 修改成功，false 修改失败
     */
    public function updateMember($uid, $data){
        //更新用户信息
        if($data && $uid){
            return $this->where(array('id'=>$uid))->filter('html')->save($data);
        }
        return false;
    }

    // +----------------------------------------------------------------------
    // | 自动验证
    // +----------------------------------------------------------------------
    // 多字段验证 参数为数组
    // 检测注册用户选项：用户名|手机|邮箱必须填写一个选项
    public function checkUser($data){
        if(empty($data['username']) && empty($data['tel']) && empty($data['email'])){
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
    
    /**
     * 验证手机号的唯一性用于validataform
     */
    public function checkUniqueMobile($tel){
        $map['tel']= array('eq',$tel);
        return $this->where($map)->find();
    }
    /**
     * 验证邮箱号的唯一性用于validataform
     */
    public function checkUniqueEmail($email){
        $map['email']= array('eq',$email);
        return $this->where($map)->find();
    }
    /**
     * 验证用户的唯一性用于validataform
     */
    public function checkUniqueUsername($username){
        $map['username']= array('eq',$username);
        return $this->where($map)->find();
    }
    /**
     * 验证邀请码用于validataform
     */
    public function checkInviteCode($inviteCode){
        $map['invite_code']= array('eq',$inviteCode);
        return $this->where($map)->find();
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
        return h318_md5($password);
    }

    /**
     */
    public function creatInviteCode(){
       $randnum_1 = $this->generate_password(5);
       $randnum_2 = $this->generate_password(5);
       return md5($randnum_1.time().$randnum_2);;
    }
    
    function generate_password( $length = 5) {
        // 密码字符集，可任意添加你需要的字符
        $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        $password = "";
        for ( $i = 0; $i < $length; $i++ )
        {
        // 这里提供两种字符获取方式
        // 第一种是使用 substr 截取$chars中的任意一位字符；
        // 第二种是取字符数组 $chars 的任意元素
        // $password .= substr($chars, mt_rand(0, strlen($chars) – 1), 1);
        $password .= $chars[ mt_rand(0, strlen($chars) - 1) ];
    }
            return $password;
    }
    
    
    
    
    
    
    /**
     * 根据配置指定用户状态
     * @return integer 用户状态
     */
    protected function getStatus(){
        return C('MEMBER_REG_CHECK') ? 0 : 1;
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
    
    public function addInvite($inviteCode,$inviteId){
        $map['invite_code']=$inviteCode;
        $user = M('users')->where($map)->field("id,is_invite")->find();
//         $invite_id = $user['invite_id']?$user['invite_id'].",".$inviteId:$inviteId;
        $where["id"] = $user['id'];
        //特约商户结算表添加数据
        $invite = array("Jan"=>0,"Feb"=>0,"Mar"=>0,"Apr"=>0,"May"=>0,"Jun"=>0,"Jul"=>0,"Aug"=>0,"Sep"=>0,"Oct"=>0,"Nov"=>0,"Dec"=>0);
        $invite['inviteid'] = $inviteId;
        $invite['userid'] = $user['id'];
        $add_invite = M('invite')->add($invite);
        M('users')->where($where)->setField("shorturl",$user['id']);//用于短路径
        if($user['is_invite']==0){
            $this->where($where)->setField('is_invite', 1);
        }
        
    }
    
    /**
     * [用户加密]
     * @author LaoHe
     * @DateTime 2017-03-27
     * @param    [string]   $userkey
     * @return   [string]
     */
    public function userkey(){
        $psw = $this->generate_password(5);
        return strtoupper(substr(md5(time().$psw),8,16));
    }
}
