<?php
// +----------------------------------------------------------------------
// | hicms | 点击数
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Api\Controller;
class ViewsController extends HibaseController {
    //获取点击数
    public function index() {
        //内容ID
        $id = I('get.id/d');
        //模型ID
        $modelid = I('get.modelid/d');
        $modelname = I('get.modelname/s');
        if(empty($modelid) || empty($modelname)) {
            exit;
        }
        $map = array();
        $map['contentid'] = $contentid;
        if ($modelid > 0) {
            $map['modelid'] = $modelid;
        }else{
            $map['modelname'] = $modelname;
        }
        $res = M('Views')->where($map)->field('contentid,views,yesterdayviews,dayviews,monthviews,weekviews,updatetime')->find();
        if (empty($res)) {
            exit;
        }
        $res['modelid'] = $modelid;
        $res['modelname'] = $modelname;
        //增加点击数
        $this->views($res);
        echo json_encode($res);
    }

    /**
     * 增加点击数
     * @param array $rs 点击相关数据
     * @return boolean
     */
    private function views($rs) {
        if (empty($rs)) {
            return false;
        }
        //当前时间
        $time = time();
        //总点击+1
        $views = $rs['views'] + 1;
        //昨日
        $yesterdayviews = (date('Ymd', $rs['updatetime']) == date('Ymd', strtotime('-1 day'))) ? $rs['dayviews'] : $rs['yesterdayviews'];
        //今日点击
        $dayviews = (date('Ymd', $rs['updatetime']) == date('Ymd', $time)) ? ($rs['dayviews'] + 1) : 1;
        //本周点击
        $weekviews = (date('YW', $rs['updatetime']) == date('YW', $time)) ? ($rs['weekviews'] + 1) : 1;
        //本月点击
        $monthviews = (date('Ym', $rs['updatetime']) == date('Ym', $time)) ? ($rs['monthviews'] + 1) : 1;
        $data = array(
            'views' => $views,
            'yesterdayviews' => $yesterdayviews,
            'dayviews' => $dayviews,
            'weekviews' => $weekviews,
            'monthviews' => $monthviews,
            'updatetime' => $time
        );
        $map = array();
        $map['contentid'] = $contentid;
        if ($res['modelid'] > 0) {
            $map['modelid'] = $res['modelid'];
        }else{
            $map['modelname'] = $res['modelname'];
        }
        $status = M('Views')->where($map)->save($data);
        return false !== $status ? true : false;
    }

}
