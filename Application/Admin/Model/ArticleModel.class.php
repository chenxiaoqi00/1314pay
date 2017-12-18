<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Model;
use Common\Model\BaseRelationModel;
class ArticleModel extends BaseRelationModel{
    // 关联内容表
    protected $_link=array(
        'ArticleData'=> array(
            'mapping_type' => self::HAS_ONE,
            'class_name'   => 'ArticleData',
            'foreign_key'  => 'id',
        ),
    );

    /* 自动验证规则 */
    protected $_validate = array(
        array('id', 'number', '非法提交', self::MUST_VALIDATE, 'regex', self::MODEL_UPDATE),
        // 标题
        array('title', 'require', '文章标题不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('title', '1,80', '标题长度不能超过80个字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
        array('title','','标题已经存在', self::MUST_VALIDATE,'unique', self::MODEL_BOTH),
        // 标识
        array('name', '/^[a-zA-Z]\w{0,39}$/', '文档标识不合法', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
        // 摘要
        array('description', '1,255', '摘要长度不能超过255个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
        // 栏目
        array('catid', 'require', '栏目不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_INSERT),
        array('catid', 'checkIsParent', '该栏目不允许发布内容', self::MUST_VALIDATE, 'callback', self::MODEL_BOTH),
        // 跳转链接
        array('url', 'url', '链接地址格式不正确', self::VALUE_VALIDATE),
        array('url', 'checkUrl', '请填写URL地址', self::MUST_VALIDATE, 'callback', self::MODEL_BOTH),
        // 正文内容
        array('content','require','文章内容不能为空', self::MUST_VALIDATE,'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('uid', 'is_login', self::MODEL_INSERT, 'function'),
        array('description', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
        array('inputtime', NOW_TIME, self::MODEL_INSERT,'callback'),
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
        return D('Category')->getArrchildid($catid) ? false: true;
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
        	$check 	=	M('Category')->getFieldById($cate,'ischeck');
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
        // 编辑状态缩略图如果删掉不修改BUG
        $data['thumb'] = $data['thumb'] ? $data['thumb']:0;
        // 文章内容关联表
        $data['ArticleData'] = array('content' => I('post.content'));
        // 模型ID
        $modelid = category($data['catid'], 'modelid');
        /* 添加或更新文章 */
        if(empty($data['id'])){ //新增数据
            $done = $this->relation(true)->add($data);
            $data['id'] = $done;
            // 添加TAGS标签
            D('Tags')->tags($data, $modelid);
            // 添加附件信息
            addAttachment($data['thumb'], $data['id'], $modelid);
            if($done){
                return true;
            } else {
                return false;
            }
        } else { //更新数据
            $status = $this->relation(true)->save($data);
            // 更新TAGS标签
            D('Tags')->tags($data, $modelid);
            // 更新附件信息
            addAttachment($data['thumb'], $data['id'], $modelid);
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

    protected function base64_encode($matches) {
        return $matches[1]."\"".base64_encode($matches[2])."\"";
    }
    protected function base64_decode($matches) {
        return $matches[1]."\"".base64_decode($matches[2])."\"";
    }
    protected function keylinks($txt, $replacenum = '3',$link_mode = 1) {
        $search = "/(alt\s*=\s*|title\s*=\s*)[\"|\'](.+?)[\"|\']/is";
        $txt = preg_replace_callback($search, array($this, 'base64_encode'), $txt);
        $linkdatas = S('KEYLINK');
        if($linkdatas) {
            $word = $replacement = array();
            foreach($linkdatas as $v) {
                $word1[] = '/(?!(<a.*?))' . preg_quote($v['title'], '/') . '(?!.*<\/a>)/s';
                $word2[] = $v['title'];
                $replacement[] = '<a href="'.$v['url'].'" target="_blank" class="keylink">'.$v['title'].'</a>';
            }
            if($replacenum != '') {
                $txt = preg_replace($word1, $replacement, $txt, $replacenum);
            } else {
                $txt = str_replace($word2, $replacement, $txt);
            }
        }
        $txt = preg_replace_callback($search, array($this, 'base64_decode'), $txt);
        return $txt;
    }

    // +----------------------------------------------------------------------
    // | 模型通用操作
    // +----------------------------------------------------------------------

    /**
     * [删除对应模型操作]
     * 进行缓存及各种模型相关动作的处理
     * @author LaoHe
     * @DateTime 2017-07-11
     * @param    array()   $ids
     * @return   boolean
     */
    public function del($ids){
        //删除副表数据
        M('ArticleData')->where(array( 'id' => array('in', $ids)))->delete();
        return true;
    }

    // +----------------------------------------------------------------------
    // | 自定义标签查询
    // +----------------------------------------------------------------------
    /**
     * 文章内容列表
     * @param   integer $catid 栏目ID，多个用","分割
     * @param   integer $limit 调用数目 如:limit="2,5" 取2-5条数据
     * @param   integer $thumb 是否缩略图
     * @param   string  $order 排序
     * @return  array() 列表信息
     */
    public function taglib($catid, $thumb, $limit, $order){
        //查询
        $map = array();
        $map['status'] = array('eq', 1);
        if(!empty($catid)){
            $catArr = str2arr($catid);
            foreach ($catArr as $catid) {
                //当前栏目ID下的所有子栏目
                $cats[] = D('Admin/Category')->getArrchildid($catid);
            }
            if (!empty($cats[0])) {
            	$map['catid'] = array('in', arr2str(array_unique($cats)));
            }else {
            	$map['catid'] = $catid;
            }
        }
        if($thumb){
            $map['thumb'] = array('neq', 0);
        }
        $list = $this->where($map)->field('id,thumb,title,catid,islink,url,updatetime')->limit($limit)->order($order)->select();
        foreach ($list as $key => $value) {
        	if ($value['islink'] == 0) {
        		$list[$key]['url'] = U('Home/news/detail',array('id'=>$value['id']));
        	}
        }
        return $list;
    }


}