<?php
// +----------------------------------------------------------------------
// | hicms | 图片管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class AttachmentController extends AdminController {
    public function index(){
        // 附件导航配置
        $exts = array(
            'image'=>array(
                'title'=>'图片',
                'exts'=>'jpg,gif,bmp,jpeg,png'
            ),
            'file'=>array(
                'title'=>'附件',
                'exts'=>'doc,docx,xls,xlsx,pdf'
            ),
            'video'=>array(
                'title'=>'视频',
                'exts'=>'mp4,mov,avi'
            )
        );
        $title= trim(I('get.title/s'));
        $type = I('type/s') ? I('type/s') : 'image';
        $map = array();
        if(isset($title)){
            $map['title'] = array('like', '%'.(string)$title.'%');
        }
        $map['ext'] = array('in',$exts[$type]['exts']);
        $list = $this->lists('Attachment',$map);
        $this->assign('extsType', $exts);
        $this->assign('list', $list);
        $this->assign('title',$title?$title:'图片名称');
        $this->assign('type',$type);
        $this->display();
    }

}