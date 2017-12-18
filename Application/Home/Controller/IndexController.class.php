<?php
namespace Home\Controller;

class IndexController extends HomeController {
    
    public function index(){
    	$notice = M('article')->where(array("catid"=>1,"status"=>1))->order("id desc")->limit(5)->field("id,inputtime,updatetime,title")->select();
    	foreach ($notice as $k=>$v){
    	    $notice[$k]['url']="/news/detail/id/".$v['id'];
    	}
    	$help = M('article')->where(array("catid"=>11,"status"=>1))->order("id desc")->limit(5)->field("id,inputtime,updatetime,title")->select();
    	$this->assign('notice',$notice);
    	$this->assign('help',$help);
    	$this->assign('meta_title',"首页");
    	if(check_wap()){
    	    $this->display("../App:index");
    	}else{
    	    $this->display();
    	}
       
    }
    
    public function aboutUs(){
        $this->assign('meta_title',"公司简介");
        $this->display();
    }
    
    public function qualificatio(){
        $this->assign('meta_title',"企业资质");
        $this->display();
    }
    
    public function connect(){
        $this->assign('meta_title',"联系我们");
        $this->display();
    }
    
    public function service(){
        $this->assign('meta_title',"服务项目");
        if(check_wap()){
            $this->display("../App:service");
        }else{
            $this->display();
        }
    }
   
    //根据路径生成二维码
    public function qrcode(){
        $save_path = isset($_GET['save_path'])?$_GET['save_path']:__ROOT__.'Uploads/qrcode/';  //图片存储的绝对路径
        $web_path = isset($_GET['save_path'])?$_GET['web_path']:'/Uploads/qrcode/';        //图片在网页上显示的路径
        $qr_data = 'http://www.1314fk.com/';
        $qr_level = isset($_GET['qr_level'])?$_GET['qr_level']:'H';
        $qr_size = isset($_GET['qr_size'])?$_GET['qr_size']:'8';
        $save_prefix = isset($_GET['save_prefix'])?$_GET['save_prefix']:'ZETA';
        if($filename = createQRcode($save_path,$qr_data,$qr_level,$qr_size,$save_prefix)){
            $pic = $web_path.$filename;
        }
        echo "<img src='".$pic."'>";
    }
}