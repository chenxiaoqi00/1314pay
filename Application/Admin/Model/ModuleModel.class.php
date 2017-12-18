<?php
// +----------------------------------------------------------------------
// | hicms | 模块MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------

namespace Admin\Model;
use Think\Model;
/**
 * 导航模型
 */
class ModuleModel extends Model {
    protected $_validate = array(
        array('title', 'require', '模块名称不能为空', self::MUST_VALIDATE , 'regex', self::MODEL_BOTH),
        array('name', 'require', '模块标识不能为空', self::VALUE_VALIDATE , 'regex', self::MODEL_BOTH),
        array('html_cache_time','checkTime','静态缓存时间不能为空', self::EXISTS_VALIDATE, 'callback'),
        array('html_file_suffix','checkSuffix','静态缓存后缀不能为空', self::EXISTS_VALIDATE, 'callback'),
    );

    protected $_auto = array(
        array('status', '1', self::MODEL_INSERT),
        array('html_cache_on', 'getSwich', self::MODEL_BOTH, 'callback','html_cache_on'),
        array('url_router_on', 'getSwich', self::MODEL_BOTH, 'callback','url_router_on'),
        array('isauth', 'getSwich', self::MODEL_BOTH, 'callback','isauth'),
        //array('html_cache_time', 'getTime', self::MODEL_BOTH,'callback'),
    );

    /**
     * SWICH 开关值
     * @return 1:0
     */
    protected function getSwich($data,$field){
        $data == 'true' ? 1 : 0;
        return $data;
    }

    /*如果开启缓存，检测缓存时间*/
    public function checkTime(){
    	$ison = I('post.html_cache_on');
        $time = I('post.html_cache_time');
    	if($ison){
    		if(!$time){
                return false;
            }
    	}
    }

    /*如果开启缓存，检测缓存文件*/
    public function checkSuffix(){
        $ison = I('post.html_cache_on');
        $suffix = I('post.html_file_suffix');
        if($ison){
            if(!$suffix){
                return false;
            }
        }
    }

    /*如果开启缓存，生成缓存时间*/
    public function getTime(){
        $ison = I('post.html_cache_on');
        $time = I('post.html_cache_time');
        if($ison){
            return $time*60*60;
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
