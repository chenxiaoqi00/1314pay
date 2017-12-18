<?php
namespace Common\TagLib;
use Think\Template\TagLib;

class Form extends TagLib {
  // 自定义标签
  protected $tags=array(
    // input 文本标签
    'input' => array('attr'=>'title,name,type,id,tips,value,readonly,cols,style','close'=>0),
    // textarea 多行文本框标签
    'textarea' => array('attr'=>'title,name,id,tips,value,cols,rows','close'=>0),
    // swich 开关标签
    'switch' => array('attr'=>'title,name,id,tips,value,cols','close'=>0),
    // icon 图标选择器
    'icon'  => array('attr'=>'title,name,id,tips,value','close'=>0),
    // radio 单选框
    'radio' => array('attr'=>'title,name,tips,data,checked','close'=>0),
    // select 选择框
    'select' => array('attr'=>'title,name,id,first,tips,data,checked','close'=>0),
    // checkbox 多选框 'checkbox'  => array('attr'=>'name,checkboxes,checked,separator','close'=>0),
    'checkbox' => array('attr'=>'title,name,tips,data,checked','close'=>0),
    // image 图片上传
    'image' => array('attr'=>'title,name,tips,value,limit,button','close'=>0),
    // editor 编辑器
    'editor' => array('attr'=>'title,name,id,tips,value','close'=>0),
    // 日期
    'datepicker' => array('attr'=>'title,name,id,tips,value','close'=>0),
    // 日期
    'datetimepicker' => array('attr'=>'title,name,id,format,tips,value','close'=>0),
  );

/**
 * input文本框标签解析
 * @example {form:input name="title" title="名称" value="info['title']" tips="菜单显示的名称" /}
 * @param title: 字段标题
 * @param name:  表单属性值
 * @param value: 当前值
 * @param id:    文本框ID 默认为当前name值
 * @param cols:  当前文本框长度  默认为5(col-sm-5)
 * @return string
 */
  public function _input($tag,$content){
      $title    = $tag['title'];
      $name     = $tag['name'];
      $type     = isset($tag['type']) ? $tag['type'] : 'text';
      $id       = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $readonly = isset($tag['readonly']) ? ' readonly':'';
      $tips     = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $cols     = isset($tag['cols']) ? $tag['cols'] : 5;
      $value    = isset($tag['value']) ? $tag['value'] : '';
      $style    = isset($tag['style']) ? $tag['style'] : '';
      if($value){
        $value = $this->autoBuildVar($tag['value']);
        $value = '{'.$value.'}';
      }
      $html  = <<<php
<div class="form-group" style="{$style}">
                  <label class="col-sm-2 control-label">{$title}：</label>
                  <div class="col-sm-{$cols}">
                    <input type="{$type}" name="{$name}" id="{$id}" value="{$value}" class="form-control"{$readonly}>{$tips}
                  </div>
                </div>
php;
      return $html;
  }

/**
 * textarea多行文本框标签解析
 * @example {form:textarea name="desc" id="desc" title="描述" value="{$info.title}" cols="6" rows="6" tips="只能输入255个字符" /}
 * @param  title: 字段标题
 * @param  name:  表单属性值
 * @param  value: 当前值
 * @param  id:    文本框ID 默认为当前name值
 * @param  cols:  当前文本框长度  默认为5(col-sm-5)
 * @param  rows:  当前文本框行数  默认为3
 * @return string
 */
  public function _textarea($tag,$content){
      $title = $tag['title'];
      $name  = $tag['name'];
      $id    = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $tips  = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $cols  = isset($tag['cols']) ? $tag['cols'] : 5;
      $rows  = isset($tag['rows']) ? $tag['rows'] : 3;
      $value = $this->autoBuildVar($tag['value']);
      $value = '{'.$value.'}';
      $html   = <<<php
<div class="form-group">
                    <label class="col-sm-2 control-label">{$title}：</label>
                    <div class="col-sm-{$cols}">
                        <textarea name="{$name}" id="{$id}" class="form-control" rows="{$rows}">{$value}</textarea>{$tips}
                    </div>
                </div>
php;
      return $html;
  }

/**
 * swich开关标签解析
 * @example {form:swich name="status" title="隐藏" value="info['status']" /}
 * @param  title: 字段标题
 * @param  name:  表单属性值
 * @param  value: 当前值
 * @param  id:    开关ID 默认为当前name值
 * @return string
 */
  public function _switch($tag,$content){
      $title   = $tag['title'];
      $name    = $tag['name'];
      $id      = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $tips    = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $checked = $tag['value'];
      $checked = $this->tpl->get($checked)?$this->tpl->get($checked):$checked;
      $check = '<?php if($'.$checked.') echo \'checked="checked"\';?>';
      $html = <<<php
<div class="form-group">
                    <label class="col-sm-2 control-label">{$title}：</label>
                    <div class="col-sm-5">
                        <div class="onoffswitch-large">
                            <input type="checkbox" class="onoffswitch-large-checkbox" value="1" name="{$name}" id="{$id}" {$check}>
                            <label class="onoffswitch-large-label" for="{$id}">
                                <span class="onoffswitch-large-inner"></span>
                                <span class="onoffswitch-large-switch"></span>
                            </label>
                        </div>
                        {$tips}
                    </div>
                </div>
php;
      return $html;
  }

/**
 * font-awesome 字体图标选择器 | 需加载CSS及JS文件
 * @example {form:icon name="icon" id="icon" title="图标" value="{$info['icon'] /}
 * @param title: 字段标题
 * @param name:  表单属性值
 * @param value: 当前值
 * @param id:    默认为当前name值
 * @return string
 */
  public function _icon($tag,$content){
      $title = $tag['title'];
      $name  = $tag['name'];
      $id    = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $tips  = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $value = $this->autoBuildVar($tag['value']);
      $value = '{'.$value.'}';
      $html = <<<php
<div class="form-group">
                    <label class="col-sm-2 control-label">{$title}：</label>
                    <div class="col-sm-5">
                        <div class="input-group col-sm-3">
                            <button name="{$name}" class="btn btn-primary" role="iconpicker" data-iconset="fontawesome" data-footer="false" data-rows="5" data-cols="10" data-placement="right" data-unselected-class="btn-default" data-icon="{$value}"></button>
                        </div>
                    </div>
                </div>
php;
      return $html;
  }

  /**
   * radio标签解析
   * @example {form:radio title="性别" name="sex" data="array" checked="1" /}
   * @param title:   字段标题
   * @param name:    表单属性值
   * @param data:    单选框选项（一维数组，如array(0=>'男',1=>'女'，2=>'不限')）
   * @param id:      默认为当前name值
   * @param checked: 当前选中值
   * @return string
   */
  public function _radio($tag,$content) {
      $title   = $tag['title'];
      $name    = $tag['name'];
      $tips    = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $data    = $tag['data'];
      $data    = $this->tpl->get($data);
      $checked = $tag['checked'];
      $checked = $this->tpl->get($checked)?$this->tpl->get($checked):$checked;
      //dump($title);
      $html  = '<div class="form-group">';
      $html .= '<label class="col-sm-2 control-label">'.$title.'：</label>';
      $html .= '<div class="col-sm-8">';
      foreach($data as $key=>$val) {
          $check = '<?php if($'.$checked.'=='.$key.') echo \'checked="checked"\';?>';
          //if($checked == $key )
          $html .= '<div class="radio radio-info radio-inline"><input type="radio" '.$check.' value="'.$key.'" name="'.$name.'" id="'.$name.$key.'" /><label for="'.$name.$key.'">'.$val.'</label></div>';
      }
      $html .='</div></div>';
      return $html;
  }

  /**
   * checkbox标签解析
   * @example {form:checkbox title="性别" name="sex" data="array" checked="1" /}
   * @param title:   字段标题
   * @param name:    表单属性值
   * @param data:    多选框选项（一维数组，如array(0=>'男',1=>'女'，2=>'不限')）
   * @param id:      默认为当前name值
   * @param checked: 当前选中值
   * @return string
   */
  public function _checkbox($tag,$content) {
      $title   = $tag['title'];
      $name    = $tag['name'];
      $tips    = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $data    = $tag['data'];
      $data    = $this->tpl->get($data);
      $checked = $tag['checked'];
      $checked = $this->tpl->get($checked)?$this->tpl->get($checked):$checked;
      //dump($title);
      $html  = '<div class="form-group">';
      $html .= '<label class="col-sm-2 control-label">'.$title.'：</label>';
      $html .= '<div class="col-sm-8 icheck">';
      foreach($data as $key=>$val) {
          $check = '<?php if($'.$checked.'=='.$key.' || in_array('.$key.',str2arr($'.$checked.'))) echo \'checked="checked"\';?>';
          //if($checked == $key )
          $html .= '<label for="'.$name.$key.'" class="checkbox-inline"><input type="checkbox" '.$check.' value="'.$key.'" name="'.$name.'[]" id="'.$name.$key.'" /> '.$val.'</label>';
      }
      $html .='</div></div>';
      return $html;
  }


/**
 * 图片上传 | 表单需加载CSS及JS文件
 * @example {form:image name="thumb" title="缩略图" value="info['value']" limit="2" button="选择图片" /}
 * @param title:  字段标题
 * @param name:   表单属性值
 * @param value:  当前值
 * @param limit:  最多上传图片数(默认：1)
 * @param button: 按钮显示文字(默认：选择图片)
 * @return string
 */
  public function _image($tag,$content){
      $title   = $tag['title'];
      $name    = $tag['name'];
      $limit   = $tag['limit'];
      $button  = $tag['button'];
      $value = $this->autoBuildVar($tag['value']);
      $value = '{'.$value.'}';
      $tips    = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $html = <<<php
<div class="form-group hiUploder">
                        <label class="col-sm-2 control-label">{$title}：</label>
                        <div class="col-sm-5 queueList">
                            <a class="hiPicker" limit="{$limit}" name="{$name}" value="{$value}"><i class="fa fa-image"></i> {$button}</a>
                        </div>
                    </div>
php;
      return $html;
  }

  /**
   * select 多选框标签解析
   * @example {form:radio title="性别" name="sex" data="array" checked="1" /}
   * @param title: 字段标题
   * @param name: 表单属性值
   * @param data: 单选框选项（一维数组，如array(0=>'男',1=>'女'，2=>'不限')）
   * @param id: 默认为当前name值
   * @param checked: 当前选中值
   * @return string
   */
  public function _select($tag,$content) {
      $title = $tag['title'];
      $name  = $tag['name'];
      $first = $tag['first'];
      $id    = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $tips  = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $data  = $tag['data'];
      //$data    = $this->tpl->get($data);
      $selected = isset($tag['selected']) ? $tag['selected'] : '';
      $selected = $this->tpl->get($selected)?$this->tpl->get($selected):$selected;
      //dump($title);
      $html  = '<div class="form-group">';
      $html .= '<label class="col-sm-2 control-label">'.$title.'：</label>';
      $html .= '<div class="col-sm-2">';
      $html .= '<select id="'.$id.'" name="'.$name.'" class="form-control">';
      if(!empty($first)) {
        $html .= '<option value="" >'.$first.'</option>';
      }
      if(!empty($data)) {
            $html   .= '<?php  foreach($'.$data.' as $key=>$val) { ?>';
            if(!empty($selected)) {
                $html   .= '<?php if(!empty($'.$selected.') && ($'.$selected.' == $key || in_array($key,$'.$selected.'))) { ?>';
                $html   .= '<option selected="selected" value="<?php echo $key ?>"><?php echo $val ?></option>';
                $html   .= '<?php }else { ?><option value="<?php echo $key ?>"><?php echo $val ?></option>';
                $html   .= '<?php } ?>';
            }else {
                $html   .= '<option value="<?php echo $key ?>"><?php echo $val ?></option>';
            }
            $html   .= '<?php } ?>';
        }
      $html .='</select>';
      $html .='</div></div>';
      return $html;
  }

  /**
   * 编辑器标签解析
   * @example {form:editor name="content" id="content" title="文章内容" value="info.content" /}
   * @param  title: 字段标题
   * @param  name:  表单属性值
   * @param  value: 当前值
   * @param  id:    文本框ID 默认为当前name值
   * @param  cols:  当前文本框长度  默认为5(col-sm-5)
   * @param  rows:  当前文本框行数  默认为3
   * @return string
   */
  public function _editor($tag,$content){
      $title = $tag['title'];
      $name  = $tag['name'];
      $id    = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $tips  = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $value = $this->autoBuildVar($tag['value']);
      $value = '{'.$value.'}';
      $html   = <<<php
<div class="form-group">
                    <label class="col-sm-2 control-label">{$title}：</label>
                    <div class="col-sm-10">
                        <textarea name="{$name}" id="{$id}">{$value}</textarea>{$tips}
                    </div>
                </div>
                <script src="__JS__/ueditor/ueditor.config.js"></script>
                <script src="__JS__/ueditor/ueditor.all.min.js"></script>
                <script>
                $(function(){
                    var ue = UE.getEditor('{$id}',{
                      serverUrl :hi.url_editor_upload,
                      initialFrameHeight:350,
                    });
                })
                </script>
php;
      return $html;
  }

  /**
   * 日期时间选取器
   * @example {form:datepicker name="enddate" title="结束日期" value="info['enddate']" tips="广告位的结束日期" /}
   * @param title: 字段标题
   * @param name:  表单属性值
   * @param value: 当前值
   * @param id:    文本框ID 默认为当前name值
   * @param cols:  当前文本框长度  默认为2(col-sm-2)
   * @return string
   */
  public function _datepicker($tag,$content){
      $title    = $tag['title'];
      $name     = $tag['name'];
      $id       = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $tips     = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $cols     = isset($tag['cols']) ? $tag['cols'] : 2;
      $value    = isset($tag['value']) ? $tag['value'] : '';
      if($value){
        $value = $this->autoBuildVar($tag['value']);
        $value = '{'.$value.'}';
      }
      $html  = <<<php
<div class="form-group">
                  <label class="col-sm-2 control-label">{$title}：</label>
                  <div class="col-sm-8">
                        <div class="input-group col-sm-3">
                            <input type="text" name="{$name}" id="{$id}" value="{$value}" class="form-control">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                        {$tips}
                    </div>
                </div>
                <link href="__CSS__/plugins/datapicker/datepicker3.css" rel="stylesheet">
                <script src="__JS__/plugins/datapicker/bootstrap-datepicker.js"></script>
                <script>
                $('#{$id}').datepicker({
                    todayHighlight: true,
                    format: 'yyyy-mm-dd',
                    minView:2,
                    todayBtn:true,
                    autoclose:true
                });
                </script>
php;
      return $html;
  }

  /**
   * 日期时间选取器
   * @example {form:datetimepicker name="enddate" title="结束日期" value="info['enddate']" tips="广告位的结束日期" /}
   * @param title: 字段标题
   * @param name:  表单属性值
   * @param value: 当前值
   * @param id:    文本框ID 默认为当前name值
   * @param cols:  当前文本框长度  默认为2(col-sm-2)
   * @return string
   */
  public function _datetimepicker($tag,$content){
      $title    = $tag['title'];
      $name     = $tag['name'];
      $id       = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $format   = isset($tag['format']) ? $tag['format'] : 'yyyy-mm-dd hh:ii';
      $tips     = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $cols     = isset($tag['cols']) ? $tag['cols'] : 3;
      $value    = isset($tag['value']) ? $tag['value'] : '';
      if($value){
        $value = $this->autoBuildVar($tag['value']);
        $value = '{'.$value.'}';
      }
      $html  = <<<php
<div class="form-group">
                  <label class="col-sm-2 control-label">{$title}：</label>
                  <div class="col-sm-5">
                        <div class="input-group col-sm-5">
                            <input type="text" name="{$name}" id="{$id}" value="{$value}" class="form-control">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                        {$tips}
                    </div>
                </div>
                <link rel="stylesheet" type="text/css" href="__JS__/datetimepicker/bootstrap-datetimepicker.min.css">
                <script src="__JS__/datetimepicker/bootstrap-datetimepicker.min.js"></script>
                <script src="__JS__/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
                <script>
                $('#{$id}').datetimepicker({
                    language:  'zh-CN',
                    format: '{$format}',
                    weekStart: 1,
                    todayBtn:  1,
                    autoclose: 1,
                    todayHighlight: 1,
                    startView: 2,
                    minView: 2,
                    forceParse: 1
                });
                </script>
php;
      return $html;
  }

// datepicker 范围选择样式
/*<div class="form-group">
                    <label class="col-sm-2 control-label">起止日期：</label>
                    <div class="input-daterange input-group" id="datepicker">
                        <input type="text" class="form-control" value="" id="start" name="start_date" placeholder="开始日期" />
                        <span class="input-group-addon">~</span>
                        <input type="text" class="form-control" value="" id="end" name="end_date" placeholder="结束日期" />
                    </div>
                </div>*/
}

