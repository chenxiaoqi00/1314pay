<?php
// +----------------------------------------------------------------------
// | hicms | 商户管理
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenj 
// +----------------------------------------------------------------------
namespace Admin\Controller;
class NewsController extends AdminController {
    
    /* 站点公告*/
	public function notice() {
	    $catid = 1;
		$list = $this->article($catid);
		foreach ($list as $key => $value) {
			$list[$key]['is_state_text'] = $this->get_status($value['is_state']);
		}
		// 记录当前列表页的cookie
		Cookie('__forward__',$_SERVER['REQUEST_URI']);
		$this->assign('catid', $catid);
		$this->assign('list', $list);
		$this->assign('title',$title?$title:'关于我们');
		$this->assign('meta_title', $catid ? '关于我们 - '.category($catid, 'title') : '站点公告');
		$this->display("index");
	}
	
	/* 商家百科*/
	public function knowledge() {
	    $catid = 3;
	    $list = $this->article($catid);
	    foreach ($list as $key => $value) {
	        $list[$key]['is_state_text'] = $this->get_status($value['is_state']);
	    }
	    // 记录当前列表页的cookie
	    Cookie('__forward__',$_SERVER['REQUEST_URI']);
	    $this->assign('catid', $catid);
	    $this->assign('list', $list);
	    $this->assign('title',$title?$title:'关于我们');
	    $this->assign('meta_title', $catid ? '关于我们 - '.category($catid, 'title') : '商家百科');
	    $this->display("index");
	}
	
	/* 业务相关*/
	public function aboutUs() {
	    $catid = 10;
	    $list = $this->article($catid);
	    foreach ($list as $key => $value) {
	        $list[$key]['is_state_text'] = $this->get_status($value['is_state']);
	    }
	    // 记录当前列表页的cookie
	    Cookie('__forward__',$_SERVER['REQUEST_URI']);
	    $this->assign('catid', $catid);
	    $this->assign('list', $list);
	    $this->assign('title',$title?$title:'关于我们');
	    $this->assign('meta_title', $catid ? '关于我们 - '.category($catid, 'title') : '业务相关');
	    $this->display("index");
	}
	
	/* 帮助中心*/
	public function help() {
	    $catid = 11;
	    $list = $this->article($catid);
	    foreach ($list as $key => $value) {
	        $list[$key]['is_state_text'] = $this->get_status($value['is_state']);
	    }
	    // 记录当前列表页的cookie
	    Cookie('__forward__',$_SERVER['REQUEST_URI']);
	    $this->assign('catid', $catid);
	    $this->assign('list', $list);
	    $this->assign('title',$title?$title:'关于我们');
	    $this->assign('meta_title', $catid ? '关于我们 - '.category($catid, 'title') : '帮助中心');
	    $this->display("index");
	}
	
	/*文章列表*/
	public function article($catid = null){
		        $title= trim(I('get.title/s'));
        $map = array();
        // 状态
        if(isset($_GET['status'])){
            $map['status'] = I('status');
            $status = $map['status'];
        }else{
            $status = null;
            $map['status'] = array('in', '0,1,2');
        }
        // 栏目ID
        if($catid){
            $map['catid'] = $catid;
        }
        // 关键词
        if(isset($title)){
            $map['title'] = array('like', '%'.(string)$title.'%');
        }
        // 开始时间
        if ( isset($_GET['start_date']) ) {
            $map['inputtime'][] = array('egt',strtotime(I('start_date')));
        }
        // 结束时间
        if ( isset($_GET['end_date']) ) {
            $map['inputtime'][] = array('elt',24*60*60 + strtotime(I('end_date')));
        }
        // 用户名|手机|邮箱
        if ( isset($_GET['username']) ) {
            $verify = new \Libs\Verify();
            if($verify::isMobile(I('username'))){
                $map['uid'] = M('Member')->where(array('mobile'=>I('username')))->getField('id');
            }else if($verify::isEmail(I('username'))){
                $map['uid'] = M('Member')->where(array('email'=>I('email')))->getField('id');
            }else{
                $map['uid'] = M('Member')->where(array('username'=>I('username/s')))->getField('id');
            }
        }
        $list = $this->lists('Article', $map, 'status desc, sort desc, id desc', 'id,title,catid,inputtime,thumb,ispos,status,sort,uid');
		
		return $list;
	}
	
	private function get_status($status) {
	    $text = '';
	    switch ($status) {
	        case 1:
	            $text = '<font color="green">已审核</font>';
	            break;
	        case 2:
	            $text = '<font color="red">未审核</font>';
	            break;
	        case 0:
	            $text = '<font color="grey">已冻结</font>';
	            break;
	        default:
	            $text = '<font color="green">已审核</font>';
	            break;
	    }
	
	    return $text;
	}
	
	
	/*添加*/
	public function add(){
	    if(IS_POST){
	        $done = D('Article')->update();
	        if(!$done){
	            $this->error(D('Article')->getError());
	        }else{
	            $this->success('文章'.I('post.title').'发布成功', Cookie('__forward__'));
	        }
	    }else{
	        $info['catid'] = I("get.catid");
	        $this->assign('info', $info);
	        $this->display('edit');
	    }
	}
	
	/*编辑*/
	public function edit($id){
	    if(IS_POST){
	        $done = D('Article')->update();
	        if(!$done){
	            $this->error(D('Article')->getError());
	        }else{
	            $this->success('文章'.I('post.title').'编辑成功', Cookie('__forward__'));
	        }
	    }else{
	        $id = (int)I('get.id');
	        if(empty($id)){
	            $this->error('参数有误！');
	        }
	        $info = D('Article')->field(true)->relation(true)->find($id);
	        if(!(is_array($info) || 1 !== $info['status'])){
	            $this->error = '文章被禁用或已删除！';
	        }
	        $this->assign('info',$info);
	        //获取左边菜单
	        $this->display('edit');
	    }
	}

	// 检测标题是否存在
	public function unique($title){
	    if(empty($title)){
	        $this->error('请输入标题');
	    }
	    $do = D('Article')->where("title = '%s'", $title)->find();
	    if($do){
	        $this->error('标题已存在');
	    }else{
	        $this->success('标题可使用');
	    }
	}
	
	// 检测标题是否存在
	public function del(){
	    
	   $this->delete($model="Article");
	}
}
