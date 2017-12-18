<?php
// +----------------------------------------------------------------------
// | hicms | 广告MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model\RelationModel;
class AdModel extends RelationModel{
    protected $_link=array(
        'Postion'=> array(
            'mapping_type' => self::BELONGS_TO,
            'class_name'   => 'Adpos',
            'mapping_name' =>'Postion',
            'foreign_key'  => 'pos',
            'as_fields'    => 'title:postion,width,height',
        ),
    );

	/* 自动验证 */
    protected $_validate = array(
        array('id', 'number', '非法提交', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
        array('title', 'require', '广告名称不能为空', self::MUST_VALIDATE),
        array('url', 'url', '广告链接格式不正确', self::MUST_VALIDATE),
        array('image', 'require', '请上传图片', self::MUST_VALIDATE),
        array('enddate', 'require', '结束日期不能为空', self::MUST_VALIDATE),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('enddate', 'strtotime', self::MODEL_BOTH,'function'),
        array('status', 1, self::MODEL_INSERT),
    );


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
        return true;
    }

}