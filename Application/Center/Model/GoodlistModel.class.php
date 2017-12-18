<?php
// +----------------------------------------------------------------------
// | hicms | 商品模型
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenjie
// +----------------------------------------------------------------------
namespace Center\Model;
use Think\Model;
class GoodlistModel extends Model{
    
    /* 自动验证规则 */
    protected $_validate = array(
    		array('id','number','非法提交!', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
    		
    		array('cateid','number','非法提交!', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
    		array('cateid','require','商品分类不能为空!', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
    		
    		array('goodname','require','商品名称不能为空!', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
    		array('price','require','商品价格不能为空!', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
    		array('price','currency','价格格式不正确!', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
    		array('cbprice','currency','成本价格格式不正确!', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
    		// 邮件提醒验证
    		array('is_email',array(0,1),'设置邮箱提醒有误！',self::MUST_VALIDATE,'in',self::MODEL_BOTH),
    		// 预警库存提醒
    		array('invent_report','number','预警库存格式不正确！',self::VALUE_VALIDATE,'regex',self::MODEL_BOTH),
    		
    		array('limit_quantity','number','限购数量格式不正确！',self::VALUE_VALIDATE,'regex',self::MODEL_BOTH),
    		
    		array('is_coupon',array(0,1),'是否支持优惠券有误！',self::MUST_VALIDATE,'in',self::MODEL_BOTH),
    		
    		array('is_dispay',array(0,1,2),'支付方式参数有误！',self::MUST_VALIDATE,'in',self::MODEL_BOTH),
    		
    		array('is_api',array(0,1),'商品类型有误！',self::MUST_VALIDATE,'in',self::MODEL_INSERT),
    		
    		array('api_return_url','url','通知地址链接格式不正确！',self::VALUE_VALIDATE,'regex',self::MODEL_INSERT),
    		
    		array('siteurl','url','网站链接格式不正确！',self::VALUE_VALIDATE,'regex',self::MODEL_BOTH),
    		array('qq','number','QQ格式不正确!', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
    		
    		array('sortid','number','排序参数错误!', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        
    );

    // 自动完成
    protected $_auto = array(
    		array('userid', UID, self::MODEL_BOTH),
    		array('is_state', 1, self::MODEL_BOTH),
    		array('linkid', 'getlinkid', self::MODEL_INSERT,'callback'),
            array('addtime', NOW_TIME, self::MODEL_BOTH),
    );
    /* 删除前置操作*/
    protected function _before_delete($options){
    		$info = $this->where($options['where'])->getField('userid',true);
    		$uid = array_unique($info);
    		if (UID != $uid[0] || count($uid) != 1) {
    			return false;
    		}
    }
    /* 更新前置操作*/
    protected function _before_update($data, $options){
    		$info = $this->where($options['where'])->getField('userid',true);
    		$uid = array_unique($info);
    		if (UID != $uid[0] || count($uid) != 1) {
    			return false;
    		}
    }
    // +----------------------------------------------------------------------
    // | 用户数据调用
    // +----------------------------------------------------------------------
    
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
        
        if (!$data['id']) {
        	$status = $this->add($data);
        }else {
        	$status = $this->save($data);
        }
       
       	if(false === $status){
           	return false;
       	}
        
        	return true;
    }
	/**
	 * 统计数量
	 * @param  $uid 用户ID 0:全部 
	 * @param $issell 是否卖出 0：未卖出 1：已卖出 2：全部
	 */
    public function getNum($uid=0,$issell =2){
    	if (!empty($uid)) {
    		$map['userid'] = $uid;
    	}
    	switch ($issell) {
    		case 0:
    			$map['is_state'] = 0;
    		break;
    		case 1:
    			$map['is_state'] = 1;
    		break;
    		default:
    			;
    		break;
    	}
    	
    	return  $this->where($map)->count();
    }

// +----------------------------------------------------------------------
    // | 自动验证
    // +----------------------------------------------------------------------
    // 多字段验证 参数为数组
    // 检测注册用户选项：用户名|手机|邮箱必须填写一个选项
 


    // +----------------------------------------------------------------------
    // | 自动完成
    // +----------------------------------------------------------------------
    /**
     * [生成链接]
     * @author LaoHe
     * @return   [string]
     */
    public function getlinkid(){
    	return strtoupper(substr(hi_md5(NOW_TIME.UID),8,16));
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