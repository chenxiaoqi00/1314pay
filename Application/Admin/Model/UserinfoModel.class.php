<?php
// +----------------------------------------------------------------------
// | hicms | 商户MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 
// +----------------------------------------------------------------------
// | Author: huangchenjie
// +----------------------------------------------------------------------
namespace Admin\Model;
use Think\Model;
use Libs\Verify; //验证类库
class UserinfoModel extends Model{
   
    /* 自动验证规则 */
    protected $_validate = array(
//用户名、手机或邮箱不能全为空
        //array('realname','checkUser','用户名、手机或邮箱必须填写一个',self::MUST_VALIDATE,'callback',self::MODEL_BOTH),
        //用户名长度不合法
        array('realname', 'checkDenyMember', '用户名禁止注册', self::VALUE_VALIDATE, 'callback'), //用户名被占用
        
    );

    // 自动完成
    protected $_auto = array(
        
    );
    
    // +----------------------------------------------------------------------
    // | 用户数据调用
    // +----------------------------------------------------------------------

    /**
     * 新增或更新新闻资讯
     * @param array  $data 手动传入的数据
     * @return boolean fasle 失败 ， int  成功 返回完整的数据
     */
    public function update($data = null){
        /* 获取数据对象 */
        $data = $this->token(false)->create($data);
       
        if(empty($data)){
            return false;
        }
        dump($data);
        /* 添加或更新 */
        if(empty($data['id'])){ //新增数据
           return false;
        } else { //更新数据
            $status = $this->save($data);
           
            if(false === $status){
                return false;
            }
        }
        return true;
    }


// +----------------------------------------------------------------------
    // | 自动验证
    // +----------------------------------------------------------------------
    // 多字段验证 参数为数组
    // 检测注册用户选项：用户名|手机|邮箱必须填写一个选项


    /**
     * 禁止注册用户名
     * @param  string  $field  用户名
     * @return integer 错误编号
     */
    public function checkDenyMember($username){
        return !in_array($username, explode('|',C('DENY_MEMBER'))) ?true:false;
    }


    // +----------------------------------------------------------------------
    // | 自动完成
    // +----------------------------------------------------------------------
   
    // +----------------------------------------------------------------------
    // | 模型通用操作
    // +----------------------------------------------------------------------
    /**
     * [快捷编辑对应模型操作]
     * 进行缓存及各种模型信息的处理
     * @author LaoHe
     * @DateTime 2017-05-27
     * @param    integer   $id
     * @return   boolean
     */
    public function quick($id){
        if($id == 1){
            $this->error = '不允许对超级管理员执行该操作!';
            return false;
        }
        return true;
    }



}