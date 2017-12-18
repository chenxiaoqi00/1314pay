<?php
// +----------------------------------------------------------------------
// | hicms | 上传
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
/**
 * 文件控制器
 * 主要用于下载模型的文件上传和下载
 */
class UploadController extends AdminController {

    /* 文件上传 */
    public function file(){
		$return  = array('status' => 1, 'info' => '上传成功', 'data' => '');
		/* 调用文件上传组件上传文件 */
		$File = D('File');
		$file_driver = C('DOWNLOAD_UPLOAD_DRIVER');
		$info = $File->upload(
			$_FILES,
			C('DOWNLOAD_UPLOAD'),
			C('DOWNLOAD_UPLOAD_DRIVER'),
			C("UPLOAD_{$file_driver}_CONFIG")
		);

        /* 记录附件信息 */
        if($info){
            $return['data'] = think_encrypt(json_encode($info['download']));
            $return['info'] = $info['download']['name'];
        } else {
            $return['status'] = 0;
            $return['info']   = $File->getError();
        }

        /* 返回JSON数据 */
        $this->ajaxReturn($return);
    }

    /* 下载文件 */
    public function download($id = null){
        if(empty($id) || !is_numeric($id)){
            $this->error('参数错误！');
        }

        $logic = D('Download', 'Logic');
        if(!$logic->download($id)){
            $this->error($logic->getError());
        }

    }

    /**
     * 上传图片
     */
    public function picture(){
        /* 返回标准数据 */
        $return  = array('status' => 1, 'info' => '上传成功', 'data' => '');
        /* 调用文件上传组件上传文件 */
        $Picture = D('Picture');
        $pic_driver = C('PICTURE_UPLOAD_DRIVER');
        $info = $Picture->upload(
            $_FILES,
            C('PICTURE_UPLOAD'),
            C('PICTURE_UPLOAD_DRIVER'),
            C("UPLOAD_{$pic_driver}_CONFIG")
        ); //TODO:上传到远程服务器

        if($info){
            $return['status'] = 1;
            $return = array_merge($info['download'], $return);
        } else {
            $return['status'] = 0;
            $return['info']   = $Picture->getError();
        }

        /* 返回JSON数据 */
        $this->ajaxReturn($return);
    }

    /**
     * 百度上传 webUploader 上传图片
     */
    public function webUploader(){
        /* 返回标准数据 */
        $return  = array('status' => 1, 'info' => '上传成功', 'data' => '');
        /* 调用文件上传组件上传文件 */
        $Attachment = D('Attachment');
        $pic_driver = C('UPLOAD_DRIVER');
        $info = $Attachment->upload(
            $_FILES,
            C('PICTURE_UPLOAD'),
            C('UPLOAD_DRIVER'),
            C("UPLOAD_{$pic_driver}_CONFIG")
        ); //TODO:上传到远程服务器
        /* 记录图片信息 */
        if($info){
            // 生成缩略图
            foreach ($info as $file) {
                $fullpath = './'.$file['path']; //当前路径
                // 获取原图地址
                $image = new \Think\Image();            // GD库
                $image->open($fullpath);                // 打开原图
                $thumbs = C('IMAGE_THUMB');
                //$dir = basename($fullpath, $file['ext']);
                // 设置缩略图宽、高、前缀
                $thumb = array(
                    1 => array('w' => $thumbs['L_WIDTH'], 'h' => $thumbs['L_HEIGHT']),
                    2 => array('w' => $thumbs['M_WIDTH'], 'h' => $thumbs['M_HEIGHT']),
                    3 => array('w' => $thumbs['S_WIDTH'], 'h' => $thumbs['S_HEIGHT']),
                );
                foreach ($thumb as $value){
                    // 生成缩略图保存路径,并命名
                    $save_path = dirname($fullpath).'/'.basename($fullpath, '.'.$file['ext']).'_'.$value["w"].'_'.$value["h"].'.'.$file['ext'];
                    // 设置宽高和缩略类型,并保存缩略图
                    $image->thumb($value['w'], $value['h'], \Think\Image::IMAGE_THUMB_SCALE)->save($save_path);
                }
            }
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
        $Avatar = D('Avatar');
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

    /**
     * 上传图片
     */
    /*public function editor(){
        session('upload_error', null);
        // 上传配置
        $setting = C('EDITOR_UPLOAD');

        // 调用文件上传组件上传文件
        $this->uploader = new \Think\Upload($setting, 'Local');
        $info   = $this->uploader->upload($_FILES);
        if($info){
            $url = C('EDITOR_UPLOAD.rootPath').$info['imgFile']['savepath'].$info['imgFile']['savename'];
            $url = str_replace('./', '/', $url);
            $info['fullpath'] = __ROOT__.$url;
        }
        session('upload_error', $this->uploader->getError());
        $return = array();
        $return['url'] = $info['fullpath'];
        $title = htmlspecialchars($_POST['pictitle'], ENT_QUOTES);
        $return['title'] = $title;
        $return['original'] = $info['imgFile']['name'];
        $return['state'] = ($info)? 'SUCCESS' : session('upload_error');
        // 返回JSON数据
        $this->ajaxReturn($return);
    }*/

    public function ueditor(){
        $data = new \Libs\Ueditor();
        echo $data->output();
    }

}
