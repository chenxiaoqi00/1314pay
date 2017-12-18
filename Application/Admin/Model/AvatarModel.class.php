<?php
// +----------------------------------------------------------------------
// | hicms | 图片附件MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------

namespace Admin\Model;
use Think\Model;
use Think\Upload;
class AvatarModel extends Model{
    /**
     * 自动完成
     * @var array
     */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
    );

    /**
     * 文件模型字段映射
     * @var array
     */
    protected $_map = array(
        'type' => 'mime',
    );

    /**
     * 检测当前上传的文件是否已经存在
     * @param  array   $file 文件上传数组
     * @return boolean       文件信息， false - 不存在该文件
     */
    public function isFile($file){
        if(empty($file['md5'])){
            throw new \Exception('缺少参数:md5');
        }
        /* 查找文件 */
		$map = array('md5' => $file['md5'],'sha1'=>$file['sha1'],);
        return $this->field(true)->where($map)->find();
    }

	/**
	 * 清除数据库存在但本地不存在的数据
	 * @param $data
	 */
	public function removeTrash($data){
		$this->where(array('id'=>$data['id'],))->delete();
	}

    /**
     * 头像上传
     * @param  array  $files   要上传的文件列表（通常是$_FILES数组）
     * @param  array  $setting 文件上传配置
     * @param  string $driver  上传驱动名称
     * @param  array  $config  上传驱动配置
     * @return array           文件上传成功后的信息
     */
    public function upload($files, $setting, $driver = 'Local', $config = null){
        // 头像上传配置
        $setting['callback'] = array($this, 'isFile');
        $setting['removeTrash'] = array($this, 'removeTrash');
        $Upload = new Upload($setting, $driver);
        $thumbList = array('__source', '__avatar1', '__avatar2', '__avatar3');
        $thumb = C('AVATAR_THUMB');
        array_unshift($thumb, UID);
        $savename = uniqid();
        $source_pic = $files['__source'];
        if($source_pic){
            $source_pic['name'] .= '.jpg';
            //设置保存文件名
            $Upload->saveName = $savename;
            //删除头像
            $this->delAvatar(UID);
            //上传头像
            $sourcefile = $Upload->uploadOne($source_pic);
            $data = $sourcefile;
            // 存储头像
            $data['path'] = substr($setting['rootPath'], 1).$data['savepath'].$data['savename'];
            $data['uid'] = UID;
            // 已经存在文件记录
            if(isset($data['id']) && is_numeric($data['id'])){
                continue;
            }
            // 已有头像更新,无头像新增
            $isexit = $this->where(array('uid'=>UID))->find();
            S('Avatar_'.UID, null);
            if($isexit){
                $this->where(array('uid'=>UID))->setField('path', $data['path']);

            }else{
                if($this->create($data) && ($id = $this->add())){
                    $data['id'] = $id;
                }
            }
            if ($sourcefile === false) {
                exit(json_encode(array(
                    'success' => false,
                    'msg' => $Upload->getError(),
                )));
                break;
            }
        }
        unset($files['__source']);
        // 上传
        foreach ($thumbList as $i => $key) {
            if (!isset($files[$key])) {
                continue;
            }
            $files[$key]['name'] .= '.jpg';
            //设置保存文件名
            $Upload->saveName = $savename.'_'.$thumb[$i].'x'.$thumb[$i];
            //上传头像
            $file = $Upload->uploadOne($files[$key]);
            if ($file === false) {
                exit(json_encode(array(
                    'success' => false,
                    'msg' => $Upload->getError(),
                )));
                break;
            }
        }
        exit(json_encode(array(
            'success' => true,
            'msg' => '上传成功！',
        )));
    }

    /*删除头像文件*/
    function delAvatar($uid){
        $path = C('AVATAR_SAVE_SUB') . $uid;
        del_dir_file($path, false);
    }
}