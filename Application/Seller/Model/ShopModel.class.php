<?php
// +----------------------------------------------------------------------
// | 中船通管理平台|店铺模型类
// +----------------------------------------------------------------------
namespace Seller\Model;
use Think\Model;
use Libs\Verify; // 验证类库
class ShopModel extends Model{
    /* 自动验证规则 */
    protected $_validate = array(
        array('shopid','checkID','非法提交!', self::MUST_VALIDATE, 'callback', self::MODEL_UPDATE),
        // 店铺名称
        array('shopname', 'require', '店铺名称必须填写', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('shopname', '6,32', '店铺名称为6-32个字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
        array('shopname', '', '店铺名称已存在', self::MUST_VALIDATE, 'unique', self::MODEL_BOTH), //是否被占用
        // 验证QQ号码
        array('qq', 'checkQQ', 'QQ格式不正确！', self::VALUE_VALIDATE, 'callback', self::MODEL_BOTH),
        array('qq,wangwang','checkIM','客服QQ和阿里旺旺必须填写一个',self::MUST_VALIDATE,'callback',self::MODEL_BOTH),
        // 库存预警
        array('inventory_warning', 'number', '库存必须为数字', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        // 包邮额度
        array('free_shipping_price', 'currency', '包邮额度必须为货币格式', self::VALUE_VALIDATE, 'regex', self::MODEL_UPDATE),
        // 关键字
        array('keywords', '1,255', 'SEO关键字不能超过255个字符', self::VALUE_VALIDATE , 'length', self::MODEL_BOTH),
        // SEO描述
        array('description', '1,255', 'SEO描述不能超过255个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('uid', 'is_login', self::MODEL_INSERT, 'function'),
        array('shopname', 'html', self::MODEL_BOTH, 'function'),
        array('keywords', 'html', self::MODEL_BOTH, 'function'),
        array('description', 'html', self::MODEL_BOTH, 'function'),
        array('wangwang', 'html', self::MODEL_BOTH, 'function'),
        array('status', '2', self::MODEL_INSERT), //审核状态
        array('open_time', NOW_TIME, self::MODEL_INSERT), //开店时间
    );

    // +----------------------------------------------------------------------
    // | 验证函数
    // +----------------------------------------------------------------------
    /**
     * 检测当前ID|只为防止某些人在线修改ID
     * @param  integer  $field  手机号码
     * @return integer 错误编号
     */
    public function checkID($shopid){
        //是否为数字
        if(!($shopid!==0 && is_numeric($shopid))){
            return false;
        }
        if($this->where(array('shopid'=>$shopid))->getField('uid')!=UID){
            return false;
        }
        return true;
    }

    /**
     * 检测QQ号码
     * @param  integer $qq  qq号码
     */
    public function checkQQ($qq){
        $verify = new Verify();
        return $verify::isQQ($qq) ? true: false;
    }

    // 多字段验证 参数为数组
    // 检测客服QQ和阿里旺旺必须填写其中一个
    public function checkIM($data){
        if(empty($data['qq']) && empty($data['wangwang'])){
            return false;
        }else{
            return true;
        }
    }



}