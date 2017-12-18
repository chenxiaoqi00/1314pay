<?php
// +----------------------------------------------------------------------
// | hicms | 卡
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenjie
// +----------------------------------------------------------------------
namespace Center\Model;
use Think\Model;
class GoodsModel extends Model{
    
    /* 自动验证规则 */
    protected $_validate = array(
    		array('goodid','require','商品不能为空',self::MUST_VALIDATE,'regex',self::MODEL_BOTH),
    		array('goodid','number','商品不正确',self::MUST_VALIDATE,'regex',self::MODEL_BOTH),
    );

    // 自动完成
    protected $_auto = array(
    	
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
        if (I('post.upload/d') == 1) {
        	$id = I('post.file/d');
        	$file = D('Attachment')->where(array('id'=>$id,'uid'=>UID))->field('path,name')->find();
        	if (!$file) {
        		$this->error='文件信息有误！';
        		return false;
        	}
        	$content = explode("\r\n", iconv("gb2312", "utf-8//IGNORE",file_get_contents('.'.$file['path'])));
        }else {
        	$content = explode ("\r\n",$_POST['content']);
        }
        
        $maxnum = C('MAX_CARD_NUM')?C('MAX_CARD_NUM'):200;
        
        if (count($content)<=0||count($content)>$maxnum) {
        	$this->error='输入框添加卡密最多'.$maxnum.'张('.$maxnum.'行)';
        }
        
        $num = $this->getNum(UID,I('post.goodid/d'),0);
        // 是否超过最大数量
        if ((count($content)+$num)>$maxnum){
        	$this->error='您该商品的库存还有'.$num.'件！您上传'.count($content).'件商品已超出平台允许的最大数量'.$maxnum.'！请重新上传!';
        	return false;
        }
        
        foreach ($content as $key => $value) {
            if($value!=""){
                if (I('post.is_deff') == 1) {
                    $card[] = $this->getarray($value);
                }else {
                    $array = $this->getarray($value);
                    $card[$array[0]] = $array[1];
                }
            }
        }
       	
        foreach ($card as $key => $value) {
        	$data1['userid'] = UID;
        	$data1['goodid'] = I('post.goodid/d');
        	if (I('post.is_deff') == 1) {
        		$data1['cardnum'] = $value[0];
        		$data1['cardpwd'] = $value[1];
        	}else{
        		$data1['cardnum'] = $key;
        		$data1['cardpwd'] = $value;
        	}
        	$data1['is_state'] = 0;
        	$data1['addtime'] = date('Y-m-d H:i:s');
        	$data1['updatetime'] = date('Y-m-d H:i:s');
        	$data2[]=$data1;
         }
        
        $status = $this->addAll($data2);
       
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
    public function getNum($uid=0,$goodid=0,$issell =2){
    	if (!empty($uid)) {
    		$map['userid'] = $uid;
    	}
    	if (!empty($goodid)) {
    		$map['goodid'] = $goodid;
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
    	$num = $this->where($map)->count();
    	return  $num;
    }

// +----------------------------------------------------------------------
    // | 自动验证
    // +----------------------------------------------------------------------
    // 多字段验证 参数为数组
    // 检测注册用户选项：用户名|手机|邮箱必须填写一个选项
 


    // +----------------------------------------------------------------------
    // | 自动完成
    // +----------------------------------------------------------------------
   
   
   
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
	/**
	 * 去除字符串中的空格 返回数组
	 * @param unknown $str
	 */
	private function getarray($str) {
		$trimval=trim($str);
		$nbsp='';
			//一行中间有多少空格，如果大于1个，则替换成一个空格
		if(substr_count($trimval," ")>1){
			for($i=1;$i<=substr_count($trimval," ");$i++){
				$nbsp .=" ";
		    }
			$trimval=str_replace($nbsp, ' ' , $trimval);
			$nbsp='';
			}
		if(strpos($trimval," ")){
			$arr_cards=explode(' ',$trimval);
			$card=$arr_cards;
		} else {
			$card[]=$trimval;
			$card[]='';
		}
		return $card;
	}

}