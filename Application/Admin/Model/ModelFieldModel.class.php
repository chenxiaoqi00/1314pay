<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: huajie <banhuajie@163.com>
// +----------------------------------------------------------------------

namespace Admin\Model;
use Think\Model;

/**
 * 属性模型
 * @author huajie <banhuajie@163.com>
 */

class ModelFieldModel extends Model {

    /* 自动验证规则 */
    protected $_validate = array(
        array('name', 'require', '字段名必须', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('name', '/^[a-zA-Z][\w_]{1,29}$/', '字段名不合法', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('name', 'checkName', '字段名已存在', self::MUST_VALIDATE, 'callback', self::MODEL_BOTH),
        array('field', 'require', '字段定义必须', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
        array('field', '1,100', '注释长度不能超过100个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
        array('title', '1,100', '注释长度不能超过100个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
        array('tips', '1,100', '备注不能超过100个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
        array('modelid', 'require', '未选择操作的模型', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('status', 1, self::MODEL_INSERT, 'string'),
        array('inputtime', 'time', self::MODEL_INSERT, 'function'),
        array('updatetime', 'time', self::MODEL_BOTH, 'function'),
        array('isposition', 'getSwitch', self::MODEL_BOTH, 'callback','isposition'),
        array('ismust', 'getSwitch', self::MODEL_BOTH, 'callback','ismust'),
        array('isshow', 'getSwitch', self::MODEL_BOTH, 'callback','isshow'),
    );

    /* 操作的表名 */
    protected $table_name = null;

    // +----------------------------------------------------------------------
    // | 自动完成相关
    // +----------------------------------------------------------------------
    /**
     * SWITCH 开关值
     * @return 1:0
     */
    protected function getSwitch($data,$field){
        $data == 'true' ? 1 : 0;
        return $data;
    }

    /**
     * 新增或更新一个属性
     * @return boolean fasle 失败 ， int  成功 返回完整的数据
     */
    public function update($data = null, $create = true){
        /* 获取数据对象 */
        $data = empty($data) ? $_POST : $data;
        $data = $this->create($data);
        if(empty($data)){
            return false;
        }
        /* 添加或新增属性 */
        if(empty($data['id'])){ //新增属性

            $id = $this->add();
            if(!$id){
                $this->error = '新增字段出错！';
                return false;
            }

            if($create){
                //新增表字段
                $res = $this->addField($data);
                if(!$res){
                    $this->error = '新建字段出错！';
                    //删除新增数据
                    $this->delete($id);
                    return false;
                }
            }

        } else { //更新数据
            if($create){
            //更新表字段
                $res = $this->updateField($data);
                if(!$res){
                    $this->error = '更新字段出错！';
                    return false;
                }
            }

            $status = $this->save();
            if(false === $status){
                $this->error = '更新属性出错！';
                return false;
            }
        }
        //删除字段缓存文件
        $model_name = M('Model')->field('tablename')->find($data['modelid']);
        $cache_name = C('DB_NAME').'.'.preg_replace('/\W+|\_+/','',$model_name['tablename']);
        F($cache_name, null, DATA_PATH.'_fields/');

        //内容添加或更新完成
        return $data;

    }

    /**
     * 检查同一张表是否有相同的字段
     */
    protected function checkName(){
        $name = I('post.name');
        $modelid = I('post.modelid');
        $id = I('post.id');
        $map = array('name'=>$name, 'modelid'=>$modelid);
        if(!empty($id)){
            $map['id'] = array('neq', $id);
        }
        $res = $this->where($map)->find();
        return empty($res);
    }

    /**
     * 检查当前表是否存在
     * @param intger $model_id 模型id
     * @return intger 是否存在
     */
    protected function checkTableExist($modelid){
        $Model = M('Model');
        //当前操作的表
        $model = $Model->where(array('id'=>$modelid))->field('tablename')->find();

        $table_name = $this->table_name = C('DB_PREFIX').strtolower($model['tablename']);
        $sql = <<<sql
                SHOW TABLES LIKE '{$table_name}';
sql;
        $res = M()->query($sql);
        return count($res);
    }

    /**
     * 新建表字段
     * @param array $field 需要新建的字段属性
     * @return boolean true 成功 ， false 失败
     */
    protected function addField($field){
        //检查表是否存在
        $table_exist = $this->checkTableExist($field['modelid']);

        //获取默认值
        if($field['value'] === ''){
            $default = '';
        }elseif (is_numeric($field['value'])){
            $default = ' DEFAULT '.$field['value'];
        }elseif (is_string($field['value'])){
            $default = ' DEFAULT \''.$field['value'].'\'';
        }else {
            $default = '';
        }

        if($table_exist){
            $sql = <<<sql
                ALTER TABLE `{$this->table_name}`
ADD COLUMN `{$field['name']}`  {$field['field']} {$default} COMMENT '{$field['title']}';
sql;
        }else{
            //新建表时是否默认新增“id主键”字段
            $model_info = M('Model')->field('engine_type,need_pk')->getById($field['modelid']);
            if($model_info['need_pk']){
                $sql = <<<sql
                CREATE TABLE IF NOT EXISTS `{$this->table_name}` (
                `id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键' ,
                `{$field['name']}`  {$field['field']} {$default} COMMENT '{$field['title']}' ,
                PRIMARY KEY (`id`)
                )
                ENGINE={$model_info['engine_type']}
                DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
                CHECKSUM=0
                ROW_FORMAT=DYNAMIC
                DELAY_KEY_WRITE=0
                ;
sql;
            }else{
                $sql = <<<sql
                CREATE TABLE IF NOT EXISTS `{$this->table_name}` (
                `{$field['name']}`  {$field['field']} {$default} COMMENT '{$field['title']}'
                )
                ENGINE={$model_info['engine_type']}
                DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
                CHECKSUM=0
                ROW_FORMAT=DYNAMIC
                DELAY_KEY_WRITE=0
                ;
sql;
            }

        }
        $res = M()->execute($sql);
        return $res !== false;
    }

    /**
     * 更新表字段
     * @param array $field 需要更新的字段属性
     * @return boolean true 成功 ， false 失败
     */
    protected function updateField($field){
        //检查表是否存在
        $table_exist = $this->checkTableExist($field['modelid']);
        //获取原字段名
        $last_field = $this->getFieldById($field['id'], 'name');
        //获取默认值
        $default = $field['value']!='' ? ' DEFAULT '.$field['value'] : '';
        $sql = <<<sql
            ALTER TABLE `{$this->table_name}`
CHANGE COLUMN `{$last_field}` `{$field['name']}`  {$field['field']} {$default} COMMENT '{$field['title']}' ;
sql;
        $res = M()->execute($sql);
        return $res !== false;
    }

    /**
     * 删除一个字段
     * @param array $field 需要删除的字段属性
     * @return boolean true 成功 ， false 失败
     */
    public function deleteField($field){
        //检查表是否存在
        $table_exist = $this->checkTableExist($field['modelid']);

        $sql = <<<sql
            ALTER TABLE `{$this->table_name}`
DROP COLUMN `{$field['name']}`;
sql;
        $res = M()->execute($sql);
        return $res !== false;
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
