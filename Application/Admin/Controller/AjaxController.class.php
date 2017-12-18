<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class AjaxController extends AdminController {
    // 移动文档
    public function move(){
        if(IS_POST){
            $ids = I('post.ids');
            if(empty($ids)) {
                $this->error('请选择要移动的信息！');
            }
            $catid = I('post.catid/d');
            if(!$catid){
                $this->error('请选择栏目！');
            }
            if(get_child_categorys($catid)){
                $this->error('请选择子栏目！');
            }
            $modelid = I('post.model/d') ? I('post.model/d'):2;
            $tomodelid = category($catid, 'modelid');
            if($modelid != $tomodelid){
                $this->error('移动的栏目和当前文章模型不一致！');
            }
            $model = tablename($modelid);
            $map['id'] = array('in',$ids);
            if($modelid == 2){
                $category = category();
            }
            $done = D($model)-> where($map)->setField('catid',$catid);
            if($done){
                $this->success('信息移动成功！');
            }else{
                $this->error('信息移动失败,请稍后再试！');
            }
        }else{
            $this->display();
        }
    }

    // 推送
    public function position(){
        if(IS_POST){
            $ids = I('post.ids');
            if(empty($ids)) {
                $this->error('请选择要推荐的信息！');
            }
            $posids = I('post.posid/a');
            if(!$posids){
                $this->error('请选择推荐位！');
            }
            $modelid = I('post.model/d') ? I('post.model/d'):2;
            $model = tablename($modelid);
            $pos_data = M('PositionData');
            $fields = fields($modelid);
            $ids = str2arr($ids);
            if (is_array($posids) && !empty($posids)) {
                foreach ($posids as $posid) {
                    $data = array();
                    foreach ($ids as $v) {
                        $data['id'] = $v;
                        $data['posid'] = $posid;
                        $data['modelid'] = $modelid;
                        $res = M($model)-> find($v);
                        foreach ($res as $value) {
                            foreach ($fields as $_value) {
                                $field = $_value['name'];
                                //判断字段是否推荐位
                                if ($_value['isposition']) {
                                    $data['data'][$field] = $res[$field];
                                }
                            }
                        }
                        $data['catid'] = $res['catid'];
                        $data['thumb'] = $data['data']['thumb'];
                        $data['data'] = serialize($data['data']);
                        //判断推荐位数据是否存在，不存在新增
                        $r = $pos_data->where(array('id' => $v, 'posid' => $posid, 'catid' => $data['catid']))->find();
                        if ($r) {
                            $pos_data->where(array('id' => $v, 'posid' => $posid, 'catid' => $data['catid']))->save($data);
                        } else {
                            $status = $pos_data->data($data)->add();
                            if ($status !== false) {
                                D('Position')->updatapos($data['id'], $data['modelid']);
                            }
                        }
                        unset($data);
                    }
                }
                $this->success('推送到推荐位成功！');
            }else{
                $this->error('信息推荐失败,请稍后再试！');
            }
        }else{
            $modelid = I('get.model/d') ? I('get.model/d'):2;
            if(!empty($modelid)){
                $map['_string']="FIND_IN_SET('".$modelid."', modelid)";
            }
            $position = M('position')->where($map)->select();
            $this->assign('position', $position);
            $this->display();
        }
    }

    /**
     * 获取栏目
     * @author LaoHe
     * @DateTime 2017-05-08
     * @param    integer    $catid 栏目ID
     * @return   json
     */
    public function category($catid = 0){
        $id = I('get.id/d');
        if(!$id){
            $cate=get_child_categorys();
            foreach ( $cate as $value ) {
                $json[$value['id']]['name'] = $value ['title'];
                $json[$value['id']]['id']   = $value ['id'];
            }
            $json = json_encode($json);
        }else{
            $cate=get_child_categorys($id);
            foreach ( $cate as $value ) {
                $json[$value['id']]['name'] = $value ['title'];
                $json[$value['id']]['id']   = $value ['id'];
            }
            $json = json_encode($json);
        }
        echo $json;
    }

    /**
     * 踢掉在线用户
     * @author LaoHe
     * @DateTime 2017-05-08
     * @param    integer    $uid 用户ID
     */
    public function kickuser($uid=0){
        $map = array();
        $map['session_id'] = M('Member')->where(array('id'=>$uid))->getField('session_id');
        $done = M('Session')->where($map)->setField('session_data','');
        if($done){
            $this->success('用户已强退！');
        }else{
            $this->error('用户强退失败,请稍后再试！');
        }
    }
	/**
	 * 
	 * @param unknown $param
	 */
    public function gateway($type=0) {
    	$type = I('get.id');
    	if (empty($type)) {
    		$cate = M('Accessprovider')->select();
    		foreach ( $cate as $value ) {
    			$json[$value ['accesstype']]['name'] = $value ['accessname'];
    		}
    		$json = json_encode($json);
    	}else {
    		$cate = M('Paylist')->where(array('accessType'=>$type))->select();
    		foreach ( $cate as $value ) {
    			$json[$value ['gateway']]['name'] = pay($value['payid'],'payname');
    		}
    		$json = json_encode($json);
    	}
    	echo $json;
    }
    
}