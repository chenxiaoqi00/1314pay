<?php
namespace Home\Controller;

class ProductController extends HomeController {
	
    private $display = "index";
    
	public function _initialize(){
		parent::_initialize();
		$this->assign('chennal',channellist());
		// 蓝色页面支付方式
		$channel = M('Channellist')->where(array('is_state'=>1))->order('sort desc')->select();
		foreach ($channel as $key => $value) {
			if ($value['payid'] < 24) {
				$pay[$value['sort']] = array(
						'val' => $value['id'],
						'pic' => '/Public/statics/images/blue/'.pay($value['payid'],'imgurl'),
						'name' => $value['channelname'],
				);
			}else {
				switch ($value['payid']) {
					case 24:
						$pt[] = array(
							'data'=>'wangying',
							'name'=>'网银支付',
							'tab'=>'3',
						);
					break;
					case 25:
						$pt[] = array(
						'data'=>'zhifubao',
						'name'=>'支付宝支付',
						'tab'=>'2',
						);
					break;
					case 26:
						$pt[] = array(
						'data'=>'caifutong',
						'name'=>'财付通支付',
						'tab'=>'5',
						);
					break;
					case 27:
						$pt[] = array(
						'data'=>'wechat',
						'name'=>'微信支付',
						'tab'=>'1',
						);
					break;
					case 28:
						$pt[] = array(
						'data'=>'QQpay',
						'name'=>'QQ支付',
						'tab'=>'',
						);
					break;
				}
				
			}
			
		}
		$this->assign('ptp',$pt);
		$this->assign('pay',json_encode($pay));
		if(check_wap()){
		    $this->display = "phone";
		}else{
		    $this->display = "white"; //white
		}
	}
    //根据商品分类查询商品
    public function goodcate(){
    	if(!empty(I("get.linkid"))){
    	    $linkid = I("get.linkid/s");
    	    $list = D("Product")->goodcate($linkid);
    	    $goodcate = array();
    	    $goodlist = array();
    	    if($list){
    	        foreach($list as $k=>$v){
    	            $goodcate[$k]["catename"] = $v["catename"];
    	            $goodcate[$k]["linkid"] = $v["catelinkid"];
    	            $goodlist[$k]["goodname"] = $v["goodname"];
    	            $goodlist[$k]["linkid"] = $v["linkid"];
    	        }
    	        // 用户ID
    	        $userid = M('Goodcate')->where(array('linkid'=>$linkid))->field('userid,theme')->find();
    	        if (!check_wap()) {
    	        	// 页面选择
    	        	if (!empty($userid['theme'])) {
    	        		$this->display = $userid['theme'];
    	        	}else {
    	        		
            			$userid['theme'] = users($userid['userid'],'theme');
            			if ($userid['theme']) {
            				$this->display = $userid['theme'];
            			}
            		}
    	        }
    	        $this->productUsers($list[0],$userid['userid']);
      	        $this->assign('userid',$userid['userid']);
    	        $this->assign("goodcate",array_unique($goodcate));
    	        $this->assign("goodlist",$goodlist);
    	        $this->assign("goodcatesize",sizeof(array_unique($goodcate)));
    	        $this->assign("goodlistsize",2);
    	    }else{
    	        $this->error("已无库存，请联系卖家！");
    	    }
    	}else{
    	    $this->error("参数有误！");
    	}
        $this->display($this->display);
    }
    
    //查询商品及所属分类
    public function goodlist(){
        if(!empty(I("get.linkid"))){
            $linkid = I("get.linkid");
            $list = D("Product")->goodlist($linkid);
            
            // 用户ID
            $userid = M('Goodlist')->where(array('linkid'=>$linkid))->field('userid,theme,is_invent')->find();
        	// 显示页面判断
        	if (!check_wap()) {
    	        	// 页面选择
    	        	if ($userid['theme']) {
    	        		$this->display = $userid['theme'];
    	        	}else {
    	        	$userid['theme'] = users($userid['userid'],'theme');
            			if ($userid['theme']) {
            				$this->display = $userid['theme'];
            			}
            		}
    	        }
    	    if ($userid['is_invent']!=2) {
    	    	$userid['is_invent'] = users($userid['userid'],'is_invent');
    	    }    
            $this->assignGoodList($list,$userid['userid'],$userid['is_invent']);
            $this->assign('userid',$userid['userid']);
            $this->assign('is_invent',$userid['is_invent']);
        }else{
            $this->error("参数有误！");
        }
        $this->display($this->display);
    }
    
    public function assignGoodList($list,$userid,$is_invent){
        $goodcate = array();
        $goodlist = array();
        if($list){
            $inventory = sizeof($list);
            if ($is_invent == 2) {
            	if ($inventory < 20 && $inventory>0) {
            		$inventoryinfo = '少量';
            	}elseif( $inventory>20 && $inventory<50 ){
            		$inventoryinfo = '中等';
            	}elseif ($inventory>50){
            		$inventoryinfo = '充足';
            	}else {
            		$inventoryinfo = '缺货';
            	}
            	
            }else {
            	$inventoryinfo = $inventory;
            }
            $goodcate[0]["catename"]=$list[0]["catename"];
            $goodcate[0]["linkid"] = $list[0]["catelinkid"];
            $goodlist[0]["goodname"] = $list[0]["goodname"];
            $goodlist[0]["linkid"] = $list[0]["linkid"];
            $this->productUsers($list[0],$userid);
            $this->assign("inventoryinfo",$inventoryinfo);
            $this->assign("inventory",$inventory);
            $this->assign("unitPrice",$list[0]["price"]);
            $this->assign("goodcate",$goodcate);
            $this->assign("goodlist",$goodlist);
            $this->assign("goodcatesize",1);
            $this->assign("goodlistsize",1);
        }else{
            $this->error("已无库存，请联系卖家！");
        }
    }
    
    
    //店铺的支付页面
    public function store(){
        $linkid = I("get.linkid");
        if(!empty($linkid)){
            $list = D("Product")->store($linkid);
            $goodcate = array();
            $goodlist = array();
          
        	   // dump($list);
            if($list){
                $this->assign("goodcate",$list);
                $this->assign("goodcatesize",2);
                $this->assign("goodlistsize",2); //为了初始的时候列表框不为空
                // 用户ID
                $user = M('users')->where(array('userkey'=>$linkid))->field("id,theme,sitename,siteurl,qq")->find();
                $meta_title = $user['sitename']?$user['sitename']:"支付页";
                
            	if (!check_wap()) {
    	        	// 页面选择
    	        	if ($user['theme']) {
    	        		$this->display = $user['theme'];
    	        	}
    	        } 
                $this->assign("meta_title",$meta_title);
                $this->assign('userid',$user['id']);
                $this->assign('sitename',$user['sitename']);
                $this->assign('siteurl',$user['siteurl']);
                $this->assign('qq',$user['qq']);
            }else{
                $this->error("已无库存，请联系卖家！");
            }
        }else{
            $this->error("参数有误！");
        }
        $this->display($this->display);
    }
    

    //根据商品查询详细信息
    public function getgood(){
        $linkid = I("get.linkid");
        if($linkid){
            $list = D("Product")->getgood($linkid);
            $data['price'] = $list[0]['price'];
            if ($list[0]['is_invent'] != 2) {
            	$is_invent = users($list[0]['userid'],'is_invent');
            }else {
            	$is_invent = $list[0]['is_invent'];
            }
            $inventory = sizeof($list);
            if ($is_invent == 2) {
            	if ($inventory < 20 && $inventory>0) {
            		$inventoryinfo = '少量';
            	}elseif( $inventory>20 && $inventory<50 ){
            		$inventoryinfo = '中等';
            	}elseif ($inventory>50){
            		$inventoryinfo = '充足';
            	}else {
            		$inventoryinfo = '缺货';
            	}
            	 
            }else {
            	$inventoryinfo = $inventory;
            }
            $data['inventoryinfo'] = $inventoryinfo;
            $data['count'] = $inventory;
            $data['status'] = 1;
            $data['is_coupon'] = $list[0]['is_coupon'];
            $data['is_discount'] = $list[0]['is_discount'];
            $this->ajaxReturn($data);
        }else{
            $this->error("参数有误！");
        }
    }
    
    //根据分类查询对应商品
    public function getgoodlist(){
        $linkid = I("get.linkid");
        if($linkid){
            $list = D("Product")->getgoodlist($linkid);
            $data['data'] = $list;
            $data['status'] = 1;
            // dump($data);
            $this->ajaxReturn($data);
        }else{
            $this->error("参数有误！");
        }
    }
    
    //订单未支付，补交
    public function afterPayment(){
        if(!empty(I("get.orderid"))){
            $orderid = I("get.orderid");
            $orders = M("orders")->where(array("orderid"=>$orderid))->field("goodid,userid,price,quantity,channelid,contact,email")->find();
            $list = D("Product")->goodlistById($orders['goodid']);
            $this->assignGoodList($list,$orders['userid']);
            $this->assign("quantity",$orders['quantity']);
            $this->assign("contact",$orders['contact']);
            $this->assign("email",$orders['email']);
            $this->assign('userid',$orders['userid']);
            $this->assign('orderid',$orderid);
        }else{
            $this->error("参数有误！");
        }
        $this->display($this->display);
    
    }
    
   /*  获取商户的店铺名称、qq 、mate-title*/
    public function productUsers($cate,$uesrid){
        $user = users($uesrid);
        $sitename =$cate['sitename']?$cate['sitename']:$user['sitename'];
        $siteurl = $cate['siteurl']?$cate['siteurl']:$user['siteurl'];
        $qq = $cate['qq']?$cate['qq']:$user['qq'];
        $meta_title = $cate['catename']?$cate['catename']:"支付页";
        $this->assign("meta_title",$meta_title);
        $this->assign("sitename",$sitename);
        $this->assign("siteurl",$siteurl);
        $this->assign("qq",$qq);
    }
}
