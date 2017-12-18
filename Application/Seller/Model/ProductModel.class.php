<?php
// +----------------------------------------------------------------------
// | hicms | 产品MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Seller\Model;
use Think\Model\RelationModel;
class ProductModel extends RelationModel{
    // 关联内容表
    protected $_link=array(
        'ProductData'=> array(
            'mapping_type' => self::HAS_ONE,
            'class_name'   => 'ProductData',
            'foreign_key'  => 'id',
        ),
    );

    /* 自动验证规则 */
    protected $_validate = array(
        array('id', 'number', '非法提交', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
        // 标题
        array('title', 'require', '产品名称不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('title', '1,80', '标题长度不能超过80个字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
        
        // 栏目
        array('catid', 'require', '分类不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_INSERT),
        array('catid', 'checkIsParent', '该分类不允许发布产品', self::MUST_VALIDATE, 'callback', self::MODEL_BOTH),
        // 正文内容
        array('content','require','产品内容不能为空', self::MUST_VALIDATE,'regex', self::MODEL_BOTH),
    	// 库存
    	array('stock', 'require', '产品库存不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
    	
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('uid', 'is_login', self::MODEL_INSERT, 'function'),
        array('description', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
        array('inputtime', 'getInputTime', self::MODEL_BOTH,'callback'),
        array('updatetime', NOW_TIME, self::MODEL_BOTH),
        array('iscomment', 'getSwitch', self::MODEL_BOTH, 'callback','iscomment'),
        array('status', 1, self::MODEL_BOTH),
        //array('url', 'getUrl', self::MODEL_BOTH,'callback'),
        //array('tags', 'getTags', self::MODEL_BOTH, 'callback'),
    );

    // +----------------------------------------------------------------------
    // | 自动验证相关函数
    // +----------------------------------------------------------------------
    /**
     * 栏目是否允许发布内容,如果为最低级栏目，允许发布。
     * @param  integer  $catid  栏目
     * @return boolean
     */
    public function checkIsParent($catid){
        return D('Admin/ProductCategory')->getArrchildid($catid) ? false: true;
    }

    /**
     * 栏目是否允许发布内容,如果为最低级栏目，允许发布。
     * @param  integer  $catid  栏目
     * @return boolean
     */
    public function checkUrl($data){
        return (I('post.islink') && empty($data)) ? false: true;
    }

    // +----------------------------------------------------------------------
    // | 自动完成相关函数
    // +----------------------------------------------------------------------
    /**
     * SWICH 开关值
     * @return 1:0
     */
    protected function getSwitch($data,$field){
        $data == 'true' ? 1 : 0;
        return $data;
    }

    /**
     * SWICH 开关值
     * @return 1:0
     */
    protected function getURL(){
        //$id = $this->getLastInsID;
        return '/show/'.$this->find();
    }

    /**
     * 获取数据状态
     * @return integer 数据状态
     */
    protected function getStatus($field){
        $id = I('post.id');
        if(empty($id)){	//新增
        	$cate = I('post.catid');
        	$check 	=	M('ProductCategory')->getFieldById($cate,'ischeck');
            $status = 	$check ? 2 : 1;
        }else{				//更新
            $status = $this->getFieldById($id, 'status');
            //编辑草稿改变状态
            if($status == 3){
                $status = 1;
            }
        }
        return $status;
    }

    /**
     * 创建时间不写则取当前时间
     * @return int 时间戳
     */
    protected function getInputTime($field){
        //$inputtime = I('post.inputtime');
        return $field ? strtotime($field):NOW_TIME;
    }


    /**
     * 新增或更新产品
     * @param array  $data 手动传入的数据
     * @return boolean fasle 失败 ， int  成功 返回完整的数据
     */
    public function update($data = null){
        /* 获取数据对象 */
        $data = $this->token(false)->create($data);
        if(empty($data)){
        	return false;
        }
        // 编辑状态缩略图如果删掉不修改BUG
        $data['picture'] = $data['picture'] ? arr2str($data['picture'],','):0;

        // 文章内容关联表
        $data['ProductData'] = array('content' => I('post.content'));
        // 模型ID
        $modelid = category($data['catid'], 'modelid');
        /* 添加或更新文章 */
        if(empty($data['id'])){ //新增数据
            $done = $this->relation(true)->add($data);
            $data['id'] = $done;
            // 添加TAGS标签
            D('Admin/Tags')->tags($data, $modelid);
            // 添加附件信息
            addAttachment($data['picture'], $data['id'], $modelid);
            if($done){
                return true;
            } else {
                return false;
            }
        } else { //更新数据
            $status = $this->relation(true)->save($data);
            // 更新TAGS标签
            D('Admin/Tags')->tags($data, $modelid);
            // 更新附件信息
            addAttachment($data['picture'], $data['id'], $modelid);
            if(false === $status){
                return false;
            }
        }
        return true;
    }

    /**
     * 获取当前URL
     * @return id 当前内容ID
     */
    protected function updateUrl($id){
        //$inputtime = I('post.inputtime');
        return $field ? strtotime($field):NOW_TIME;
    }

    // +----------------------------------------------------------------------
    // | 模型通用操作
    // +----------------------------------------------------------------------
    /**
     * [快捷编辑对应模型操作]
     * 进行缓存及各种模型相关动作的处理
     * @author LaoHe
     * @DateTime 2017-05-27
     * @param    integer   $id
     * @return   boolean
     */
    public function quick($id){
        return true;
    }



}