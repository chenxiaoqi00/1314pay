<?php
// +----------------------------------------------------------------------
// | hicms | 模板控制器
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.allship.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
class TemplateController extends AdminController {
    //模块列表
    protected $ModuleType = array();
    //配置文件
    protected $configfile = null;
    //模块名
    protected $modulename = null;
    //初始化
    protected function _initialize() {
        parent::_initialize();
        $module = I('get.module/s') ? I('get.module/s') : 'admin';
        $this->modulename = ucfirst($module);

        // 配置文件地址
        $this->configfile = TMPL_PATH.$this->modulename.'/config.php';
        file_exists($this->configfile) or touch($this->configfile);
        //模块列表
        $this->ModuleType = D('Module')->getField('id,title,name');
        $this->assign('ModuleType', $this->ModuleType);
        $this->assign('module', $module);
    }

    /*模板首页*/
    public function index(){
        //配置信息
        $fileinfo = include($this->configfile);
        //获取目录
        $dir = I('get.dir/s');
        //遍历目录
        $filepath = TMPL_PATH. $this->modulename. '/' .$dir;
        $DirAndFile = glob($filepath.DIRECTORY_SEPARATOR.'*');
        if(!empty($DirAndFile)) ksort($DirAndFile);
        // 替换路径
        $local = str_replace(array( TMPL_PATH, DIRECTORY_SEPARATOR.DIRECTORY_SEPARATOR), array('',DIRECTORY_SEPARATOR), $filepath);
        if (substr($local, -1, 1) == '.') {
            $local = substr($local, 0, (strlen($local)-1));
        }
        $encode_local = str_replace(array('/', '\\'), '|', $local);
        if(!$dir){
            $encode_local = substr($encode_local, 0, (strlen($encode_local)-1));
        }
        $list = array();
        if(is_array($DirAndFile)){
            foreach ($DirAndFile as $key => $value) {
                $list[$key]['path'] = $value;
                $list[$key]['filename'] = basename($value);
                //$list[$key]['url'] = U('edit',array('file'=>base64_encode($encode_local.'|'.basename($value))));
                $list[$key]['urlcode'] = base64_encode($encode_local.'|'.basename($value));
            }
        }
        // 赋值
        $this->assign('local', $encode_local);
        $this->assign('fileinfo', $fileinfo);
        $this->assign('list', $list);
        $this->display();
    }

    /*更新模板配置信息*/
    public function update(){
        $conf = filter_array(I('post.'));
        $fileinfo = include($this->configfile);
        if(!isset($fileinfo)) $fileinfo = array();
        $conf = array_merge(filter_array($fileinfo), $conf);
        $str = "<?php";
            $str .= "\n\r//模板配置信息文件由系统自动生成.如非必要,请在后台修改并生成！";
            $str .= "\n\r//各模块的模板配置信息文件必须有写入权限";
            $str .= "\n\rreturn ".var_export($conf, true).';';
        \Think\Storage::put($this->configfile, $str);
        $this->success('模板配置信息更新成功！');
    }

    /*编辑模板*/
    public function edit() {
        $file = base64_decode(I('file'));
        $file = str_replace(array('|', '\\'), '/', $file);

        $filepath = TMPL_PATH.$file;
        if(!file_exists($filepath)){
            $this->error('文件不存在!');
        }
        //获取文件名
        $path = str2arr($file, '/');
        if(IS_POST){
            $content = I('content', '', '');
            // 备份模板文件
            $this->template_bak($file);
            //dump($filepath);
            if (false !== @file_put_contents($filepath, $content)) {
                $this->success('保存成功!');
            } else {
                $this->error('保存文件失败，请重试!');
            }
        }else{
            //读取文件
            $content = file_get_contents($filepath);
            if ($content === false) {
                $this->error('读取文件失败');
            }
            $content = htmlspecialchars($content);
            $this->assign('filename', $path[2]);
            $this->assign('content', $content);
            $this->assign('meta_title','编辑模板'.$file);
            $this->display();
        }
    }

    /*模板历史版本*/
    public function history(){
        $file = base64_decode(I('file'));
        $file = str_replace(array('|', '\\'), '/', $file);
        $list = M('Template')->where(array('file'=>$file))->field('template', true)->order('id desc')->select();
        //文件路径
        $filepath = TMPL_PATH.$file;
        if(!file_exists($filepath)){
            $this->error('文件不存在!');
        }
        //获取文件名
        $path = str2arr($file, '/');
        $this->assign('list', $list);
        $this->display();
    }

    /*还原当前模板内容*/
    public function restore(){
        $id = (int)I('get.id/d');
        $info = M('Template')->find($id);
        if(!$info){
            $this->error('当前备份信息不存在');
        }
        //当前文件路径
        $filepath = TMPL_PATH.$info['file'];
        if(!file_exists($filepath)){
            $this->error($info["file"].'文件不存在!');
        }
        if (!is_writable($filepath)) {
            $this->error('当前文件'.$info["file"].'不可写!');
        }
        if (false !== @file_put_contents($filepath, new_stripslashes($info['template']))) {
            $this->success($info["file"].'模板文件还原成功!');
        } else {
            $this->error($info["file"].'模板文件还原失败!');
        }
    }

    /**
     * 生成模板临时文件
     * @param $filepath 文件地址
     * @param $dir 目录名
     */
    function template_bak($filepath) {
        if(!file_exists(TMPL_PATH.$filepath)){
            $this->error('文件不存在!');
        }
        $filename = basename($filepath);
        $model = M('Template');
        $data = array();
        $data['time']     = NOW_TIME;
        $data['file']     = $filepath;
        $data['uid']      = UID;
        $data['template'] = new_addslashes(file_get_contents(TMPL_PATH.$filepath));
        $model->add($data);
    }


}