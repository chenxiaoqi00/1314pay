;
$(function() {
    // radio点击切换
    $(".blue-radio").on("click", function() {
        var radioName = $(".blue-radio").find("input").attr("name");
        $(this).addClass("on-radio").siblings().removeClass("on-radio");
        $(".blue-radio").find("input[name= " + radioName + "]").attr("checked", false);
        $(this).find("input").attr("checked", "checked");
    })
    $(".blue-checkbox").on("click", function() {
        if ($(this).hasClass("on-check")) {
            $(this).removeClass("on-check")
            $(this).find("input").attr("checked", false);
        } else {
            $(this).addClass("on-check");
            $(this).find("input").attr("checked", "checked");
        }
    })
    $("select").on("change", function() {
        $(this).next(".selectbg").html($(this).find("option:selected").text()); //$(this).find("option:selected").text() 意为获取select选中的值 设置给selectbg
    });

    // 全选
    $(".checkall").on("click", function() {
        if ($(this).hasClass("on-check")) {
            $(".list-table .blue-checkbox").addClass("on-check");
            $(".list-table input").attr("checked", "checked");
        } else {
            $(".list-table .blue-checkbox").removeClass("on-check");
            $(".list-table input").attr("checked", false);
        }
    })
    

})


/**
 * +----------------------------------------------------------------------
 * | AJAX相关
 * +----------------------------------------------------------------------
 */
//ajax ajax-form submit表单请求
$('.ajax-submit').click(function() {
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

//ajax ajax-get
$('.ajax-get').click(function() {
    var target;
    var that = this;
    var title = $(this).data('title') ? $(this).data('title') : '进行此操作';
    if ((target = $(that).data('url')) || (target = $(that).attr('href'))) {
        if ($(this).hasClass('confirm')) {
            layer.confirm('确定要' + title + '？', { icon: 0 }, function() {
                layerGet(target);
            });
        } else {
            layerGet(target);
        }
    }
});



//列表状态变更
$('.ajax-status').click(function() {
    var target, query, form;
    var target_form = $(this).attr('target-form');
    var self = this;
    if ((target = $(this).data('url')) || (target = $(this).attr('href')) || (target = $(this).attr('url')) ) {
    	form = $('.' + target_form);
        query = form.find('.check').serialize();
        if (!$(form).is(':checked')){
            layer.msg('请选择操作数据', { icon: 5, time: 1500, anim: 6 });
            return false;
        }
        /*loading = layer.load(2, {
            shade: [0.9,'#000'] //0.2透明度的白色背景
        });*/
        if ($(self).hasClass('confirm')) {
            layer.confirm('确定要进行此操作？', { icon: 0 }, function() {
                layerPost(target, query, self);
            });
        } else {
            layerPost(target, query, self);
        }
    }
});

//switch更新状态
//默认URL为url_quick   data-url值
$(".ajax-switch").on('click', function() {
  var that = this;
  var $data = { value: $(this).prop('checked'), field: $(this).data('field') || '', model: $(this).data('model') || '', id: $(this).data('id') || '', type: 'switch' };
  var $url = $(this).data('url') ? $(this).data('url') : hi.on_off;
  $.post($url, $data, function(res) {
      if (res.status) {
          layer.msg(res.info, { icon: 6, time: 1500 });
      } else {
          $(that).prop('checked', !$data.value);
          layer.msg(res.info, { icon: 8, time: 1500, shift: 6 });
      }
  }, 'json');
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
            //layer.msg(data.info, { icon: 5, time: 1500, shift: 6 });
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
* 设置表单的值
* @param string $name   表单name
* @param string $value  表单值
*/
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