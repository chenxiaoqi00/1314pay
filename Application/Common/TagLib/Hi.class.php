<?php
// +----------------------------------------------------------------------
// | 自定义标签 [ HiCMS ]
// +----------------------------------------------------------------------
// | Author: LaoHe <21199555@qq.com>
// +----------------------------------------------------------------------
namespace Common\TagLib;
use Think\Template\TagLib;
class Hi extends TagLib {
  protected $tags=array(
    //获取上一篇信息
    'prev'       => array('attr' => 'info', 'close' => 0),
    //获取下一篇信息
    'next'       => array('attr' => 'info', 'close' => 0),
    //获取碎片
    'block'      => array('attr' => 'name', 'close' => 0),
    //面包屑导航
    'breadcrumb' => array('attr' => 'catid,module', 'close' => 0),
    //友情链接
    'link'       => array('attr' => 'type,limit,order', 'close' => 1),
    //推荐位列表
    'position'   => array('attr' => 'pos,catid,modelid,limit,order,empty','close' => 1),
    //栏目列表
    'category'   => array('attr' => 'catid,model','close' => 1),
    //文章列表
    'article'    => array('attr' => 'catid,thumb,limit,order,empty','close' => 1),
  	//产品列表
  	'product'    => array('attr' => 'catid,picture,limit,order,empty,iscomment,shopid','close' => 1),
  	//标签列表
  	'tags'   => array('attr' => 'limit,order,empty','close' => 1),
    //找人列表
    'job'   => array('attr' => 'limit,empty','close' => 1),
    //求职列表
    'resume'   => array('attr' => 'limit,empty','close' =>1),
  );

  /**
   * 当前模型数据的上一条信息
   * @example {hi:prev /}
   * @param   array $info 当前文章信息
   * @return  string
   */
  public function _prev($tag, $content){
    $info  = $tag['info'];
    $parse = <<<parse
<?php
  \$map = array();
  \$map['id'] = array('lt', \$info['id']);
  if(\$info['catid']){
    \$map['catid'] = \$info['catid'];
  }
  \$map['status'] = array('eq',1);
  // 返回前一条数据
  \$res = M('Article')->field('id,url,title')->where(\$map)->order('id DESC')->find();
  unset(\$map);
  if(\$res){
      echo '<a href="'.U('show',array('id'=>\$res['id'])).'">'.\$res['title'].'</a>';
  }else{
      echo '暂无信息';
  }
?>
parse;
    return $parse;
  }

  /**
   * 当前模型栏目的下一条信息
   * @example {hi:next /}
   * @param   array $info 当前文章信息
   * @return  string
   */
  public function _next($tag, $content){
    $info  = $tag['info'];
    $parse = <<<parse
<?php
  \$map = array();
  \$map['id'] = array('gt', \$info['id']);
  if(\$info['catid']){
    \$map['catid'] = \$info['catid'];
  }
  \$map['status'] = array('eq',1);
  // 返回后一条数据
  \$res = M('Article')->field('id,url,title')->where(\$map)->order('id DESC')->find();
  unset(\$map);
  if(\$res){
      echo '<a href="'.U('show',array('id'=>\$res['id'])).'">'.\$res['title'].'</a>';
  }else{
      echo '暂无信息';
  }
?>
parse;
    return $parse;
  }

  /**
   * 碎片信息
   * @example {hi:block name='nav' /}
   * @param   array $name 当前碎片标识
   * @return  string
   */
  public function _block($tag, $content){
    $name  = $tag['name'];
    $parse = <<<parse
<?php
  echo block($name);
?>
parse;
    return $parse;
  }

  /**
   * 获取栏目
   * @example {hi:block name='nav' /}
   * @param   array $name 当前碎片标识
   * @return  string
   */
  public function _category($tag, $content){
    $catid  = empty($tag['catid']) ? '0' : $tag['catid'];
    $module = empty($tag['module']) ? 'news' : $tag['module'];
    $item   = empty($tag['item']) ? '$v' : '$'.$tag['item'];
    $parse  = <<<parse
<?php
  \$categorys = get_child_categorys($catid);
  foreach(\$categorys as \$key => $item):
?>
parse;
    $parse .= $content;
    $parse .= '<?php endforeach;?>';
    return $parse;
  }

  /**
   * 面包屑导航
   * @example {hi:breadcrumb module="news" catid="15" /}
   * @param   string  $module 模块(用于调用文章或产品分类)
   * @param   integer $catid  当前栏目ID
   * @return  string
   */
  public function _breadcrumb($tag, $content){
    $catid  = empty($tag['catid']) ? '0' : $tag['catid'];
    $module = empty($tag['module']) ? 'product' : $tag['module'];
    $item   = empty($tag['item']) ? 'v' : $tag['item'];
    $parse  = <<<parse
<?php
  if($module=='news'){
    echo breadcrumb($catid, false);
  }else{
    echo breadcrumb($catid, false);
  }
?>
parse;
    return $parse;
  }

  /**
   * 友情链接列表
   * @example {hi:link type="1" limit="2,5" empty="no data" order="sort desc"}
   * @param   integer $pos   推荐位ID
   * @param   integer $limit 调用数目 如:limit="2,5" 取2-5条数据
   * @param   string  $order 排序
   * @param   string  $item  循环变量名
   * @return  array()
   */
  public function _link($tag, $content){
      $pos    = empty($tag['type'])  ? '0' : $tag['type'];
      $item   = empty($tag['item'])  ? 'v' : $tag['item'];
      $empty  = isset($tag['empty']) ? $tag['empty'] : '暂无友情链接';
      $limit  = empty($tag['limit']) ? '10' : $tag['limit'];
      $order  = empty($tag['order']) ? 'id desc' : $tag['order'];
      //解析PHP
      $parse  = '<?php ';
      $parse .= '$__LINK_LIST__ = D(\'Admin/Link\')->taglib('.$pos.', "'.$limit.'", "'.$order.'");';
      $parse .= ' ?>';
      $parse .= '{volist name="__LINK_LIST__" id="'. $item .'" empty="'. $empty .'"}';
      $parse .= $content;
      $parse .= '{/volist}';
      return $parse;
  }

  /**
   * 推荐位列表
   * @example {hi:position pos="1" limit="2,5" thumb="1" empty="no data" order="sort desc"}
   * @param   integer $pos   推荐位ID
   * @param   integer $limit 调用数目 如:limit="2,5" 取2-5条数据
   * @param   integer $catid 栏目ID
   * @param   integer $modelid 模型ID 1：单页；2：文章；3：个人会员；4：企业会员；5：产品
   * @param   string  $order 排序
   * @param   string  $item  循环变量名
   * @return  array()
   */
  public function _position($tag, $content){
      $pos    = empty($tag['pos'])   ? '0' : $tag['pos'];
      $item   = empty($tag['item'])  ? 'v' : $tag['item'];
      $empty  = isset($tag['empty']) ? $tag['empty']:'暂无推荐信息';
      $limit  = empty($tag['limit']) ? '10' : $tag['limit'];
      $order  = empty($tag['order']) ? 'id desc':$tag['order'];
      $catid  = empty($tag['catid']) ? '0' : $tag['catid'];
      $modelid = empty($tag['modelid']) ? '0' : $tag['modelid'];
      //解析PHP
      $parse  = '<?php ';
      $parse .= '$__POS_LIST__ = D(\'Admin/Position\')->taglib('.$pos.','.$modelid.', '.$catid.', "'.$limit.'", "'.$order.'");';
      $parse .= ' ?>';
      $parse .= '{volist name="__POS_LIST__" id="'. $item .'" empty="'. $empty .'"}';
      $parse .= $content;
      $parse .= '{/volist}';
      return $parse;
  }


  /**
   * 文章列表
   * @example {hi:article catid="1" limit="1,2,3" thumb="1" empty="no data" order="sort desc"}
   * @param   integer $catid 栏目ID，多个用","分割  如:catid="1,2,3" 查询当前当前及所有子栏目
   * @param   integer $limit 调用数目 如:limit="2,5" 取2-5条数据
   * @param   integer $thumb 是否缩略图
   * @param   string  $order 排序
   * @param   string  $item  循环变量名
   * @return  array()
   */
  public function _article($tag, $content){
      $catid  = empty($tag['catid']) ? '0' : $tag['catid'];
      $item   = empty($tag['item'])  ? 'v' : $tag['item'];
      $empty  = isset($tag['empty']) ? $tag['empty']:'暂无信息';
      $limit  = empty($tag['limit']) ? '20' : $tag['limit'];
      $order  = empty($tag['order']) ? 'inputtime desc':$tag['order'];
      $thumb  = isset($tag['thumb']) ? 1 : 0;

      //解析PHP
      $parse  = '<?php ';
      $parse .= '$__ARTICLE_LIST__ = D(\'Admin/Article\')->taglib("'.$catid.'", '.$thumb.', "'.$limit.'", "'.$order.'");';
      $parse .= ' ?>';
      $parse .= '{volist name="__ARTICLE_LIST__" id="'. $item .'" empty="'. $empty .'"}';
      $parse .= $content;
      $parse .= '{/volist}';
      return $parse;
  }
  
  /**
   * 文章列表
   * @example {hi:product catid="1" limit="1,2,3" picture="1" empty="no data" order="sort desc"}
   * @param   integer $catid 栏目ID，多个用","分割  如:catid="1,2,3" 查询当前当前及所有子栏目
   * @param   integer $limit 调用数目 如:limit="2,5" 取2-5条数据
   * @param   integer $picture 是否缩略图
   * @param   string  $order 排序
   * @param   string  $item  循环变量名
   * @return  array()
   */
  public function _product($tag, $content){
  	$catid  = empty($tag['catid']) ? '0' : $tag['catid'];
  	$item   = empty($tag['item'])  ? 'v' : $tag['item'];
  	$empty  = isset($tag['empty']) ? $tag['empty']:'暂无信息';
  	$limit  = empty($tag['limit']) ? '20' : $tag['limit'];
  	$order  = empty($tag['order']) ? 'inputtime desc':$tag['order'];
  	$picture  = isset($tag['picture']) ? 1 : 0;
  	$shopid  = empty($tag['shopid']) ? '0' : $tag['shopid'];
  	$iscomment  = isset($tag['iscomment']) ? 1 : 0;
  	
  	//解析PHP
  	$parse  = '<?php ';
  	$parse .= '$__ARTICLE_LIST__ = D(\'Admin/Product\')->taglib("'.$catid.'", '.$picture.', "'.$limit.'", "'.$order.'", "'.$iscomment.'", '.$shopid.');';
  	$parse .= ' ?>';
  	$parse .= '{volist name="__ARTICLE_LIST__" id="'. $item .'" empty="'. $empty .'"}';
  	$parse .= $content;
  	$parse .= '{/volist}';
  	return $parse;
  }

  /**
   * 标签列表
   * @example {hi:tags limit="2,5" empty="no data" order="sort desc"}
   * @param   integer $limit 调用数目 如:limit="2,5" 取2-5条数据
   * @param   string  $order 排序
   * @param   string  $item  循环变量名
   * @return  array()
   */
  public function _tags($tag, $content){
  	$item   = empty($tag['item'])  ? 'v' : $tag['item'];
  	$empty  = isset($tag['empty']) ? $tag['empty'] : '暂无友情链接';
  	$limit  = empty($tag['limit']) ? '10' : $tag['limit'];
  	$order  = empty($tag['order']) ? 'id desc' : $tag['order'];
  	//解析PHP
  	$parse  = '<?php ';
  	$parse .= '$__LINK_LIST__ = D(\'Admin/Tags\')->taglib("'.$limit.'", "'.$order.'");';
  	$parse .= ' ?>';
  	$parse .= '{volist name="__LINK_LIST__" id="'. $item .'" empty="'. $empty .'"}';
  	$parse .= $content;
  	$parse .= '{/volist}';
  	return $parse;
  }

   /**
   * 招人列表
   * @example {hi:job name="job" limit="2,5" item="jobInfo" empty="no data"}  
   * @param   integer $limit 调用数目 如:limit="2,5" 取2-5条数据
   * @param   string  $item  循环变量名
   * @return  array()
   */
  public function _job($tag, $content){
      $item   = empty($tag['item'])  ? 'v' : $tag['item'];
      $empty  = isset($tag['empty']) ? $tag['empty']:'暂无信息';
      $limit  = empty($tag['limit']) ? '6' : $tag['limit'];

      //解析PHP
      $parse  = '<?php ';
      $parse .= '$__JOB_LIST__ = D(\'Admin/Job\')->joblist("'.$limit.'");';
      $parse .= ' ?>';
      $parse .= '{volist name="__JOB_LIST__" id="'. $item .'" empty="'. $empty .'"}';
      $parse .= $content;
      $parse .= '{/volist}';
      return $parse;
  }

   /**
   * 求职列表
   * @example {hi:resume name="resume" limit="2,5" item="resumeInfo" empty="no data"}  
   * @param   integer $limit 调用数目 如:limit="2,5" 取2-5条数据
   * @param   string  $item  循环变量名
   * @return  array()
   */
  public function _resume($tag, $content){
      $item   = empty($tag['item'])  ? 'v' : $tag['item'];
      $empty  = isset($tag['empty']) ? $tag['empty']:'暂无信息';
      $limit  = empty($tag['limit']) ? '6' : $tag['limit'];

      //解析PHP
      $parse  = '<?php ';
      $parse .= '$__RESUME_LIST__ = D(\'Center/Resume\')->resumeList("'.$limit.'");';
      $parse .= ' ?>';
      $parse .= '{volist name="__RESUME_LIST__" id="'. $item .'" empty="'. $empty .'"}';
      $parse .= $content;
      $parse .= '{/volist}';
      return $parse;
  }


}