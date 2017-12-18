<?php
// +----------------------------------------------------------------------
// | hicms | 商户MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenjie
// +----------------------------------------------------------------------
namespace Center\Model;
use Think\Model;
class GoodcateModel extends Model{
    
    /* 自动验证规则 */
    protected $_validate = array(
    	array('id','number','非法提交!', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
		//用户名、手机或邮箱不能全为空
        array('catename','require','分类名称不能为空',self::MUST_VALIDATE,'regex',self::MODEL_BOTH),
        
    );

    // 自动完成
    protected $_auto = array(
    	array('linkid', 'getlinkid', self::MODEL_INSERT, 'callback'),
    	array('userid', UID, self::MODEL_BOTH),
    	array('is_state', 1, self::MODEL_INSERT),
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


// +----------------------------------------------------------------------
    // | 自动验证
    // +----------------------------------------------------------------------
    // 多字段验证 参数为数组
    // 检测注册用户选项：用户名|手机|邮箱必须填写一个选项
 


    // +----------------------------------------------------------------------
    // | 自动完成
    // +----------------------------------------------------------------------
   
    /**
     * [用户加密]
     * @author LaoHe
     * @DateTime 2017-03-27
     * @param    [string]   $userkey
     * @return   [string]
     */
    public function getlinkid(){
    	return strtoupper(substr(md5(UID.time()),8,16));
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