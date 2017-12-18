<?php
// +----------------------------------------------------------------------
// | hicms | 上传
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
/**
 * 文件控制器
 * 主要用于下载模型的文件上传和下载
 */
class UploadController extends CenterBaseController {
    /**
     * 百度上传 webUploader 上传图片
     * 去除生成缩略图,调用时自动生成
     */
    public function webUploader(){
        /* 返回标准数据 */
        $return  = array('status' => 1, 'info' => '上传成功', 'data' => '');
        /* 调用文件上传组件上传文件 */
        $Attachment = D('Admin/Attachment');
        $pic_driver = C('UPLOAD_DRIVER');
        //会员上传目录
        $_SETTING = C('PICTURE_UPLOAD');
        $_SETTING['subName'] = UID.'/'.date('Y-m-d');
        //上传
        $info = $Attachment->upload(
            $_FILES,
            $_SETTING,
            C('UPLOAD_DRIVER'),
            C("UPLOAD_{$pic_driver}_CONFIG")
        ); //TODO:上传到远程服务器
        /* 记录图片信息 */
        if($info){
            //返回状态信息
            $return['status'] = 1;
            $return = $info['file'];
        } else {
            $return['status'] = 0;
            $return['info']   = $Attachment->getError();
        }
        /* 返回JSON数据 */
        $this->ajaxReturn($return);
    }

    /*AJAX获取百度上传图片*/
    public function getPicture(){
        $ids = array_unique((array)str2arr(I('ids')));
        $map['id'] = array('in',$ids);
        $list = D('Attachment')->field('id,name,path,mime,size')->where($map)->select();
        echo json_encode($list);
        //dump($list);
    }

    /**
     * 头像上传
     */
    public function avatar(){
        /* 返回标准数据 */
        $return  = array('status' => 1, 'info' => '上传成功', 'data' => '');
        //配置
        //$setting = C('PICTURE_UPLOAD');
        $setting['rootPath'] = C('AVATAR_SAVE_SUB'); //保存根路径
        $setting['saveExt'] = 'jpg'; //文件保存后缀，空则使用原后缀
        $setting['replace'] = true; //存在同名是否覆盖
        $setting['exts'] = C('UPLOAD_IMAGE_EXTS');
        $setting['maxSize'] = C('UPLOAD_PICTURE_MAXSIZE')*1024*1024;
        //会员上传目录
        $setting ['subName'] = UID;
        /* 调用文件上传组件上传文件 */
        $Avatar = D('Admin/Avatar');
        $info = $Avatar->upload($_FILES, $setting); //TODO:上传到远程服务器

        if($info){
            S('Avatar_'.UID, null);
            $return['status'] = 1;
            $return = array_merge($info['download'], $return);
        } else {
            $return['status'] = 0;
            $return['info']   = $Avatar->getError();
        }

        /* 返回JSON数据 */
        $this->ajaxReturn($return);
    }

    public function ueditor(){
        $data = new \Libs\Ueditor();
        echo $data->output();
    }
	
    /**
     * 上传文件
     * 去除生成缩略图,调用时自动生成
     */
    public function fileUploader(){
    	/* 返回标准数据 */
    	$return  = array('status' => 1, 'info' => '上传成功', 'data' => '');
    	/* 调用文件上传组件上传文件 */
    	$Attachment = D('Admin/Attachment');
    	$pic_driver = C('UPLOAD_DRIVER');
    	//会员上传目录
    	$_SETTING = C('FILE_UPLOAD');
    	$_SETTING['subName'] = UID.'/'.date('Y-m-d');
    	//上传
    	$info = $Attachment->upload(
    			$_FILES,
    			$_SETTING,
    			C('UPLOAD_DRIVER'),
    			C("UPLOAD_{$pic_driver}_CONFIG")
    	); //TODO:上传到远程服务器
    	/* 记录图片信息 */
    	if($info){
    		//返回状态信息
    		$return['status'] = 1;
    		$return = $info['file'];
    	} else {
    		$return['status'] = 0;
    		$return['info']   = $Attachment->getError();
    	}
    	/* 返回JSON数据 */
    	$this->ajaxReturn($return);
    }
    
}
