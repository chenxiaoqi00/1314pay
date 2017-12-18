<?php
namespace Home\Controller;

class ComplainController extends HomeController {
   
    //投诉页面
    public function index($userid){
       $userid=I("get.userid");
       $this->assign("userid",$userid);
       $content = $this->fetch("complain");
       $resoult=array("status"=>1,"data"=>$content);
       $this->ajaxReturn($resoult);
       
    }
    
    public function complaint(){
        $complainContent=I("POST.");
        $complainContent['is_state'] = 1;
        $complainContent['addtime'] = time();
        $resoult=M("complain")->add($complainContent);
        $resoult? $this->success("投诉成功！"):$this->error("投诉失败！");
//         $this->ajaxReturn($resoult);
    }
}