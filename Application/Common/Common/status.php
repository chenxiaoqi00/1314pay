<?php
// +----------------------------------------------------------------------
// | 后台公共函数库 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
/**
 * 获取对应状态的文字信息
 * @param int $status
 * @return string 状态文字 ，false 未获取到
 */
function show_status($status = null){
    if(!isset($status)){
        return false;
    }
    switch ($status){
        case -1 : return '删除'; break;
        case 0  : return '禁用'; break;
        case 1  : return '启用'; break;
        case 2  : return '审核'; break;
        default : return false;  break;
    }
}

/**
 * 获取对应状态的图标信息
 * @param int $status
 * @return string 状态文字 ，false 未获取到
 */
function show_status_icon($status = null){
    if(!isset($status)){
        return false;
    }
    switch ($status){
        case -1  : return '<span class="label">删除</span>'; break;
        case 0  : return '<span class="label label-danger">禁用</span>'; break;
        case 1  : return '<span class="label label-primary">正常</span>'; break;
        case 2  : return '<span class="label label-warning">审核</span>'; break;
        default : return false; break;
    }
}

/**
 * 获取对应状态的图标信息
 * @param int $status
 * @return string 状态文字 ，false 未获取到
 */
function show_status_complain($status = null){
    if(!isset($status)){
        return false;
    }
    switch ($status){
        case 1  : return '<span class="label label-danger">未读</span>'; break;
        case 0  : return '<span class="label label-primary">已读</span>'; break;
        default : return false; break;
    }
}


/**
 * 获取对应登陆状态信息
 * @param int $status
 * @return string 状态文字 ，false 未获取到
 */
function show_status_login($status = null){
    if(!isset($status)){
        return false;
    }
    switch ($status){
        case 0  : return '<span class="label label-danger">登陆失败</span>'; break;
        case 1  : return '<span class="label label-primary">登陆成功</span>'; break;
    }
}

/**
 * 获取对应登陆状态信息
 * @param int $status
 * @return string 状态文字 ，false 未获取到
 */
function show_status_op($status = null){
    if(!isset($status)){
        return false;
    }
    switch ($status){
        case 0  : return '<span class="label label-danger">操作失败</span>'; break;
        case 1  : return '<span class="label label-primary">操作成功</span>'; break;
    }
}

function show_position_model($modelid = 0){
    $arr = array_filter(explode(",", $modelid));
    if (!empty($arr)){
        $map['id'] = array('in',$arr);
        $list = M('Model')->where($map)->select();
        if ($list){
            foreach ($list as $v){
                $str .= ($str==null?$v['title']:','.$v['title']);
            }
        }
        return $str;
    }else{
        return '无限制';
    }
}

/**
 * 获取对应状态的图标信息
 * @param int $status
 * @return string 状态文字 ，false 未获取到
 */
function show_status_goods($status = null){
	if(!isset($status)){
		return false;
	}
	switch ($status){
		case -1  : return '<span class="label">删除</span>'; break;
		case 0  : return '<span class="label label-danger">已下架</span>'; break;
		case 1  : return '<span class="label label-primary">售卖中</span>'; break;
		case 2  : return '<span class="label label-warning">待审核</span>'; break;
		default : return false; break;
	}
}

/**
 * 获取对应状态的图标信息
 * @param int $status
 * @return string 状态文字 ，false 未获取到
 */
function show_status_card($status = null){
	if(!isset($status)){
		return false;
	}
	switch ($status){
		case 1  : return '<span class="label label-danger">已出售</span>'; break;
		case 0  : return '<span class="label label-primary">售卖中</span>'; break;
		default : return false; break;
	}
}

/**
 * 优惠券
 * @param int $status
 * @return string 状态文字 ，false 未获取到
 */
function show_status_coupon($status = null,$deadline){
    if(!isset($status)){
        return false;
    }
    if($status == 1){
        return '<span class="label label-warning">已使用</span>';
    }else if($status == 0){
        if($deadline>=time()){
            return '<span class="label label-primary">未使用</span>';
        }else{
            return '<span class="label label-danger">已过期</span>';
        }
    }
}

/**
 * 结算
 * @param int $status
 * @return string 状态文字 ，false 未获取到
 */
function show_account_card($status = null){
	if(!isset($status)){
		return false;
	}
	switch ($status){
		case 1  : return '<span class="label label-primary">已结算</span>'; break;
		case 0  : return '<span class="label label-danger">未结算</span>'; break;
		default : return false; break;
	}
}