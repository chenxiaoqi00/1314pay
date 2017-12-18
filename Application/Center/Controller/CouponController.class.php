<?php
// +----------------------------------------------------------------------
// | hicms | 个人中心首页
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Center\Controller;
use Think\Controller;
class CouponController extends CenterBaseController {
    public function index(){
        $map['userid'] = UID;
		// 分类
		$cateid = I('get.cateid');
		if ($cateid !== ''){
			$map['cateid'] = $cateid;
		}
		
		$is_state = I('get.is_state');
		if ($is_state !== ''){
		    if($is_state == "2" ){
		        $map['deadline'] = array("LT",time());
		        $map['is_state'] = 0;
		    }else{
		        $map['deadline'] = array("EGT",time());
		        $map['is_state'] = $is_state;
		    }
		    
		}
// 		dump($map);
		$list = $this->lists('goodcoupon',$map,'id desc');
        $cate = M("goodlist")->where(array("userid"=> UID))->field("goodname,id")->select();
//         array_push($cate,array("id"=>"0","goodname"=>"全部"));
//         dump(array_merge(array("id"=>"0","goodname"=>"全部"),$cate));
        array_unshift($cate,array("id"=>"0","goodname"=>"全部"));
        $this->assign('cate',$cate);
		$this->assign('list',$list);
		$this->display();
    }
    
    public function add(){
        if(IS_POST){
            $quantity = (int)I("post.quantity");
            if($quantity>200){
                $this->error("一次性添加数量需少于200张!");
            }
            $data['coupon'] = I("post.coupon");
            $data['ctype'] = I("post.ctype");
            $data['cateid'] = I("post.cateid");
            $data['remark'] = I("post.remark");
            $data['valid'] = I("post.valid");
            $data['addtime']=date('Y-m-d H:i:s');
            $data['userid']=UID;
            //$data['deadline']= $data['addtime']+ $data['ctype']*24*60*60;
            $data["id"] = I("post.id");
            if(empty($data["id"])){
                $_data = array();
                for($i=1;$i<=$quantity;$i++){
                	$data['couponcode']=getRandomString(16);
                    $_data[] = $data;
                }
                $is_add =  M("goodcoupon")->addAll($_data);
            }else{
                $is_add->save($data);
            }
            if($is_add){
                $this->success("添加成功!",U("index"));
            }else{
                $this->error("添加失败!");
            }
        }else{
            $goodlist = M("goodcate")->where(array("userid"=>UID,"is_state"=>0))->field("id,catename")->select();
            array_unshift($goodlist,array("id"=>"0","catename"=>"全部"));
            $this->assign("goodlist",$goodlist);
            $this->display("edit");
        }
       
    }
    
    //编辑
    public function edit(){
        if(IS_AJAX){
            $id = I("get.id");
            $goodcoupon = M("goodcoupon")->where(array("id"=>$id))->find();
             $goodlist = M("goodcate")->where(array("userid"=>UID,"is_state"=>0))->field("id,catename")->select();
            array_unshift($goodlist,array("id"=>"0","catename"=>"全部"));
            $goodcoupon['goodlist'] = $goodlist;
            $goodcoupon['title'] = "编辑优惠券";
            $this->ajaxReturn($goodcoupon);
        }else{
            $this->assign("title","编辑优惠券");
            $this->display("edit");
        }
    }

    // 删除
    public function del() {
        $this->delete("goodcoupon");
    }
}
