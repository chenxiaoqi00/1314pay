<?php
// +----------------------------------------------------------------------
// | hicms | 模块MODEL类
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------

namespace Admin\Model;
use Think\Model;
/**
 * 模型
 */
class ModelModel extends Model {
    protected $_validate = array(
        array('title', 'require', '模型名称必须填写', self::MUST_VALIDATE , 'regex', self::MODEL_BOTH),
        array('title','','模型名称已经存在', self::MUST_VALIDATE,'unique', self::MODEL_BOTH),
        array('tablename', 'require', '模型数据表必须填写', self::VALUE_VALIDATE , 'regex', self::MODEL_BOTH),
        array('tablename','','模型数据表已经存在', self::MUST_VALIDATE,'unique', self::MODEL_BOTH),
        array('type', 'require', '模型分类有误', self::MUST_VALIDATE , 'regex', self::MODEL_BOTH),
    );

    protected $_auto = array(
        array('status', '1', self::MODEL_INSERT),
        array('inputtime', NOW_TIME, self::MODEL_BOTH),
        array('updatetime', NOW_TIME, self::MODEL_BOTH),
        array('name', 'getTable', self::MODEL_BOTH, 'callback'),
    );

    /**
     * 获取表名
     * @return string 表名
     */
    protected function getTable(){
        if(I('post.table')){
            $tablename = I('post.table');
            $tablename = substr($tablename, strlen(C('DB_PREFIX')));
        }else{
            $tablename = I('post.tablename');
        }
        $tablename = str2arr($tablename, '_');
        foreach ($tablename as $key) {
            $table .= ucfirst($key);
        }
        return $table;
    }

    /**
     * [getModel 获取模型]
     * @author LaoHe
     * @DateTime 2017-04-21
     * @param    integer    $type [模型类型]
     * @return   array
     */
    public function models($type = 1){
        return $this->where(array('type'=>$type))->getField('id,title');
    }

    /**
     * 获取指定数据库的所有数据表
     */
    public function getTables(){
        return $this->db->getTables();
    }

    /**
     * 根据数据表生成模型及其属性数据
     */
    public function build(){
        $table = I('table/s');
        $title = I('title/s');
        $type  = I('type/d');
        //新增模型数据
        $tablename = substr($table, strlen(C('DB_PREFIX')));
        $modeldata = array('tablename'=>$tablename, 'title'=>$title, 'type'=>$type);
        $modeldata = $this->token(false)->create($modeldata);
        //dump($data);
        if($modeldata){
            $res = $this->add($modeldata);
            if(!$res){
                return false;
            }
        }else{
            $this->error = $this->getError();
            return false;
        }

        //新增属性
        $fields = M()->query('SHOW FULL COLUMNS FROM '.$table);
        foreach ($fields as $key=>$value){
            $value  =   array_change_key_case($value);
            //不新增id字段
            if(strcmp($value['field'], 'id') == 0){
                continue;
            }
            //生成属性数据
            $data = array();
            $data['name'] = $value['field'];
            $data['title'] = $value['comment'];
            $data['type'] = 'string';   //TODO:根据字段定义生成合适的数据类型
            //获取字段定义
            $is_null = strcmp($value['null'], 'NO') == 0 ? ' NOT NULL ' : ' NULL ';
            $data['field'] = $value['type'].$is_null;
            $data['value'] = $value['default'] == null ? '' : $value['default'];
            $data['modelid'] = $res;
            $_POST = $data;     //便于自动验证

            D('ModelField')->update($data, false);
        }
        return $res;
    }

    // +----------------------------------------------------------------------
    // | 模型通用操作
    // +----------------------------------------------------------------------
    /**
     * [快捷编辑对应模型操作]
     * 进行缓存及各种模型相关动作的处理
     * @author LaoHe
     * @DateTime 2017-05-27
     * @param    integer   $id
     * @return   boolean
     */
    public function quick($id){
        return true;
    }

}
