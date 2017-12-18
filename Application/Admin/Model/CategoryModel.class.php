<?php
namespace Admin\Model;
use Think\Model;
use Libs\Tree;	 //树
use Libs\Verify; //验证类库
/**
 * 分类模型
 */
class CategoryModel extends Model{
    protected $_validate = array(
        array('id', 'number', '非法提交', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
        array('title', 'require', '栏目名称不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('title','','栏目名称已经存在',self::MUST_VALIDATE ,'unique', self::MODEL_BOTH),
        array('name', 'require', '栏目标识不能为空', self::EXISTS_VALIDATE, 'regex', self::MODEL_BOTH),
        array('name','','栏目标识已经存在',self::MUST_VALIDATE ,'unique', self::MODEL_BOTH),
        array('name','','栏目标识只能为英文',self::MUST_VALIDATE ,'unique', self::MODEL_BOTH),
    	array('meta_title', '1,50', '网页标题不能超过50个字符', self::VALUE_VALIDATE , 'length', self::MODEL_BOTH),
    	array('keywords', '1,255', '网页关键字不能超过255个字符', self::VALUE_VALIDATE , 'length', self::MODEL_BOTH),
    	array('description', '1,255', '网页描述不能超过255个字符', self::VALUE_VALIDATE , 'length', self::MODEL_BOTH),
        //array('pid', 'checkpid', '上级栏目不能属于当前子分类', self::VALUE_VALIDATE, 'callback', self::MODEL_BOTH),
    );

    protected $_auto = array(
        array('status', '1', self::MODEL_BOTH),
        array('child', 'doChild', self::MODEL_BOTH, 'callback'),
        array('arrchildid', 'arrChildid', self::MODEL_BOTH, 'callback'),
        array('arrparentid', 'arrParentid', self::MODEL_BOTH, 'callback'),
        array('ispost', 'getSwitch', self::MODEL_BOTH, 'callback','ispost'),
        array('ischeck', 'getSwitch', self::MODEL_BOTH, 'callback','ischeck'),
        array('ishtml', 'getSwitch', self::MODEL_BOTH, 'callback','ishtml'),
    );


    // +----------------------------------------------------------------------
    // | 自动验证相关函数
    // +----------------------------------------------------------------------
    /**
     * 检测英文名
     * @param  integer  $field  栏目标识
     * @return integer 错误编号
     */
    public function checkName($name){
        $verify = new Verify();
        return $verify::isName($name, false) ? true: false;
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

    protected function doChild($field){
        return $this->arrChildid() ? 1 :0;
    }

    /**
     * 获取子栏目ID列表
     * @param integer  $catid 当前栏目
     * @return string   返回栏目子列表，以逗号隔开
     */
    protected function arrChildid() {
        $catid = I('post.id/d');
        if(!$catid) {
            $catid = $this->getLastInsID;
        }
        $arrchild = Tree::getChildsId( categorys(), $catid);
        asort($arrchild);
        $arrchildid = arr2str($arrchild);
        return $arrchildid;
    }

    /**
     * 获取父栏目ID列表
     * @param integer   $catid 当前栏目ID
     * @return string   返回栏目子列表，以逗号隔开
     */
    protected function arrParentid() {
        $catid = I('post.id/d');
        if(!$catid) {
            $catid = $this->getLastInsID;
        }
        $arrparent = Tree::getParentsId( categorys(), $catid);
        //array_pop($arrparent);
        asort($arrparent);
        $arrparentid = arr2str($arrparent);
        return $arrparentid;
    }

    // +----------------------------------------------------------------------
    // | 数据调用相关函数
    // +----------------------------------------------------------------------
    /*public function parent($catid, $field = null){
        $category = categorys();
        foreach($category as $v){
            if($v['pid'] == $catid){
                $result = $v['Title'];
            }else{
                return '';
            }
        }
    }*/
    /**
     * 获取子栏目ID列表
     * @param integer  $catid 当前栏目
     * @return string   返回栏目子列表，以逗号隔开
     */
    public function getArrchildid($catid) {
        $arrchild = Tree::getChildsId( categorys(), $catid);
        asort($arrchild);
        $arrchildid = arr2str($arrchild);
        return $arrchildid;
    }

    /**
     * 获取父栏目ID列表
     * @param integer   $catid 当前栏目ID
     * @return string   返回栏目子列表，以逗号隔开
     */
    public function getArrparentid($catid) {
        $arrparent = Tree::getParentsId( categorys(), $catid);
        //array_pop($arrparent);
        asort($arrparent);
        $arrparentid = arr2str($arrparent);
        return $arrparentid;
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