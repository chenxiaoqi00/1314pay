<?php
// +----------------------------------------------------------------------
// | hicms | 广告位 MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model;
class PositionModel extends Model{
    //自动验证
    protected $_validate = array(
        //array(验证字段,验证规则,错误提示,验证条件,附加规则,验证时间)
        array('id', 'number', '非法提交', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
        array('title', 'require', '推荐位名称必须填写', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('title','','标题已经存在', self::MUST_VALIDATE,'unique', self::MODEL_BOTH),
        array('maxnum', 'number', '最大条数必须为数字', self::MUST_VALIDATE, 'regex'),
        array('sort', 'number', '最大条数必须为数字', self::MUST_VALIDATE, 'regex'),
    );

    //自动完成
    protected $_auto = array(
        //array('modelid', 'arr2str', self::MODEL_BOTH, 'function'),
        array('modelid', 'getModel', self::MODEL_BOTH, 'callback'),
        array('status', '1', self::MODEL_BOTH),
    );

    // 提交的模型转换为字符串
    protected function getModel($field){
        return $field ? arr2str($field) : 0;
    }

    /**
     * 更新推荐状态, 判断文章是否被推荐
     * @param intval $id
     * @param intval $modelid
     */
    public function updatapos($id, $modelid) {
        $id = intval($id);
        $modelid = intval($modelid);
        if ($id && $modelid) {
            $pos_data = M("PositionData");
            $model = M(tablename($modelid));
            $ispos = $pos_data->where(array('id' => $id, 'modelid' => $modelid))->find() ? 1 : 0;
            //更新信息推荐状态
            $model->where(array('id' => $id))->save(array('ispos' => $ispos));
        }
        return true;
    }

    /**
     * 信息从推荐位中移除
     * @param intval $posid 推荐位id
     * @param intval $id 信息id
     * @param intval $modelid] 模型id
     */
    public function remove($posid, $id, $modelid) {
        if (!$posid || !$id || !$modelid) {
            return false;
        }
        $map = array();
        $map['id'] = $id;
        $map['modelid'] = $modelid;
        $map['posid'] = $posid;
        $db = M('PositionData');
        if ($db->where($map)->delete() !== false) {
            $this->updatapos($id, $modelid);
            return false;
        } else {
            return false;
        }
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
