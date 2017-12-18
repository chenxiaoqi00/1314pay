<?php
	/**
	 * [缩略图调用]
	 * +----------------------------------------------------------------------
	 * | thumb  {$vo['id']|thumb=''}
	 * +----------------------------------------------------------------------
	 * /
	 * @author LaoHe
	 * @DateTime 2017-03-30
	 * @param    integer    $id   [图片ID]
	 * @param    string     $size [图片尺寸   1:小图(small) 2:中图(middle) 3:大图(large)]
	 * @return   string 	图片路径 $v['thumb']|thumb=2
	 */
	function thumb($id = 1, $size = 2){
		$thumbs = C('IMAGE_THUMB');
	    // 设置缩略图宽、高
	    $thumb = array(
	        1 => array('w' => $thumbs['S_WIDTH'], 'h' => $thumbs['S_HEIGHT']),
	        2 => array('w' => $thumbs['M_WIDTH'], 'h' => $thumbs['M_HEIGHT']),
	        3 => array('w' => $thumbs['L_WIDTH'], 'h' => $thumbs['L_HEIGHT']),
	    );
		$file = D('Attachment')->cache('Attachment_'.$id)->where(array('status' => 1))->field('path,ext')->getById($id);
		if(!$size){
			$picture = $file['path'];
		}else{
			if($file){
				$picture = dirname($file['path']).'/'.basename($file['path'], '.'.$file['ext']).'_'.$thumb[$size]['w'].'_'.$thumb[$size]['h'].'.'.$file['ext'];
				// 如果文件不存在,重新生成缩略图
				if( !file_exists( SITE_PATH.$picture ) && file_exists( SITE_PATH.$file['path'] )){
					$fullpath = './'.$file['path'];
					$image = new \Think\Image();
		            $image->open($fullpath);
		            //保存路径
		            $save_path = dirname( $fullpath ).'/'.basename( $fullpath, '.'.$file['ext']).'_'.$thumb[$size]['w'].'_'.$thumb[$size]['h'].'.'.$file['ext'];
		            $image->thumb($thumb[$size]['w'], $thumb[$size]['h'], \Think\Image::IMAGE_THUMB_SCALE)->save($save_path);
		            $picture = $picture;
				}elseif (!file_exists( SITE_PATH.$picture ) && !file_exists( SITE_PATH.$file['path'] )){
					$picture = __ROOT__.'/Public/statics/images/nopic.gif';
				}
			}
		}
		return $picture ? $picture : __ROOT__.'/Public/statics/images/nopic.gif';
	}

	/**
	 * [原图]
	 * +----------------------------------------------------------------------
	 * | image  {$vo['id']|original=''}
	 * +----------------------------------------------------------------------
	 * @author LaoHe
	 * @DateTime 2017-03-30
	 * @param    integer    $id   [图片ID]
	 * @return   string 	图片路径 $v['thumb']|origin
	 */
	function getImage($id = 1){
		$picture = D('Attachment')->cache('Attachment_'.$id)->where(array('status' => 1))->field('path,ext')->find($id);
		return $picture ? $picture['path'] : __ROOT__.'/Public/statics/img/nopic.gif';
	}

	/**
	 * [获取头像]
	 * @author LaoHe
	 * @DateTime 2017-04-24
	 * @param    integer   $uid   用户ID
	 * @return   string    图片路径 $v['thumb']|origin
	 */
	function avatar($uid = 0, $size = 0){
		if(!isset($uid) || !is_numeric($uid)){
	        return '';
	    }
		$avatar = D('Avatar')->cache('Avatar_'.$uid)->where(array('status'=>1, 'uid'=>$uid))->field('path')->getField('path');
		if($size){
			$thumb = C('AVATAR_THUMB');
			$size = array_search($size, $thumb);
			if($avatar){
				$avatar = dirname($avatar).'/'.basename($avatar, '.jpg').'_'.$thumb[$size].'x'.$thumb[$size].'.jpg';
			}
		}
		return $avatar ? $avatar : __ROOT__.'/Public/Center/images/avatar.png';
	}

    /**
     * 保存到附件附属表
     * @param integer|array $attid 附件id
     * @param integer $attid 附件id
     * @param integer $modelid 模型id
     * @param string $modelname 模型名称(唯一标志符)
     * @return mixed
     */
    function addAttachment($aid, $contentid, $modelid, $modelname=null) {
        if (empty($aid) || empty($contentid)){
            return false;
        }
        if (empty($modelid) && $modelname == ''){
			return false;
		}
		$aid = explode(',', $aid);
        $aid = array_unique($aid);
        if (is_array($aid)) {
            $id_array = array_unique($aid);
        } else {
            $id_array = array($aid);
        }
        // 删除原关联附件
		$map['contentid'] = $contentid;
		if ($modelid > 0) {
			$map['modelid'] = $modelid;
		}else{
			$map['modelname'] = $modelname;
		}
		$where['aid'] = array('in', $id_array);
		$befind = M('AttachmentData')->where($map)->getField('aid', true);
		// 删除原有数据
		M('AttachmentData')->where($map)->delete();
		// 调用次数减一
		foreach ($befind as $key) {
			M('Attachment')->where(array('id'=>$key))->setDec('usetimes');
		}
		$time = NOW_TIME;
		// 添加关联附件
        foreach ($id_array as $v) {
			if ($modelid > 0) {
				$dataAtt[] = array('aid' => $v,'contentid' => $contentid, 'modelid' => $modelid, 'time'=>$time);
			} else {
				$dataAtt[] = array('aid' => $v,'contentid' => $contentid, 'modelname' => $modelname, 'time'=>$time);
			}
			if (M('Attachment')->where(array("id" => $v))->find()) {
                M('Attachment')->where(array("id" => $v))->setInc('usetimes');
            }
		}
        M('AttachmentData')->addAll($dataAtt);
        return true;
    }
    /**
     * [产品图调用]
     * +----------------------------------------------------------------------
     * | getPicture  {$vo['id']|getPicture=''}
     * +----------------------------------------------------------------------
     * /
     * @author LaoHe
     * @DateTime 2017-03-30
     * @param    string     $picture   [图片ID]
     * @param    integer    $num   [获取第几张图片]
     * @param    boolean    $isthumb [true:缩略图   false:原图]
     * @param    string     $size [图片尺寸   1:小图(small) 2:中图(middle) 3:大图(large)]
     * @return   string 	图片路径 $v['thumb']|thumb=2
     */
    function getPicture($picture,$num=0,$isthumb=true,$size=2){
    	$ids = str2arr($picture, ',');
    	$id = $ids[$num];
    	if ($isthumb) {
    		$pic = thumb($id,$size);
    	}else {
    		$pic = getImage($id);
    	}
    	return $pic;
    }