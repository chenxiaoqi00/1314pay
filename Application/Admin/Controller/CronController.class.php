<?php
// +----------------------------------------------------------------------
// | hicms | 文章资讯控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class CronController extends AdminController {
	public function index(){
        $list = D('Cron')->select();
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        $this->assign('list', $list);
        //模板赋值
        $this->assign('Intervals',array(60=>'1分钟', 300=>'5分钟', 1800=>'30分钟', 3600=>'1小时', 39600=>'12小时',  86400=>'1天', 604800=>'7天', 1296000=>'15天', 2592000=>'30天'));
        $this->meta_title = '定时任务';
        $this->display();
    }

    /**
     * 新增定时任务
     */
    public function add(){
        if(IS_POST){
            $model = D('Cron');
            $data = $model->create ();
            if($data){
                $id = $model->add();
                if($id){
                    $this->success('添加定时任务成功', U('index'));
                } else {
                    $this->error('添加定时任务失败');
                }
            } else {
                $this->error($model->getError());
            }
        } else {
            //模板赋值
            $this->assign('Intervals',array(60=>'1分钟', 300=>'5分钟', 1800=>'30分钟', 3600=>'1小时', 39600=>'12小时',  86400=>'1天', 604800=>'7天', 1296000=>'15天', 2592000=>'30天'));
            $this->meta_title = '新增定时任务';
            $this->display('edit');
        }
    }

    /**
     * 编辑友情链接
     */
    public function edit($id = 0){
        $model = D('Cron');
        if(IS_POST){
            $data = $model->create();
            if($data){
                if($model->save()!== false){
                    $this->success('定时任务编辑成功', U('index'));
                } else {
                    $this->error('定时任务编辑失败');
                }

            } else {
                $this->error($model->getError());
            }
        } else {
            $info = array();
            /* 获取数据 */
            $info = $model->find($id);
            if(false === $info){
                $this->error('获取配置信息错误');
            }
            //模板赋值
            $this->assign('Intervals',array(60=>'1分钟', 300=>'5分钟', 1800=>'30分钟', 3600=>'1小时', 39600=>'12小时',  86400=>'1天', 604800=>'7天', 1296000=>'15天', 2592000=>'30天'));
            $this->assign('info', $info);
            $this->meta_title = '编辑定时任务';
            $this->display();
        }
    }


	// 生成
	public function build(){
		if (IS_POST) {
			$map = array();
			$map['status'] = array('eq',1);
			$data = M('Cron') -> where($map) -> order('sort desc') -> getField('cron,intervals,runtime,config', true);
			$crons = array();
			foreach ($data as $key => $value) {
				$crons[$key][0] = $value['cron'];
				$crons[$key][1] = $value['intervals'];
				$crons[$key][2] = $value['runtime'];
				$crons[$key][3] = json_decode($value['config'],true);
			}
			$str = "<?php";
			$str .= "\n\r//定时任务需要行为配置定时任务行为扩展";
			$str .= "\n\r//定时任务文件由系统自动生成.如非必要,请在后台修改并生成！";
			$str .= "\n\r//定时任务文件需对应网站目录/Application/Common/Cron/下的文件名称";
			$str .= "\n\rreturn ".var_export($crons,true).';';
			\Think\Storage::put(COMMON_PATH.'Conf/crons.php',$str);
			@unlink(RUNTIME_PATH.'~crons.php');
			$this -> success('定时任务生成成功');
		}
	}
}