<?php
// +----------------------------------------------------------------------
// | 中船通管理平台|产品模型类
// +----------------------------------------------------------------------
namespace Center\Model;
use Think\Model;
use Libs\Verify; //验证类库
class AddressModel extends Model{

    /* 自动验证规则 */
    protected $_validate = array(
        array('id','checkID','非法提交!', self::MUST_VALIDATE, 'callback', self::MODEL_UPDATE),
        array('consignee', 'require', '收货人姓名不能为空'),
        array('province','require','请选择所在省份',self::MUST_VALIDATE),
        array('city','require','请选择城市！',self::MUST_VALIDATE),
        array('district','checkRegion','请选择县区！', self::MUST_VALIDATE, 'callback'),
        array('address', '6,60', '请填写收货地址', self::MUST_VALIDATE, 'length'),
        //手机或电话号码不能全为空
        array('mobile,phone','checkPhone','手机或电话号码必须填写一个',self::MUST_VALIDATE,'callback',self::MODEL_BOTH),
        array('mobile', 'isMobile', '手机号码有误', self::VALUE_VALIDATE, 'callback'),
        array('phone', 'isPhone', '电话号码格式有误', self::VALUE_VALIDATE, 'callback'),
        array('zipcode', 'isPostcode', '邮政编码有误', self::VALUE_VALIDATE, 'callback'),
        //array('title', 'require', '地址别名不能为空'),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('uid', 'is_login', self::MODEL_INSERT, 'function'),
        array('consignee', 'html', self::MODEL_BOTH, 'function'),
        array('address', 'html', self::MODEL_BOTH, 'function'),
        array('zipcode', 'html', self::MODEL_BOTH, 'function'),
        array('mobile', 'html', self::MODEL_BOTH, 'function'),
        array('phone', 'html', self::MODEL_BOTH, 'function'),
        //array('title', 'html', self::MODEL_BOTH, 'function'),
        array('isdefault', 'setDefault', self::MODEL_BOTH, 'callback'),
    );

    // +----------------------------------------------------------------------
    // | 验证函数
    // +----------------------------------------------------------------------
    /**
     * 检测当前ID|只为防止某些人在线修改ID
     * @param  integer  $field  手机号码
     * @return integer 错误编号
     */
    public function checkID($id){
        //是否为数字
        if(!($id!==0 && is_numeric($id))){
            return false;
        }
        if($this->where(array('id'=>$id))->getField('uid')!=UID){
            return false;
        }
        return true;
    }

    // 多字段验证 参数为数组
    // 检测注册用户选项：电话号码|手机必须填写一个
    public function checkPhone($data){
        if(empty($data['mobile']) && empty($data['phone'])){
            return false;
        }else{
            return true;
        }
    }

    // 验证地区 不是直辖市就跳过验证
    public function checkRegion($district){
        $province = I('post.province/d');
        $district = I('post.district/d');
        if(empty($district)){
            if($province!=110000 xor $province!=120000 xor $province!=310000 xor $province!=500000){
                return true;
            }else{
                return false;
            }
        }else{
            return true;
        }
    }

    /**
     * 检测手机号码
     * @param  integer  $field  手机号码
     * @return integer 错误编号
     */
    public function isMobile($mobile){
        $verify = new Verify();
        return $verify::isMobile($mobile) ? true: false;
    }

    /**
     * 检测手机号码
     * @param  integer  $field  手机号码
     * @return integer 错误编号
     */
    public function isPhone($phone){
        $verify = new Verify();
        return $verify::isPhone($phone) ? true: false;
    }

    /*验证是否为邮编*/
    public function isPostcode($zipcode){
        $verify = new Verify();
        return $verify::isPostcode($zipcode) ? true: false;
    }

    /*设置默认地址*/
    public function setDefault(){
        $is = $this->where(array('uid'=>is_login(),'isdefault'=>1))->find();
        if($is){
            $isdefault = 0;
        }else{
            $isdefault = 1;
        }
        return $isdefault;
    }


}