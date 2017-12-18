<?php
// +----------------------------------------------------------------------
// | 中船通管理平台|关联菜单模型
// +----------------------------------------------------------------------

namespace Admin\Model;
use Think\Model;
/**
 * 导航模型
 */
class LinkageModel extends Model {
    protected $_validate = array(
        array('title', 'require', '菜单名称不能为空', self::MUST_VALIDATE , 'regex', self::MODEL_BOTH),
        //array('title', '', '菜单名称已经存在', self::VALUE_VALIDATE, 'unique', self::MODEL_BOTH),
        array('name', 'check_name', '请设置配置名称', self::MUST_VALIDATE, 'callback'),
        array('name', '', '配置名称已经存在', self::VALUE_VALIDATE, 'unique', self::MODEL_BOTH),
        array('value', 'check_value', '请设置配置数值', self::MUST_VALIDATE, 'callback'),
    );

    protected $_auto = array(
        array('status', '1', self::MODEL_INSERT),
    );

    /**
     * 当前联动是否需要配置名称|父联动 需配置
     * @return boolean fasle 失败,true 成功
     */
    protected function check_name($field){
        if(!I('post.pid/d')){
            if(empty($field)){
                return false;
            }else{
                return ture;
            }
        }
    }

    /**
     * 当前联动是否需要配置值|子联动 需配置
     * @return boolean fasle 失败,true 成功
     */
    protected function check_value($field){
        if(I('post.pid/d')){
            if(empty($field)){
                return false;
            }else{
                return ture;
            }
        }
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
            $this->error = '不允许对该联动执行该操作!';
            return false;
        }
        return true;
    }


}
