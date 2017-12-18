//dom加载完成后执行的js
;
$(function() {
	icheck();
});

//icheck加载
function icheck(){
	 $(".icheck").iCheck({
	        checkboxClass: "icheckbox_flat-green",
	        radioClass: "iradio_flat-green",
	    })

	    //icheck全选
	    var checkAll = $('input.checkall');
	    var checkboxes = $('input.check');
	    checkAll.on('ifChecked ifUnchecked', function(event) {
	        if (event.type == 'ifChecked') {
	            checkboxes.iCheck('check');
	        } else {
	            checkboxes.iCheck('uncheck');
	        }
	    });
	    checkboxes.on('ifChanged', function(event) {
	        if (checkboxes.filter(':checked').length == checkboxes.length) {
	            checkAll.prop('checked', 'checked');
	        } else {
	            checkAll.removeProp('checked');
	        }
	        checkAll.iCheck('update');
	    });

	    //editable 快捷操作
	    $.fn.editable.defaults.url = hi.url_quick;
	    $.fn.editable.defaults.emptytext = '空值';
	    $.fn.editable.defaults.params = function(params) {
	        params.type = $(this).data('type') || '';
	        params.field = $(this).data('name') || '';
	        params.id = $(this).data('pk') || '';
	        params.model = $(this).data('model') || '';
	        return params;
	    };
	    $.fn.editable.defaults.success = function(res) {
	        if (res.status) {
	            layer.msg(res.info, { icon: 6, time: 1500 });
	        } else {
	            return res.info;
	        }
	    };
	    $('.edit-text').editable();
	    $('.edit-textarea').editable({ showbuttons: 'bottom' });
	    $('.edit-select').editable();
}

/**
 * +----------------------------------------------------------------------
 * | AJAX相关
 * +----------------------------------------------------------------------
 */
// 搜索
$(".so-btn").on('click', function() {
    var url = $(this).attr('url') ? $(this).attr('url') : hi.url_curr;;
    var query = $('.so-form').find('input,select').serialize();
    query = query.replace(/(&|^)(\w*?\d*?\-*?_*?)*?=?((?=&)|(?=$))/g, '');
    query = query.replace(/^&/g, '');
    if(!$('.so-form').get(0).nodeName=='SELECT'){
        if (!query) {
            layer.msg('请输入搜索关键词！', { icon: 8, time: 1500, shift: 6 });
            return false;
        }
    }
    if (url.indexOf('?') > 0) {
        url += '&' + query;
    } else {
        url += '?' + query;
    }
    window.location.href = url;
});
//回车搜索
$(".so-input").keyup(function(e) {
    if (e.keyCode === 13) {
        $(".so-btn").click();
        return false;
    }
});

//switch更新状态
//默认URL为url_quick   data-url值
$(".ajax-switch").on('click', function() {
    var that = this;
    var $data = { value: $(this).prop('checked'), field: $(this).data('field') || '', model: $(this).data('model') || '', id: $(this).data('id') || '', type: 'switch' };
    var $url = $(this).data('url') ? $(this).data('url') : hi.url_quick;
    $.post($url, $data, function(res) {
        if (res.status) {
            layer.msg(res.info, { icon: 6, time: 1500 });
        } else {
            $(that).prop('checked', !$data.value);
            layer.msg(res.info, { icon: 8, time: 1500, shift: 6 });
        }
    }, 'json');
});

//ajax get
$('.ajax-get').click(function() {
    var target;
    var that = this;
    var title = $(this).attr('title') ? $(this).attr('title') : '进行此操作';
    if ((target = $(that).attr('href')) || (target = $(that).attr('url'))) {
        if ($(this).hasClass('confirm')) {
            layer.confirm('确定要' + title + '？', { icon: 0 }, function() {
                layerGet(target);
            });
        } else {
            layerGet(target);
        }
    }
});

//ajax ajax-form submit请求
$('.ajax-form').click(function() {
    var target, query, form;
    var target_form = $(this).attr('target-form');
    var self = this;
    if (($(self).attr('type') == 'submit') || (target = $(self).attr('href')) || (target = $(self).attr('url'))) {
        form = $('.' + target_form);
        if ($(this).attr('url') !== undefined) {
            target = $(this).attr('url');
        } else {
            target = form.get(0).action;
        }
        query = form.serialize();
        $(self).addClass('disabled').attr('autocomplete', 'off').prop('disabled', true);
        layerPost(target, query, self);
    }
    return false;
});


//列表状态变更
$('.ajax-status').click(function() {
    var target, query, form;
    var target_form = $(this).attr('target-form');
    var self = this;
    if ((target = $(this).attr('href')) || (target = $(this).attr('url'))) {
        form = $('.' + target_form);
        query = form.find('.check').serialize();
        //alert($(form).is(':checked'));
        if (!$(form).is(':checked')){
            layer.msg('请选择操作数据', { icon: 5, time: 1500, anim: 6 });
            return false;
        }
        //禁止按钮
        $(self).addClass('disabled').attr('autocomplete', 'off').prop('disabled', true);
        /*loading = layer.load(2, {
            shade: [0.9,'#000'] //0.2透明度的白色背景
        });*/
        if ($(self).hasClass('confirm')) {
            layer.confirm('确定要进行此操作？', { icon: 0 }, function() {
                layerPost(target, query, self);
            }, function() {
                //取消禁止
                $(self).removeClass('disabled').prop('disabled', false);
            });
        } else {
            layerPost(target, query, self);
        }
    }
});

//layer iframe窗口 调用移动|推送等信息
$('.ajax-iframe').click(function() {
    var target_form = $(this).attr('target-form');
    var title       = $(this).data('title');
    var model       = $(this).data('model');
    var url         = $(this).data('url');
    var result      = new Array();
    var form        = $('.'+target_form);
    $('input[name="ids[]"]:checked').each(function(){
        result.push($(this).val());
    });
    var ids = result.join(',');
    if ($(form).is(':checked')) {
        layer.open({
            type: 2,
            title: title,
            area: ['450px', '300px'],
            skin: 'layui-layer-rim', //加上边框
            content: [ url, 'no'],
            success: function(layero, index) {
                var body = layer.getChildFrame('body', index); //与父窗口建立连接
                var iframeWin = window[layero.find('iframe')[0]['name']];
                body.find('input[name="ids"]').val(ids); // 赋值到iframe
                body.find('input[name="model"]').val(model); // 赋值到iframe
            },
        });
    } else {
        layer.msg('请选择操作数据', {
            icon: 5,
            time: 1500,
            anim: 6
        });
        return false;
    }
    return false;
});

//layer window窗口 调用移动|推送等信息
$('.ajax-window').click(function() {
    var title       = $(this).data('title');
    var url         = $(this).data('url');
    layer.open({
        type: 2,
        title: title,
        area: ['75%', '90%'],
        skin: 'layui-layer-rim', //加上边框
        content: url,
    });
    return false;
});

/**
 * AJAX layer post方式
 * @method 表单提交方式
 * @target 表单提交地址
 * @query  表单提交地址
 */
function layerPost(url, query, that) {
    $.post(url, query).success(function(data) {
        if (data.status == 1) {
            if (data.url) {
                layer.msg(data.info, { icon: 6, time: 1500 }, function() {
                    window.location.href = data.url;
                });
            } else {
                layer.msg(data.info, { icon: 6, time: 1500 }, function() {
                    $(that).removeClass('disabled').prop('disabled', false);
                    location.reload();
                });
            }
        } else {
            layer.msg(data.info, { icon: 5, time: 1500, shift: 6 }, function() {
                $(that).removeClass('disabled').prop('disabled', false);
            });
        }
    });
}

/**
 * layer ajax get方式
 * @target 表单提交地址
 */
function layerGet(url) {
    $.get(url).success(function(data) {
        if (data.status == 1) {
            if (data.url) {
                layer.msg(data.info, { icon: 6, time: 1500 }, function() {
                    location.href = data.url;
                });
            } else {
                layer.msg(data.info, { icon: 6, time: 1500 }, function() {
                    location.reload();
                })
            }
        } else {
            if (data.url) {
                layer.msg(data.info, { icon: 5, time: 1500 }, function() {
                    location.href = data.url;
                });
            } else {
                layer.msg(data.info, { icon: 5, time: 1500, shift: 6 });
            }
        }
    });
}



/**
 * +----------------------------------------------------------------------
 * | 后台公共函数
 * +----------------------------------------------------------------------
 */
 //重新刷新页面，使用location.reload()有可能导致重新提交
function reloadPage(win) {
    var location = win.location;
    location.href = location.pathname + location.search;
}

//设置表单的值
function setFormValue(name, value) {
    var first = name.substr(0, 1),
        input, i = 0,
        val;
    if (value === "") return;
    if ("#" === first || "." === first) {
        input = $(name);
    } else {
        input = $("[name='" + name + "']");
    }

    if (input.eq(0).is(":radio")) { //单选按钮
        input.filter("[value='" + value + "']").each(function() { this.checked = true });
    } else if (input.eq(0).is(":checkbox")) { //复选框
        if (!$.isArray(value)) {
            val = new Array();
            val[0] = value;
        } else {
            val = value;
        }
        for (i = 0, len = val.length; i < len; i++) {
            input.filter("[value='" + val[i] + "']").each(function() { this.checked = true });
        }
    } else { //其他表单选项直接设置值
        input.val(value);
    }
}

/*
 * [strlen_verify 字符输入长度检测]
 * @author LaoHe
 * @DateTime 2017-04-14
 * @param    {[type]}   obj      [对象]
 * @param    {[type]}   checklen [检测长度]
 * @param    {[type]}   maxlen   [最长]
 * @return   {[type]}            [description]
 */
function strlen_verify(obj, checklen, maxlen) {
    var v = obj.value,
        charlen = 0,
        maxlen = !maxlen ? 200 : maxlen,
        curlen = maxlen,
        len = strlen(v);
    var charset = 'utf-8';
    for (var i = 0; i < v.length; i++) {
        if (v.charCodeAt(i) < 0 || v.charCodeAt(i) > 255) {
            curlen -= charset == 'utf-8' ? 2 : 1;
        }
    }
    if (curlen >= len) {
        $('#' + checklen).html(curlen - len);
    } else {
        obj.value = mb_cutstr(v, maxlen, true);
    }
}

// 长度统计
function strlen(str) {
    return (str.indexOf('\n') != -1) ? str.replace(/\r?\n/g, '_').length : str.length;
}

// 超过最大字符数替换
function mb_cutstr(str, maxlen, dot) {
    var len = 0;
    var ret = '';
    var dot = !dot ? '...' : '';
    var charset = 'utf-8';
    maxlen = maxlen - dot.length;
    for (var i = 0; i < str.length; i++) {
        len += str.charCodeAt(i) < 0 || str.charCodeAt(i) > 255 ? (charset == 'utf-8' ? 3 : 2) : 1;
        if (len > maxlen) {
            ret += dot;
            break;
        }
        ret += str.substr(i, 1);
    }
    return ret;
}