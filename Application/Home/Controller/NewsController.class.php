<?php
namespace Home\Controller;

class NewsController extends HomeController {
    public function aboutUs(){
    
        $this->display("index");
    }
    
    /* 站点公告*/
    public function notice() {
        $catid = 1;
        $list = $this->article($catid);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        if($list){
            foreach($list as $k=>$v){
                $content .= "<p class='notice'><a href='/news/detail/id/".$v['id']."'><font color='".$v['style']."'>".$v['title']."</font></a></p>";
            }
        }else{
            $content = '<td colspan="10" class="text-center"> aOh! 暂时还没有内容! </td>';
        }
        $this->assign('content', $content);
        $this->assign('meta_title',"站点公告");
        $this->display("index");
    }
    
    /* 帮助中心*/
    public function help() {
        $catid = 11;
        $list = $this->article($catid);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        if($list){
            foreach($list as $k=>$v){
                $content .= "<p class='help' data-toggle='modal' data-target='#demoModal' style='cursor:pointer' id=".$v['id']."><font color='".$v['style']."'>".$v['title']."</font></p>";
            }
        }else{
            $content = '<td colspan="10" class="text-center"> aOh! 暂时还没有内容! </td>';
        }
        $this->assign('content', $content);
        $this->assign('meta_title',"帮助中心");
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
        $list = $this->lists('Article', $map, 'status desc, sort desc, id desc', 'id,title,catid,style,inputtime,thumb,ispos,status,sort,uid');
    
        return $list;
    }
    
        /*文章详情*/
        public function detail(){
           $pid = I("get.id");
           $content =  M("ArticleData")->where(array("id"=>$pid))->field("content")->find();
           $this->assign("content",$content["content"]);
        switch($pid)
            {
            case 209:
                 $this->assign('meta_title',"关于我们");
            break;
            case 204:
                $this->assign('meta_title',"联系我们");
            break;
            case 205:
                $this->assign('meta_title',"企业资质");
            break;
            case 206:
                $this->assign('meta_title',"使用条款");
            break;
            case 207:
                $this->assign('meta_title',"免责申明");
            break;
            case 208:
                $this->assign('meta_title',"购买帮助");
            break;
            default:
                $this->assign('meta_title',"站点公告");
            
            }
            
           $this->display("index");
        }
    
    /*文章列表*/
    public function ajaxDetail(){
       $pid = I("get.id");
       $_content =  M("ArticleData")->where(array("id"=>$pid))->field("content")->find();
       $content =  $_content?$_content:"";
       $this->ajaxReturn($content);
    }
}