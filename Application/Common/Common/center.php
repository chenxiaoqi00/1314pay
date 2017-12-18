<?php
// +----------------------------------------------------------------------
// | 会员中心相关函数 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------

function get_address_phone($id){
    $info = M('Address')->find($id);
    if($info){
        return $info['mobile'] ? $info['mobile'] : $info['phone'];
    }else{
        return '无';
    }
}

/**
 * @author: vfhky 20130304 20:10
 * @description: PHP调用百度短网址API接口
 *     * @param string $type: 非零整数代表长网址转短网址,0表示短网址转长网址
 */
function bdUrlAPI($type, $url){
    if($type)
        $baseurl = 'http://dwz.cn/create.php';
    else
        $baseurl = 'http://dwz.cn/query.php';
    $ch=curl_init();
    curl_setopt($ch,CURLOPT_URL,$baseurl);
    curl_setopt($ch,CURLOPT_POST,true);
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
    if($type)
        $data=array('url'=>$url);
    else
        $data=array('tinyurl'=>$url);
    curl_setopt($ch,CURLOPT_POSTFIELDS,$data);
    $strRes=curl_exec($ch);
    curl_close($ch);
    $arrResponse=json_decode($strRes,true);
    if($arrResponse['status']!=0)
    {
       
        echo 'ErrorCode: ['.$arrResponse['status'].'] ErrorMsg: ['.iconv('UTF-8','GBK',$arrResponse['err_msg'])."]<br/>";
        return 0;
    }
    if($type)
        return $arrResponse['tinyurl'];
    else
        return $arrResponse['longurl'];
}