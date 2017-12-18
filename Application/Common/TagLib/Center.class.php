<?php
namespace Common\TagLib;
use Think\Template\TagLib;

class Center extends TagLib {
  // 自定义标签
  protected $tags=array(
    // input 文本标签
    'input' => array('attr'=>'title,name,type,id,tips,value,readonly,width,style,class important','close'=>0),
    // input 文本标签
    'form_input' => array('attr'=>'title,name,type,id,tips,value,readonly,width','close'=>0),
    // textarea 多行文本框标签
    'textarea' => array('attr'=>'title,name,id,tips,value,width,rows','close'=>0),
    // switch 开关标签
    'switch' => array('attr'=>'title,name,id,text,tips','close'=>0),
    // radio 单选框
    'radio' => array('attr'=>'title,name,tips,data,checked','close'=>0),
    // select 选择框
    'select' => array('attr'=>'title,name,id,first,tips,data,selected,important disabled','close'=>0),
    // select 选择框
    'form_select' => array('attr'=>'title,name,id,first,tips,data,checked','close'=>0),
    // checkbox 多选框
    'checkbox' => array('attr'=>'title,name,tips,data,checked','close'=>0),
    // image 图片上传
    'image' => array('attr'=>'title,name,tips,value,limit,button','close'=>0),
  	// file 文件上传
  	'file' => array('attr'=>'title,name,tips,value,limit,button','close'=>0),
    // editor 编辑器
    'editor' => array('attr'=>'title,name,id,tips,value','close'=>0),
    // 日期
    'datepicker' => array('attr'=>'title,name,id,tips,value','close'=>0),
    // 日期
    'datetimepicker' => array('attr'=>'title,name,id,tips,value','close'=>0),
    // 关联日期
    'daterange' => array('attr'=>'title,startname,endnae,startvalue,endvalue,tips,value','close'=>0),
    // 关联日期
    'form_daterange' => array('attr'=>'title,startname,endnae,startvalue,endvalue,tips,value','close'=>0),
    // 关联日期
    'datetimerange' => array('attr'=>'title,startname,endnae,startvalue,endvalue,tips,value','close'=>0),
  );

/**
 * input文本框标签解析
 * @example {center:input name="readonly" title="只读文本框" value="info['readonly']" readonly="true" tips="这里是文本框" /}
 * @param title:  字段标题
 * @param name:   表单属性值
 * @param value:  当前值
 * @param id:     文本框ID 默认为当前name值
 * @param width:  当前文本框长度  默认为200(width200)
 * @return string
 */
  public function _input($tag,$content){
      $title    = $tag['title'];
      $name     = $tag['name'];
      $type     = isset($tag['type']) ? $tag['type'] : 'text';
      $id       = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $readonly = isset($tag['readonly']) ? ' readonly':'';
      $tips     = isset($tag['tips']) ? '<span class="help-block-tips"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $width     = isset($tag['width']) ? $tag['width'] : 200;
      $value    = isset($tag['value']) ? $tag['value'] : '';
      $style    = isset($tag['style']) ? $tag['style'] : '';
      $class    = isset($tag['class']) ? $tag['class'] : '';
      $important =isset($tag['important']) ? '<i style="color:#f00">*</i>'  : '';
      if($value){
        $value = $this->autoBuildVar($tag['value']);
        $value = '{'.$value.'}';
      }
      $html  = <<<php
<div class="form-group" style="{$style}">
                <label class="label-control " for="{$name}">{$important}{$title}：</label>
                <input type="{$type}" name="{$name}" id="{$id}" value="{$value}" class="form-control {$class} width{$width} "{$readonly}>
                {$tips}
            </div>
php;
      return $html;
  }

/**
 * input文本框标签解析
 * @example {center:input name="readonly" title="只读文本框" value="info['readonly']" readonly="true" tips="这里是文本框" /}
 * @param title:  字段标题
 * @param name:   表单属性值
 * @param value:  当前值
 * @param id:     文本框ID 默认为当前name值
 * @param width:  当前文本框长度  默认为200(width200)
 * @return string
 */
  public function _form_input($tag,$content){
      $name     = $tag['name'];
      $type     = isset($tag['type']) ? $tag['type'] : 'text';
      $id       = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $readonly = isset($tag['readonly']) ? ' readonly':'';
      $width    = isset($tag['width']) ? $tag['width'] : 150;
      $value    = isset($tag['value']) ? $tag['value'] : '';
      if($value){
        $value = $this->autoBuildVar($tag['value']);
        $value = '{'.$value.'}';
      }
      $html  = <<<php
                <input type="{$type}" name="{$name}" id="{$id}" value="{$value}" class="table-form-control width{$width}"{$readonly} style="{$style}">
php;
      return $html;
  }

/**
 * textarea多行文本框标签解析
 * @example {center:textarea name="desc" id="desc" title="描述" value="{$info.title}" width="300" rows="6" tips="只能输入255个字符" /}
 * @param  title: 字段标题
 * @param  name:  表单属性值
 * @param  value: 当前值
 * @param  id:    文本框ID 默认为当前name值
 * @param  width:  当前文本框长度  默认为5(col-sm-5)
 * @param  rows:  当前文本框行数  默认为3
 * @return string
 */
  public function _textarea($tag,$content){
      $title = $tag['title'];
      $name  = $tag['name'];
      $id    = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $tips  = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $width  = isset($tag['width']) ? $tag['width'] : 400;
      $rows  = isset($tag['rows']) ? $tag['rows'] : 3;
      $value = $this->autoBuildVar($tag['value']);
      $value = '{'.$value.'}';
      $html   = <<<php
<div class="form-group">
                    <label class="label-control" for="{$name}">{$title}：</label>
                    <textarea name="{$name}" id="{$id}" class="form-control  width{$width}" rows="{$rows}" style="width:{$width}px">{$value}</textarea>
                    {$tips}
                </div>
php;
      return $html;
  }

/**
 * swich开关标签解析
 * @example {center:switch name="swich" title="开关" value="info['status']" /}
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
      $text    = isset($tag['text']) ? $tag['text'] : 'OPEN|CLOSE';
      $text = str2arr($text, '|');
      $tips    = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $checked = $tag['value'];
      $checked = $this->tpl->get($checked)?$this->tpl->get($checked):$checked;
      $check = '<?php if($'.$checked.') echo \'checked="checked"\';?>';
      $html = <<<php
<div class="form-group">
              <label class="label-control" for="text">{$title}：</label>
              <div class="switch">
                  <input id="{$id}" name="{$name}" value="1" class="cmn-toggle cmn-toggle-yes-no" type="checkbox" {$check}>
                  <label for="{$id}" data-on="{$text[0]}" data-off="{$text[1]}"></label>
              </div>
              {$tips}
          </div>
php;
      return $html;
  }

  /**
   * radio标签解析
   * @example {center:radio title="单选" name="radio" data="radio" checked="info['radio']" tips="单选框只能选其一" /}
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
      $html  = '<div class="form-group">';
      $html .= '<label class="label-control">'.$title.'：</label>';
      foreach($data as $key=>$val) {
          $check = '<?php if($'.$checked.'=='.$key.') echo \'checked="checked"\';?>';
          $html .= '<input class="form-radio" type="radio" '.$check.' name="'.$name.'" value="'.$key.'" data-labelauty="'.$val.'" id="'.$name.$key.'" />';
      }
     /*  $html .='<div class="clear"></div>'; */
      $html .= $tips;
      $html .='</div>';
      return $html;
  }

  /**
   * checkbox标签解析
   * @example {center:checkbox title="多选" name="checkbox" data="checkbox" checked="info['checkbox']" tips="多选框可以选好几个" /}
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
      $html  = '<div class="form-group">';
      $html .= '<label class="label-control">'.$title.'：</label>';
      foreach($data as $key=>$val) {
          $check = '<?php if($'.$checked.'=='.$key.' || in_array('.$key.',str2arr($'.$checked.'))) echo \'checked="checked"\';?>';
          $html .= '<input class="form-checkbox" type="checkbox" '.$check.' name="'.$name.'[]" value="'.$key.'" data-labelauty="'.$val.'" id="'.$name.$key.'" />';
      }
      $html .='<div class="clear"></div>';
      $html .= $tips;
      $html .='</div>';
      return $html;
  }


/**
 * 图片上传 | 表单需加载CSS及JS文件
 * @example {form:center name="thumb" title="缩略图" value="info['value']" limit="2" button="选择图片" /}
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
              <label class="label-control" for="{$name}">{$title}：</label>
              <div class="queueList">
                  <a class="hiPicker webuploader-container" limit="{$limit}" name="{$name}" value="{$value}"><i class="fa fa-image"></i> {$button}</a>
              </div>
              {$tips}
          </div>
php;
      return $html;
  }

  /**
   * 图片上传 | 表单需加载CSS及JS文件
   * @example {form:center name="thumb" title="缩略图" value="info['value']" limit="2" button="选择图片" /}
   * @param title:  字段标题
   * @param name:   表单属性值
   * @param value:  当前值
   * @param limit:  最多上传图片数(默认：1)
   * @param button: 按钮显示文字(默认：选择图片)
   * @return string
   */
  public function _file($tag,$content){
  	$title   = $tag['title'];
  	$name    = $tag['name'];
  	$limit   = $tag['limit'];
  	$button  = $tag['button'];
  	$value = $this->autoBuildVar($tag['value']);
  	$value = '{'.$value.'}';
  	$tips    = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
  	$html = <<<php
<div class="form-group hiUploder">
              <label class="label-control" for="{$name}">{$title}：</label>
              <div class="queueList">
                  <a class="hiPicker webuploader-container" limit="{$limit}" name="{$name}" value="{$value}"><i class="fa fa-image"></i> {$button}</a>
              </div>
              {$tips}
          </div>
php;
                return $html;
  }
  /**
   * select 下拉框标签解析
   * @example {center:select title="下拉框" name="select" data="select_array" selected="info['select']" /}
   * @param title:    字段标题
   * @param name:     表单属性值
   * @param data:     下拉框选项（一维数组，如array(0=>'下拉一',1=>'下拉二'，2=>'下拉三')）
   * @param id:       默认为当前name值
   * @param checked:  当前选中值
   * @return string
   */
  public function _select($tag,$content) {
      $title = $tag['title'];
      $name  = $tag['name'];
      $first = $tag['first'];
      $disabled = isset($tag['disabled']) ? 'disabled':'';
      $id    = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $tips  = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $important =isset($tag['important']) ? '<i style="color:#f00">*</i>'  : '';
      $data  = $tag['data'];
      //$data    = $this->tpl->get($data);
      $selected = isset($tag['selected']) ? $tag['selected'] : '';
      $selected = $this->tpl->get($selected)?$this->tpl->get($selected):$selected;
      $html  = '<div class="form-group">';
      $html .= '<label class="label-control">'.$important.$title.'：</label>';
      $html .= '<select id="'.$id.'" name="'.$name.'" class="form-control" '.$disabled.'>';
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
      $html .= $tips;
      $html .='</div>';
      return $html;
  }


  /**
   * select 下拉框标签解析
   * @example {center:select title="下拉框" name="select" data="select_array" selected="info['select']" /}
   * @param title:    字段标题
   * @param name:     表单属性值
   * @param data:     下拉框选项（一维数组，如array(0=>'下拉一',1=>'下拉二'，2=>'下拉三')）
   * @param id:       默认为当前name值
   * @param checked:  当前选中值
   * @return string
   */
  public function _form_select($tag,$content) {
      $name  = $tag['name'];
      $first = $tag['first'];
      $id    = isset($tag['id']) ? $tag['id'] : $tag['name'];
      $data  = $tag['data'];
      //$data    = $this->tpl->get($data);
      $selected = isset($tag['selected']) ? $tag['selected'] : '';
      $selected = $this->tpl->get($selected)?$this->tpl->get($selected):$selected;
      $html .= '<select name="'.$name.'" class="table-form-control">';
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
      return $html;
  }

  /**
   * 编辑器标签解析
   * @example {center:editor name="content" id="content" title="文章内容" value="info.content" /}
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
                    <label class="label-control">{$title}：</label>
                    <div class="ueditor clear">
                        <textarea name="{$name}" id="{$id}">{$value}</textarea>
                    </div>
                    {$tips}
                </div>
                <script src="__BASE_JS__/ueditor/ueditor.config.mini.js"></script>
                <script src="__BASE_JS__/ueditor/ueditor.all.min.js"></script>
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
   * @example {center:datepicker name="enddate" title="结束日期" value="info['enddate']" tips="广告位的结束日期" /}
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
      $width     = isset($tag['width']) ? $tag['width'] : 120;
      $value    = isset($tag['value']) ? $tag['value'] : '';
      if($value){
        $value = $this->autoBuildVar($tag['value']);
        $value = '{'.$value.'}';
      }
      $html  = <<<php
<div class="form-group">
                  <label class="label-control">{$title}：</label>
                  <input type="text" name="{$name}" id="{$id}" value="{$value}" class="form-control icon-date width{$width}">
                  {$tips}
                </div>
                <link href="__BASE_CSS__/plugins/datapicker/datepicker3.css" rel="stylesheet">
                <script src="__BASE_JS__/plugins/datapicker/bootstrap-datepicker.js"></script>
                <script>
                $('#{$id}').datepicker({
                    todayHighlight: true,
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
      $tips     = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $width     = isset($tag['width']) ? $tag['width'] :   150;
      $format   = isset($tag['format']) ? $tag['format'] : 'yyyy-mm-dd hh:ii';
      $value    = isset($tag['value']) ? $tag['value'] : '';
      if($value){
        $value = $this->autoBuildVar($tag['value']);
        $value = '{'.$value.'}';
      }
      $html  = <<<php
<div class="form-group">
                  <label class="label-control">{$title}：</label>
                  <input type="text" name="{$name}" id="{$id}" value="{$value}" class="form-control icon-date width{$width}">
                  {$tips}
                </div>
                <link rel="stylesheet" type="text/css" href="__BASE_JS__/datetimepicker/bootstrap-datetimepicker.min.css">
                <script src="__BASE_JS__/datetimepicker/bootstrap-datetimepicker.min.js"></script>
                <script src="__BASE_JS__/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
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

  /**
   * 日期范围选取器
   * @example {center:daterange startname="start_time" endname="end_time" title="起始日期" startvalue="info['start_time']" endvalue="info['end_time']" tips="此次航海经历的起始日期" /}
   * @param title: 字段标题
   * @param name:  表单属性值
   * @param value: 当前值
   * @param id:    文本框ID 默认为当前name值
   * @param cols:  当前文本框长度  默认为2(col-sm-2)
   * @return string
   */
  public function _daterange($tag,$content){
      $title      = $tag['title'];
      $startname  = $tag['startname'];
      $endname    = $tag['endname'];
      $tips       = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $cols       = isset($tag['cols']) ? $tag['cols'] : 2;
      $startvalue = isset($tag['startvalue']) ? $tag['startvalue'] : '';
      $endvalue   = isset($tag['endvalue']) ? $tag['endvalue'] : '';
      if($startvalue){
        $startvalue = $this->autoBuildVar($tag['startvalue']);
        $startvalue = '{'.$startvalue.'}';
      }
      if($endvalue){
        $endvalue = $this->autoBuildVar($tag['endvalue']);
        $endvalue = '{'.$endvalue.'}';
      }
      $html  = <<<php
<div class="form-group">
                  <label class="label-control">{$title}：</label>
                  <input type="text" name="{$startname}" id="{$startname}" value="{$startvalue}" class="form-control icon-date width120"> ~ <input type="text" name="{$endname}" id="{$endname}" value="{$endvalue}" class="form-control icon-date width120">
                  {$tips}
                </div>
                <link href="__BASE_CSS__/plugins/datapicker/datepicker3.css" rel="stylesheet">
                <script src="__BASE_JS__/plugins/datapicker/bootstrap-datepicker.js"></script>
                <script>
                  //开始时间
                  $('#{$startname}').datepicker({
                      todayBtn: "linked",
                      autoclose: true,
                      todayHighlight: true,
                      //endDate: new Date()
                  }).on('changeDate', function(e) {
                      var startTime = e.date;
                      $('#{$endname}').datepicker('setStartDate', startTime);
                  });
                  //结束时间：
                  $('#{$endname}').datepicker({
                      todayBtn: "linked",
                      autoclose: true,
                      todayHighlight: true,
                      //endDate: new Date()
                  }).on('changeDate', function(e) {
                      var endTime = e.date;
                      $('#{$startname}').datepicker('setEndDate', endTime);
                  });
                </script>
php;
      return $html;
  }

    /**
   * 日期范围选取器
   * @example {center:daterange startname="start_time" endname="end_time" title="起始日期" startvalue="info['start_time']" endvalue="info['end_time']" tips="此次航海经历的起始日期" /}
   * @param title: 字段标题
   * @param name:  表单属性值
   * @param value: 当前值
   * @param id:    文本框ID 默认为当前name值
   * @param cols:  当前文本框长度  默认为2(col-sm-2)
   * @return string
   */
  public function _form_daterange($tag,$content){
      $title      = $tag['title'];
      $startname  = $tag['startname'];
      $endname    = $tag['endname'];
      $startvalue = isset($tag['startvalue']) ? $tag['startvalue'] : '';
      $endvalue   = isset($tag['endvalue']) ? $tag['endvalue'] : '';
      if($startvalue){
        $startvalue = $this->autoBuildVar($tag['startvalue']);
        $startvalue = '{'.$startvalue.'}';
      }
      if($endvalue){
        $endvalue = $this->autoBuildVar($tag['endvalue']);
        $endvalue = '{'.$endvalue.'}';
      }
      $html  = <<<php
                  <input type="text" name="{$startname}" id="{$startname}" value="{$startvalue}" class="table-form-control width80 pickstart">~<input type="text" name="{$endname}" id="{$endname}" value="{$endvalue}" class="table-form-control width80 pickend">
                <link href="__BASE_CSS__/plugins/datapicker/datepicker3.css" rel="stylesheet">
                <script src="__BASE_JS__/plugins/datapicker/bootstrap-datepicker.js"></script>
                <script>
                  //开始时间
                  $('.pickstart').datepicker({
                      todayBtn: "linked",
                      autoclose: true,
                      todayHighlight: true,
                      //endDate: new Date()
                  }).on('changeDate', function(e) {
                      var startTime = e.date;
                      $('.pickend').datepicker('setStartDate', startTime);
                  });
                  //结束时间：
                  $('.pickend').datepicker({
                      todayBtn: "linked",
                      autoclose: true,
                      todayHighlight: true,
                      //endDate: new Date()
                  }).on('changeDate', function(e) {
                      var endTime = e.date;
                      $('.pickstart').datepicker('setEndDate', endTime);
                  });
                </script>
php;
      return $html;
  }

  /**
   * 日期时间范围选取器
   * @example {center:datetimerange startname="start_time" endname="end_time" title="起始日期" startvalue="info['start_time']|times" endvalue="info['end_time']|times" tips="团购开始和结束时间" /}
   * @param title: 字段标题
   * @param name:  表单属性值
   * @param value: 当前值
   * @param id:    文本框ID 默认为当前name值
   * @param cols:  当前文本框长度  默认为2(col-sm-2)
   * @return string
   */
  public function _datetimerange($tag,$content){
      $title      = $tag['title'];
      $startname  = $tag['startname'];
      $endname    = $tag['endname'];
      $format     = isset($tag['format']) ? $tag['format'] : 'yyyy-mm-dd hh:ii';
      $tips       = isset($tag['tips']) ? '<span class="help-block"><i class="fa fa-info-circle"></i> '.$tag['tips'].'</span>' : '';
      $startvalue = isset($tag['startvalue']) ? $tag['startvalue'] : '';
      $endvalue   = isset($tag['endvalue']) ? $tag['endvalue'] : '';
      if($startvalue){
        $startvalue = $this->autoBuildVar($tag['startvalue']);
        $startvalue = '{'.$startvalue.'}';
      }
      if($endvalue){
        $endvalue = $this->autoBuildVar($tag['endvalue']);
        $endvalue = '{'.$endvalue.'}';
      }
      $html  = <<<php
<div class="form-group">
                  <label class="label-control">{$title}：</label>
                  <input type="text" name="{$startname}" id="{$startname}" value="{$startvalue}" class="form-control icon-date width150"> ~ <input type="text" name="{$endname}" id="{$endname}" value="{$endvalue}" class="form-control icon-date width150">
                  {$tips}
                </div>
                <link rel="stylesheet" type="text/css" href="__BASE_JS__/datetimepicker/bootstrap-datetimepicker.min.css">
                <script src="__BASE_JS__/datetimepicker/bootstrap-datetimepicker.min.js"></script>
                <script src="__BASE_JS__/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>
                <script>
                  //开始时间
                  $('#{$startname}').datetimepicker({
                      language:  'zh-CN',
                      todayBtn: "linked",
                      autoclose: true,
                      todayHighlight: true,
                      //endDate: new Date()
                  }).on('changeDate', function(e) {
                      var startTime = e.date;
                      $('#{$endname}').datetimepicker('setStartDate', startTime);
                  });
                  //结束时间：
                  $('#{$endname}').datetimepicker({
                      language:  'zh-CN',
                      todayBtn: "linked",
                      autoclose: true,
                      todayHighlight: true,
                      //endDate: new Date()
                  }).on('changeDate', function(e) {
                      var endTime = e.date;
                      $('#{$startname}').datetimepicker('setEndDate', endTime);
                  });
                </script>
php;
      return $html;
  }

}